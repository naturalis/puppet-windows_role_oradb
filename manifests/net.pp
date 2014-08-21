# == Class: windows_role_oradb::net
#
class windows_role_oradb::net (
  $net_hash,
  ){
  create_resources('windows_oradb::net', $net_hash)
}
