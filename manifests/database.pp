# == Class: windows_role_oradb::database
#
class windows_role_oradb::database (
  $database_hash,
  ){
  create_resources('windows_oradb::database', $database_hash)
}
