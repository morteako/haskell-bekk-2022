# Functors

## Tester

Installer doctest : `stack install doctest`

`doctest Oppgaver.hs`



### ghcid - test on save
`ghcid --ignore-loaded --reload="Oppgaver.hs" --test=":! doctest Oppgaver.hs"`

Bytt ut Oppgaver.hs med annen fil hvis ønsket