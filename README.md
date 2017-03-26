
Dokumentation: Ozean
===

Alle Variablen wurden konsistent mit kleinen Buchstaben gesetzt.


__student__


Ein Student _student_ besteht aus folgenden Attributen:
* id : int (primary key), not null
* name : varchar
* uniid : varchar
* matriculationnumber : int
* refund : bool, default: false 
* report : bool, default: false 
* comment : string

Die _id_ wird eingeführt um ein primary key (Primärschlüssel) zu gewährleisten, da Datenbestände existieren, die keine uniid und Matrikelnummer besitzen. Die _id_ wird von der Software selbst gesetzt und inkrementiert (Autoinkrement).

Der _name_ wird nicht gesondert in Vor- und Nachname getrennt, wegen Zweit- und Drittnamen und u.a. Namen aus asiatischen Ländern. Einzutragen ist hier der komplette Name.

Die _uniid_ soll langfristig die Matrikelnummer ablösen. Durch die Uni-ID erhält man die Mailadresse, falls Problematiken auftreten sollten.

Die _matriculationnumber_ wird langfristig durch die _uniid_ ersetzt. 

_refund_ und _report_ sind boolsche Werte. 

Sind entweder _refund_ == true oder _report_ == true, so darf sich _student_ pfandpflichtige Ordner ohne weitere Pfandzahlung ausleihen. _refund_ und _report_ werden per default auf false gesetzt.
_refund_ wird auf true gesetzt, nachdem Pfand gezahlt wurde. _report_ wird auf true gesetzt, nachdem das Pfand zurückgezahlt wurde und dabei wird _refund_ wieder auf false gesetzt.

Bsp.: 
Pfand wurde bezahlt => refund = true
Pfand wurde zurückgegeben $\Rightarrow$ refund = false, report = true
Bericht wurde geschrieben vorm Einzahlen des Pfand $\Rightarrow$ report = true
$\Rightarrow$ Studis bei denen refund == true oder report == true gesetzt ist, dürfen pfandpflichtige Ordner ausleihen ohne nochmals Pfand zu bezahlen.

Zu verbessern wäre, dass die Datenbankelemente (ohne _comment_) not null sind.


__folder__


Unter _folder_ sind sämtliche Ordner eingetragen.

Ein Ordner _folder_ besteht aus folgenden Attributen:
* id : int, not null
* name : varchar
* content : varchar 
* obligation_to_report : bool
* barcode : varchar

Die _id_ wird von der Software gesetzt.

Der _name_ ist die Bezeichnung des Ordners.

Der _content_ beschreibt die fachliche Zuordnung des _folder_ .

Die _obligation_to_report_ beschreibt, ob der _folder_ pfandpflichtig ist.

Der _barcode_ steht als neues Feature in Planung.


__lent__


In _lent_ sind alle aktuell verliehene Ordner aufgelistet.

Ein Ordner in _lent_ besteht aus folgenden Attributen:
* id :int, not null
* studentid : int
* folderid : int
* lentat : datetime

Die _id_ ist in dem Fall ein primary key (Primärschlüssel), welche jedem Ausleihvorgang ein Autoinkrement setzt. 

Die _studentid_ und _folderid_ sind jeweils foreign keys (Fremdschlüssel), welche die _id_ des _student_ und des _folder_ sind. 

_lentat_ gibt den Ausleihzeitpunkt wieder.

Unter Ordner in _returned_ sind alle zurückgegebenen Ordner aufgelistet. Dies dient der History und der Statistik. 


__returned__


In _returned_ besteht aus folgenden Attributen:
* id : int, not null
* studentid : int
* folderid : int
* lentat : datetime
* returnedat : datetime

Die _id_ setzt jedem Rückgabevorgang durch die Software ein Autoinkrement. 

_studentid_ und _folderid_ sind foreign keys (Fremdschlüssel) aus _student_ und aus _folder_.

_lentat_ gibt den Ausleihzeitpunkt wieder.

_returnedat_ gibt den Rückgabezeitpunkt wieder.


































---
tags: MathPhys, Software
---

Zu Überarbeitende FS-Software
===
 
