# -*- coding: utf-8 -*-


#Trenger yaml_utf8: True i /etc/salt/master
# Test med: sudo salt-call state.sls testchar


##### VIRKER IKKE!!!!
#test-characters:
#  cmd.run:
#    - name: echo "Dette er en plain ascii test med æøå"
#    - name: echo "¿Me pones un café, por favor?"


## OK:

test-characters1:
  file.touch:
    - name: /tmp/foobar

test-characters2:
  file.append:
    - name: /tmp/foobar
    - text: "¿Me pones un café, por favor?"
    - require:
      - file: test-characters1
                                    