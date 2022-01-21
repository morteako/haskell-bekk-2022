# Setup

## GHCup
Det letteste for å installere diverse haskell-verktøy er `ghcup`.
[https://www.haskell.org/ghcup/](https://www.haskell.org/ghcup/)

Installer med `curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`.

Start med `ghcup tui`

Installer følgende (ved å markere og trykke `i`)
* Stack 2.7.3
* cabal 3.6.2.0
* GHC 8.10.7

### Ghcid
"GHCi as a daemon" or "GHC + a bit of an IDE"
Veldig kjekt å bruke for rask kompilering og kjøring.
Ikke nødvendig, men anbefales

Installering : `stack install ghcid`

Bruk :
  * i et prosjekt : `ghcid` 
  * enkelt fil : `ghcid Filnavn.hs`
Mer: 
  * kjøre main : legg på `-r` (--run) 
  * utføre noe annet : `-T NOEANNET` . feks `-T "reverse [1,2,3]"`  


## "IDE"
Anbefaler å bruke VS Code med https://marketplace.visualstudio.com/items?itemName=haskell.haskell

Syntax highlighting : https://marketplace.visualstudio.com/items?itemName=justusadam.language-haskell


### Formattering
Anbefaler `fourmolu`

Tror VS Code laster ned automatisk (hvis ikke, se linjen under), men man må bytte default i settings : `Haskell: formatting provider`.

Kan installeres via `stack install fourmolu`

(Ikke veldig viktig nå i starten, så hvis det ikke funker, bare la det være)

## Sjekk at ting fungerer og bli litt kjent med ting

#### GHC - kompilatoren
* Kompiler Example.hs : `ghc Example.hs`
* Kjør Example.hs : `./Example`
  
#### GHCi - repl
* start med `ghci`
* last fil med : `:l Example.hs` (kan også lastes når man starter : `ghci Example.hs`)
* evaluer noe fra filen, feks : `exampleFunc 10`
* sjekk typen : `:t exampleFunc`
* endre noe på filen og så reload med : `:r` (loader da siste fil)
  
#### Stack - build tool
* lag et nytt prosjekt med : `stack new haskell-test simple-hpack`
  * haskell-test er navnet på prosjektet
  * simple-hpack er en template (kan ignoreres for nå)
* cd inn i mappen og bygg prosjektet : `stack build`
  * Kan ta litt tid siden stack installerer en spesifikk GHC
* kjør prosjektet : `stack exec haskell-test`
* Åpne prosjektet i editor og sjekk om HLS fungerer
  * Skal da være type on hover osv
* Sjekk gjerne at `ghcid -r` fungerer inne i prosjektet


