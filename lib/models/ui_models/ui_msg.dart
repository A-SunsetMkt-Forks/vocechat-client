import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vocechat_client/api/models/msg/msg_archive/archive.dart';
import 'package:vocechat_client/app_consts.dart';
import 'package:vocechat_client/app_methods.dart';
import 'package:vocechat_client/dao/init_dao/chat_msg.dart';
import 'package:vocechat_client/dao/init_dao/user_info.dart';
import 'package:vocechat_client/services/send_task_queue/send_task_queue.dart';

class UiMsg {
  ChatMsgM chatMsgM;
  ValueNotifier<MsgSendStatus> status = ValueNotifier(MsgSendStatus.success);
  File? file;
  Archive? archive;

  ChatMsgM? repliedMsgM;
  UserInfoM? repliedUserInfoM;
  File? repliedThumbFile;

  UiMsg(
      {required this.chatMsgM,
      // required this.status,
      this.file,
      this.archive,
      this.repliedMsgM,
      this.repliedUserInfoM,
      this.repliedThumbFile}) {
    status.value =
        SendTaskQueue.singleton.isWaitingOrExecuting(chatMsgM.localMid)
            ? MsgSendStatus.sending
            : getMsgSendStatus(chatMsgM.status);
  }
}
