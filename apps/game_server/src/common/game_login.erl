-module(game_login).

-author("Naupio Z.Y. Huang").

-include("common_pb.hrl").

-export([
    login/3
]).

login(Cmd, Bin, WsState) ->
    Module = game_massage:decoder_for(Cmd),
    RecordName = game_massage:msg_type(Cmd),
    RecordData = Module:decode_msg(Bin, RecordName),
    NewWsState = login_handler(RecordData, WsState),
    NewWsState.

login_handler(#loginReq{cookie = Cookie}, #{ws_pid := WsPid} = WsState) ->
    UserId = game_mn:get_user_id_by_account(Cookie),
    {ok, UserPid} = supervisor:start_child(game_sup, [[UserId, WsPid]]),
    ws_util:ws_send(WsPid, #loginResp{result='SUCCESED', user_id = UserId, user_name = Cookie}),
    WsState#{logined => true, user_pid => UserPid}.