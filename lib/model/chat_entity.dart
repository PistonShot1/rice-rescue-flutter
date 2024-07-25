class ChatEntity {
  final String? chatRole;
  final String? chatContent;

  ChatEntity({this.chatRole, this.chatContent});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'role': chatRole, 'content': chatContent};
  }

  factory ChatEntity.fromJson(Map<String, dynamic> json) {
    return ChatEntity(chatRole: json['role'], chatContent: json['content']);
  }
}
