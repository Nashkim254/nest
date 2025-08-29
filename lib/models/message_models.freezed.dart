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

ConversationResponse _$ConversationResponseFromJson(Map<String, dynamic> json) {
  return _ConversationResponse.fromJson(json);
}

/// @nodoc
mixin _$ConversationResponse {
  List<Conversation> get conversations => throw _privateConstructorUsedError;

  /// Serializes this ConversationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationResponseCopyWith<ConversationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationResponseCopyWith<$Res> {
  factory $ConversationResponseCopyWith(ConversationResponse value,
          $Res Function(ConversationResponse) then) =
      _$ConversationResponseCopyWithImpl<$Res, ConversationResponse>;
  @useResult
  $Res call({List<Conversation> conversations});
}

/// @nodoc
class _$ConversationResponseCopyWithImpl<$Res,
        $Val extends ConversationResponse>
    implements $ConversationResponseCopyWith<$Res> {
  _$ConversationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
  }) {
    return _then(_value.copyWith(
      conversations: null == conversations
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationResponseImplCopyWith<$Res>
    implements $ConversationResponseCopyWith<$Res> {
  factory _$$ConversationResponseImplCopyWith(_$ConversationResponseImpl value,
          $Res Function(_$ConversationResponseImpl) then) =
      __$$ConversationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Conversation> conversations});
}

/// @nodoc
class __$$ConversationResponseImplCopyWithImpl<$Res>
    extends _$ConversationResponseCopyWithImpl<$Res, _$ConversationResponseImpl>
    implements _$$ConversationResponseImplCopyWith<$Res> {
  __$$ConversationResponseImplCopyWithImpl(_$ConversationResponseImpl _value,
      $Res Function(_$ConversationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversations = null,
  }) {
    return _then(_$ConversationResponseImpl(
      conversations: null == conversations
          ? _value._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationResponseImpl implements _ConversationResponse {
  const _$ConversationResponseImpl(
      {required final List<Conversation> conversations})
      : _conversations = conversations;

  factory _$ConversationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationResponseImplFromJson(json);

  final List<Conversation> _conversations;
  @override
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  String toString() {
    return 'ConversationResponse(conversations: $conversations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_conversations));

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationResponseImplCopyWith<_$ConversationResponseImpl>
      get copyWith =>
          __$$ConversationResponseImplCopyWithImpl<_$ConversationResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationResponseImplToJson(
      this,
    );
  }
}

abstract class _ConversationResponse implements ConversationResponse {
  const factory _ConversationResponse(
          {required final List<Conversation> conversations}) =
      _$ConversationResponseImpl;

  factory _ConversationResponse.fromJson(Map<String, dynamic> json) =
      _$ConversationResponseImpl.fromJson;

  @override
  List<Conversation> get conversations;

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationResponseImplCopyWith<_$ConversationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) {
  return _MessageResponse.fromJson(json);
}

/// @nodoc
mixin _$MessageResponse {
// Made these nullable in case API returns null
  int? get limit => throw _privateConstructorUsedError;
  int? get offset => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;

  /// Serializes this MessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageResponseCopyWith<MessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageResponseCopyWith<$Res> {
  factory $MessageResponseCopyWith(
          MessageResponse value, $Res Function(MessageResponse) then) =
      _$MessageResponseCopyWithImpl<$Res, MessageResponse>;
  @useResult
  $Res call({int? limit, int? offset, List<Message> messages});
}

/// @nodoc
class _$MessageResponseCopyWithImpl<$Res, $Val extends MessageResponse>
    implements $MessageResponseCopyWith<$Res> {
  _$MessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = freezed,
    Object? offset = freezed,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageResponseImplCopyWith<$Res>
    implements $MessageResponseCopyWith<$Res> {
  factory _$$MessageResponseImplCopyWith(_$MessageResponseImpl value,
          $Res Function(_$MessageResponseImpl) then) =
      __$$MessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? limit, int? offset, List<Message> messages});
}

/// @nodoc
class __$$MessageResponseImplCopyWithImpl<$Res>
    extends _$MessageResponseCopyWithImpl<$Res, _$MessageResponseImpl>
    implements _$$MessageResponseImplCopyWith<$Res> {
  __$$MessageResponseImplCopyWithImpl(
      _$MessageResponseImpl _value, $Res Function(_$MessageResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = freezed,
    Object? offset = freezed,
    Object? messages = null,
  }) {
    return _then(_$MessageResponseImpl(
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageResponseImpl implements _MessageResponse {
  const _$MessageResponseImpl(
      {this.limit, this.offset, final List<Message> messages = const []})
      : _messages = messages;

  factory _$MessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageResponseImplFromJson(json);

// Made these nullable in case API returns null
  @override
  final int? limit;
  @override
  final int? offset;
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
    return 'MessageResponse(limit: $limit, offset: $offset, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageResponseImpl &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, limit, offset,
      const DeepCollectionEquality().hash(_messages));

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageResponseImplCopyWith<_$MessageResponseImpl> get copyWith =>
      __$$MessageResponseImplCopyWithImpl<_$MessageResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageResponseImplToJson(
      this,
    );
  }
}

abstract class _MessageResponse implements MessageResponse {
  const factory _MessageResponse(
      {final int? limit,
      final int? offset,
      final List<Message> messages}) = _$MessageResponseImpl;

  factory _MessageResponse.fromJson(Map<String, dynamic> json) =
      _$MessageResponseImpl.fromJson;

// Made these nullable in case API returns null
  @override
  int? get limit;
  @override
  int? get offset;
  @override
  List<Message> get messages;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageResponseImplCopyWith<_$MessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
// Updated to match your API response - using lowercase 'id' instead of 'ID'
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_picture')
  String? get avatar => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'whatsapp_number')
  String? get whatsappNumber => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  List<String>? get interests => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_private')
  bool get isPrivate => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_on_guest_list')
  bool get showOnGuestList => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_events')
  bool get showEvents => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_active')
  DateTime? get lastActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_login')
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  @JsonKey(name: 'qdrant_id')
  String? get qdrantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

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
  $Res call(
      {int? id,
      @JsonKey(name: 'display_name') String? name,
      @JsonKey(name: 'profile_picture') String? avatar,
      String? email,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      @JsonKey(name: 'whatsapp_number') String? whatsappNumber,
      String? bio,
      List<String>? interests,
      double? longitude,
      double? latitude,
      String? location,
      @JsonKey(name: 'is_private') bool isPrivate,
      @JsonKey(name: 'show_on_guest_list') bool showOnGuestList,
      @JsonKey(name: 'show_events') bool showEvents,
      @JsonKey(name: 'last_active') DateTime? lastActive,
      @JsonKey(name: 'last_login') DateTime? lastLogin,
      @JsonKey(name: 'qdrant_id') String? qdrantId,
      @JsonKey(name: 'is_verified') bool isVerified,
      @JsonKey(name: 'is_active') bool isActive,
      String? role});
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
    Object? id = freezed,
    Object? name = freezed,
    Object? avatar = freezed,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phoneNumber = freezed,
    Object? whatsappNumber = freezed,
    Object? bio = freezed,
    Object? interests = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? location = freezed,
    Object? isPrivate = null,
    Object? showOnGuestList = null,
    Object? showEvents = null,
    Object? lastActive = freezed,
    Object? lastLogin = freezed,
    Object? qdrantId = freezed,
    Object? isVerified = null,
    Object? isActive = null,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      whatsappNumber: freezed == whatsappNumber
          ? _value.whatsappNumber
          : whatsappNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: freezed == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      showOnGuestList: null == showOnGuestList
          ? _value.showOnGuestList
          : showOnGuestList // ignore: cast_nullable_to_non_nullable
              as bool,
      showEvents: null == showEvents
          ? _value.showEvents
          : showEvents // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      qdrantId: freezed == qdrantId
          ? _value.qdrantId
          : qdrantId // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {int? id,
      @JsonKey(name: 'display_name') String? name,
      @JsonKey(name: 'profile_picture') String? avatar,
      String? email,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      @JsonKey(name: 'whatsapp_number') String? whatsappNumber,
      String? bio,
      List<String>? interests,
      double? longitude,
      double? latitude,
      String? location,
      @JsonKey(name: 'is_private') bool isPrivate,
      @JsonKey(name: 'show_on_guest_list') bool showOnGuestList,
      @JsonKey(name: 'show_events') bool showEvents,
      @JsonKey(name: 'last_active') DateTime? lastActive,
      @JsonKey(name: 'last_login') DateTime? lastLogin,
      @JsonKey(name: 'qdrant_id') String? qdrantId,
      @JsonKey(name: 'is_verified') bool isVerified,
      @JsonKey(name: 'is_active') bool isActive,
      String? role});
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
    Object? id = freezed,
    Object? name = freezed,
    Object? avatar = freezed,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phoneNumber = freezed,
    Object? whatsappNumber = freezed,
    Object? bio = freezed,
    Object? interests = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? location = freezed,
    Object? isPrivate = null,
    Object? showOnGuestList = null,
    Object? showEvents = null,
    Object? lastActive = freezed,
    Object? lastLogin = freezed,
    Object? qdrantId = freezed,
    Object? isVerified = null,
    Object? isActive = null,
    Object? role = freezed,
  }) {
    return _then(_$UserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      whatsappNumber: freezed == whatsappNumber
          ? _value.whatsappNumber
          : whatsappNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: freezed == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      showOnGuestList: null == showOnGuestList
          ? _value.showOnGuestList
          : showOnGuestList // ignore: cast_nullable_to_non_nullable
              as bool,
      showEvents: null == showEvents
          ? _value.showEvents
          : showEvents // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      qdrantId: freezed == qdrantId
          ? _value.qdrantId
          : qdrantId // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {this.id,
      @JsonKey(name: 'display_name') this.name,
      @JsonKey(name: 'profile_picture') this.avatar,
      this.email,
      @JsonKey(name: 'first_name') this.firstName,
      @JsonKey(name: 'last_name') this.lastName,
      @JsonKey(name: 'phone_number') this.phoneNumber,
      @JsonKey(name: 'whatsapp_number') this.whatsappNumber,
      this.bio,
      final List<String>? interests,
      this.longitude,
      this.latitude,
      this.location,
      @JsonKey(name: 'is_private') this.isPrivate = false,
      @JsonKey(name: 'show_on_guest_list') this.showOnGuestList = false,
      @JsonKey(name: 'show_events') this.showEvents = false,
      @JsonKey(name: 'last_active') this.lastActive,
      @JsonKey(name: 'last_login') this.lastLogin,
      @JsonKey(name: 'qdrant_id') this.qdrantId,
      @JsonKey(name: 'is_verified') this.isVerified = false,
      @JsonKey(name: 'is_active') this.isActive = false,
      this.role})
      : _interests = interests;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

// Updated to match your API response - using lowercase 'id' instead of 'ID'
  @override
  final int? id;
  @override
  @JsonKey(name: 'display_name')
  final String? name;
  @override
  @JsonKey(name: 'profile_picture')
  final String? avatar;
  @override
  final String? email;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  @JsonKey(name: 'whatsapp_number')
  final String? whatsappNumber;
  @override
  final String? bio;
  final List<String>? _interests;
  @override
  List<String>? get interests {
    final value = _interests;
    if (value == null) return null;
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? longitude;
  @override
  final double? latitude;
  @override
  final String? location;
  @override
  @JsonKey(name: 'is_private')
  final bool isPrivate;
  @override
  @JsonKey(name: 'show_on_guest_list')
  final bool showOnGuestList;
  @override
  @JsonKey(name: 'show_events')
  final bool showEvents;
  @override
  @JsonKey(name: 'last_active')
  final DateTime? lastActive;
  @override
  @JsonKey(name: 'last_login')
  final DateTime? lastLogin;
  @override
  @JsonKey(name: 'qdrant_id')
  final String? qdrantId;
  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  final String? role;

  @override
  String toString() {
    return 'User(id: $id, name: $name, avatar: $avatar, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, whatsappNumber: $whatsappNumber, bio: $bio, interests: $interests, longitude: $longitude, latitude: $latitude, location: $location, isPrivate: $isPrivate, showOnGuestList: $showOnGuestList, showEvents: $showEvents, lastActive: $lastActive, lastLogin: $lastLogin, qdrantId: $qdrantId, isVerified: $isVerified, isActive: $isActive, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.whatsappNumber, whatsappNumber) ||
                other.whatsappNumber == whatsappNumber) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.showOnGuestList, showOnGuestList) ||
                other.showOnGuestList == showOnGuestList) &&
            (identical(other.showEvents, showEvents) ||
                other.showEvents == showEvents) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.qdrantId, qdrantId) ||
                other.qdrantId == qdrantId) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        avatar,
        email,
        firstName,
        lastName,
        phoneNumber,
        whatsappNumber,
        bio,
        const DeepCollectionEquality().hash(_interests),
        longitude,
        latitude,
        location,
        isPrivate,
        showOnGuestList,
        showEvents,
        lastActive,
        lastLogin,
        qdrantId,
        isVerified,
        isActive,
        role
      ]);

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
      {final int? id,
      @JsonKey(name: 'display_name') final String? name,
      @JsonKey(name: 'profile_picture') final String? avatar,
      final String? email,
      @JsonKey(name: 'first_name') final String? firstName,
      @JsonKey(name: 'last_name') final String? lastName,
      @JsonKey(name: 'phone_number') final String? phoneNumber,
      @JsonKey(name: 'whatsapp_number') final String? whatsappNumber,
      final String? bio,
      final List<String>? interests,
      final double? longitude,
      final double? latitude,
      final String? location,
      @JsonKey(name: 'is_private') final bool isPrivate,
      @JsonKey(name: 'show_on_guest_list') final bool showOnGuestList,
      @JsonKey(name: 'show_events') final bool showEvents,
      @JsonKey(name: 'last_active') final DateTime? lastActive,
      @JsonKey(name: 'last_login') final DateTime? lastLogin,
      @JsonKey(name: 'qdrant_id') final String? qdrantId,
      @JsonKey(name: 'is_verified') final bool isVerified,
      @JsonKey(name: 'is_active') final bool isActive,
      final String? role}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

