-module(ws_util).

-author("Naupio Z.Y. Huang").

-export([
        ws_send/2
    ]).

ws_send(SendPid, RecordData) ->
    RecordName = element(1, RecordData),
    Cmd = pb_messages:msg_code(RecordName),
    Module = pb_messages:decoder_for(Cmd),
    Bin = Module:encode_msg(RecordData),
    BinRecordData = <<Cmd:16, Bin/binary>>,
    SendPid ! {send_binary, BinRecordData}.