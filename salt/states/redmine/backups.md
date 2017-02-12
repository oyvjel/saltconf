# Backup and restore notes:
When backing up, the apache2 settings for passenger and mods/sites are
restored by the saltstack configuration settings. As such, any changes
made to those, _must_ be made to the saltstack platform, or they will
be lost.


## Files used by Redmine
- /var/lib/dbconfig-common/sqlite3/redmine/instances/default/
- /usr/share/redmine/
- /etc/redmine
- /var/lib/redmine/

I have taken these files and created symlinks to the shared folder
network drive. This way, as the data set grows large, I won't have
issues with the root disk becoming full. The directory itself is what
is backed up.

- /media/sf_raid/archive/Redmine

# RESTORING

To restore a redmine system, first you need to install to the correct
state. If the salt-call method fails to place the system into the
correct state, troubleshoot the following process:

    aptitude update && aptitude install apache2 libapache2-mod-passenger redmine redmine-sqlite

Make sure that you allow dbconfig-common to set the database to the
defaults, using sqlite3 for my instance.

- /etc/apache2/mods-available/passenger.conf

    <IfModule mod_passenger.c>
        PassengerDefaultUser www-data
        PassengerRoot /usr
        PassengerRuby /usr/bin/ruby
    </IfModule>


- ln -s /usr/share/redmine/public /var/www/redmine

- /etc/apache2/sites-available/default

    <Directory /var/www/redmine>
        RailsBaseURI /redmine
        PassengerResolveSymlinksInDocumentRoot on
    </Directory>
