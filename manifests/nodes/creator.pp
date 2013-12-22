$modulepath = [
  '$confdir/environments/$environment/modules',
  '$confdir/environments/$environment/site',
]

network_config { 'eth0':
  ensure    => present,
  family    => inet,
  method    => static,
  ipaddress => '10.0.0.1',
  netmask   => '255.255.255.0',
  onboot    => true,
}

host {'creator.mgnt.local':
  ensure       => present,
  host_aliases => creator,
  ip           => '10.0.0.1',
}


class{ 'puppet::repo::puppetlabs': }
Class[ 'puppet::repo::puppetlabs'] -> Package <| |> class { 'puppetdb': }

class { 'puppet::master':
  modulepath            => inline_template("<%= @modulepath.join(':') %>"),
  manifest              => '$confdir/environments/$environment/manifests/site.pp',
  storeconfigs          => true,
  storeconfigs_dbserver => 'creator.mgnt.local',
  certname              => 'creator.mgnt.local',
}
