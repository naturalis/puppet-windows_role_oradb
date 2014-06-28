# == Class: windows_role_oradb::installdb
#
class windows_role_oradb::installdb (
  $installdb_hash,
  ){
  create_resources('windows_oradb::installdb', $installdb_hash)
}
