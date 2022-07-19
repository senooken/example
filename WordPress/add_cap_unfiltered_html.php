<?php
//////////////////////////////////////////////////////////////////////////////
/// \file      add_cap_unfiltered_html.php
/// \author    SENOO, Ken
/// \copyright CC0
/// \url       https://senooken.jp/post/2022/07/19/
//////////////////////////////////////////////////////////////////////////////
add_action('admin_init', 'add_cap_unfiltered_html');
/**
 * Add unfiltered_html capability.
 *
 * @wp-hook admin_init
 */
function add_cap_unfiltered_html() {
    // Add all capabilities.
    // global $wp_roles;
    // $wp_roles->add_cap('author', 'unfiltered_html');

    // Add administrator.
    $role = get_role('administrator');
    $role->add_cap('unfiltered_html');
}
