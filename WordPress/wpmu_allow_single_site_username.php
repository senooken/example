<?php
//////////////////////////////////////////////////////////////////////////////
/// @file      wpmu_allow_single_site_username.php
/// @author    SENOO, Ken
/// @copyright CC0
/// @url       https://senooken.jp/post/2022/07/03/
//////////////////////////////////////////////////////////////////////////////
add_filter( 'wpmu_validate_user_signup', 'wpmu_allow_single_site_username');
/**
 * Allow single site username on multiple site.
 *
 * @wp-hook wpmu_validate_user_signup
 * @param   array $result
 * @return  array
 */
function wpmu_allow_single_site_username( $result ) {
  $error_name = $result[ 'errors' ]->get_error_message( 'user_name' );

  if ( ! empty ( $error_name )
      && $error_name == __( 'Usernames can only contain lowercase letters (a-z) and numbers.' )
      && $result['user_name'] == $result['orig_username']
      && $result['user_name'] == sanitize_user($result['user_name'], true)
  ) {
    unset ( $result[ 'errors' ]->errors[ 'user_name' ] );
    return $result;
  }
  return $result;
}
