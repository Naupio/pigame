-module(game_ws_routing).

-author("Naupio Z.Y. Huang").

-export([
    cmd_routing/3
]).

cmd_routing(Cmd, Bin, #{ws_pid := WsPid} = State) ->
    ProtocolModule = game_massage:decoder_for(Cmd),
    RecordName = game_massage:msg_type(Cmd),
    RecordData = ProtocolModule:decode_msg(Bin, RecordName),
    case Cmd of
        101 ->
            notdoing;
        _ ->
            game_debug:debug(info,"wwwwwww WsPid : ~p, protobuf recevie: ~p ~n  wwwwwww", [WsPid, RecordData])
    end,
    HandlerModule = list_to_atom(lists:concat([hd(string:split(atom_to_list(ProtocolModule),"_",trailing)), "_handler"])),
    HandlerModule:handle(RecordData, State).