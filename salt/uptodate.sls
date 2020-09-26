# Not to be included by top.sls
# Could be triggered by a role?
# Run as salt '*' state.apply uptodate

uptodate:
  pkg.uptodate:
    - refresh: True