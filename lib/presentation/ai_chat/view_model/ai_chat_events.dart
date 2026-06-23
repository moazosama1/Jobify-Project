import 'dart:typed_data';

sealed class AiChatEvents {
  const AiChatEvents();
}

class LoadAiChatHistoryEvent extends AiChatEvents {
  const LoadAiChatHistoryEvent();
}

class SendAiChatMessageEvent extends AiChatEvents {
  final String text;
  const SendAiChatMessageEvent(this.text);
}

class ClearAiChatHistoryEvent extends AiChatEvents {
  const ClearAiChatHistoryEvent();
}

class SelectPdfAiChatEvent extends AiChatEvents {
  final Uint8List bytes;
  final String name;
  const SelectPdfAiChatEvent(this.bytes, this.name);
}

class RemoveSelectedPdfAiChatEvent extends AiChatEvents {
  const RemoveSelectedPdfAiChatEvent();
}

