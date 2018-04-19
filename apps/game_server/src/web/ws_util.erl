-module(ws_util).

-author("Naupio Z.Y. Huang").

-export([
        ws_send/2
    ]).

ws_send(WsPid, RecordData) ->
    RecordName = element(1, RecordData),
    Cmd = pb_messages:msg_code(RecordName),
    Module = pb_messages:decoder_for(Cmd),
    Bin = Module:encode_msg(RecordData),
    BinRecordData = <<Cmd:16, Bin/binary>>,
    game_debug:debug(cmd_loginfo,"wwwwwww WsPid: ~p, protobuf send: ~p   wwwwwww ~n", [WsPid, RecordData]),
    WsPid ! {send_binary, BinRecordData}.