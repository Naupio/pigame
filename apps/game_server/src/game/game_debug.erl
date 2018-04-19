-module(game_debug).

-author("Naupio Z.Y. Huang").

-export([
        debug/2, debug/3
    ]).

debug(cmd, String) ->
    io:format(String);
debug(loginfo, String) ->
    logger:info(String);
debug(cmd_loginfo, String) ->
    debug(cmd, String),
    debug(loginfo, String).


debug(cmd, FormatStr, ArgsList) ->
    io:format(FormatStr, ArgsList);
debug(loginfo, FormatStr, ArgsList) ->
    logger:info(FormatStr, ArgsList);
debug(cmd_loginfo,FormatStr, ArgsList) ->
    debug(cmd, FormatStr, ArgsList),
    debug(loginfo, FormatStr, ArgsList).