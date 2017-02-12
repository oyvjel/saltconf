Vi (burde, vi inkuderer git direkte) inkluderer windows repo fra Saltstack med git i salt-winrepo.git
Dette blir ikke automatisk oppdatert.

Etablering av lokale repo:
--------------------------

cd <winrepo_dir>

git clone https://github.com/saltstack/salt-winrepo.git
git clone https://github.com/saltstack/salt-winrepo-ng.git


#Evt
## Automatisk oppdatering:
 #### NEVER EVER DO THIS ############
salt-run winrepo.update_git_repos

Dette overskriver eksisterende git-repos under winrepo_dir: '/srv/base/salt/win/repo/'
Branch vil være: (detached from origin/master)

Eksisterende master branch blir beholdt, og man kan manuelt switche tilbake ( git checkout master )

 ####################################


Bedre Oppdatering:
------------------

cd <winrepo_dir:>/salt-winrepo[-ng]

git pull


Kjør deretter på master:

salt-run winrepo.genrepo

# Push ut oppdatert liste til minions:
#salt '*' pkg.refresh_db
salt -G 'os:windows' pkg.refresh_db

salt -G 'os:windows' pkg.list_pkgs