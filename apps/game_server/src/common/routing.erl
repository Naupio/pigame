-module(routing).

-author("Naupio Z.Y. Huang").

-export([
    cmd_routing/3
]).

cmd_routing(Cmd, Bin, State) ->
    Module = game_massage:decoder_for(Cmd),
    RecordName = game_massage:msg_type(Cmd),
    RecordData = Module:decode_msg(Bin, RecordName),

    NewModule = list_to_atom(lists:concat([hd(string:split(atom_to_list(Module),"_",trailing)), "_handler"])),
    NewModule:handle(RecordData, State),
    ok.