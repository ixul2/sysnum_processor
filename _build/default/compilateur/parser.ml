
module MenhirBasics = struct
  
  exception Error
  
  let _eRR : exn =
    Error
  
  type token = 
    | XOR
    | SUB
    | STORE
    | RSHIFT
    | RET
    | REG of (
# 12 "compilateur/parser.mly"
       (int)
# 19 "compilateur/parser.ml"
  )
    | PUSH
    | POP
    | OR
    | MOV
    | LSHIFT
    | LOAD
    | LABEL_DEC of (
# 11 "compilateur/parser.mly"
       (string)
# 30 "compilateur/parser.ml"
  )
    | LABEL of (
# 11 "compilateur/parser.mly"
       (string)
# 35 "compilateur/parser.ml"
  )
    | JMP
    | JLT
    | JLE
    | JGT
    | JGE
    | JE
    | IMM of (
# 12 "compilateur/parser.mly"
       (int)
# 46 "compilateur/parser.ml"
  )
    | EOF
    | CMP
    | CALL
    | AND
    | ADD
  
end

include MenhirBasics

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState112
  | MenhirState0

# 2 "compilateur/parser.mly"
  
  open Ast
  open Lexing
  
  module IntSet = Set.Make(Int)
  

# 77 "compilateur/parser.ml"

let rec _menhir_goto_list_line_ : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.program) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (instrs : (Ast.program))) = _menhir_stack in
            let _v : (Ast.program) = 
# 28 "compilateur/parser.mly"
                        ( instrs )
# 95 "compilateur/parser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (Ast.program)) = _v in
            Obj.magic _1
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (x : (Ast.line))), _, (xs : (Ast.program))) = _menhir_stack in
        let _v : (Ast.program) = 
# 213 "<standard.mly>"
    ( x :: xs )
# 114 "compilateur/parser.ml"
         in
        _menhir_goto_list_line_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_line : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.line) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADD ->
        _menhir_run101 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | AND ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | CALL ->
        _menhir_run89 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | CMP ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | JE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | JGE ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | JGT ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | JLE ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | JLT ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | JMP ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | LABEL_DEC _v ->
        _menhir_run64 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
    | LOAD ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | LSHIFT ->
        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | MOV ->
        _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | OR ->
        _menhir_run38 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | POP ->
        _menhir_run36 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | PUSH ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | RET ->
        _menhir_run32 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | RSHIFT ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | STORE ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | SUB ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | XOR ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | EOF ->
        _menhir_reduce51 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112

and _menhir_goto_instr : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.instr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (i : (Ast.instr)) = _v in
    let _v : (Ast.line) = 
# 32 "compilateur/parser.mly"
          ( Instr i)
# 184 "compilateur/parser.ml"
     in
    _menhir_goto_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_reduce51 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (Ast.program) = 
# 211 "<standard.mly>"
    ( [] )
# 204 "compilateur/parser.ml"
     in
    _menhir_goto_list_line_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 233 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 238 "compilateur/parser.ml"
                ))), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 242 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 44 "compilateur/parser.mly"
                            (xori rg imm rd)
# 247 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 281 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 286 "compilateur/parser.ml"
                ))), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 290 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 45 "compilateur/parser.mly"
                            (xori rg imm rd)
# 295 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 317 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 322 "compilateur/parser.ml"
                ))), (rsb : (
# 12 "compilateur/parser.mly"
       (int)
# 326 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 43 "compilateur/parser.mly"
                             (xor rsa rsb rd)
# 331 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run10 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 378 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 383 "compilateur/parser.ml"
                ))), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 387 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 50 "compilateur/parser.mly"
                            (subi_rev rg imm rd)
# 392 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 426 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 431 "compilateur/parser.ml"
                ))), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 435 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 51 "compilateur/parser.mly"
                            (subi rg imm rd)
# 440 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 462 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 467 "compilateur/parser.ml"
                ))), (rsb : (
# 12 "compilateur/parser.mly"
       (int)
# 471 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 49 "compilateur/parser.mly"
                             (sub rsa rsb rd)
# 476 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run19 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 517 "compilateur/parser.ml"
            )) = _v in
            let ((_menhir_stack, _menhir_s), (radd : (
# 12 "compilateur/parser.mly"
       (int)
# 522 "compilateur/parser.ml"
            ))) = _menhir_stack in
            let _v : (Ast.instr) = 
# 65 "compilateur/parser.mly"
                         (storei radd imm)
# 527 "compilateur/parser.ml"
             in
            _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (ra : (
# 12 "compilateur/parser.mly"
       (int)
# 537 "compilateur/parser.ml"
            )) = _v in
            let ((_menhir_stack, _menhir_s), (radd : (
# 12 "compilateur/parser.mly"
       (int)
# 542 "compilateur/parser.ml"
            ))) = _menhir_stack in
            let _v : (Ast.instr) = 