// Updated to match your API response - using lowercase 'id' instead of 'ID'
  @override
  int? get id;
  @override
  @JsonKey(name: 'display_name')
  String? get name;
  @override
  @JsonKey(name: 'profile_picture')
  String? get avatar;
  @override
  String? get email;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  @JsonKey(name: 'whatsapp_number')
  String? get whatsappNumber;
  @override
  String? get bio;
  @override
  List<String>? get interests;
  @override
  double? get longitude;
  @override
  double? get latitude;
  @override
  String? get location;
  @override
  @JsonKey(name: 'is_private')
  bool get isPrivate;
  @override
  @JsonKey(name: 'show_on_guest_list')
  bool get showOnGuestList;
  @override
  @JsonKey(name: 'show_events')
  bool get showEvents;
  @override
  @JsonKey(name: 'last_active')
  DateTime? get lastActive;
  @override
  @JsonKey(name: 'last_login')
  DateTime? get lastLogin;
  @override
  @JsonKey(name: 'qdrant_id')
  String? get qdrantId;
  @override
  @JsonKey(name: 'is_verified')
  bool get isVerified;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  String? get role;

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
// Updated to match your API response - using lowercase 'id'
  int? get id =>
      throw _privateConstructorUsedError; // Made senderId nullable in case API returns null
  @JsonKey(name: 'sender_id')
  int? get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiver_id')
  int? get receiverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id')
  int? get conversationId => throw _privateConstructorUsedError;
  String get content =>
      throw _privateConstructorUsedError; // Added default empty string
  @JsonKey(name: 'message_type')
  String get messageType => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_at')
  DateTime? get readAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at')
  DateTime? get deletedAt =>
      throw _privateConstructorUsedError; // Updated to match your API response - using snake_case
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_url')
  String? get fileUrl => throw _privateConstructorUsedError;
  User? get sender => throw _privateConstructorUsedError;
  User? get receiver => throw _privateConstructorUsedError;
  Conversation? get conversation => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'sender_id') int? senderId,
      @JsonKey(name: 'receiver_id') int? receiverId,
      @JsonKey(name: 'conversation_id') int? conversationId,
      String content,
      @JsonKey(name: 'message_type') String messageType,
      @JsonKey(name: 'is_read') bool isRead,
      @JsonKey(name: 'read_at') DateTime? readAt,
      @JsonKey(name: 'deleted_at') DateTime? deletedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'file_url') String? fileUrl,
      User? sender,
      User? receiver,
      Conversation? conversation});

  $UserCopyWith<$Res>? get sender;
  $UserCopyWith<$Res>? get receiver;
  $ConversationCopyWith<$Res>? get conversation;
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
    Object? senderId = freezed,
    Object? receiverId = freezed,
    Object? conversationId = freezed,
    Object? content = null,
    Object? messageType = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? deletedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? fileUrl = freezed,
    Object? sender = freezed,
    Object? receiver = freezed,
    Object? conversation = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as User?,
      receiver: freezed == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as User?,
      conversation: freezed == conversation
          ? _value.conversation
          : conversation // ignore: cast_nullable_to_non_nullable
              as Conversation?,
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

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<$Res>? get conversation {
    if (_value.conversation == null) {
      return null;
    }

    return $ConversationCopyWith<$Res>(_value.conversation!, (value) {
      return _then(_value.copyWith(conversation: value) as $Val);
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
      @JsonKey(name: 'sender_id') int? senderId,
      @JsonKey(name: 'receiver_id') int? receiverId,
      @JsonKey(name: 'conversation_id') int? conversationId,
      String content,
      @JsonKey(name: 'message_type') String messageType,
      @JsonKey(name: 'is_read') bool isRead,
      @JsonKey(name: 'read_at') DateTime? readAt,
      @JsonKey(name: 'deleted_at') DateTime? deletedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'file_url') String? fileUrl,
      User? sender,
      User? receiver,
      Conversation? conversation});

  @override
  $UserCopyWith<$Res>? get sender;
  @override
  $UserCopyWith<$Res>? get receiver;
  @override
  $ConversationCopyWith<$Res>? get conversation;
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
    Object? senderId = freezed,
    Object? receiverId = freezed,
    Object? conversationId = freezed,
    Object? content = null,
    Object? messageType = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? deletedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? fileUrl = freezed,
    Object? sender = freezed,
    Object? receiver = freezed,
    Object? conversation = freezed,
  }) {
    return _then(_$MessageImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as User?,
      receiver: freezed == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as User?,
      conversation: freezed == conversation
          ? _value.conversation
          : conversation // ignore: cast_nullable_to_non_nullable
              as Conversation?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {this.id,
      @JsonKey(name: 'sender_id') this.senderId,
      @JsonKey(name: 'receiver_id') this.receiverId,
      @JsonKey(name: 'conversation_id') this.conversationId,
      this.content = '',
      @JsonKey(name: 'message_type') this.messageType = 'text',
      @JsonKey(name: 'is_read') this.isRead = false,
      @JsonKey(name: 'read_at') this.readAt,
      @JsonKey(name: 'deleted_at') this.deletedAt,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'file_url') this.fileUrl,
      this.sender,
      this.receiver,
      this.conversation});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

