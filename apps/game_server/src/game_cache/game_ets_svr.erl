-module(game_ets_svr).

-author("Naupio Z.Y. Huang").

-behaviour(gen_server).

%% callback function
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% api
-export([start_link/1]).

start_link({EtsName, Options}) ->
    gen_server:start_link({local, list_to_atom(lists:concat([EtsName,"_svr"]))}
                , ?MODULE, [EtsName, Options], []).

init([EtsName, Options]) ->
    ets:new(EtsName, Options),
    State = #{ets_name => EtsName, ets_options => Options},
    {ok, State}.

handle_call(_Msg, _From, _State) ->
    game_debug:debug(info,"~n~n module *~p* unknow  *CALL* message:  ~p   which *From*:  ~p   with *State* ~p ~n~n", [?MODULE,_Msg, _From, _State]),
    {noreply, _State}.

handle_cast(_Msg, _State) ->
    game_debug:debug(info,"~n~n module *~p* unknow  *CAST* message:  ~p   with *State* ~p ~n~n", [?MODULE,_Msg, _State]),   
    {noreply, _State}.
    
handle_info(_Msg, _State) ->
    game_debug:debug(info,"~n~n module *~p* unknow  *INFO* message:  ~p   with *State* ~p ~n~n", [?MODULE, _Msg, _State]),
    {noreply, _State}.
    
terminate(_Reson, _State) ->
    ok.

code_change(_OldVsn, _State, _Extra) ->
    ok.