# 64 "compilateur/parser.mly"
                        (store radd ra)
# 547 "compilateur/parser.ml"
             in
            _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run23 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 588 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 593 "compilateur/parser.ml"
                ))), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 597 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 56 "compilateur/parser.mly"
                               (rshifti rg imm rd)
# 602 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 636 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 641 "compilateur/parser.ml"
                ))), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 645 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 57 "compilateur/parser.mly"
                               (rshift rg imm rd)
# 650 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 672 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 677 "compilateur/parser.ml"
                ))), (rsb : (
# 12 "compilateur/parser.mly"
       (int)
# 681 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 55 "compilateur/parser.mly"
                                (rshift rsa rsb rd)
# 686 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run32 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Ast.instr) = 
# 71 "compilateur/parser.mly"
      (ret ())
# 715 "compilateur/parser.ml"
     in
    _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v

and _menhir_run33 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 732 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 67 "compilateur/parser.mly"
               (pushi imm)
# 738 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 748 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 66 "compilateur/parser.mly"
             (push r)
# 754 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run36 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 777 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 68 "compilateur/parser.mly"
            (pop r)
# 783 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run38 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 818 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 823 "compilateur/parser.ml"
                ))), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 827 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 41 "compilateur/parser.mly"
                           (ori rg imm rd)
# 832 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 866 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 871 "compilateur/parser.ml"
                ))), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 875 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 42 "compilateur/parser.mly"
                           (ori rg imm rd)
# 880 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 902 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 907 "compilateur/parser.ml"
                ))), (rsb : (
# 12 "compilateur/parser.mly"
       (int)
# 911 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 40 "compilateur/parser.mly"
                            (or_ rsa rsb rd)
# 916 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run47 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 957 "compilateur/parser.ml"
            )) = _v in
            let ((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 962 "compilateur/parser.ml"
            ))) = _menhir_stack in
            let _v : (Ast.instr) = 
# 62 "compilateur/parser.mly"
                     (addi 0 imm rd)
# 967 "compilateur/parser.ml"
             in
            _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 989 "compilateur/parser.ml"
            )) = _v in
            let ((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 994 "compilateur/parser.ml"
            ))) = _menhir_stack in
            let _v : (Ast.instr) = 
# 61 "compilateur/parser.mly"
                     (add 0 rsa rd)
# 999 "compilateur/parser.ml"
             in
            _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run52 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1040 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 1045 "compilateur/parser.ml"
                ))), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 1049 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 59 "compilateur/parser.mly"
                               (lshifti rg imm rd)
# 1054 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1088 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 1093 "compilateur/parser.ml"
                ))), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 1097 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 60 "compilateur/parser.mly"
                               (lshift rg imm rd)
# 1102 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1124 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 1129 "compilateur/parser.ml"
                ))), (rsb : (
# 12 "compilateur/parser.mly"
       (int)
# 1133 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 58 "compilateur/parser.mly"
                                (lshift rsa rsb rd)
# 1138 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run61 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1179 "compilateur/parser.ml"
            )) = _v in
            let ((_menhir_stack, _menhir_s), (radd : (
# 12 "compilateur/parser.mly"
       (int)
# 1184 "compilateur/parser.ml"
            ))) = _menhir_stack in
            let _v : (Ast.instr) = 
# 63 "compilateur/parser.mly"
                       (load radd rd)
# 1189 "compilateur/parser.ml"
             in
            _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run64 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 11 "compilateur/parser.mly"
       (string)
# 1208 "compilateur/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (l : (
# 11 "compilateur/parser.mly"
       (string)
# 1216 "compilateur/parser.ml"
    )) = _v in
    let _v : (Ast.line) = 
# 33 "compilateur/parser.mly"
              ( Label l)
# 1221 "compilateur/parser.ml"
     in
    _menhir_goto_line _menhir_env _menhir_stack _menhir_s _v

and _menhir_run65 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LABEL _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (
# 11 "compilateur/parser.mly"
       (string)
# 1238 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 73 "compilateur/parser.mly"
              (jmpi l)
# 1244 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 1254 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 72 "compilateur/parser.mly"
            (jmp r)
# 1260 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run68 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LABEL _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (
# 11 "compilateur/parser.mly"
       (string)
# 1283 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 77 "compilateur/parser.mly"
              (jlti l)
# 1289 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 1299 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 76 "compilateur/parser.mly"
            (jlt r)
# 1305 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run71 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LABEL _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (
# 11 "compilateur/parser.mly"
       (string)
# 1328 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 79 "compilateur/parser.mly"
              (jlei l)
# 1334 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 1344 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 78 "compilateur/parser.mly"
            (jle r)
# 1350 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run74 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LABEL _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (
# 11 "compilateur/parser.mly"
       (string)
# 1373 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 81 "compilateur/parser.mly"
              (jgti l)
# 1379 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 1389 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 80 "compilateur/parser.mly"
            (jgt r)
# 1395 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run77 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LABEL _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (
# 11 "compilateur/parser.mly"
       (string)
# 1418 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 83 "compilateur/parser.mly"
              (jgei l)
# 1424 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 1434 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 82 "compilateur/parser.mly"
            (jge r)
# 1440 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run80 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LABEL _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (
# 11 "compilateur/parser.mly"
       (string)
# 1463 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 75 "compilateur/parser.mly"
             (jei l)
# 1469 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 1479 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 74 "compilateur/parser.mly"
           (je r)
# 1485 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run83 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 1514 "compilateur/parser.ml"
            )) = _v in
            let ((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 1519 "compilateur/parser.ml"
            ))) = _menhir_stack in
            let _v : (Ast.instr) = 
