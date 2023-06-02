package OVH::Bastion::Plugin::accountAddPersonalAccess;
# vim: set filetype=perl ts=4 sw=4 sts=4 et:
use common::sense;

require OVH::Bastion::Plugin::addPersonalAccess;

*validate_config = \&OVH::Bastion::Plugin::addPersonalAccess::validate_config;

1;
