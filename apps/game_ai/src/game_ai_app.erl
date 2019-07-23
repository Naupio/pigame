%%%-------------------------------------------------------------------
%% @doc game_ai public API
%% @end
%%%-------------------------------------------------------------------

-module(game_ai_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    game_ai_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
