-module(common_handler).

-author("Naupio Z.Y. Huang").

-include("common_pb.hrl").

-export([
        handle/2
    ]).

%% heartbeat for keep user alive.
handle(#heartbeatReq{}, #{ws_pid := WsPid} = State) ->
    UnixTime = game_util:unixtime(),
    RecordData = #heartbeatResp{unixtime = UnixTime},
    game_ws_util:ws_send(WsPid, RecordData),
    {noreply, State#{check_online_count := 0}};

%% Test proto for Hello World。
handle(#helloReq{msg = OptionalString}, #{ws_pid := WsPid} = State) ->
    case OptionalString of
        undefined ->
            RecordData = #worldResp{},
            game_ws_util:ws_send(WsPid, RecordData);
        _ ->
            RecordData = #worldResp{msg = OptionalString},
            game_ws_util:ws_send(WsPid, RecordData)
    end,
    {noreply, State};

handle(_Record, State) ->
    {noreply, State}.