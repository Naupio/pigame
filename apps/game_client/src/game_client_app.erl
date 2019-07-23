%%%-------------------------------------------------------------------
%% @doc game_client public API
%% @end
%%%-------------------------------------------------------------------

-module(game_client_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    game_client_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
