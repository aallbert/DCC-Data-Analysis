# Links

- [Kaggle Beitrag des Datensatzes](https://www.kaggle.com/datasets/mexwell/drug-consumption-classification/data)
- [Konvertierung der Daten in Python](https://www.kaggle.com/code/mexwell/starter-notebook-convert-column-values)



# Roter Faden (Vorschlag von Albert):
- Daten cleanen 
- Überblick verschaffen über Daten und Güte der Daten: 
    - ist wirklich der avg Joe repräsentiert? (Stichpunkt Altersverteilung, Bildungsverteilung, Verteilung der Persönlichkeitsscores) (bspw. sind nur englischsprachige Länder Teil der Daten)
    - ist Fragemethode mit "letzter Konsum" valid? was sagt die Psychologie dadrüber?
    - Begriffsklärung (was sind legal highs? was bedueten die einzelnen Persönlichkeitsmerkmale?)
- Fragestellungen formulieren:
    - Genereller Konsum -> Alter?
    - Genereller Konsum -> Geschlecht?
    - Genereller Konsum -> Bildung?
    - Genereller Konsum -> Land?
    - Genereller Konsum -> Ethnie?
    - Genereller Konsum -> Persönlichkeit?
    - Besondere "Konsummuster" bei vorigen Auffälligkeiten? (bspw. Partydrogen bei Persönlichkeitsmerkmal X, "harte" Drogen bei Bildungsstand Y, etc.)
- Daten durchjagen
- Schlüsse ziehen
    - Wichtig! Korrelationen mit anderen Sachen beachten (bspw. niedriger Bildungsstand -> Armut; generell alles was näher an Kriminalität ist konsumiert eher)
    - Recherche gescheiter Quellen


# TODO
- Research machen für sinnvolles mapping für Persönlichkeitsmerkmale 
    - Notiz Albert: man macht das glaub normalerweise mit einem score von 1-50 und wir können den Float dementsprechend umrechnen. Muss man recherchieren