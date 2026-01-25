open Netlist_ast

let granularity = 8
let mem_size = (1 lsl 16) * granularity

let debug = ref false
let number_steps = ref (-1)

let rom = Array.make mem_size false

exception InvalidType of string

module Env = Netlist_ast.Env

(*returns an integer based on the boolean value*)
let int_of_bool b = if b then 1 else 0

(*take a big edian bit array and returns the int value*)
let byte_to_int b =
  let rec calculate_value sum pow i = 
    if i < 0 then
      sum 
    
    else
      calculate_value (sum + pow*(int_of_bool (b.(i)))) (pow*2) (i-1)
  in
  calculate_value 0 1 ((Array.length b) - 1)

(*returns the number of bits for the data stored by a certain type*)
let length_type t = 
  match t with
  |TBit -> 1
  |TBitArray n -> n

(*returns the number of bits for data*)
let length_data v = match v with
  | VBit _ -> 1
  | VBitArray a -> Array.length a

(*returns the integer corresponding to the bits as read in big_endian*)
let read_as_binary v = match v with
  | VBit b -> int_of_bool b
  | VBitArray l -> Array.fold_left (fun n b -> n*2 + (int_of_bool b)) 0 l

(*return a bit from a value. The function fails if the value is an array*)
let extract_bit v = match v with
  | VBit b -> b
  | VBitArray _ -> raise (InvalidType "expected int, got array")

(*return an array from a value. The function fails if the value is a bit*)
let extract_array v = match v with
  | VBit b -> [|b|]
  | VBitArray a -> a

(*return a bit from a value. The function does an explicite conversion if the value is an array is of size 1*)
let cast_as_bit v = match v with 
  | VBit b -> Array.make 1 b
  | VBitArray a -> a

(*return an array from a value. The function does an implicit conversion if the value is a bit*)
let cast_as_array v = match v with 
  | VBit b -> Array.make 1 b
  | VBitArray a -> a

(*return the value for a variable as typed in by the user*)
let rec read_input var_name var_type = 
  Printf.printf "%s : " var_name;
  let inp = read_line () in 
  if (String.exists(fun c -> (c <> '0') && (c <> '1')) inp) || (String.length inp <> length_type var_type) then (*an input is correct if it only contains 1s and 0s and the right amount*)
    read_input var_name var_type (*we ask again if the input is incorrect*)
  
  else
    match var_type with 
    | TBitArray n -> VBitArray (Array.init n (fun i -> inp.[i]='1'))
    | TBit -> VBit (inp.[0]='1')

(*print the values of the output variables*)
let print_output var_values outputs = 
  let print_value v = 
    (match v with 
    | VBit n -> Printf.printf "%d" (int_of_bool n)
    | VBitArray l -> Array.iter (fun n -> Printf.printf "%d" (int_of_bool n)) l);
    Printf.printf "\n"
  in
  List.iter (fun o -> Printf.printf "%s : " o; print_value (Hashtbl.find var_values o)) outputs

(*return an evaluated expression using the previous and current values of the identifiers the memory (ram and rom) *)
let eval_expr expr ident_values previous_ident_values memory =
  let eval_arg arg = match arg with 
    | Avar ident -> Hashtbl.find ident_values ident  
    | Aconst value -> value
  in
  match expr with 
  | Earg arg -> eval_arg arg
  
  | Enot arg -> VBit (not @@ extract_bit @@ eval_arg arg)
  
  | Ereg ident -> Hashtbl.find previous_ident_values ident
  
  | Ebinop (op, arg1, arg2) -> 
      let bit1 = extract_bit @@ eval_arg arg1 in
      let bit2 = extract_bit @@ eval_arg arg2 in 
      VBit (match op with 
      | Or -> bit1 || bit2
      | Xor -> bit1 <> bit2
      | And -> bit1 && bit2
      | Nand -> not (bit1 && bit2))
      
  | Emux (choice, arg1, arg2) -> 
    (match extract_bit @@ eval_arg choice, eval_arg arg1, eval_arg arg2 with
      | true, d1, d2 -> d2
      | false, d1, d2 -> d1)
  
  | Econcat (arr1, arr2) -> VBitArray (Array.append (cast_as_array @@ eval_arg arr1) (cast_as_array @@ eval_arg arr2))
  
  | Eselect (n, arg) -> VBit ((extract_array (eval_arg arg)).(n))
  
  | Eslice (n1, n2, arg) -> 
    if n1 = n2 then 
      VBit ((extract_array (eval_arg arg)).(n1))
    else
      VBitArray (Array.sub (extract_array (eval_arg arg)) n1 (n2-n1+1))

  | Erom (addr_size, word_size, read_addr) ->
    if length_data (eval_arg read_addr) <> addr_size then raise (InvalidType "valid address size") else 
    let read_addr = read_as_binary (eval_arg read_addr) in 
    VBitArray (Array.sub rom (read_addr * granularity) word_size)
    
  | Eram (addr_size, word_size, read_addr, _, _, _) -> 
    if length_data (eval_arg read_addr) <> addr_size then raise (InvalidType "valid address size") else 
    let read_addr = read_as_binary (eval_arg read_addr) in 
    let mem = Hashtbl.find memory expr in
    VBitArray (Array.sub mem (read_addr * granularity) word_size)


