# Functors

## Notes
`ghcid Main.hs -r`


## Oppgaver

* MonadOppgaver.hs
* DooOppgaver.hs
* IoOppgaver.hs
* StateOppgaver.hs ?

## Tester

Installer doctest : `stack install doctest`

`doctest Oppgaver.hs`



### ghcid - test on save
Monader : `ghcid --ignore-loaded --reload="MonadOppgaver.hs" --test=":! doctest MonadOppgaver.hs"`

Bytt ut Oppgaver.hs med annen fil hvis ønsket