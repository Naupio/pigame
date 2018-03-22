-module(game_massage).

-export([msg_type/1, msg_code/1, decoder_for/1]).

-spec msg_type(non_neg_integer()) -> atom().

msg_type(10001) -> helloReq;
msg_type(10002) -> worldResp;
msg_type(_) -> undefined.

-spec msg_code(atom()) -> non_neg_integer().

msg_code(helloReq) -> 10001;
msg_code(worldResp) -> 10002.

-spec decoder_for(non_neg_integer()) -> module().


decoder_for(10001) -> common_pb;
decoder_for(10002) -> common_pb.