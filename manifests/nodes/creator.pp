$modulepath = [
  "${confdir}/environments/${environment}/modules",
  "${confdir}/environments/${environment}/site",
]

class{ 'puppet::repo::puppetlabs': }
Class[ 'puppet::repo::puppetlabs'] -> Package <| |> class { 'puppetdb': }

class { 'puppet::master':
  modulepath   => inline_template("<%= @modulepath.join(':') %>"),
  manifest     => '$confdir/environments/$environment/manifests/site.pp',
  storeconfigs => true,
}

puppet::masterenv { 'main':
  modulepath   => inline_template("<%= @modulepath.join(':') %>"),
  manifest     => '$confdir/environments/$environment/manifests/site.pp',
}
