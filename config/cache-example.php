<?php

/**
 * Use local varnish server.
 * @var string
 */
define('VHP_VARNISH_IP', '127.0.0.1');

/**
 * Use memcached.
 * @var bool
 */
//define('WP_USE_MEMCACHED', true);

/**
* Memcache key salt
* @var string
*/
define('WP_CACHE_KEY_SALT', NONCE_KEY);
