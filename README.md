# Progressi projekt "Kliendi ja tema lepingute haldusprogramm"
## Lahendamise meetod

Antud aines otsustas kolme liikmeline tiim kodutöö tegemiseks saada esialgu projekti koostamisel TTÜ ruumides kokku, et koos välja mõelda kuidas ja millise rakenduse loome.

Esimeseks suureks probleemiks sai see et rakendust arendada kolmes erinevas arvutis ei olnud hea lahendus. Probleemile ei aidanud kaasa see, et ühiste aegade leidmine oli keeruline erinevate kohustuste ning kauguste tõttu. Seega otsustasime kasutusele võtta virtuaalmasina, kuhu kõik liikmed said kaugelt ligi. Lisaks kasutasime suhtlemiseks Skype rakendust.
 
Antud lahendus oli meie tiimile sobilik ning tänu sellele, et kõik nägime kõigi tegevusi sai igaüks panustada oma mõtetega koheselt kaasa ning vastavad muudatused kõigi silme all rakendada. Lisaks andis antud lahendus tiimile võimaluse tihedamalt projektiga tegeleda, kuna kohaline piirang kadus. Töö loomisel panustasid kõik tiimi liikmed võrdselt kuna projekti arendus toimus ainult siis kui kõik liikmed said osaleda, vastasel juhul lükati ülesande lahendamine edasi.

## Kodutöö loogika
### Sissejuhatus
Antud aines eksamitööks sai koostatud OpenEdge progressis rakendus, mille eesmärk on jätta meelde kliendid, kliendiga seotud lepingud ning lepingutega seotud maksed. Iga muudatus kliendi või lepingu sisule loob vastava ajaloo tabelisse uue kirje ning seega tagab rakendus võimalus lepingu ja kliendi muutusi pikema aja jooksul jälgida.
 
Projekt loodi veebirakendusena ning veebiliidesena otsustati Kendo UI Builderi kasuks. Ühendus Kendo ja veebiserveriga toimub kasutades business entity tehnoloogiat, kuhu on loodud temp-tabelid koos andmebaasiga ühilduvaga loogikaga.
### Kliendi vaade
Minnes rakenduse lehele on kasutajal võimalik vaadata kliente ja nende ajalugu. Kliente saab lisada, muuta ja kustutada. Kliente saab kustutada vaid juhul, kui kliendil ei ole lepinguid. Lisaks saab vaadata kliendi ajalugu. Kliendi kustutamisel kustub ka kliendi ajalugu. Lisamisel ja kliendi muutmisel lisatakse kliendile uus ajaloo kirje. 
### Lepingu vaade
Rakendusega näeb ka lepinguid. Neid saab lisada, muuta ja kustutada ning sarnaselt kliendi tabelile saab vaadata ajalugu ning lepingu kustutamisel kustub ka sellega seotud ajalugu. Iga uus muudatus loob ka ajaloo. Lepingu kustutamisel peab arvestama ka lepingu staatust, kustutamiseks peab leping olema lõpetatud (2). Lisaks saab vaadata kliendi ja tema lepingute vahelist seost. Ühel kliendil võib olla üks kuni mitu lepingut.
### Maksete vaade
Makseid saab kasutaja ainult lisada. Iga makse lisamisel seotakse makse lepinguga ning vastavalt makse suurusele arvutatakse lepingu jäänud summa ümber. Ka selle kohta tuleb lepingule ajalugu, kuna lepingu sisu muutus. Juhul kui maksete arv on suurem või võrdne lepingu summale siis lepingu staatus muudetakse lõpetatud (2) olekusse. Muul ajal on lepingu olek aktiivne (0). 

## Tabelid
### Customer
CustomerId
IdCode
FirstName
LastName
CustomerHistory
CustomerHistoryId
CustomerId
IdCode
FirstName
LastName
Edit
### Contract
ContractId
ContractNr
CustomerId
TimeIn
TimeEnded
ContractStatus
Amount
AmountLeft
PaymentDate
### ContractHistory
ContractHistoryId
ContractId
ContractNr
CustomerId
TimeIn
TimeEnded
ContractStatus
Amount
AmountLeft
PaymentDate
Edit
### PaymentHistory
PaymentHistoryId
PaymentAmount
PaymentTime
ContractNr

## Triggerid 
### createCustomer
Kutsutakse välja kliendi loomisel.
Aktiveerib jada CUSTOMERID millega omistatakse tabelil primaarse võtme väärtus.
### updateCustomer
Kutsutakse välja kliendi uuendamisel.
Kirjutatakse baasi uus CustomerHistory rida.
määratakse muutust kirjeldav sõna.
### deleteCustomer
Kutsutakse välja kliendi kustutmisel.
Otsib ega kliendil lepinguid pole ja annab veateate kui on.
Kui ei ole lepinguid siis kustuta kasutaja ajalugu.
Tagasta sõnum logisse ajaloo kustutamisest.
### createContract
Kutsutakse välja lepingu loomisel.
Aktiveerib jada CONTRACTID, millega omistatakse tabelil primaarse võtme väärtus.
### updateContract
Kutsutakse välja lepingu uuendamisel.
Logisse kirjutakse info.
Vaadatkase kas ajalugu on varem olemas.
Kui on siis edit tulp = "Create”.
Vastasel juhul  = "Update".
### deleteContract
Kutsutakse välja lepingu kustutamisel.
Trigger kontrollib, kui leping on veel aktiivne lepingu kustutamist ei lubata ning kasutaja saab veateate “Cannot delete active contract.”.
Kui leping ei ole aktiivne ning kustutamine on lubatud, siis kustutatakse ka kogu lepingu ajalugu.
### createPayment
Kutsutakse välja makse loomisel.
Aktiveerib jada PAYMENTHISTORYID millega omistatakse tabelil primaarse võtme väärtus.
### updatePayment
Kutsutakse välja makse uuendamisel.
Määratakse uus muutuja amount_left.
Määratakse uus muutuja contract_status.
Otsitakse maksele seostuv leping.
Tühistatakse teised triggerid.
Arvutatakse uue makse peale lepingule uus jääk summa.
Vajadusel muudetakse lepingu staatust 2 kui jääk 0.
Logitakse makse.
Luuakse lepingu muudatuse kohta ajalugu.
Kui esineb viga siis antakse veateade.
