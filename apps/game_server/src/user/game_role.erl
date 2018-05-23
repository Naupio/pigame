-module(game_role).

-author("Naupio Z.Y. Huang").

-behaviour(gen_server).

%% callback function
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
terminate/2, code_change/3]).

%% API
-export([start_link/1]).

-define(SERVER, ?MODULE).

-define(SAVE_TIME, 5000).

start_link([UserId, WsPid]) ->
    gen_server:start_link(?MODULE, [UserId, WsPid], []).

init([UserId, WsPid]) ->
    State = game_mn:get_user_state(UserId),
    NewState = State#{user_id => UserId, user_pid => self(), ws_pid => WsPid},
    erlang:send_after(?SAVE_TIME, self(), save_user_state),
    {ok, NewState}.

handle_call(_Msg, _From, _State) ->
    game_debug:debug(error,"~n~n module *~p* unknow  *CALL* message:  ~p   which *From*:  ~p   with *State* ~p ~n~n", [?MODULE,_Msg, _From, _State]),
    {noreply, _State}.

handle_cast({cmd_routing, Cmd, Bin}, State) ->
    game_routing:cmd_routing(Cmd, Bin, State);
handle_cast(_Msg, _State) ->
    game_debug:debug(error,"~n~n module *~p* unknow  *CAST* message:  ~p   with *State* ~p ~n~n", [?MODULE,_Msg, _State]),   
    {noreply, _State}.
    
handle_info(save_user_state, State) ->
    game_mn:save_user_state(State),
    erlang:send_after(?SAVE_TIME, self(), save_user_state),
    {noreply, State};
handle_info(_Msg, _State) ->
    game_debug:debug(error,"~n~n module *~p* unknow  *INFO* message:  ~p   with *State* ~p ~n~n", [?MODULE, _Msg, _State]),
    {noreply, _State}.
    
terminate(_Reson, State) ->
    game_mn:save_user_state(State),
    ok.

code_change(_OldVsn, _State, _Extra) ->
    ok.
