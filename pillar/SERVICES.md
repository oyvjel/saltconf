Service selection for a host.
=============================

Services may be selected i two ways:

1. Explicitly declearing a product
2. Defining an enabeling pillar.

Typically pillars for a specific host are defined in a file
./byid/<hostid>.sls or ./byid/<hostid>/cmdb.sls

The latter is desigend to interface to some future cmdb-system.

Declearing a product
--------------------

Define the pillar ucmdb:product like this:

cmdb:
  status: development
  product:
    - ourwebsite
    - fileserver
    
In this example "ourwebsite" corresponds to the file
../salt/products/<productname>.sls, which defines the services that
constitues the product. See ../salt/cmdb.sls for details.

Service by pillar.
------------------

Defining certain pillars for a host will trigger the installation of a
corresponding service. The pillar name must match the service name.

Defined services are coded in ../salt/services/init.sls.

Se ../salt/services/init.sls for a definitive list of services that
may be defined by declearing a pillar with same name.


Example: 

Content of ./byid/gitlab.sls:

include:
  - gitlab
  

This will include ./gitlab.sls with content:

gitlab:
  use_rvm: False
  rvm_ruby: 2.1.0
  shell_version: v2.2.0
  gitlab_version: 7-5-stable
	
....
....


