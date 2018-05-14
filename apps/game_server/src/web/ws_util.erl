-module(ws_util).

-author("Naupio Z.Y. Huang").

-export([
        ws_send/2
    ]).

ws_send(WsPid, RecordData) ->
    RecordName = element(1, RecordData),
    Cmd = game_massage:msg_code(RecordName),
    Module = game_massage:decoder_for(Cmd),
    Bin = Module:encode_msg(RecordData),
    BinRecordData = <<Cmd:16, Bin/binary>>,
    game_debug:debug(error,"wwwwwww WsPid: ~p, protobuf send: ~p   wwwwwww ~n", [WsPid, RecordData]),
    WsPid ! {send_binary, BinRecordData}.