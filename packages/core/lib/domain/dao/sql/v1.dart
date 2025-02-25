part of 'sql.dart';

const sql_v1 = '''

CREATE TABLE IF NOT EXISTS hs_user (
  user_id TEXT PRIMARY KEY,
  user_login TEXT DEFAULT '',
  user_name TEXT DEFAULT '',
  user_status INTEGER DEFAULT 0,
  user_sex INTEGER DEFAULT 0,
  user_birthday TEXT DEFAULT '',
  user_email TEXT DEFAULT '',
  user_note TEXT DEFAULT '',
  user_job TEXT DEFAULT '',
  user_room_number TEXT DEFAULT '',
  user_office_phone TEXT DEFAULT '',
  user_mobile TEXT DEFAULT '',
  user_picture TEXT DEFAULT '',
  user_address TEXT DEFAULT '',
  user_first_spell TEXT DEFAULT '',
  user_full_spell TEXT DEFAULT '',
  user_job_number TEXT DEFAULT '',
  user_agency TEXT DEFAULT '',
  user_superior_leader TEXT DEFAULT '',
  user_short_number TEXT DEFAULT '',
  user_id_card TEXT DEFAULT '',
  user_ssid TEXT DEFAULT '',
  user_session_id TEXT DEFAULT '',
  user_platform INTEGER DEFAULT 0,
  user_server_id TEXT DEFAULT '',
  user_login_time INTEGER DEFAULT 0,
  user_level INTEGER DEFAULT 0,
  user_file_level INTEGER DEFAULT 0,
  user_order_id INTEGER DEFAULT 1000
);

CREATE TABLE IF NOT EXISTS hs_config (
  config_id INTEGER PRIMARY KEY AUTOINCREMENT,
  config_key TEXT DEFAULT '',
  config_value TEXT DEFAULT '',
  config_type TEXT DEFAULT ''
);
''';