# 53 "compilateur/parser.mly"
                     (subi rg imm 0)
# 1524 "compilateur/parser.ml"
             in
            _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 1546 "compilateur/parser.ml"
            )) = _v in
            let ((_menhir_stack, _menhir_s), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 1551 "compilateur/parser.ml"
            ))) = _menhir_stack in
            let _v : (Ast.instr) = 
# 54 "compilateur/parser.mly"
                     (subi rg imm 0)
# 1556 "compilateur/parser.ml"
             in
            _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (rsb : (
# 12 "compilateur/parser.mly"
       (int)
# 1566 "compilateur/parser.ml"
            )) = _v in
            let ((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 1571 "compilateur/parser.ml"
            ))) = _menhir_stack in
            let _v : (Ast.instr) = 
# 52 "compilateur/parser.mly"
                      (sub rsa rsb 0)
# 1576 "compilateur/parser.ml"
             in
            _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run89 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LABEL _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (
# 11 "compilateur/parser.mly"
       (string)
# 1605 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 70 "compilateur/parser.mly"
               (calli l)
# 1611 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (r : (
# 12 "compilateur/parser.mly"
       (int)
# 1621 "compilateur/parser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Ast.instr) = 
# 69 "compilateur/parser.mly"
             (call r)
# 1627 "compilateur/parser.ml"
         in
        _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run92 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1662 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 1667 "compilateur/parser.ml"
                ))), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 1671 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 38 "compilateur/parser.mly"
                            (andi rg imm rd)
# 1676 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1710 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 1715 "compilateur/parser.ml"
                ))), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 1719 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 39 "compilateur/parser.mly"
                            (andi rg imm rd)
# 1724 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1746 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 1751 "compilateur/parser.ml"
                ))), (rsb : (
# 12 "compilateur/parser.mly"
       (int)
# 1755 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 37 "compilateur/parser.mly"
                             (and_ rsa rsb rd)
# 1760 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run101 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IMM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1807 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 1812 "compilateur/parser.ml"
                ))), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 1816 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 47 "compilateur/parser.mly"
                            (addi rg imm rd)
# 1821 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | REG _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IMM _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1855 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rg : (
# 12 "compilateur/parser.mly"
       (int)
# 1860 "compilateur/parser.ml"
                ))), (imm : (
# 12 "compilateur/parser.mly"
       (int)
# 1864 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 48 "compilateur/parser.mly"
                            (addi rg imm rd)
# 1869 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | REG _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | REG _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (rd : (
# 12 "compilateur/parser.mly"
       (int)
# 1891 "compilateur/parser.ml"
                )) = _v in
                let (((_menhir_stack, _menhir_s), (rsa : (
# 12 "compilateur/parser.mly"
       (int)
# 1896 "compilateur/parser.ml"
                ))), (rsb : (
# 12 "compilateur/parser.mly"
       (int)
# 1900 "compilateur/parser.ml"
                ))) = _menhir_stack in
                let _v : (Ast.instr) = 
# 46 "compilateur/parser.mly"
                             (add rsa rsb rd)
# 1905 "compilateur/parser.ml"
                 in
                _menhir_goto_instr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and file : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program) =
  fun lexer lexbuf ->
    let _menhir_env = {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = Obj.magic ();
      _menhir_error = false;
    } in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADD ->
        _menhir_run101 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | AND ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | CALL ->
        _menhir_run89 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | CMP ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | JE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | JGE ->
        _menhir_run77 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | JGT ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | JLE ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | JLT ->
        _menhir_run68 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | JMP ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LABEL_DEC _v ->
        _menhir_run64 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | LOAD ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LSHIFT ->
        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | MOV ->
        _menhir_run47 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | OR ->
        _menhir_run38 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | POP ->
        _menhir_run36 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | PUSH ->
        _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | RET ->
        _menhir_run32 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | RSHIFT ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | STORE ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | SUB ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | XOR ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | EOF ->
        _menhir_reduce51 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)

# 269 "<standard.mly>"
  

# 2005 "compilateur/parser.ml"
