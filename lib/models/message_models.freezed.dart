// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({int id, String name, String? avatar, String? email});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? avatar, String? email});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
    Object? email = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id, required this.name, this.avatar, this.email});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? avatar;
  @override
  final String? email;

  @override
  String toString() {
    return 'User(id: $id, name: $name, avatar: $avatar, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatar, email);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final int id,
      required final String name,
      final String? avatar,
      final String? email}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  String? get email;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  int? get id => throw _privateConstructorUsedError;
  int get senderId => throw _privateConstructorUsedError;
  int? get receiverId => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get messageType => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  User? get sender => throw _privateConstructorUsedError;
  User? get receiver => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {int? id,
      int senderId,
      int? receiverId,
      String conversationId,
      String content,
      String messageType,
      bool isRead,
      DateTime? readAt,
      DateTime? deletedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      User? sender,
      User? receiver});

  $UserCopyWith<$Res>? get sender;
  $UserCopyWith<$Res>? get receiver;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? senderId = null,
    Object? receiverId = freezed,
    Object? conversationId = null,
    Object? content = null,
    Object? messageType = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? deletedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? sender = freezed,
    Object? receiver = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _value.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as User?,
      receiver: freezed == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get receiver {
    if (_value.receiver == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.receiver!, (value) {
      return _then(_value.copyWith(receiver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int senderId,
      int? receiverId,
      String conversationId,
      String content,
      String messageType,
      bool isRead,
      DateTime? readAt,
      DateTime? deletedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      User? sender,
      User? receiver});

  @override
  $UserCopyWith<$Res>? get sender;
  @override
  $UserCopyWith<$Res>? get receiver;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? senderId = null,
    Object? receiverId = freezed,
    Object? conversationId = null,
    Object? content = null,
    Object? messageType = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? deletedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? sender = freezed,
    Object? receiver = freezed,
  }) {
    return _then(_$MessageImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _value.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as User?,
      receiver: freezed == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {this.id,
      required this.senderId,
      this.receiverId,
      required this.conversationId,
      required this.content,
      this.messageType = 'text',
      this.isRead = false,
      this.readAt,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.sender,
      this.receiver});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final int? id;
  @override
  final int senderId;
  @override
  final int? receiverId;
  @override
  final String conversationId;
  @override
  final String content;
  @override
  @JsonKey()
  final String messageType;
  @override
  @JsonKey()
  final bool isRead;
  @override
  final DateTime? readAt;
  @override
  final DateTime? deletedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final User? sender;
  @override
  final User? receiver;

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, receiverId: $receiverId, conversationId: $conversationId, content: $content, messageType: $messageType, isRead: $isRead, readAt: $readAt, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, sender: $sender, receiver: $receiver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      senderId,
      receiverId,
      conversationId,
      content,
      messageType,
      isRead,
      readAt,
      deletedAt,
      createdAt,
      updatedAt,
      sender,
      receiver);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {final int? id,
      required final int senderId,
      final int? receiverId,
      required final String conversationId,
      required final String content,
      final String messageType,
      final bool isRead,
      final DateTime? readAt,
      final DateTime? deletedAt,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final User? sender,
      final User? receiver}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  int? get id;
  @override
  int get senderId;
  @override
  int? get receiverId;
  @override
  String get conversationId;
  @override
  String get content;
  @override
  String get messageType;
  @override
  bool get isRead;
  @override
  DateTime? get readAt;
  @override
  DateTime? get deletedAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  User? get sender;
  @override
  User? get receiver;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  int? get id => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  List<int> get participantIds => throw _privateConstructorUsedError;
  int? get lastMessageId => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  bool get isGroup => throw _privateConstructorUsedError;
  String? get groupName => throw _privateConstructorUsedError;
  String? get groupAvatar => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call(
      {int? id,
      String conversationId,
      List<int> participantIds,
      int? lastMessageId,
      DateTime? lastMessageAt,
      bool isGroup,
      String? groupName,
      String? groupAvatar,
      List<Message> messages});
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? conversationId = null,
    Object? participantIds = null,
    Object? lastMessageId = freezed,
    Object? lastMessageAt = freezed,
    Object? isGroup = null,
    Object? groupName = freezed,
    Object? groupAvatar = freezed,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      participantIds: null == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      lastMessageId: freezed == lastMessageId
          ? _value.lastMessageId
          : lastMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      groupAvatar: freezed == groupAvatar
          ? _value.groupAvatar
          : groupAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
          _$ConversationImpl value, $Res Function(_$ConversationImpl) then) =
      __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String conversationId,
      List<int> participantIds,
      int? lastMessageId,
      DateTime? lastMessageAt,
      bool isGroup,
      String? groupName,
      String? groupAvatar,
      List<Message> messages});
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
      _$ConversationImpl _value, $Res Function(_$ConversationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? conversationId = null,
    Object? participantIds = null,
    Object? lastMessageId = freezed,
    Object? lastMessageAt = freezed,
    Object? isGroup = null,
    Object? groupName = freezed,
    Object? groupAvatar = freezed,
    Object? messages = null,
  }) {
    return _then(_$ConversationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      participantIds: null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      lastMessageId: freezed == lastMessageId
          ? _value.lastMessageId
          : lastMessageId // ignore: cast_nullable_to_non_nullable
              as int?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      groupAvatar: freezed == groupAvatar
          ? _value.groupAvatar
          : groupAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl(
      {this.id,
      required this.conversationId,
      required final List<int> participantIds,
      this.lastMessageId,
      this.lastMessageAt,
      this.isGroup = false,
      this.groupName,
      this.groupAvatar,
      final List<Message> messages = const []})
      : _participantIds = participantIds,
        _messages = messages;

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final int? id;
  @override
  final String conversationId;
  final List<int> _participantIds;
  @override
  List<int> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  final int? lastMessageId;
  @override
  final DateTime? lastMessageAt;
  @override
  @JsonKey()
  final bool isGroup;
  @override
  final String? groupName;
  @override
  final String? groupAvatar;
  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'Conversation(id: $id, conversationId: $conversationId, participantIds: $participantIds, lastMessageId: $lastMessageId, lastMessageAt: $lastMessageAt, isGroup: $isGroup, groupName: $groupName, groupAvatar: $groupAvatar, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            (identical(other.lastMessageId, lastMessageId) ||
                other.lastMessageId == lastMessageId) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            (identical(other.isGroup, isGroup) || other.isGroup == isGroup) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.groupAvatar, groupAvatar) ||
                other.groupAvatar == groupAvatar) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      conversationId,
      const DeepCollectionEquality().hash(_participantIds),
      lastMessageId,
      lastMessageAt,
      isGroup,
      groupName,
      groupAvatar,
      const DeepCollectionEquality().hash(_messages));

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(
      this,
    );
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation(
      {final int? id,
      required final String conversationId,
      required final List<int> participantIds,
      final int? lastMessageId,
      final DateTime? lastMessageAt,
      final bool isGroup,
      final String? groupName,
      final String? groupAvatar,
      final List<Message> messages}) = _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  int? get id;
  @override
  String get conversationId;
  @override
  List<int> get participantIds;
  @override
  int? get lastMessageId;
  @override
  DateTime? get lastMessageAt;
  @override
  bool get isGroup;
  @override
  String? get groupName;
  @override
  String? get groupAvatar;
  @override
  List<Message> get messages;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WebSocketMessage _$WebSocketMessageFromJson(Map<String, dynamic> json) {
  return _WebSocketMessage.fromJson(json);
}

