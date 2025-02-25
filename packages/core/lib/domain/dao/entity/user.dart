part of 'entity.dart';

class User implements Table {
  @override
  String get tableName => 'hs_user';

  @override
  Field get primaryKey => const Field(name: 'user_id', type: FieldType.string, isPrimary: true);

  final String userId;
  String userLogin;
  String userName;
  UserStatusType userStatus;
  UserSexType userSex;
  String userBirthday;
  String userEmail;
  String userNote;
  String userJob;
  String userRoomNumber;
  String userOfficePhone;
  String userMobile;
  String userPicture;
  String userAddress;
  String userFirstSpell;
  String userFullSpell;
  String userJobNumber;
  String userAgency;
  String userSuperiorLeader;
  String userShortNumber;
  String userIdCard;
  String userSsid;
  String userSessionId;
  PlatformType userPlatform;
  String userServerId;
  int userLoginTime;
  int userLevel;
  int userFileLevel;
  int userOrderId;

  User({
    this.userId = '',
    this.userLogin = '',
    this.userName = '',
    this.userStatus = UserStatusType.offline,
    this.userSex = UserSexType.unknown,
    this.userBirthday = '',
    this.userEmail = '',
    this.userNote = '',
    this.userJob = '',
    this.userRoomNumber = '',
    this.userOfficePhone = '',
    this.userMobile = '',
    this.userPicture = '',
    this.userAddress = '',
    this.userFirstSpell = '',
    this.userFullSpell = '',
    this.userJobNumber = '',
    this.userAgency = '',
    this.userSuperiorLeader = '',
    this.userShortNumber = '',
    this.userIdCard = '',
    this.userSsid = '',
    this.userSessionId = '',
    this.userPlatform = PlatformType.unknown,
    this.userServerId = '',
    this.userLoginTime = 0,
    this.userLevel = 0,
    this.userFileLevel = 0,
    this.userOrderId = 1000,
  });

  List<Field> get fields => [
        const Field(name: 'user_id', type: FieldType.string, isPrimary: true),
        const Field(name: 'user_login', type: FieldType.string),
        const Field(name: 'user_name', type: FieldType.string),
        const Field(name: 'user_status', type: FieldType.int),
        const Field(name: 'user_sex', type: FieldType.int),
        const Field(name: 'user_birthday', type: FieldType.string),
        const Field(name: 'user_email', type: FieldType.string),
        const Field(name: 'user_note', type: FieldType.string),
        const Field(name: 'user_job', type: FieldType.string),
        const Field(name: 'user_room_number', type: FieldType.string),
        const Field(name: 'user_office_phone', type: FieldType.string),
        const Field(name: 'user_mobile', type: FieldType.string),
        const Field(name: 'user_picture', type: FieldType.string),
        const Field(name: 'user_address', type: FieldType.string),
        const Field(name: 'user_first_spell', type: FieldType.string),
        const Field(name: 'user_full_spell', type: FieldType.string),
        const Field(name: 'user_job_number', type: FieldType.string),
        const Field(name: 'user_agency', type: FieldType.string),
        const Field(name: 'user_superior_leader', type: FieldType.string),
        const Field(name: 'user_short_number', type: FieldType.string),
        const Field(name: 'user_id_card', type: FieldType.string),
        const Field(name: 'user_ssid', type: FieldType.string),
        const Field(name: 'user_session_id', type: FieldType.string),
        const Field(name: 'user_platform', type: FieldType.int),
        const Field(name: 'user_server_id', type: FieldType.string),
        const Field(name: 'user_login_time', type: FieldType.bigint),
        const Field(name: 'user_level', type: FieldType.int),
        const Field(name: 'user_file_level', type: FieldType.int),
        const Field(name: 'user_order_id', type: FieldType.int),
      ];

  @override
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'user_login': userLogin,
      'user_name': userName,
      'user_status': userStatus,
      'user_sex': userSex,
      'user_birthday': userBirthday,
      'user_email': userEmail,
      'user_note': userNote,
      'user_job': userJob,
      'user_room_number': userRoomNumber,
      'user_office_phone': userOfficePhone,
      'user_mobile': userMobile,
      'user_picture': userPicture,
      'user_address': userAddress,
      'user_first_spell': userFirstSpell,
      'user_full_spell': userFullSpell,
      'user_job_number': userJobNumber,
      'user_agency': userAgency,
      'user_superior_leader': userSuperiorLeader,
      'user_short_number': userShortNumber,
      'user_id_card': userIdCard,
      'user_ssid': userSsid,
      'user_session_id': userSessionId,
      'user_platform': userPlatform,
      'user_server_id': userServerId,
      'user_login_time': userLoginTime,
      'user_level': userLevel,
      'user_file_level': userFileLevel,
      'user_order_id': userOrderId,
    };
  }

  @override
  User fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      userLogin: map['user_login'],
      userName: map['user_name'],
      userStatus: map['user_status'],
      userSex: map['user_sex'],
      userBirthday: map['user_birthday'],
      userEmail: map['user_email'],
      userNote: map['user_note'],
      userJob: map['user_job'],
      userRoomNumber: map['user_room_number'],
      userOfficePhone: map['user_office_phone'],
      userMobile: map['user_mobile'],
      userPicture: map['user_picture'],
      userAddress: map['user_address'],
      userFirstSpell: map['user_first_spell'],
      userFullSpell: map['user_full_spell'],
      userJobNumber: map['user_job_number'],
      userAgency: map['user_agency'],
      userSuperiorLeader: map['user_superior_leader'],
      userShortNumber: map['user_short_number'],
      userIdCard: map['user_id_card'],
      userSsid: map['user_ssid'],
      userSessionId: map['user_session_id'],
      userPlatform: map['user_platform'],
      userServerId: map['user_server_id'],
      userLoginTime: map['user_login_time'],
      userLevel: map['user_level'],
      userFileLevel: map['user_file_level'],
      userOrderId: map['user_order_id'],
    );
  }
}
