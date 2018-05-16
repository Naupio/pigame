-module(common_handler).

-author("Naupio Z.Y. Huang").

-include("common_pb.hrl").

-export([
        handle/2
    ]).

%% heartbeat for keep user alive.
handle(#heartbeatReq{}, #{ws_pid := WsPid} = _State) ->
    UnixTime = game_util:unixtime(),
    RecordData = #heartbeatResp{unixtime = UnixTime},
    ws_util:ws_send(WsPid, RecordData),
    ok;

%% Test proto for Hello World。
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