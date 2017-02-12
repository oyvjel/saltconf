
#updates:
#  win_update.installed:
#    - categories:
#      - 'Critical Updates'
#      - 'Security Updates'
  
######## RDP access #############
enable_rdp:
  rdp.enabled:
    - name: 
      - hitadmin

#firewall_rdp_enable:
#  win_firewall.add_rule:
#    - localport: 3389
#    - protocol: tcp
#    - action: allow
#    - dir: 'in'

firewall_disable:
  win_firewall.disabled:
    - name: allprofiles


# Disable NLA authentication. Nødvendig for klienter som ikke er i AD?
# Se http://www.lazywinadmin.com/2014/04/powershell-getset-network-level.html
(Get-WmiObject -Class Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0):
  cmd.run:
    - shell: powershell
    - unless:  exit ((Get-WmiObject -Class Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'").UserAuthenticationRequired)
#    - onlyif: cmd /c 'IF EXIST c:\test.txt EXIT 1'

######## Hostname from ID

{%- set fqdn = grains['id']|replace("-dev", "")|replace("-test", "")|replace("-qa", "")|upper %}

computername_from_id:
  system.computer_name:
    - name: {{ fqdn }}

## Above does not work at the moment, so poor mans workaround:
#set_new_name:
#  cmd.script:
#    - source: salt://win/ps/rename.ps1
#    - name: rename.ps1
#    - shell: powershell
#    - template: jinja
#    - newname: {{ fqdn }}

Administrated by Embriq SaltStack, avoid local config!:
  system:
    - computer_desc


#Always fires???
#system.reboot:
#  module.run:
#    - watch:
#      - system: computername_from_id