(*puts a certain number into the rom*)
let byte_to_binary_in_rom i rom_ind =
  let rec aux i ind =
    if ind < 8 then
      let p = 1 lsl (7 - ind) in
      rom.(rom_ind + ind) <- i / p = 1;
      aux (i mod p) (ind + 1)
      
  in aux i 0

(*puts the content from a given file into the rom*)
let allocate_rom f_rom =
  let f_rom = Netlist.find_file f_rom in
  let rec aux ind =
      let c = input_char f_rom in
      byte_to_binary_in_rom (int_of_char c) ind;
      aux (ind + 8)
  in 
  try
    aux 0
  with
  | End_of_file -> ()

(*return a Hashtbl that maps each rom/ram instruction to its corresponding memory space*)
let allocate_ram instrs = 
  let memory = Hashtbl.create 64 in
  let allocate_memory_ram exp addr_size word_size =
    let memory_space = Array.make mem_size false in (*we initialize the memory to be only zeros*)
    Hashtbl.add memory exp memory_space
    
  in
  List.iter (fun (_, exp) -> 
    match exp with
    | Eram (addr_size, word_size, _, _, _, _) -> allocate_memory_ram exp addr_size word_size
    | _ -> ()
    ) instrs;
  memory

let allocate_memory instrs f_rom =
   allocate_rom f_rom;
   allocate_ram instrs

(*return nothing but update the memory Hashtbl*)
let update_memory eqs ident_values memory = 
  let eval_arg arg = match arg with 
    | Avar ident -> Hashtbl.find ident_values ident  
    | Aconst value -> value
  in
  let update_memory_space eq = 
    let _, expr = eq in
    match expr with 
    | Eram (addr_size, word_size, read_addr, write_enable, write_addr, write_data) -> 
      if (length_data @@ eval_arg write_addr <> addr_size) then raise (InvalidType "taille de l'addresse non valide") else 
      if (length_data @@ eval_arg write_data <> word_size) then raise (InvalidType "taille de l'addresse non valide") else 
      if extract_bit @@ eval_arg write_enable then
        let write_addr = read_as_binary (eval_arg write_addr) in
        let ram = Hashtbl.find memory expr in
        Array.blit (cast_as_array (eval_arg write_data)) 0 ram (write_addr * granularity) word_size
  
    | _ -> ()
  in
  List.iter update_memory_space eqs;
  Hashtbl.iter (fun expr memory -> (*print what the program tells us to*)
     match expr with
     | Eram (_, word_size, _, _, _, _) ->
       let v = byte_to_int (Array.sub memory (mem_size - word_size) word_size) in
       Printf.printf "%d\n" v;
       if v > 0 then
         Printf.printf "%c" (Char.chr v)
       
     | _ -> ()
  )
  memory

(*simulate 'number_steps' of the programs*)
let simulator program number_steps filename_rom =
  let memory = allocate_memory program.p_eqs filename_rom in
  let rec loop program previous_ident_values step =
    if !debug then
       Printf.printf "step % d :\n%!" step;
       
    let ident_values = Hashtbl.create 64 in
    List.iter (fun input_var ->  (*for input variables, we get the values from the user*)
      let type_input_var = Env.find input_var program.p_vars in 
      Hashtbl.add ident_values input_var (read_input input_var type_input_var)
    ) program.p_inputs;

    List.iter (fun (ident, exp) -> (*we process all the equations*)
      let value = eval_expr exp ident_values previous_ident_values memory in
      if length_data value <> length_type (Env.find  ident program.p_vars) then raise (InvalidType "the number of bits does not match that expected for this identifier") else
      Hashtbl.add ident_values ident value) program.p_eqs;

    update_memory program.p_eqs ident_values memory;
    if !debug then
       print_output ident_values program.p_outputs;
       
    if (step <> number_steps) then
      loop program ident_values (step+1)
  in
  let all_variables_false = Hashtbl.create 64 in (*for the first step, all reg instructions bits are set to false*)
  Env.iter (fun var var_type -> 
    let default_value =  match var_type with
      | TBit -> VBit false
      | TBitArray n -> VBitArray (Array.make n false)
    in
    Hashtbl.add all_variables_false var default_value) program.p_vars;

  loop program all_variables_false 1

let compile filename filename_rom =
  try
    let p = Netlist.read_file filename in
    begin try
        let p = Scheduler.schedule p in
        simulator p !number_steps filename_rom
      with
        | Scheduler.Combinational_cycle ->
            Format.eprintf "The netlist has a combinatory cycle.@.";
    end;
  with
    | Netlist.Parse_error s -> Format.eprintf "An error accurred: %s@." s; exit 2

let main () =
  let args = ref [] in
  let speclist = ["-n", Arg.Set_int number_steps, "Number of steps to simulate";
  "-d", Arg.Set debug, "pour afficher les outputs"] in
  let usg_msg = "./netlist_simulator.byte [-n number_of_steps] netlist rom" in
  let anon_fun arg =
    args := arg :: !args
  in

  Arg.parse speclist anon_fun usg_msg;
  match List.rev !args with
  | [filename; filename_rom] -> compile filename filename_rom
  | _ -> 
    begin
      Arg.usage speclist usg_msg;
      exit 1
    end
;;

main ()
