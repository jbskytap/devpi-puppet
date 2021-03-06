# == Class: devpi::nginx
#
# Optional NginX proxy for an external port. See "devpi" for general parameters.
#
# === Parameters
#
# [*ensure*]
# Passed to the nginx package, unless undef, then the package is not managed by this module.
# Defaults to undef.
#
# [*www_default_disable*]
# Disable 'default' NginX site?
# Defaults to false.
#
# [*listen*]
# Array of interfaces (IPs, domain names) to listen on.
# See http://nginx.org/en/docs/http/ngx_http_core_module.html#listen for details.
# Defaults to undef, which means to listen to `www_port` (on all interfaces).
#
# [*ssl_cert*]
# Base name of the certificate files, set this to the domain name of your devpi
# service, and provide the certificate in /etc/nginx/ssl (as .crt and .key file).
# Defaults to undef (no SSL).
#
# [*immutable_accounts*]
# Prevent account creation / changes via NginX; this means account
# maintenance requires SSH access on the server (mutation only via
# the local port).
# Defaults to false (no restriction).
#
class devpi::nginx (
    $ensure                     = $devpi::params::ensure_nginx,
    $www_default_disable        = $devpi::params::www_default_disable,
    $listen                     = $devpi::params::listen,
    $ssl_cert                   = $devpi::params::ssl_cert,
    $immutable_accounts         = $devpi::params::immutable_accounts,
) inherits devpi::params {
    Class['devpi']
    -> class { 'devpi::nginx_config': }
    ~> class { 'devpi::nginx_service': }
    -> Class['devpi::nginx']
}
