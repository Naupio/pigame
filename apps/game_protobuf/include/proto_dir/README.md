```
// -------------------------------------------------------
//              用于 socket 和 websocket 流处理的包头描述
// -------------------------------------------------------

1.包头描述
Socket 客户度请求统一的结构为：<Len:32> <CMD:16>  <ProtoBuff/binary>
WebSocket 客户度请求统一的结构为：<CMD:16>  <ProtoBuff/binary>


命名规范：
enum xxxNameEnum  //枚举
{
    test_read_msg = 10000;
}

MSG的type子类型
message xxxNameType
{
    repeated string test = 1;
}



客户端的请求协议消息
名字：小写字母开头　驼峰式 Req结尾
消息内变量名：全为小写加下划线
message xxxNameReq
{
    required uint32 player_id = 1;
    optional string name = 2;
    optional TestType test = 3;
}

服务器的响应协议消息
名字：小写字母开头　驼峰式 Resp 结尾
消息内变量名：全为小写加下划线
message xxxNameResp
{
    required uint32 player_id = 1;
    optional string name = 2;
}

服务器的主动推送的消息
名字：小写字母开头　驼峰式 Push 结尾
消息内变量名：全为小写加下划线

消息内有消息嵌套时候, Type放在最后面,主题协议放在最前面

message xxxNamePush
{
    required uint32 player_id = 1;
    optional string name = 2;
    required xxxNameType type = 3;

    message xxxNameType
    {
        repeated string test = 1;
    }
}
```