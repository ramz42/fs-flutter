import 'dart:async';
import 'package:mysql1/mysql1.dart';

class Mysql {
  // static String host = "217.21.72.2",
  //     user = "n1575196_foto_selfie_flutter",
  //     db = "n1575196_foto_selfie_flutter",
  //     password = "%;Eq}m3Wjy{&";

  // localhost
  static String host = "localhost",
      user = "root",
      db = "foto_selfi",
      password = "rama4422";
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}