/// @nodoc
mixin _$WebSocketMessage {
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;

  /// Serializes this WebSocketMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSocketMessageCopyWith<WebSocketMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketMessageCopyWith<$Res> {
  factory $WebSocketMessageCopyWith(
          WebSocketMessage value, $Res Function(WebSocketMessage) then) =
      _$WebSocketMessageCopyWithImpl<$Res, WebSocketMessage>;
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class _$WebSocketMessageCopyWithImpl<$Res, $Val extends WebSocketMessage>
    implements $WebSocketMessageCopyWith<$Res> {
  _$WebSocketMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebSocketMessageImplCopyWith<$Res>
    implements $WebSocketMessageCopyWith<$Res> {
  factory _$$WebSocketMessageImplCopyWith(_$WebSocketMessageImpl value,
          $Res Function(_$WebSocketMessageImpl) then) =
      __$$WebSocketMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class __$$WebSocketMessageImplCopyWithImpl<$Res>
    extends _$WebSocketMessageCopyWithImpl<$Res, _$WebSocketMessageImpl>
    implements _$$WebSocketMessageImplCopyWith<$Res> {
  __$$WebSocketMessageImplCopyWithImpl(_$WebSocketMessageImpl _value,
      $Res Function(_$WebSocketMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_$WebSocketMessageImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSocketMessageImpl implements _WebSocketMessage {
  const _$WebSocketMessageImpl(
      {required this.type, required final Map<String, dynamic> payload})
      : _payload = payload;

  factory _$WebSocketMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSocketMessageImplFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  String toString() {
    return 'WebSocketMessage(type: $type, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketMessageImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_payload));

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketMessageImplCopyWith<_$WebSocketMessageImpl> get copyWith =>
      __$$WebSocketMessageImplCopyWithImpl<_$WebSocketMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSocketMessageImplToJson(
      this,
    );
  }
}

abstract class _WebSocketMessage implements WebSocketMessage {
  const factory _WebSocketMessage(
      {required final String type,
      required final Map<String, dynamic> payload}) = _$WebSocketMessageImpl;

  factory _WebSocketMessage.fromJson(Map<String, dynamic> json) =
      _$WebSocketMessageImpl.fromJson;

  @override
  String get type;
  @override
  Map<String, dynamic> get payload;

  /// Create a copy of WebSocketMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketMessageImplCopyWith<_$WebSocketMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessagePayload _$MessagePayloadFromJson(Map<String, dynamic> json) {
  return _MessagePayload.fromJson(json);
}

/// @nodoc
mixin _$MessagePayload {
  Message get message => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;

  /// Serializes this MessagePayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessagePayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessagePayloadCopyWith<MessagePayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagePayloadCopyWith<$Res> {
  factory $MessagePayloadCopyWith(
          MessagePayload value, $Res Function(MessagePayload) then) =
      _$MessagePayloadCopyWithImpl<$Res, MessagePayload>;
  @useResult
  $Res call({Message message, String conversationId});

  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class _$MessagePayloadCopyWithImpl<$Res, $Val extends MessagePayload>
    implements $MessagePayloadCopyWith<$Res> {
  _$MessagePayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessagePayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? conversationId = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of MessagePayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res> get message {
    return $MessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessagePayloadImplCopyWith<$Res>
    implements $MessagePayloadCopyWith<$Res> {
  factory _$$MessagePayloadImplCopyWith(_$MessagePayloadImpl value,
          $Res Function(_$MessagePayloadImpl) then) =
      __$$MessagePayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Message message, String conversationId});

  @override
  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$MessagePayloadImplCopyWithImpl<$Res>
    extends _$MessagePayloadCopyWithImpl<$Res, _$MessagePayloadImpl>
    implements _$$MessagePayloadImplCopyWith<$Res> {
  __$$MessagePayloadImplCopyWithImpl(
      _$MessagePayloadImpl _value, $Res Function(_$MessagePayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessagePayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? conversationId = null,
  }) {
    return _then(_$MessagePayloadImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessagePayloadImpl implements _MessagePayload {
  const _$MessagePayloadImpl(
      {required this.message, required this.conversationId});

  factory _$MessagePayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessagePayloadImplFromJson(json);

  @override
  final Message message;
  @override
  final String conversationId;

  @override
  String toString() {
    return 'MessagePayload(message: $message, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagePayloadImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, conversationId);

  /// Create a copy of MessagePayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagePayloadImplCopyWith<_$MessagePayloadImpl> get copyWith =>
      __$$MessagePayloadImplCopyWithImpl<_$MessagePayloadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessagePayloadImplToJson(
      this,
    );
  }
}

abstract class _MessagePayload implements MessagePayload {
  const factory _MessagePayload(
      {required final Message message,
      required final String conversationId}) = _$MessagePayloadImpl;

  factory _MessagePayload.fromJson(Map<String, dynamic> json) =
      _$MessagePayloadImpl.fromJson;

  @override
  Message get message;
  @override
  String get conversationId;

  /// Create a copy of MessagePayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessagePayloadImplCopyWith<_$MessagePayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TypingPayload _$TypingPayloadFromJson(Map<String, dynamic> json) {
  return _TypingPayload.fromJson(json);
}

/// @nodoc
mixin _$TypingPayload {
  int get userId => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;

  /// Serializes this TypingPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypingPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypingPayloadCopyWith<TypingPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypingPayloadCopyWith<$Res> {
  factory $TypingPayloadCopyWith(
          TypingPayload value, $Res Function(TypingPayload) then) =
      _$TypingPayloadCopyWithImpl<$Res, TypingPayload>;
  @useResult
  $Res call({int userId, String conversationId, bool isTyping});
}

/// @nodoc
class _$TypingPayloadCopyWithImpl<$Res, $Val extends TypingPayload>
    implements $TypingPayloadCopyWith<$Res> {
  _$TypingPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypingPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? conversationId = null,
    Object? isTyping = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypingPayloadImplCopyWith<$Res>
    implements $TypingPayloadCopyWith<$Res> {
  factory _$$TypingPayloadImplCopyWith(
          _$TypingPayloadImpl value, $Res Function(_$TypingPayloadImpl) then) =
      __$$TypingPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, String conversationId, bool isTyping});
}

/// @nodoc
class __$$TypingPayloadImplCopyWithImpl<$Res>
    extends _$TypingPayloadCopyWithImpl<$Res, _$TypingPayloadImpl>
    implements _$$TypingPayloadImplCopyWith<$Res> {
  __$$TypingPayloadImplCopyWithImpl(
      _$TypingPayloadImpl _value, $Res Function(_$TypingPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypingPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? conversationId = null,
    Object? isTyping = null,
  }) {
    return _then(_$TypingPayloadImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TypingPayloadImpl implements _TypingPayload {
  const _$TypingPayloadImpl(
      {required this.userId,
      required this.conversationId,
      required this.isTyping});

  factory _$TypingPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypingPayloadImplFromJson(json);

  @override
  final int userId;
  @override
  final String conversationId;
  @override
  final bool isTyping;

  @override
  String toString() {
    return 'TypingPayload(userId: $userId, conversationId: $conversationId, isTyping: $isTyping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypingPayloadImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, conversationId, isTyping);

  /// Create a copy of TypingPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypingPayloadImplCopyWith<_$TypingPayloadImpl> get copyWith =>
      __$$TypingPayloadImplCopyWithImpl<_$TypingPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypingPayloadImplToJson(
      this,
    );
  }
}

abstract class _TypingPayload implements TypingPayload {
  const factory _TypingPayload(
      {required final int userId,
      required final String conversationId,
      required final bool isTyping}) = _$TypingPayloadImpl;

  factory _TypingPayload.fromJson(Map<String, dynamic> json) =
      _$TypingPayloadImpl.fromJson;

  @override
  int get userId;
  @override
  String get conversationId;
  @override
  bool get isTyping;

  /// Create a copy of TypingPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypingPayloadImplCopyWith<_$TypingPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OnlineStatusPayload _$OnlineStatusPayloadFromJson(Map<String, dynamic> json) {
  return _OnlineStatusPayload.fromJson(json);
}

/// @nodoc
mixin _$OnlineStatusPayload {
  int get userId => throw _privateConstructorUsedError;
  bool get online => throw _privateConstructorUsedError;

  /// Serializes this OnlineStatusPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OnlineStatusPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnlineStatusPayloadCopyWith<OnlineStatusPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlineStatusPayloadCopyWith<$Res> {
  factory $OnlineStatusPayloadCopyWith(
          OnlineStatusPayload value, $Res Function(OnlineStatusPayload) then) =
      _$OnlineStatusPayloadCopyWithImpl<$Res, OnlineStatusPayload>;
  @useResult
  $Res call({int userId, bool online});
}

/// @nodoc
class _$OnlineStatusPayloadCopyWithImpl<$Res, $Val extends OnlineStatusPayload>
    implements $OnlineStatusPayloadCopyWith<$Res> {
  _$OnlineStatusPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnlineStatusPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? online = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlineStatusPayloadImplCopyWith<$Res>
    implements $OnlineStatusPayloadCopyWith<$Res> {
  factory _$$OnlineStatusPayloadImplCopyWith(_$OnlineStatusPayloadImpl value,
          $Res Function(_$OnlineStatusPayloadImpl) then) =
      __$$OnlineStatusPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, bool online});
}

/// @nodoc
class __$$OnlineStatusPayloadImplCopyWithImpl<$Res>
    extends _$OnlineStatusPayloadCopyWithImpl<$Res, _$OnlineStatusPayloadImpl>
    implements _$$OnlineStatusPayloadImplCopyWith<$Res> {
  __$$OnlineStatusPayloadImplCopyWithImpl(_$OnlineStatusPayloadImpl _value,
      $Res Function(_$OnlineStatusPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnlineStatusPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? online = null,
  }) {
    return _then(_$OnlineStatusPayloadImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlineStatusPayloadImpl implements _OnlineStatusPayload {
  const _$OnlineStatusPayloadImpl({required this.userId, required this.online});

  factory _$OnlineStatusPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlineStatusPayloadImplFromJson(json);

  @override
  final int userId;
  @override
  final bool online;

  @override
  String toString() {
    return 'OnlineStatusPayload(userId: $userId, online: $online)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlineStatusPayloadImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.online, online) || other.online == online));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, online);

  /// Create a copy of OnlineStatusPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlineStatusPayloadImplCopyWith<_$OnlineStatusPayloadImpl> get copyWith =>
      __$$OnlineStatusPayloadImplCopyWithImpl<_$OnlineStatusPayloadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlineStatusPayloadImplToJson(
      this,
    );
  }
}

abstract class _OnlineStatusPayload implements OnlineStatusPayload {
  const factory _OnlineStatusPayload(
      {required final int userId,
      required final bool online}) = _$OnlineStatusPayloadImpl;

  factory _OnlineStatusPayload.fromJson(Map<String, dynamic> json) =
      _$OnlineStatusPayloadImpl.fromJson;

  @override
  int get userId;
  @override
  bool get online;

  /// Create a copy of OnlineStatusPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnlineStatusPayloadImplCopyWith<_$OnlineStatusPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
