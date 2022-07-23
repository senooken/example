<?php
//////////////////////////////////////////////////////////////////////////////
/// \file      add_cap_unfiltered_html_mu.php
/// \author    SENOO, Ken
/// \copyright CC0
/// \url       https://senooken.jp/post/2022/07/19/
//////////////////////////////////////////////////////////////////////////////
add_filter('map_meta_cap', 'add_cap_unfiltered_html_mu', 1, 3);
/**
 * Add unfiltered_html capability to editor and administrator on multisite.
 *
 * @wp-hook map_meta_cap
 */
function add_cap_unfiltered_html_mu($caps, $cap, $user_id) {
    if ($cap === 'unfiltered_html'
    && (user_can($user_id, 'editor') || user_can($user_id, 'administrator'))
    ) {
        $caps = array('unfiltered_html');
    }
    return $caps;
}
