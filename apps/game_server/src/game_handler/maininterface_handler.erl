-module(maininterface_handler).

-author("Naupio Z.Y. Huang").

-include("maininterface_pb.hrl").

-export([
        handle/2
    ]).

%% heartbeat for keep user alive.
handle(#userInfoReq{}, #{ws_pid := WsPid} = State) ->
    UserInfo = game_proto_util:proto_cast_change(State, userInfoResp, record_info(fields, userInfoResp)),
    game_ws_util:ws_send(WsPid, UserInfo),
    {noreply, State};

handle(Record, State) ->
    game_debug:debug(info,"~n~n module *~p* unknow  *Record* message:  ~p   with *State* ~p ~n~n", [?MODULE,Record, State]),   
    {noreply, State}.
