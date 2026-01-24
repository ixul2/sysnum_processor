open Ast

let instruction_count = ref 0

let labels_pos = Hashtbl.create 32

let valid_register r =
  if (r > 31) or (r < 0) then
    failwith "invalid size"

let valid_immediate i =
  if (i >= 1 lsl 31) or (-i > 1 lsl 31) then
    failwith "invalid size"

let get_pos_labels p = 
  List.iter (fun line ->
    match line with
    | Label l -> 
      if Hashtbl.mem labels_pos l then
        failwith "can't define the same label twice"
      
      else
        Hashtbl.add l !instruction_count
        
    | Instr (op_code, _, _, operand) ->
      let nb_instr = (if op_code < 0 then
        2
      else
        1)
      +
      match operand with
      | Imm i -> 
        if (i >= (1 lsl 16)) or (-i > (1 lsl 16)) then (*we take account putting *)
          if op_code = -4 then
            2
          else
            3 
        else
          0
             | Reg _ -> 0
      in
      instruction_count <- !instruction_count + nb_instr;
  )
  
let rec write_instr ofile op_code rw ra rb =
  valid_register rw;
  valid_register ra;
  let instr = op_code lsl 27 + rw lsl 22 + ra lsl 17 in
  match rb with
  | Reg r ->
    valid_register r;
    r lsl 12 + instr
  
  | Imm n -> 
    valid_immediate n;
    put_imm_in_r3 n
    if n >= 0 and n < (1 lsl 16) then
      n + instr
    
    else if n < 0 and -n <= (1 lsl 16)
      ((1 lsl 17) + n) + instr
    
    else
      put_imm_in_r3 ofile n
      write_instr (op_code-1) rw ra 3
  
  | ImmLabel s -> 


and put_imm_in_r3 ofile imm = 
  i = 
    if i < 0 then 
      (1 lsl 32) + n
    else
      i
  in
  write_instr addi_code 3 3 (Imm (i lsr 16)));
  write_instr lshifti_code 3 3 (Imm 16);
  write_instr addi_code 3 0 (Imm (i mod (1 lsl 16)))

let compile_program p ofile =
  let f = open_out_bin ofile in
  get_pos_labels p;
  List.iter (fun i -> match i
  | (-1, ) ->
  | (-2, ) -> 
  | (-3, ) -> 
  | (-4, ) -> 
  | (-5, ) ->
  | (-6, ) -> 
  | (op_code, rw, ra, rb) ->  write_instr op_code rw ra rb
  )
  p
  close_out f
