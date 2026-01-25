open Ast

let instruction_count = ref 0

let labels_pos = Hashtbl.create 32

let valid_register r =
  if (r > 31) || (r < 0) then
    failwith "invalid size"

let valid_immediate i =
  if (i >= 1 lsl 31) || (-i > 1 lsl 31) then
    failwith "invalid size"

let get_pos_labels p =  
  List.iter (fun line ->
    match line with
    | Label l -> 
      if Hashtbl.mem labels_pos l then
        failwith "can't define the same label twice"
      
      else
        Hashtbl.add labels_pos l !instruction_count
        
    | Instr (op_code, _, _, operand) ->
      let nb_instr = (if op_code < -3 then
        2
      else if op_code < 0 then
        3
      else
        1)
      +
      match operand with
      | Imm i -> 
        if (i >= (1 lsl 16)) || (-i > (1 lsl 16)) then (*we take account putting*)
          3 
        else
          0
      | _ -> 0
      in
      instruction_count := !instruction_count + nb_instr
  ) p
  
let rec write_instr ofile op_code rw ra rb =
  valid_register rw;
  valid_register ra;
  let instr = op_code lsl 27 + rw lsl 22 + ra lsl 17 in
  match rb with
  | Reg r ->
    valid_register r;
    output_binary_int ofile (r lsl 12 + instr);
    instruction_count := !instruction_count + 1
  
  | Imm n -> 
    valid_immediate n;
    if (n >= 0) && (n < (1 lsl 16)) then
      begin
      output_binary_int ofile (n + instr);
      instruction_count := !instruction_count + 1
      end
    
    else if (n < 0) && (-n <= (1 lsl 16)) then
      begin 
      output_binary_int ofile (((1 lsl 17) + n) + instr);
      instruction_count := !instruction_count + 1
      end 
    
    else
      begin
      put_imm_in_r3 ofile n;
      write_instr ofile (op_code-1) rw ra (Reg 3);
      end
  
  | ImmLabel s -> 
    let pos_label = Hashtbl.find labels_pos s in
    
    let diff = (pos_label - !instruction_count)*4 in
    if (diff >= 1 lsl 16) || (-diff > 1 lsl 16) then
      failwith "too big a jump"
    
    else
      write_instr ofile op_code rw ra (Imm diff)
      


and put_imm_in_r3 ofile imm = 
  let imm = 
    if imm < 0 then 
      (1 lsl 32) + imm
    else
      imm
  in
  write_instr ofile addi_code 3 0 (Imm (imm lsr 16));
  write_instr ofile lshifti_code 3 3 (Imm 16);
  write_instr ofile addi_code 3 3 (Imm (imm mod (1 lsl 16)))

let compile_program p ofile =
  let ofile = open_out_bin ofile in
  get_pos_labels p;
  instruction_count := 0;
  List.iter (fun i -> match i with
  | Instr (-1, _, opS1, _) -> 
    write_instr ofile push_code 3 2 (Imm 3);
    write_instr ofile push_code 0 0 (Reg 3);
    write_instr ofile sub_code 0 0 (Reg 0);
    write_instr ofile je_code 0 opS1 (Imm 0)
    
  | Instr (-2, _, _, immopS2) -> 
    write_instr ofile push_code 3 2 (Imm 3);
    write_instr ofile push_code 0 0 (Reg 3);
    write_instr ofile sub_code 0 0 (Reg 0);
    write_instr ofile jei_code 0 2 immopS2
    
  | Instr (-4, opD, opS1, immopS2) -> 
    write_instr ofile addi_code 3 0 immopS2;
    write_instr ofile sub_code opD 3 (Reg opS1)

  | Instr (-5, _, opS1, _) ->
     write_instr ofile sub_code 0 0 (Reg 0);
     write_instr ofile je_code 0 opS1 (Imm 0)
  
  | Instr (-6, _, _, immopS2) -> 
      write_instr ofile sub_code 0 0 (Reg 0);
      write_instr ofile jei_code 0 2 immopS2
      
  | Instr (op_code, rw, ra, rb) ->  write_instr ofile op_code rw ra rb
  | Label _ -> ()
  ) p;
  close_out ofile