## Ozean (PHP)
- [ ] Suche nach Uni-ID's
- [ ] Bericht schon geschrieben aber noch kein Geld zurück zustand ermöglichen
- [ ] Eventuell neu schreiben in Flask/Python

### Datenbankmodell

___student___
|Spaltenname|Datentyp|Beispiel|Bemerkungen|
|---	   |---	    |---	 |---	     |
|id   	   |int   	|1   	 |auto incement, not null|
|name 	   |varchar |Tom Rix |_in Vor- und Nachname trennen?_ $\Rightarrow$ wurde sich explizit gegen entschieden, wegen Zweit und Drittnamen u.a. aus asiatischen Ländern |
|uniid 	   |varchar |jb007 	 |Validität prüfen|
|matriculationnumber|varchar|1234567|soll langfristig durch UNI-ID ersetzt werden|
|refund	   |bool    |true 	 |Pfand bezahlt? default: false , siehe Anmerkungen unten|
|report   |bool    |true  	 |Bericht geschrieben? default: false |
|comment|text   |unzuverlässig|Blacklisted|
|   	   |   	    |   	 |   	     |
Pfand wurde bezahlt $\Rightarrow$ refund = true
Pfand wurde zurückgegeben $\Rightarrow$ refund = false, report = true
Bericht wurde geschrieben vorm Einzahlen des Pfand $\Rightarrow$ report = true

$\Rightarrow$ Studis bei denen refund == true oder report == true gesetzt ist, dürfen pfandpflichtige Ordner ausleihen




___folder___
|Spaltenname|Datentyp|Beispiel|Bemerkungen|
|---	   |---	    |---	 |---	     |
|id   	   |int   	|1   	 |auto incement, not null|
|name 	   |varchar |KM1A    |           |
|content   |varchar |        |           |
|obligation_to_report|boolean|1    |           |
|barcode   |varchar |2230423 |_feature in planung_|

___lent___ (zurückgegebene Ordner werden einfach in die returned Tabelle übertragen und mit Zeitstempel versehen. Dadurch bleibt die lent Tabelle klein, schnell und übersichtlich)
|Spaltenname|Datentyp|Beispiel|Bemerkungen|
|---	   |---	    |---	 |---	     |
|id   	   |int   	|1   	 |auto incement, not null|
|studentid |int     |1       |foreign |
|folderid  |int	    |1   	 |forein key |
|lentat    |datetime|2017-03-01 23:59|  Ausleihdatum |
|   	   |   	    |   	 |   	     |

___returned___ als History und für Statistiken ;)
|Spaltenname|Datentyp|Beispiel|Bemerkungen|
|---	   |---	    |---	 |---	     |
|id   	   |int   	|1   	 |auto incement, not null|
|studentid |int     |1       |foreign key|
|folderid  |int	    |1   	 |forein key |
|lentat    |datetime|2017-03-01 23:59|Ausleihdatum|
|returnedat|datetime|2017-03-02 00:01|Rückgabedatum|
|   	   |   	    |   	 |   	     |

### wichtige Funktionen
* suchen nach:
    * Namen (sowohl Vor- als auch Nachname), dabei sollten Rechtschreibfehler, überflüssige Leerzeichen etc. keinen Unterschied machen
    * UNI-ID, Matrikelnummer
    * mit Suggestions  ![suggestions](https://cdn.gobankingrates.com/wp-content/uploads/google-credit-is.jpg)

* Rückgaben rückgängig machen (einfach aus der zurückgegeben Tabelle wieder in ausgeliehen zurückkopieren. Dafür sollte man vielleicht ständig die letzten beiden Rückgaben anzeigen, sodass man diese schnell erreichen kann)

* einfache Erweiterbarkeit für Barcode Scanner ermöglichen, sodas man langfristig nur noch die Barcodes des Studiausweises und des Ordners scannen und zum Bestätigen "Enter" drücken muss 

* Statistiken: "Ordner des Monats", wie viele Ordner wurden diesen Tag/Woche/Monat/Semester schon ausgeliehen? Grafische Auswertung wann im Semester ein großer Ansturm zu erwarten ist

* Live-Info auf unserer mathphys.info Website, welche Ordner verfügbar und welche ausgeliehen sind (ähnlich zu Bib Katalog)

* __Möglichkeit zum Anbinden des Moors einplanen!__
