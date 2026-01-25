
(* Fichier principal du compilateur arithc *)

open Format
open Lexing

(* Option de compilation, pour s'arrêter à l'issue du parser *)
let parse_only = ref false
let type_only = ref false

(* Noms des fichiers source et cible *)
let ifile = ref ""
let ofile = ref ""

let set_file f s = f := s

(* Les options du compilateur que l'on affiche en tapant arithc --help *)
let options =
  ["-o", Arg.String (set_file ofile),
   "<file>  Pour indiquer le mom du fichier de sortie"]

let usage = "usage: arithc [option] file.s"

(* localise une erreur en indiquant la ligne et la colonne *)
let localisation (beg_pos, end_pos) =
  let get_c_l pos = (pos.pos_lnum, pos.pos_cnum - pos.pos_bol + 1) in
  let beg_l, beg_c = get_c_l beg_pos in
  let end_l, end_c = get_c_l end_pos in
  if beg_l = end_l then
    eprintf "File \"%s\", line %d, characters %d-%d:\n" !ifile beg_l beg_c end_c
  
  else
    eprintf "File \"%s\", line %d-%d, characters %d-%d:\n" !ifile beg_l end_l beg_c end_c

let () =
  (* Parsing de la ligne de commande *)
  Arg.parse options (set_file ifile) usage;

  (* On vérifie que le nom du fichier source a bien été indiqué *)
  if !ifile="" then begin eprintf "Aucun fichier à compiler\n@?"; exit 1 end;

  (* Ce fichier doit avoir l'extension .arr *)
  if not (Filename.check_suffix !ifile ".s") then begin
    eprintf "Le fichier d'entrée doit avoir l'extension .s\n@?";
    Arg.usage options usage;
    exit 1
  end;

  (* Par défaut, le fichier cible a le même nom que le fichier source,
     seule l'extension change *)
  if !ofile="" then ofile := Filename.chop_suffix !ifile ".s" ^ ".s";

  (* Ouverture du fichier source en lecture *)
  let f = open_in !ifile in

  (* Création d'un tampon d'analyse lexicale *)
  let buf = Lexing.from_channel f in

  try
    (* Parsing: la fonction  Parser.prog transforme le tampon lexical en un
       arbre de syntaxe abstraite si aucune erreur (lexicale ou syntaxique)
       n'est détectée.
       La fonction Lexer.token est utilisée par Parser.prog pour obtenir
       le prochain token. *)
    let p = Parser.file Lexer.token buf in
    close_in f;
    (* On s'arrête ici si on ne veut faire que le parsing *)
    Compile.compile_program p !ofile

  with
    | e ->
      localisation (Lexing.lexeme_start_p buf, Lexing.lexeme_end_p buf);
      eprintf "An error occured\n";
      raise e
