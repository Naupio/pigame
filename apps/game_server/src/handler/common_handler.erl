-module(common_handler).

-author("Naupio Z.Y. Huang").

-include("common_pb.hrl").

-export([
        handle/2
    ]).

handle(#helloReq{msg = OptionalString}, #{ws_pid := WsPid} = _State) ->
    case OptionalString of
        undefined ->
            RecordData = #worldResp{},
            ws_util:ws_send(WsPid, RecordData);
        _ ->
            RecordData = #worldResp{msg = OptionalString},
            ws_util:ws_send(WsPid, RecordData)
    end,
    ok;

handle(_Record, _State) ->
    ok.