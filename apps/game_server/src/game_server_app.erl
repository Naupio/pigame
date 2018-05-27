%%%-------------------------------------------------------------------
%% @doc game_server public API
%% @end
%%%-------------------------------------------------------------------

-module(game_server_app).

-author("Nuapio Z.Y. Huang").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    {ok, SupPid} = game_server_sup:start_link(),
    ok = game_web:network_start(),
    ok = game_mnesia:mnesia_start(),
    ok = game_ets:ets_start(),
    {ok, SupPid}.

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================