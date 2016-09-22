<?php

/**
 * Tell WordPress to save the cookie on the domain
 * @var bool
 */

if (strpos($_SERVER['HTTP_HOST'], "(#cookie_domain#)") !== false) {
    define('COOKIE_DOMAIN', ".(#cookie_domain#)");
} else {
    define('COOKIE_DOMAIN', $_SERVER['HTTP_HOST']);
}
