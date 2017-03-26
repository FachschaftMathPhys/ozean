
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
