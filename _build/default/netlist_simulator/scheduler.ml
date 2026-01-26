open Netlist_ast
open Graph

exception Combinational_cycle

let read_exp eq = 
  let extract_from_arg arg = match arg with
    | Avar var -> var::[]
    | Aconst _ -> []
  in
  let _, exp = eq in
  match exp with
  | Earg arg -> extract_from_arg arg
  | Enot bit -> extract_from_arg bit
  | Ebinop (op, bit1, bit2) -> (extract_from_arg bit1)@(extract_from_arg bit2)
  | Emux (choice, bit1, bit2) -> (extract_from_arg choice)@(extract_from_arg bit1)@(extract_from_arg bit2)
  | Ereg _ -> []
  | Eram (addr_size, word_size, read_address, write_enable, write_addr, write_data) -> extract_from_arg read_address
  | Erom (addr_size, word_size, read_address) -> extract_from_arg read_address
  | Econcat (arr1, arr2) -> (extract_from_arg arr1)@(extract_from_arg arr2)
  | Eslice (i1, i2, arr) -> extract_from_arg arr
  | Eselect (i, arr) -> extract_from_arg arr
    

let schedule p = 
  let find_eq_with_ident searched_ident = List.find (fun (ident, exp) -> ident=searched_ident) p.p_eqs in
  let is_input ident = List.exists (fun input_ident -> ident=input_ident) p.p_inputs in
  let graph = {g_nodes = []} in
  List.iter (fun (ident, _) -> add_node graph ident) p.p_eqs; (*we create a node for each ident*)
  List.iter (fun (ident, exp) ->  (*we create the appropriate links*)
    List.iter (fun connected_ident -> if not (is_input connected_ident) then add_edge graph connected_ident ident) (read_exp (ident, exp))
  ) p.p_eqs;
  {p_eqs = List.map (fun ident -> find_eq_with_ident ident) (topological graph); p_inputs = p.p_inputs; p_outputs = p.p_outputs; p_vars = p.p_vars}
