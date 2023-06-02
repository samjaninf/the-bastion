package OVH::Bastion::Plugin::addPersonalAccess;
# vim: set filetype=perl ts=4 sw=4 sts=4 et:
use common::sense;

use File::Basename;
use lib dirname(__FILE__) . '/../../../../../lib/perl';
use OVH::Result;
use OVH::Bastion;

sub validate_config {
    my %params = @_;
    my $config = $params{'config'};

    if (!$config) {
        return R('ERR_MISSING_PARAMETER', msg => "Missing config parameter");
    }

    if (ref $config ne 'HASH') {
        return R('ERR_INVALID_PARAMETER', msg => "The config parameter is not a hash");
    }

    my $widestV4Prefix = $config->{'widest_v4_prefix'};
    if (defined $widestV4Prefix) {
        if ($widestV4Prefix =~ /([0-9]+)/) {
            $widestV4Prefix = $1;
        }
        if ($widestV4Prefix > 32 || $widestV4Prefix < 0) {
            warn_syslog("Invalid value '$widestV4Prefix' for widest_v4_prefix of selfAddPersonalAccess");
            return R('ERR_CONFIGURATION_ERROR',
                msg => "This plugin has a configuration error, please report to your nearest sysadmin");
        }
        $config->{'widest_v4_prefix'} = $widestV4Prefix;
    }

    return R('OK', value => $config);
}

1;