// Updated to match your API response - using lowercase 'id'
  @override
  final int? id;
// Made senderId nullable in case API returns null
  @override
  @JsonKey(name: 'sender_id')
  final int? senderId;
  @override
  @JsonKey(name: 'receiver_id')
  final int? receiverId;
  @override
  @JsonKey(name: 'conversation_id')
  final int? conversationId;
  @override
  @JsonKey()
  final String content;
// Added default empty string
  @override
  @JsonKey(name: 'message_type')
  final String messageType;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;
  @override
  @JsonKey(name: 'read_at')
  final DateTime? readAt;
  @override
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
// Updated to match your API response - using snake_case
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'file_url')
  final String? fileUrl;
  @override
  final User? sender;
  @override
  final User? receiver;
  @override
  final Conversation? conversation;

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, receiverId: $receiverId, conversationId: $conversationId, content: $content, messageType: $messageType, isRead: $isRead, readAt: $readAt, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, fileUrl: $fileUrl, sender: $sender, receiver: $receiver, conversation: $conversation)';
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
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.conversation, conversation) ||
                other.conversation == conversation));
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
      fileUrl,
      sender,
      receiver,
      conversation);

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
      @JsonKey(name: 'sender_id') final int? senderId,
      @JsonKey(name: 'receiver_id') final int? receiverId,
      @JsonKey(name: 'conversation_id') final int? conversationId,
      final String content,
      @JsonKey(name: 'message_type') final String messageType,
      @JsonKey(name: 'is_read') final bool isRead,
      @JsonKey(name: 'read_at') final DateTime? readAt,
      @JsonKey(name: 'deleted_at') final DateTime? deletedAt,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'file_url') final String? fileUrl,
      final User? sender,
      final User? receiver,
      final Conversation? conversation}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

