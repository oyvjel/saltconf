#!py

# This script runs a bash-script to generate keys and certificate
# for a minion ( openvpn client) 
# if no keys exist. Then pillar variables are assigned the content of those files.
# Config: Set the path cwd to the catalog where the certificate files reside. 
# ca.crt must exist as <cwd>/keys/ca.crt.
# NB: cwd should not be part of the pillar path, as the CA may contain secrets
# that should not be include in code repositories and backups.

# Minion keys are supposed to be created on the fly with easy-rsa which is 
# normally distrubyted with openvpn.
# 
# Note: If saltmaster != vpnserver a way to access the ca from saltmaster must be
# provided in get_cert.sh

# Test with:
#   salt -v 'nictest' saltutil.refresh_pillar
#   salt -v 'nictest' pillar.get openvpn

# OJ, 2014-11

import subprocess

def run():
    cmd = ["./get_cert.sh", __grains__['id']]
#    cwd = "/etc/openvpn/easy-rsa"
    cwd = "/srv/CA"
    output = subprocess.Popen(cmd, cwd='/srv/base/pillar', stdout=subprocess.PIPE).communicate()[0]
#    return {'openvpn': output}

##### Read the cert-files:::::
    filename = cwd + "/keys/" + "ca.crt"
#    filename = cwd + "ca.crt"
    file = open(filename, 'r')
    cacrt = file.read()
    file.close()
    
    filename = cwd + "/keys/" + __grains__['id'] + ".crt"
    file = open(filename, 'r')
    minioncrt = file.read()
    file.close()

    filename = cwd + "/keys/" + __grains__['id'] + ".key"
    file = open(filename, 'r')
    minionkey = file.read()
    file.close()

    return {
      'openvpn':{
        'cacrt': cacrt,
	'minioncrt': minioncrt,
	'minionkey': minionkey,
      }
    }	

if __name__ == "__main__":
    global __grains__
    __grains__ = {'id':'zinc'}
    print run()

