%%%-------------------------------------------------------------------
%% @doc game_cache public API
%% @end
%%%-------------------------------------------------------------------

-module(game_cache_app).

-author("Nuapio Z.Y. Huang").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    {ok, SupPid} = game_cache_sup:start_link(),

    ok = game_ets:ets_start(),
    
    {ok, SupPid}.
    

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