// Updated to match your API response - using lowercase 'id'
  @override
  int? get id; // Made senderId nullable in case API returns null
  @override
  @JsonKey(name: 'sender_id')
  int? get senderId;
  @override
  @JsonKey(name: 'receiver_id')
  int? get receiverId;
  @override
  @JsonKey(name: 'conversation_id')
  int? get conversationId;
  @override
  String get content; // Added default empty string
  @override
  @JsonKey(name: 'message_type')
  String get messageType;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead;
  @override
  @JsonKey(name: 'read_at')
  DateTime? get readAt;
  @override
  @JsonKey(name: 'deleted_at')
  DateTime?
      get deletedAt; // Updated to match your API response - using snake_case
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'file_url')
  String? get fileUrl;
  @override
  User? get sender;
  @override
  User? get receiver;
  @override
  Conversation? get conversation;

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
// Updated to match your API response - using lowercase 'id'
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id')
  int? get conversationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'participant_ids')
  List<int>? get participantIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message_id')
  int? get lastMessageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message_at')
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_group')
  bool get isGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_name')
  String? get groupName => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_avatar')
  String? get groupAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  int? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_ids')
  List<int>? get adminIds =>
      throw _privateConstructorUsedError; // Added missing fields from your API response
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<Message> get messages =>
      throw _privateConstructorUsedError; // Added participants list to match your API structure
  List<User> get participants => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'conversation_id') int? conversationId,
      @JsonKey(name: 'participant_ids') List<int>? participantIds,
      @JsonKey(name: 'last_message_id') int? lastMessageId,
      @JsonKey(name: 'last_message_at') DateTime? lastMessageAt,
      @JsonKey(name: 'is_group') bool isGroup,
      @JsonKey(name: 'group_name') String? groupName,
      @JsonKey(name: 'group_avatar') String? groupAvatar,
      @JsonKey(name: 'created_by') int? createdBy,
      @JsonKey(name: 'admin_ids') List<int>? adminIds,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      List<Message> messages,
      List<User> participants});
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
    Object? conversationId = freezed,
    Object? participantIds = freezed,
    Object? lastMessageId = freezed,
    Object? lastMessageAt = freezed,
    Object? isGroup = null,
    Object? groupName = freezed,
    Object? groupAvatar = freezed,
    Object? createdBy = freezed,
    Object? adminIds = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? messages = null,
    Object? participants = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
      participantIds: freezed == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as int?,
      adminIds: freezed == adminIds
          ? _value.adminIds
          : adminIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<User>,
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
      @JsonKey(name: 'conversation_id') int? conversationId,
      @JsonKey(name: 'participant_ids') List<int>? participantIds,
      @JsonKey(name: 'last_message_id') int? lastMessageId,
      @JsonKey(name: 'last_message_at') DateTime? lastMessageAt,
      @JsonKey(name: 'is_group') bool isGroup,
      @JsonKey(name: 'group_name') String? groupName,
      @JsonKey(name: 'group_avatar') String? groupAvatar,
      @JsonKey(name: 'created_by') int? createdBy,
      @JsonKey(name: 'admin_ids') List<int>? adminIds,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      List<Message> messages,
      List<User> participants});
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
    Object? conversationId = freezed,
    Object? participantIds = freezed,
    Object? lastMessageId = freezed,
    Object? lastMessageAt = freezed,
    Object? isGroup = null,
    Object? groupName = freezed,
    Object? groupAvatar = freezed,
    Object? createdBy = freezed,
    Object? adminIds = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? messages = null,
    Object? participants = null,
  }) {
    return _then(_$ConversationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int?,
      participantIds: freezed == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as int?,
      adminIds: freezed == adminIds
          ? _value._adminIds
          : adminIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<User>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl(
      {this.id,
      @JsonKey(name: 'conversation_id') this.conversationId,
      @JsonKey(name: 'participant_ids') final List<int>? participantIds,
      @JsonKey(name: 'last_message_id') this.lastMessageId,
      @JsonKey(name: 'last_message_at') this.lastMessageAt,
      @JsonKey(name: 'is_group') this.isGroup = false,
      @JsonKey(name: 'group_name') this.groupName,
      @JsonKey(name: 'group_avatar') this.groupAvatar,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'admin_ids') final List<int>? adminIds,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      final List<Message> messages = const [],
      final List<User> participants = const []})
      : _participantIds = participantIds,
        _adminIds = adminIds,
        _messages = messages,
        _participants = participants;

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

// Updated to match your API response - using lowercase 'id'
  @override
  final int? id;
  @override
  @JsonKey(name: 'conversation_id')
  final int? conversationId;
  final List<int>? _participantIds;
  @override
  @JsonKey(name: 'participant_ids')
  List<int>? get participantIds {
    final value = _participantIds;
    if (value == null) return null;
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'last_message_id')
  final int? lastMessageId;
  @override
  @JsonKey(name: 'last_message_at')
  final DateTime? lastMessageAt;
  @override
  @JsonKey(name: 'is_group')
  final bool isGroup;
  @override
  @JsonKey(name: 'group_name')
  final String? groupName;
  @override
  @JsonKey(name: 'group_avatar')
  final String? groupAvatar;
  @override
  @JsonKey(name: 'created_by')
  final int? createdBy;
  final List<int>? _adminIds;
  @override
  @JsonKey(name: 'admin_ids')
  List<int>? get adminIds {
    final value = _adminIds;
    if (value == null) return null;
    if (_adminIds is EqualUnmodifiableListView) return _adminIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Added missing fields from your API response
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

// Added participants list to match your API structure
  final List<User> _participants;
// Added participants list to match your API structure
  @override
  @JsonKey()
  List<User> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  String toString() {
    return 'Conversation(id: $id, conversationId: $conversationId, participantIds: $participantIds, lastMessageId: $lastMessageId, lastMessageAt: $lastMessageAt, isGroup: $isGroup, groupName: $groupName, groupAvatar: $groupAvatar, createdBy: $createdBy, adminIds: $adminIds, createdAt: $createdAt, updatedAt: $updatedAt, messages: $messages, participants: $participants)';
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
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._adminIds, _adminIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants));
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
      createdBy,
      const DeepCollectionEquality().hash(_adminIds),
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(_participants));

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
      @JsonKey(name: 'conversation_id') final int? conversationId,
      @JsonKey(name: 'participant_ids') final List<int>? participantIds,
      @JsonKey(name: 'last_message_id') final int? lastMessageId,
      @JsonKey(name: 'last_message_at') final DateTime? lastMessageAt,
      @JsonKey(name: 'is_group') final bool isGroup,
      @JsonKey(name: 'group_name') final String? groupName,
      @JsonKey(name: 'group_avatar') final String? groupAvatar,
      @JsonKey(name: 'created_by') final int? createdBy,
      @JsonKey(name: 'admin_ids') final List<int>? adminIds,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      final List<Message> messages,
      final List<User> participants}) = _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

