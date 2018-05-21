-module(game_routing).

-author("Naupio Z.Y. Huang").

-export([
    cmd_routing/3
]).

cmd_routing(Cmd, Bin, #{ws_pid := WsPid} = State) ->
    Module = game_massage:decoder_for(Cmd),
    RecordName = game_massage:msg_type(Cmd),
    RecordData = Module:decode_msg(Bin, RecordName),
    game_debug:debug(error,"wwwwwww WsPid : ~p, protobuf recevie: ~p ~n  wwwwwww", [WsPid, RecordData]),
    NewModule = list_to_atom(lists:concat([hd(string:split(atom_to_list(Module),"_",trailing)), "_handler"])),
    NewModule:handle(RecordData, State).