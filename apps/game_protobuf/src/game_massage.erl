-module(game_massage).

-export([msg_type/1, msg_code/1, decoder_for/1]).

-spec msg_type(non_neg_integer()) -> atom().

msg_type(11) -> loginReq;
msg_type(12) -> loginResp;
msg_type(101) -> heartbeatReq;
msg_type(102) -> heartbeatResp;
msg_type(1001) -> helloReq;
msg_type(1002) -> worldResp;
msg_type(_) -> undefined.

-spec msg_code(atom()) -> non_neg_integer().

msg_code(loginReq) -> 11;
msg_code(loginResp) -> 12;
msg_code(heartbeatReq) -> 101;
msg_code(heartbeatResp) -> 102;
msg_code(helloReq) -> 1001;
msg_code(worldResp) -> 1002.

-spec decoder_for(non_neg_integer()) -> module().


decoder_for(11) -> common_pb;
decoder_for(12) -> common_pb;
decoder_for(101) -> common_pb;
decoder_for(102) -> common_pb;
decoder_for(1001) -> common_pb;
decoder_for(1002) -> common_pb.