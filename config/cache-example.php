<?php

/**
 * Use local varnish server.
 * @var string
 */
define('VHP_VARNISH_IP', '(#cache_varnish_ip#)');

/**
 * Use memcached.
 * @var bool
 */
define('WP_USE_MEMCACHED', (#cache_memcached#));

/**
* Memcache key salt
* @var string
*/
define('WP_CACHE_KEY_SALT', NONCE_KEY);
