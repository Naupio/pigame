-module(logger).

-author("Naupio Z.Y. Huang").

-export([
        info/1, info/2,
        debug/1, debug/2,
        warning/1, warning/2,
        error/1, error/2
    ]).

info(String) ->
    % error_logger:info_msg(String).
    lager:info(String).

info(FormatStr,ArgsList) ->
    % error_logger:info_msg(FormatStr,ArgsList).
    lager:info(FormatStr,ArgsList).

error(String) ->
    % error_logger:error_msg(String).
    lager:error(String).

error(FormatStr,ArgsList) ->
    % error_logger:error_msg(FormatStr,ArgsList).
    lager:error(FormatStr,ArgsList).

warning(String) ->
    % error_logger:warning_msg(String).
    lager:warning(String).

warning(FormatStr,ArgsList) ->
    % error_logger:warning_msg(FormatStr,ArgsList).
    lager:warning(FormatStr,ArgsList).

debug(String) ->
    % info(String).
    lager:debug(String).

debug(FormatStr,ArgsList) ->
    % info(FormatStr,ArgsList).
    lager:debug(FormatStr,ArgsList).