-module(game_role).

-author("Naupio Z.Y. Huang").

-include("game_user.hrl").
-include("common_pb.hrl") .
-include("maininterface_pb.hrl") .

-behaviour(gen_server).

%% callback function
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
terminate/2, code_change/3]).

%% API
-export([start_link/1, stop/2]).

-define(SERVER, ?MODULE).

-define(SAVE_TIME, 5000).
-define(CHECK_ONLINE_TIME, 30000).
-define(CHECK_ONLINE_LIMIT, 3).

stop(Pid, Reson) ->
    Pid ! {stop, Reson}.

start_link([UserId, WsPid]) ->
    gen_server:start_link(?MODULE, [UserId, WsPid], []).

init([UserId, WsPid]) ->
    State = game_mn:get_user_state(UserId),
    NewState = State#{user_pid := self(), ws_pid := WsPid, check_online_count := 0, statem_pid => none},
    erlang:send_after(?SAVE_TIME, self(), save_user_state),
    erlang:send_after(?CHECK_ONLINE_TIME, self(), check_online),
    {ok, NewState, 0}.
    
handle_call(_Msg, _From, _State) ->
    game_debug:debug(info,"~n~n module *~p* unknow  *CALL* message:  ~p   which *From*:  ~p   with *State* ~p ~n~n", [?MODULE,_Msg, _From, _State]),
    {noreply, _State}.

handle_cast({reconnect, WsPid}, #{user_id := UserId} = State) ->
    game_ws_util:ws_send(WsPid, #loginResp{result='SUCCEEDED', user_id = UserId}),
    UserInfo = game_proto_util:proto_cast_change(State, userInfoResp, record_info(fields, userInfoResp)),
    game_ws_util:ws_send(WsPid, UserInfo),
    {noreply, State#{check_online_count := 0, ws_pid := WsPid}};
handle_cast({cmd_routing, Cmd, Bin}, State) ->
    game_ws_routing:cmd_routing(Cmd, Bin, State);
handle_cast({change_gold, ChangeGold}, #{user_gold := UserGold} = State) ->
    {noreply, State#{user_gold := UserGold+ChangeGold}};
handle_cast(_Msg, _State) ->
    game_debug:debug(info,"~n~n module *~p* unknow  *CAST* message:  ~p   with *State* ~p ~n~n", [?MODULE,_Msg, _State]),   
    {noreply, _State}.

handle_info({stop, Reson} , State) ->
    {stop, Reson, State#{statem_pid := none}};
handle_info(check_online, #{check_online_count := COC} = State) ->
    case COC >= ?CHECK_ONLINE_LIMIT of
        true ->
            {stop,normal,State};
        false -> 
            erlang:send_after(?CHECK_ONLINE_TIME, self(), check_online),
            {noreply, State#{check_online_count := COC+1}}
    end;
handle_info(timeout, State) ->
    #{user_id := UserId,
      ws_pid := WsPid
    } = State,
    ets:insert(ets_user_online, #r_online{user_id = UserId, user_pid = self()}),
    game_ws_util:ws_send(WsPid, #loginResp{result='SUCCEEDED', user_id = UserId}),
    UserInfo = game_proto_util:proto_cast_change(State, userInfoResp, record_info(fields, userInfoResp)),
    game_ws_util:ws_send(WsPid, UserInfo),
    NewState = State#{user_tired := 100, user_tired_limit := 100},
    {noreply, NewState};
handle_info(save_user_state, State) ->
    game_mn:save_user_state(State),
    erlang:send_after(?SAVE_TIME, self(), save_user_state),
    {noreply, State};
handle_info(_Msg, _State) ->
    game_debug:debug(info,"~n~n module *~p* unknow  *INFO* message:  ~p   with *State* ~p ~n~n", [?MODULE, _Msg, _State]),
    {noreply, _State}.
    
terminate(_Reson, #{user_id := UserId, user_pid := UserPid, ws_pid := WsPid} = State) ->
    game_mn:save_user_state(State),
    case is_process_alive(WsPid) of
        true -> exit(WsPid, kill);
        false -> notdoing
    end,
    ets:delete(ets_user_online, UserId),
    game_debug:debug(info,"wwwwwww user terminate by user_id: ~p, user_pid: ~p, ws_pid: ~p   wwwwwww ~n"
            , [UserId, UserPid, WsPid]),
    ok.

code_change(_OldVsn, _State, _Extra) ->
    ok.