// Updated to match your API response - using lowercase 'id'
  @override
  int? get id;
  @override
  @JsonKey(name: 'conversation_id')
  int? get conversationId;
  @override
  @JsonKey(name: 'participant_ids')
  List<int>? get participantIds;
  @override
  @JsonKey(name: 'last_message_id')
  int? get lastMessageId;
  @override
  @JsonKey(name: 'last_message_at')
  DateTime? get lastMessageAt;
  @override
  @JsonKey(name: 'is_group')
  bool get isGroup;
  @override
  @JsonKey(name: 'group_name')
  String? get groupName;
  @override
  @JsonKey(name: 'group_avatar')
  String? get groupAvatar;
  @override
  @JsonKey(name: 'created_by')
  int? get createdBy;
  @override
  @JsonKey(name: 'admin_ids')
  List<int>? get adminIds; // Added missing fields from your API response
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  List<Message>
      get messages; // Added participants list to match your API structure
  @override
  List<User> get participants;

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
  @JsonKey(fromJson: _payloadFromJson, toJson: _payloadToJson)
  Map<String, dynamic>? get payload => throw _privateConstructorUsedError;

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
  $Res call(
      {String type,
      @JsonKey(fromJson: _payloadFromJson, toJson: _payloadToJson)
      Map<String, dynamic>? payload});
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
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
  $Res call(
      {String type,
      @JsonKey(fromJson: _payloadFromJson, toJson: _payloadToJson)
      Map<String, dynamic>? payload});
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
    Object? payload = freezed,
  }) {
    return _then(_$WebSocketMessageImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSocketMessageImpl implements _WebSocketMessage {
  const _$WebSocketMessageImpl(
      {required this.type,
      @JsonKey(fromJson: _payloadFromJson, toJson: _payloadToJson)
      final Map<String, dynamic>? payload})
      : _payload = payload;

  factory _$WebSocketMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSocketMessageImplFromJson(json);

  @override
  final String type;
  final Map<String, dynamic>? _payload;
  @override
  @JsonKey(fromJson: _payloadFromJson, toJson: _payloadToJson)
  Map<String, dynamic>? get payload {
    final value = _payload;
    if (value == null) return null;
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
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
      @JsonKey(fromJson: _payloadFromJson, toJson: _payloadToJson)
      final Map<String, dynamic>? payload}) = _$WebSocketMessageImpl;

  factory _WebSocketMessage.fromJson(Map<String, dynamic> json) =
      _$WebSocketMessageImpl.fromJson;

  @override
  String get type;
  @override
  @JsonKey(fromJson: _payloadFromJson, toJson: _payloadToJson)
  Map<String, dynamic>? get payload;

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
  @JsonKey(name: 'conversation_id')
  int get conversationId => throw _privateConstructorUsedError;

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
  $Res call(
      {Message message, @JsonKey(name: 'conversation_id') int conversationId});

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
              as int,
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
  $Res call(
      {Message message, @JsonKey(name: 'conversation_id') int conversationId});

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
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessagePayloadImpl implements _MessagePayload {
  const _$MessagePayloadImpl(
      {required this.message,
      @JsonKey(name: 'conversation_id') required this.conversationId});

  factory _$MessagePayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessagePayloadImplFromJson(json);

  @override
  final Message message;
  @override
  @JsonKey(name: 'conversation_id')
  final int conversationId;

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
      @JsonKey(name: 'conversation_id')
      required final int conversationId}) = _$MessagePayloadImpl;

  factory _MessagePayload.fromJson(Map<String, dynamic> json) =
      _$MessagePayloadImpl.fromJson;

  @override
  Message get message;
  @override
  @JsonKey(name: 'conversation_id')
  int get conversationId;

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
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id')
  int get conversationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_typing')
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
  $Res call(
      {@JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'conversation_id') int conversationId,
      @JsonKey(name: 'is_typing') bool isTyping});
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
              as int,
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
  $Res call(
      {@JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'conversation_id') int conversationId,
      @JsonKey(name: 'is_typing') bool isTyping});
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
              as int,
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
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'conversation_id') required this.conversationId,
      @JsonKey(name: 'is_typing') required this.isTyping});

  factory _$TypingPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypingPayloadImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'conversation_id')
  final int conversationId;
  @override
  @JsonKey(name: 'is_typing')
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
          {@JsonKey(name: 'user_id') required final int userId,
          @JsonKey(name: 'conversation_id') required final int conversationId,
          @JsonKey(name: 'is_typing') required final bool isTyping}) =
      _$TypingPayloadImpl;

  factory _TypingPayload.fromJson(Map<String, dynamic> json) =
      _$TypingPayloadImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'conversation_id')
  int get conversationId;
  @override
  @JsonKey(name: 'is_typing')
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
  @JsonKey(name: 'user_id')
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
  $Res call({@JsonKey(name: 'user_id') int userId, bool online});
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
  $Res call({@JsonKey(name: 'user_id') int userId, bool online});
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
  const _$OnlineStatusPayloadImpl(
      {@JsonKey(name: 'user_id') required this.userId, required this.online});

  factory _$OnlineStatusPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlineStatusPayloadImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
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
      {@JsonKey(name: 'user_id') required final int userId,
      required final bool online}) = _$OnlineStatusPayloadImpl;

  factory _OnlineStatusPayload.fromJson(Map<String, dynamic> json) =
      _$OnlineStatusPayloadImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
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
