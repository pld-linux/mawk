.\" {PTM/WK/2000-VI}
.TH MAWK 1  "22 grudnia 1994" "wersja 1.2" "POLECENIA U¯YTKOWNIKA"
.\" strings
.ds ex \fIwyra¿\fR
.SH NAZWA
mawk \- jêzyk wyszukiwania wzorców i przetwarzania tekstu
.SH SK£ADNIA
.TP 6
.B mawk
.RB [ -W
.IR opcja ]
.RB [ -F
.IR warto¶æ ]
.RB [ -v
.IR zmn\fB=\fPwarto¶æ ]
.br
.RB [ \-\- "] 'tekst programu'"
.RI [ plik ...]
.TP
.B mawk
.RB [ -W
.IR opcja ]
.RB [ -F
.IR warto¶æ ]
.RB [ -v
.IR zmn\fB=\fPwarto¶æ ]
.br
.RB [ -f
.IR plik-programu ]
.RB [ \-\- ]
.RI [ plik ...]
.SH OPIS
.B mawk
jest interpreterem jêzyka programowania AWK. Jêzyk AWK jest u¿yteczny
w dzia³aniach na plikach danych, wyszukiwaniu i przetwarzaniu tekstu oraz
tworzeniu prototypów i eksperymentowaniu z algorytmami.
.B mawk
implementuje jêzyk AWK, jak go zdefiniowali Aho, Kernighan i Weinberger
w ksi±¿ce
.IR "The AWK Programming Language" ,
Addison-Wesley Publishing, 1988 (dalej wzmiankowanej jako ksi±¿ka AWK).
.B mawk
jest zgodny z definicj± jêzyka AWK ze standardu Posix 1003.2
(propozycja 11.3), zawieraj±c± nowe cechy nie opisane w ksi±¿ce AWK.
Dodatkowo
.B mawk
zawiera nieco rozszerzeñ.
.PP
Program AWK jest sekwencj± par \fIwzorzec {akcja}\fP i definicji funkcji.
Krótkie programy wprowadzane s± w wierszu poleceñ, zwykle ujête w ' ', by
unikn±æ interpretacji ich sk³adowych przez pow³okê.
D³u¿sze programy mog± byæ czytane z pliku przy pomocy opcji \fB-f\fP.
dane wej¶ciowe odczytywane  s± z listy plików z wiersza poleceñ lub
ze standardowego wej¶cia, gdy lista ta jest pusta.
Wej¶cie rozbijane jest na rekordy okre¶lone wed³ug zmiennej opisuj±cej
separator rekordów, \fBRS\fP (record separator). Pocz±tkowo
\fBRS\fP="\en"
a rekordy s± to¿same z wierszami. Ka¿dy z rekordów porównywany jest z ka¿dym
ze
.IR wzorców ,
a je¶li pasuje, wykonywany jest tekst programu dla
.IR "{akcji}" .
.SH OPCJE
.TP \w'\-\fBW'u+\w'\fRsprintf=\fInum\fR'u+2n
\fB\-F \fIwarto¶æ
ustawia separator pól, \fBFS\fP, na
.IR warto¶æ .
.TP
\fB\-f \fIplik
Tekst programu jest czytany z \fIpliku\fP zamiast z wiersza poleceñ.
Dopuszcza siê wielokrotne u¿ycie opcji
.BR \-f .
.TP
\fB\-v \fIzmn\fB=\fPwarto¶æ
przypisuje
.I warto¶æ
zmiennej programu
.IR zmn .
.TP
.B \-\|\-
wskazuje jednoznaczny koniec opcji.
.PP
Powy¿sze opcje bêd± dostêpne w ka¿dej zgodnej z Posix implementacji AWK.
Opcje specyficzne dla danej implementacji poprzedzane s± przez
.BR \-W .
.B mawk
udostêpnia sze¶æ takich rozszerzeñ:
.TP \w'\-\fBW'u+\w'\fRsprintf=\fInum\fR'u+2n
.B \-W version
.B mawk
wypisuje sw± wersjê i prawa autorskie na stdout (standardowym wyj¶ciu), za¶
wkompilowane ograniczenia na stderr (standardowym wyj¶ciu b³êdów).
Koñczy pracê z kodem 0.
.TP
.B \-W dump
wypisuje na stdout asembleropodobny listing wewnêtrznej
reprezentacji programu i koñczy pracê z kodem 0 (przy pomy¶lnej kompilacji).
.TP
.B \-W interactive
ustawia niebuforowane zapisy na stdout i buforowane wierszami odczyty
z stdin (standardowego wej¶cia). Rekordy z stdin s± wierszami niezale¿nie
od warto¶ci
.BR RS .
.TP
.B \-W exec \fIplik
Tekst programu czytany jest z
.I pliku
i jest to ostatnia opcja. Przydatne na systemach obs³uguj±cych konwencjê
"liczb magicznych"
.B #!
dla skryptów wykonywalnych.
.TP
.B \-W sprintf=\fInum
ustawia rozmiar bufora wewnêtrznego sprintf
na
.I num
bajtów. Czêstsze ni¿ sporadyczne stosowanie tej opcji wskazuje, ¿e
.B mawk
powinien zostaæ zrekompilowany.
.TP
.B \-W posix_space
wymusza na
.BR mawk ,
by nie uwa¿a³ '\en' za odstêp.
.PP
Rozpoznawane s± krótkie postacie
.BR \-W [ vdiesp ],
za¶ w niektórych systemach \fB\-We\fP jest obowi±zkowe dla unikniêcia
ograniczeñ d³ugo¶ci wiersza poleceñ.
.SH "JÊZYK AWK"
.SS "1. Struktura programu"
Program w jêzyku AWK jest sk³ada siê z sekwencji par
.I "wzorzec {akcja}"
i definicji funkcji u¿ytkownika.
.PP
Wzorcem mo¿e byæ:
.nf
.RS
.B BEGIN
.B END
.I wyra¿enie
.IB wyra¿enie ", " wyra¿enie
.sp
.RE
.fi
Mo¿na pomin±c jeden z elementów z pary \fIwzorzec {akcja}\fP, ale nie oba.
Je¿eli pominiêto
.IR {akcjê} ,
to jest ni± domniemane \fB{ print }\fP.
Je¿eli pominiêto
.IR wzorzec ,
to jest on niejawnie dopasowany.
Wzorce
.B BEGIN
i
.B END
wymagaj± akcji.
.PP
Instrukcje zakoñczone s± znakami nowej linii, ¶rednikami
lub oboma tymi znakami.
Grupy instrukcji, jak akcje czy cia³a pêtli, ³±czone s± w bloki
za po¶rednictwem \fB{ ... }\fP, jak w C.
Ostatnia instrukcja w bloku nie wymaga znaku koñcz±cego.
Puste wiersza nie maj± znaczenia; pusta instrukcja zakoñczona jest
¶rednikiem. D³ugie instrukcje mo¿na kontynuowaæ przy pomocy odwrotnego
uko¶nika \fB\e\fP.
Instrukcjê mo¿na podzieliæ miêdzy wiersze bez u¿ycia odwrotnego uko¶nika
po przecinku, nawiasie otwieraj±cym, &&, ||,
.BR do ,
.BR else  ,
nawiasie zamykaj±cym instrukcji
.BR if ,
.B while
lub
.B for
oraz nawiasie zamykaj±cym definicji funkcji.
Komentarze zaczynaj± siê od \fB#\fP i rozci±gaj± siê do a¿ koñca wiersza,
choæ go nie obejmuj±.
.PP
Poni¿sze instrukcje steruj± przep³ywem programu wewn±trz bloków.
.RS
.PP
.B if
( \*(ex )
.I instrukcja
.PP
.B if
( \*(ex )
.I instrukcja
.B else
.I instrukcja
.PP
.B while
( \*(ex )
.I instrukcja
.PP
.B do
.I instrukcja
.B while
( \*(ex )
.PP
.B for
(
\fIwyr_opc\fR ;
\fIwyr_opc\fR ;
\fIwyr_opc\fR
)
.I instrukcja
.PP
.B for
( \fIzmn \fBin \fItablica\fR )
.I instrukcja
.PP
.B continue
.PP
.B break
.RE
.\"
.SS "2. Typy danych, konwersja i porównywanie"
Istniej± dwa podstawowe typy danych, numeryczny i ³añcuch znakowy.
Sta³e liczbowe mog± byæ ca³kowite, jak \-2, dziesiêtne jak 1.08,
lub podane w notacji naukowej jak \-1.1e4 czy .28E\-3. Wszystkie liczby
s± reprezentowane wewnêtrznie w arytmetyce zmiennoprzecinkowej. Wszystkie
obliczenia równie¿ s± zmiennoprzecinkowe.
Tak wiêc, na przyk³ad, wyra¿enie
0.2e2 == 20
jest prawd±. Prawda reprezentowana jest jako 1.0.
.PP
Sta³e ³añcuchowe ujête s± w cudzys³owy.
.sp
.ce
"To jest ³añcuch ze znakiem nowej linii na koñcu.\en"
.sp
£añcuchy znakowe mog± byæ kontynuowane w kolejnych wierszach dziêki
poprzedzeniu znaku nowej linii odwrotnym uko¶nikiem (\e).
Rozpoznawane s± nastêpuj±ce sekwencje specjalne:
.nf
.sp
    \e\e        \e
    \e"        "
    \ea        dzwonek, ascii 7
    \eb        backspace, ascii 8
    \et        tabulacja, ascii 9
    \en        znak nowej linii, newline , ascii 10
    \ev        tabulacja pionowa, ascii 11
    \ef        wysuw strony, formfeed, ascii 12
    \er        powrót karetki, carriage return, ascii 13
    \eddd      1, 2 lub 3 cyfry ósemkowe dla ascii ddd
    \exhh      1 lub 2 cyfry szesnastkowe dla ascii hh
.sp
.fi
Je¿eli odwrotnym uko¶nikiem zostanie poprzedzony inny znak, np. \ec, wynikiem
bêdzie sekwencja ¼ród³owa: \ec, tzn.
.B mawk
zignoruje specjalne w³a¶ciwo¶ci odwrotnego uko¶nika.
.PP
Naprawdê istniej± trzy podstawowe typy danych; trzecim jest
.IR "liczba i ³añcuch" ,
posiadaj±cy równocze¶nie warto¶æ liczbow± i warto¶æ ³añcuchow±.
Zmienne definiowane przez u¿ytkownika pojawiaj± siê przy pierwszym
ich u¿yciu i s± inicjowane na
.IR null ,
typu "liczba i ³añcuch",
maj±ce warto¶æ numeryczn± 0 a ³añcuchow± "".
Nietrywialne dane typu liczbowo-³añcuchowego pochodz± z wej¶cia
i zwykle przechowywane s± w polach (zobacz sekcja 4).
.PP
Typ wyra¿enia okre¶lany jest przez jego kontekst. W razie potrzeby wykonywana
jest automatyczna konwersja typów. Na przyk³ad, wyznaczenie warto¶ci
instrukcji
.nf
.sp
	y = x + 2  ;  z = x  "hello"
.sp
.fi
Warto¶æ przechowywana w zmiennej y otrzyma typ numeryczny.
Je¿eli x nie jest numeryczne, to warto¶æ odczytana z x zostanie
skonwertowana na liczbê przed dodaniem do 2 i zachowaniem w y.
Warto¶æ przechowywana w zmiennej z bêdzie typu ³añcuchowego: warto¶æ x
zostanie przekszta³cona na ³añcuch, je¶li bêdzie to niezbêdne, i z³±czona
z "hello". Oczywi¶cie, warto¶æ i typ przechowywane w x nie zmieniaj± siê
w ¿adnej z tych konwersji.
Wyra¿enie ³añcuchowe przekszta³cane jest na numeryczne przy zastosowaniu
najd³u¿szego swego przedrostka numerycznego jak w
.IR atof (3).
Wyra¿enie numeryczne konwertowane jest na ³añcuch poprzez zast±pienie
.I wyra¿
przez
.BR sprintf(CONVFMT ,
.IR wyra¿ ),
chyba ¿e
.I wyra¿
mo¿e byæ reprezentowane w danym komputerze jako dok³adna liczba ca³kowita,
wówczas przekszta³cane jest na \fBsprintf\fR("%d", \*(ex).
.B Sprintf()
jest funkcj± wbudowan± AWK, dubluj±c± dzia³anie
.IR sprintf (3),
za¶
.B CONVFMT
jest wbudowan± zmienn± u¿ywan± do wewnêtrznej konwersji z liczby na ³añcuch
i inicjowan± na "%.6g".
Mo¿na wymusiæ jawn± konwersjê typów:
\*(ex ""
jest ³añcuchowe, a
\*(ex+0
jest numeryczne.
.PP
Przy wyliczaniu,
\fIwyra¿1\fP \fBop-rel\fP \fIwyra¿2\fP,
je¿eli oba operandy s± numeryczne lub numeryczno-³añcuchowe, to
porównywanie jest numeryczne; je¿eli oba operandy s± ³añcuchami to
porównywanie jest ³añcuchowe; je¶li jeden z operandów jest ³añcuchem, to
operand nie-³añcuchowy jest przekszta³cany i porównywanie jest ³añcuchowe.
Wynik jest numeryczny, 1 lub 0.
.PP
W kontekstach logicznych, jak
\fBif\fP ( \*(ex ) \fIinstrukcja\fP,
warto¶ci± wyra¿enia ³añcuchowego jest prawda wtedy i tylko wtedy, gdy
nie jest ono ³añcuchem pustym ""; wyra¿eñ liczbowych wtedy i tylko wtedy
gdy nie s± numerycznie zerem.
.\"
.SS "3. Wyra¿enia regularne"
W jêzyku AWK rekordy, pola i ³añcuchy s± czêsto sprawdzane na dopasowanie
do
.IR "wyra¿enia regularnego" .
Wyra¿enia regularne umieszczone s± miêdzy uko¶nikami, a
.nf
.sp
	\*(ex ~ /\fIr\fR/
.sp
.fi
jest wyra¿eniem AWK o warto¶ci 1 je¶li \*(ex "pasuje do"
.IR r ,
co oznacza, ¿e pewien pod³añcuch \*(ex jest w zestawie ³añcuchów
zdefiniowanych przez
.IR r .
Je¶li nie wystêpuje dopasowanie, to wyra¿enie otrzymuje warto¶æ 0;
zast±pienie \fB~\fP operatorem "nie pasuje", \fB!~\fP, odwraca znaczenia.
Pary wzorzec-akcja
.nf
.sp
        /\fIr\fR/ { \fIakcja\fR }   i\
   \fB$0\fR ~ /\fIr\fR/ { \fIakcja\fR }
.sp
.fi
s± takie same,
za¶ dla ka¿dego rekordu wej¶ciowego pasuj±cego do
.IR r
wykonywana jest
.IR akcja .
Faktycznie, /\fIr\fR/ jest wyra¿eniem AWK równowa¿nym (\fB$0\fR ~ /\fIr\fR/)
wszêdzie z wyj±tkiem wyst±pienia po prawej stronie operatora dopasowania
lub przekazywania do funkcji wbudowanej oczekuj±cej jako argumentu wyra¿enia
regularnego.
.PP
AWK stosuje rozszerzone wyra¿enia regularne jak
.BR egrep (1).
Metaznakami wyra¿eñ regularnych, tj. znakami o specjalnym znaczeniu
w wyra¿eniach regularnych s±
.nf
.sp
	\ ^ $ . [ ] | ( ) * + ?
.sp
.fi
Wyra¿enia regularne konstruowane s± ze znaków jak ni¿ej:
.RS
.TP \w'[^c\d1\uc\d2\uc\d3\u...]'u+1n
\fIc\fR
dopasowuje dowolny znak nie bêd±cy metaznakiem
.IR c .
.TP
\fB\e\fIc
dopasowuje znak zdefiniowany przez tê sam± sekwencjê specjaln± u¿ywan±
w sta³ych ³añcuchowych lub dos³owny znak
.I c
je¶li
\e\fIc
nie jest sekwencj± specjaln±.
.TP
\fB\&\.
dopasowuje dowolny znak (³±cznie ze znakiem nowej linii).
.TP
\fB^
dopasowuje pocz±tek ³añcucha.
.TP
\fB$
dopasowuje koniec ³añcucha.
.TP
\fB[\fIc\d1\uc\d2\uc\d3\u\fR...\fB]
dopasowuje dowolny znak z klasy \fIc\d1\uc\d2\uc\d3\u\fP... .
Zakres znaków oznaczany jest przez \fIc\d1\u\fP\fB\-\fP\fIc\d2\u\fP
wewn±trz klasy [...].
.TP
\fB[^\fIc\d1\uc\d2\uc\d3\u\fR...\fB]
dopasowuje dowolny znak nie nale¿±cy do klasy \fIc\d1\uc\d2\uc\d3\u\fP...
.RE
.sp
Wyra¿enia regularne konstruowane s± z innych wyra¿eñ regularnych
w nastêpuj±cy sposób:
.RS
.TP \w'[^c\d1\uc\d2\uc\d3\u...]'u+1n
\fIr\d1\u\fIr\d2\u
dopasowuje \fIr\d1\u\fP, bezpo¶rednio po którym nastêpuje \fIr\d2\u\fP
(konkatenacja).
.TP
\fIr\d1\u \fB| \fIr\d2\u
dopasowuje \fIr\d1\u\fP lub \fIr\d2\u\fP (alternatywa).
.TP
\fIr\fB*
dopasowuje zero lub wiêcej wyst±pieñ \fIr\fP .
.TP
\fIr\fB+
dopasowuje jedno lub wiêcej \fIr\fP.
.TP
\fIr\fB?
dopasowuje zero lub jedno \fIr\fP.
.TP
\fB(\fIr\fB)
dopasowuje \fIr\fP, umo¿liwiaj±c grupowanie.
.RE
.sp
Operatory wed³ug rosn±cego priorytetu: alternatywa, konkatenacja
(z³±czenie) i operatory jednoargumentowe (*, + lub ?).
.PP
Na przyk³ad,
.nf
.sp
    /^[_a\-zA-Z][_a\-zA\-Z0\-9]*$/  i
    /^[\-+]?([0\-9]+\e\|.?|\e\|.[0\-9])[0\-9]*([eE][\-+]?[0\-9]+)?$/
.sp
.fi
dopasowuj± odpowiednio identyfikatory AWK i sta³e liczbowe AWK.
Zauwa¿, ¿e kropka \fB.\fP musi byæ chroniona odwrotnym uko¶nikiem, by zosta³a
rozpoznana jako kropka dziesiêtna, a nie dopasowanie dowolnego znaku,
a metaznaki wewn±trz klas znaków trac± swe specjalne znaczenie.
.PP
Po prawej stronie operatorów ~ lub !~ mo¿e zostaæ u¿yte dowolne wyra¿enie.
Podobnie, dowolne wyra¿enie mo¿na przekazaæ do funkcji wbudowanej oczekuj±cej
wyra¿enia regularnego.
W razie potrzeby zostanie ono przekszta³cone na ³añcuch, a nastêpnie
zinterpretowane jako wyra¿enie regularne. Na przyk³ad,
.nf
.sp
	BEGIN { identifier = "[_a\-zA\-Z][_a\-zA\-Z0\-9]*" }

	$0 ~ "^" identifier
.sp
.fi
wypisuje wszystkie wiersze zaczynaj±ce siê od jakiego¶ identyfikatora AWK.
.PP
.B mawk
rozpoznaje puste wyra¿enie regularne, //\|, dopasowuj±ce ³añcuch pusty.
Zatem pasuje do niego dowolny ³añcuch na pocz±tku, koñcu i pomiêdzy dowolnym
znakiem. Na przyk³ad,
.nf
.sp
	echo  abc | mawk '{ gsub(//, "X") ; print }'
	XaXbXcX
.sp
.fi
.\"
.SS "4. Rekordy i pola"
Rekordy czytane s± po jednym na raz, i przechowywane w zmiennej
.BR $0 .
Rekord rozbijany jest na
.IR pola ,
przechowywane w
.BR $1 ,
.BR $2 ", ...,"
.BR $NF .
Wbudowana zmienna
.B NF
ustawiana jest na liczbê pól, a
.B NR
i
.B FNR
s± zwiêkszane o 1.
Pola powy¿ej
.B $NF
ustawiane s± na "".
.PP
Przypisanie do
.B $0
powoduje, ¿e pola i
.B NF
s± obliczane ponownie.
Przypisanie do
.B NF
lub do pola
powoduje, ¿e
.B $0
jest ponownie tworzone przez z³±czenie kolejnych pól separowanych przez
.BR OFS .
Przypisanie do pola o indeksie wiêkszym od
.BR NF ,
powiêksza
.B NF
i powoduje ponowne utworzenie
.BR $0 .
.PP
Dane wej¶ciowe przechowywane w polach s± ³añcuchami, chyba ¿e ca³e pole
ma postaæ numeryczn± a wówczas typ jest liczbowo-³añcuchowy.
Na przyk³ad,
.sp
.nf
	echo 24 24E |
	mawk '{ print($1>100, $1>"100", $2>100, $2>"100") }'
	0 1 1 1
.fi
.sp
.B $0
i
.B $2
s± ³añcuchami a
.B $1
jest liczbowo-³añcuchowe. Pierwsze porównanie jest numeryczne, drugie
³añcuchowe, trzecie ³añcuchowe (100 jest konwertowane na "100"),
i ostatnie ³añcuchowe.
.\"
.SS "5. Wyra¿enia i operatory"
.PP
Sk³adnia wyra¿eñ jest podobna jak w C. Wyra¿eniami pierwotnymi s± sta³e
liczbowe, sta³e ³añcuchowe, zmienne, pola, tablice i wywo³ania funkcji.
Identyfikator zmiennej, tablicy b±d¼ funkcji mo¿e byæ ci±giem liter, cyfr
i znaków podkre¶lenia, nie rozpoczynaj±cym siê od cyfry.
Zmienne nie s± deklarowane; zaistniej± przy pierwszym do nich odwo³aniu,
a inicjowane s± na
.IR null .
.PP
Nowe wyra¿enia tworzone s± z u¿yciem poni¿szych, podanych w kolejno¶ci
rosn±cego priorytetu, operatorów:
.PP
.RS
.nf
.vs +2p  \"  open up a little
\fIprzypisanie\fR                =  +=  \-=  *=  /=  %=  ^=
\fIwarunkowe\fR                 ?  :
\fIlogiczne or\fR               ||
\fIlogiczne and\fR              &&
\fIprzynale¿no¶æ do tablicy\fR  \fBin
\fIdopasowanie\fR               ~   !~
\fIrelacyjne\fR                 <  >   <=  >=  ==  !=
\fIkonkatenacja\fR              (bez specjalnego operatora)
\fIdodawanie/odejmowanie\fR     +  \-
\fImno¿enie/dzielenie\fR        *  /  %
\fIjednoargumentowe\fR          +  \-
\fIlogiczne not\fR              !
\fIpotêgowanie\fR               ^
\fIinkrementacja/dekr.\fR       ++ \-\|\- (zarówno post jak i pre)
\fIpole\fR                      $
.vs
.RE
.PP
.fi
Przypisanie, operatory warunkowe i potêgowanie wi±¿± od prawej do lewej;
pozosta³e  od lewej do prawej. Ka¿de wyra¿enie mo¿e byæ umieszczone
w nawiasach.
.\"
.SS "6. Tablice"
.ds ae \fItablica\fR[\fIwyra¿\fR]
Awk obs³uguje tablice jednowymiarowe. Elementy tablic wskazuje siê jako \*(ae.
.I Wyra¿
jest przekszta³cane wewnêtrznie na typ ³añcuchowy, wiêc, na przyk³ad,
A[1] i A["1"] s± tym samym elementem, a faktycznym indeksem jest "1".
Tablice indeksowane ³añcuchami zwane s± tablicami asocjacyjnymi (tablicami
przyporz±dkowuj±cymi).
Pierwotnie tablica jest pusta; elementy zaistniej± przy pierwszym do nich
odwo³aniu.
Wyra¿enie
\fIwyra¿\fB in\fI tablica\fR
daje w wyniku 1 je¿eli istnieje \*(ae, w przeciwnym razie 0.
.PP
Istnieje postaæ instrukcji
.B for
wykonuj±ca pêtlê po wszystkich indeksach tablicy.
.nf
.sp
        \fBfor\fR ( \fIzmn\fB in \fItablica \fR) \fIinstrukcja\fR
.sp
.fi
ustawia
.I zmn
na ka¿dy z indeksów
.I tablicy
i wykonuje
.IR instrukcjê .
Kolejno¶æ, w jakiej
.I zmn
przechodzi przez indeksy
.I tablicy
nie jest zdefiniowana.
.PP
Instrukcja
.B delete
\*(ae,
powoduje usuniêcie
\*(ae.
.B mawk
obs³uguje rozszerzenie,
.B delete
.IR tablica ,
które usuwa wszystkie elementy
.IR tablicy .
.PP
Tablice wielowymiarowe tworzone s± sztucznie przez konkatenacjê
z zastosowaniem wbudowanej zmiennej
.BR SUBSEP .
\fItablica\fB[\fIwyra¿\d1\u\fB,\fIwyra¿\d2\u\fB]\fR
jest równowa¿nikiem
\fItablica\fB[\fIwyra¿\d1\u \fBSUBSEP \fIwyra¿\d2\u\fB]\fR.
Sprawdzanie elementu tablicy wielowymiarowej u¿ywa indeksu w nawiasach,
jak w
.sp
.nf
	if ( (i, j) in A )  print A[i, j]
.fi
.sp
.\"
.SS "7. Zmienne wbudowane"
.PP
Poni¿sze zmienne s± zmiennymi wbudowanymi. S± one inicjowane przed wykonaniem
programu.
.RS
.TP \w'FILENAME'u+2n
.B ARGC
liczba argumentów wiersza poleceñ.
.TP
.B ARGV
tablica argumentów wiersza poleceñ, 0..ARGC-1.
.TP
.B CONVFMT
format do wewnêtrznej konwersji liczb na ³añcuchy, pocz±tkowo = "%.6g".
.TP
.B ENVIRON
tablica zaindeksowana zmiennymi ¶rodowiska. £añcuch ¶rodowiska,
\fIzmn=warto¶æ\fR przechowywany jest jako
.BI ENVIRON[ zmn "] ="
.IR warto¶æ .
.TP
.B FILENAME
nazwa bie¿±cego pliku wej¶ciowego.
.TP
.B FNR
numer bie¿±cego rekordu w
.BR FILENAME .
.TP
.B FS
dzieli rekordy na pola jako wyra¿enie regularne.
.TP
.B NF
liczba pól bie¿±cego rekordu.
.TP
.B NR
numer bie¿±cego rekordu w ca³kowitym strumieniu wej¶ciowym.
.TP
.B OFMT
format do wydruku liczb; pocz±tkowo = "%.6g".
.TP
.B OFS
wstawiane pomiêdzy polami w wyj¶ciu, pocz±tkowo = " ".
.TP
.B ORS
koñczy ka¿dy z rekordów wyj¶ciowych, pocz±tkowo = "\en".
.TP
.B RLENGTH
d³ugo¶æ ustawiona przez ostatnie wywo³anie wbudowanej funkcji
.BR match() .
.TP
.B RS
separator rekordów wej¶ciowych, pocz±tkowo = "\en".
.TP
.B  RSTART
indeks ustawiony przez ostatnie wywo³anie
.BR match() .
.TP
.B SUBSEP
u¿ywany do budowy indeksów tablic wielowymiarowych, pocz±tkowo = "\e034".
.RE
.\"
.SS "8. Funkcje wbudowane"
Funkcje ³añcuchowe
.RS
.TP
.RI \fBgsub\fP( r , s , t ")  \fBgsub\fP(" r , s )
Zastêpowanie globalne (global substitution), ka¿de dopasowanie wyra¿enia
regularnego
.I r
w zmiennej
.I t
zastêpowane jest ³añcuchem
.IR s .
Zwracana jest liczba wykonanych zast±pieñ.
Je¿eli pominiêto
.IR t ,
to u¿ywane jest
.BR $0 .
Znak \fB&\fP w ³añcuchu zastêpuj±cym
.I s
zastêpowany jest dopasowanym pod³añcuchem ³añcucha
.IR t .
\fB\e&\fP oraz \fB\e\e\fP daj±, odpowiednio, dos³owne \fB&\fP i \fB\e\fP
w ³añcuchu zastêpuj±cym.
.TP
.RI \fBindex\fP( s , t )
Je¿eli
.I t
jest pod³añcuchem
.IR s ,
to zwracana jest pozycja, na której rozpoczyna siê
.IR t ,
w przeciwnym razie zwracane jest 0.
Pierwszy znak
.I s
jest na pozycji 1.
.TP
.RI \fBlength\fP( s )
Zwraca d³ugo¶æ ³añcucha
.IR s .
.TP
.RI \fBmatch\fP( s , r )
Zwraca indeks pierwszego najd³u¿szego dopasowania wyra¿enia regularnego
.I r
w ³añcuchu
.IR s .
Zwraca 0 je¶li nie wystêpuje dopasowanie.
Jako skutek uboczny, nastêpuje ustawienie
.B RSTART
na zwracan± warto¶æ.
.B RLENGTH
ustawiane jest na d³ugo¶æ dopasowania lub \-1 je¶li brak dopasowania.
Je¿eli dopasowano ³añcuch pusty, to
.B RLENGTH
ustawiane jest na 0, a zwracane jest 1 je¶li dopasowanie by³o na pocz±tku,
za¶ length(\fIs\fR)+1, gdy na koñcu ³añcucha.
.TP
.RI \fBsplit\fP( s , A , r ")  \fBsplit\fP(" s , A )
£añcuch
.I s
rozbijany jest na pola przez wyra¿enie regularne
.I  r
a pola wpisywane s± do tablicy
.IR A .
Zwracana jest liczba pól. Szczegó³y w sekcji 11 poni¿ej.
Je¿eli pominiêto
.IR r ,
u¿ywane jest
.BR FS .
.TP
.RI \fBsprintf\fP( format , lista-wyra¿ )
Zwraca ³añcuch utworzony z
.I listy-wyra¿eñ
zgodnie z
.IR formatem .
Zobacz opis printf() poni¿ej.
.TP
.RI \fBsub\fP( r , s , t ")  \fBsub\fP(" r , s )
Pojedyncze zast±pienie. Takie samo, jak gsub(), z wyj±tkiem tego, ¿e
wykonywane jest co najwy¿ej jedno zast±pienie.
.TP
.RI \fBsubstr\fP( s , i , n ")  \fBsubstr\fP(" s , i )
Zwraca pod³añcuch ³añcucha
.IR s ,
poczynaj±c od indeksu
.IR i ,
o d³ugo¶ci
.IR n .
Je¶li pominiêto
.IR n ,
zwracana jest koñcówka
.IR s ,
poczynaj±c od pozycji
.IR i .
.TP
.RI \fBtolower\fP( s )
Zwraca kopiê
.I s
ze wszystkimi du¿ymi literami przekszta³conymi na ma³e.
.TP
.RI \fBtoupper\fP( s )
Zwraca kopiê
.I s
ze wszystkimi ma³ymi literami przekszta³conymi na du¿e.
.RE
.PP
Funkcje arytmetyczne
.RS
.PP
.nf
\fBatan2\fR(\fIy\fR,\fIx\fR)     arcus tangens z \fIy\fR/\fIx\fR pomiêdzy -PI i PI.
.PP
\fBcos\fR(\fIx\fR)         funkcja cosinus, \fIx\fR w radianach.
.PP
\fBexp\fR(\fIx\fR)         funkcja wyk³adnicza.
.PP
\fBint\fR(\fIx\fR)         zwraca \fIx\fR obciête w stronê zera.
.PP
\fBlog\fR(\fIx\fR)         logarytm naturalny.
.PP
\fBrand\fR()         zwraca liczbê losow± miêdzy zero a jeden.
.PP
\fBsin\fR(\fIx\fR)         funkcja sinus, \fIx\fR w radianach.
.TP
\fBsqrt\fR(\fIx\fR)        zwraca pierwiastek kwadratowy z \fIx\fR.
.fi
.TP
.RI \fBsrand\fP( wyra¿ ")  \fBsrand\fP()"
Inicjuje ziarenko generatora liczb losowych, u¿ywaj±c zegara je¶li pominiêto
.IR wyra¿ ,
i zwraca warto¶æ poprzedniego ziarenka losowego.
.B mawk
inicjuje generator liczb losowych wed³ug zegara przy uruchomieniu,
wiêc nie ma faktycznej potrzeby wywo³ywania srand(). Srand(\fIwyra¿\fR)
przydaje siê do powtarzania ci±gów pseudolosowych.
.RE
.\"
.SS "9. Wej¶cie i wyj¶cie"
Istniej± dwie instrukcje wyj¶cia:
.B print
i
.BR printf .
.RS
.TP
.B print
zapisuje na standardowe wyj¶cie
.BR "$0  ORS" .
.TP
\fBprint\fP \fIwyra¿\d1\u\fR, \fIwyra¿\d2\u\fR, ..., \fIwyra¿\dn\u
zapisuje na standardowe wyj¶cie
\fIwyra¿\d1\u \fBOFS \fIwyra¿\d2\u \fBOFS\fR ... \fIwyra¿\dn\u
.BR ORS .
Wyra¿enia numeryczne s± konwertowane na ³añcuchy zgodnie z
.BR OFMT .
.TP
\fBprintf \fIformat\fR, \fIlista-wyra¿
powiela funkcjê biblioteczn± printf z C, pisz±c na standardowe wyj¶cie.
Rozpoznawany jest komplet specyfikacji formatów z ANSI C z konwersjami
%c, %d, %e, %E, %f, %g, %G, %i, %o, %s, %u, %x, %X i %%,
oraz kwalifikatorami konwersji h i l.
.RE
.PP
Lista argumentów print lub printf mo¿e byæ opcjonalnie ujêta w nawiasy.
Print formatuje liczby przy pomocy
.B OFMT
lub "%d" dla dok³adnie ca³kowitych.
"%c" z argumentem numerycznym wypisuje odpowiedni znak 8-bitowy, z argumentem
³añcuchowym wypisuje pierwszy znak ³añcucha.
Wyj¶cie print i printf mo¿na przekierowaæ do pliku lub polecenia do³±czaj±c
.B >
.IR plik ,
.B >>
.I plik
lub
.B |
.I polecenie
na koñcu instrukcji drukowania.
Przekierowanie otwiera
.I plik
lub
.I polecenie
tylko raz, kolejne przekierowania do³±czane s± do ju¿ otwartego strumienia.
Zgodnie z konwencj±,
.B mawk
³±czy nazwê pliku "/dev/stderr" z stderr, co pozwala na przekierowanie
wyników print i printf na standardowe wyj¶cie diagnostyczne.
.B mawk
wi±¿e równie¿, odpowiednio, "\-" i "/dev/stdout" z stdin i stdout, co
umo¿liwia przysy³anie tych strumieni do funkcji.
.PP
Funkcja wej¶cia
.B getline
ma nastêpuj±ce warianty:
.RS
.TP
.B getline
czyta do
.BR $0 ,
aktualizuje pola,
.BR NF ,
.B  NR
i
.BR FNR .
.TP
.B getline < \fIplik
czyta do
.B $0
z \fIpliku\fP, aktualizuje pola i
.BR NF .
.TP
.B getline \fIzmn
czyta nastêpny rekord do zmiennej
.IR zmn ,
aktualizuje
.B NR
i
.BR FNR .
.TP
.B getline \fIzmn\fP < \fIplik
czyta nastêpny rekord
.I pliku
do zmiennej
.IR zmn .
.TP
\fIpolecenie\fB | getline
przesy³a potokiem rekord z
.I polecenia
do
.B $0
i aktualizuje pola i
.BR NF .
.TP
\fIpolecenie\fB | getline \fIzmn
przesy³a potokiem rekord z
.I polecenia
do zmiennej
.IR zmn .
.RE
.PP
Getline zwraca 0 na koñcu pliku, \-1 przy b³êdzie, w pozosta³ych
przypadkach 1.
.PP
Polecenia na koñcu potoków wykonywane s± przez /bin/sh.
.PP
Funkcja \fBclose\fR(\*(ex) zamyka plik lub potok skojarzony z
.IR wyra¿ .
Close zwraca 0 je¿eli
.I wyra¿
jest otwartym plikiem, kod zakoñczenia je¶li
.I wyra¿
jest poleceniem potoku, a \-1 w pozosta³ych przypadkach.
Close stosowane jest do ponownego odczytu pliku lub polecenia, upewnienia
siê, ¿e drugi koniec potoku wyj¶ciowego jest zakoñczony lub do zachowania
zasobów plikowych.
.\" conserve file resources.
.PP
Funkcja \fBfflush\fR(\*(ex) wymiata plik wyj¶ciowy lub potok skojarzony z
.IR wyra¿ .
Fflush zwraca 0 je¶li
.I wyra¿
jest otwartym strumieniem wyj¶ciowym, w przeciwnym razie \-1.
Fflush bez argumentu opró¿nia stdout.
Fflush z pustym argumentem ("") opró¿nia wszystkie otwarte wyj¶cia.
.PP
Funkcja
\fBsystem\fR(\fIwyra¿\fR)
wykorzystuje
/bin/sh
do wykonania
.I wyra¿
i zwraca kod zakoñczenia polecenia
.IR wyra¿ .
Zmiany tablicy
.B ENVIRON
nie s± przekazywane poleceniom wykonywanym przez
.B system
lub potoki.
.SS "10. Funkcje definiowane przez u¿ytkownika"
Funkcja definiowana przez u¿ytkownika ma nastêpuj±c± sk³adniê:
.nf
.sp
    \fBfunction\fI nazwa\fR( \fIargumenty\fR ) { \fIinstrukcje\fR }
.sp
.fi
Cia³o funkcji mo¿e zawieraæ instrukcjê zwrócenia warto¶ci (return)
.nf
.sp
     \fBreturn\fI opcjonalne-wyra¿\fR
.sp
.fi
Instrukcja return nie jest wymagana.
Wywo³ania funkcji mog± byæ zagnie¿d¿ane lub rekurencyjne.
Wyra¿enia przekazywane s± funkcjom przez warto¶æ a tablice przez wskazanie.
Dodatkowe argumenty s³u¿± jako zmienne lokalne i s± inicjowane na
.IR null .
Na przyk³ad,
.RI csplit( s , A )
wstawia ka¿dy znak
.I s
do tablicy
.I A
i zwraca d³ugo¶æ
.IR s .
.nf
.sp
	function csplit(s, A,	n, i)
	{
	  n = length(s)
	  for( i = 1 ; i <= n ; i++ ) A[i] = substr(s, i, 1)
	  return n
	}
.sp
.fi
Wstawienie dodatkowych odstêpów pomiêdzy przekazywanymi parametrami
a zmiennymi lokalnymi wynika z konwencji.
Do funkcji mo¿na odwo³ywaæ siê przed ich zdefiniowaniem, ale nazwa funkcji
i nawias '(' rozpoczynaj±cy listê argumentów musz± siê stykaæ, by unikn±æ
pomy³ki z konkatenacj±.
.\"
.SS "11. Podzia³ ³añcuchów, rekordów i plików"
Programy awk u¿ywaj± tego samego algorytmu do rozbicia ³añcuchów na tablice
przy pomocy split() i rekordów na pola wed³ug
.BR FS .
.B mawk
stosuje zasadniczo ten sam algorytm przy podziale plików na rekordy
wed³ug
.BR RS .
.PP
.RI \fBSplit\fP( wyra¿ , A, sep )
dzia³a nastêpuj±co:
.RS
.TP
(1)
Je¿eli pominiêto
.IR sep ,
to jest on zastêpowany przez
.BR FS .
.I Sep
mo¿e byæ wyra¿eniem lub wyra¿eniem regularnym. Je¿eli jest wyra¿eniem typu
nie-³añcuchowego, to jest przekszta³cane na ³añcuch.
.TP
(2)
Je¶li
.I sep
= " " (pojedyncza spacja),
to <ODSTÊP> jest obcinana z pocz±tku i koñca
.IR wyra¿ ,
a
.I sep
staje siê <ODSTÊPEM>.
.B mawk
definiuje <ODSTÊP> jako wyra¿enie regularne
/[\ \et\en]+/.
W przeciwnym wypadku
.I sep
traktowany jest jako wyra¿enie regularne, z wyj±tkiem tego, ¿e metaznaki
dla ³añcucha o d³ugo¶ci 1 s± ignorowane, np.
split(x, A, "*") i split(x, A, /\e*/) s± tym samym.
.TP
(3)
Je¿eli \*(ex nie jest ³añcuchem, jest przekszta³cane na ³añcuch.
Je¿eli \*(ex jest wówczas ³añcuchem pustym "", to split() zwraca 0
a
.I A
jest ustawiane jako puste.
W przeciwnym razie, wszystkie nienak³adaj±ce siê, niepuste i najd³u¿sze
dopasowania
.I sep
w
.IR wyra¿ ,
dziel±
.I wyra¿
na pola, które wpisywane s± do
.IR A .
Pola s± umieszczane w
A[1], A[2], ..., A[n] a split() zwraca n, liczbê pól, równ± liczbie dopasowañ
plus jeden.
Dane umieszczone w
.I A
wygl±daj±ce na numeryczne otrzymuj± typ liczbowo-³añcuchowy.
.RE
.PP
Podzia³ rekordów na pola dzia³a tak samo, z wyj±tkiem tego, i¿ czê¶ci
wpisywane s± do
.BR $1 ,
\fB$2\fR,...,
.BR $NF .
Je¿eli
.B $0
jest puste,
.B NF
jest ustawiane na 0 a wszystkie
.B $i
na "".
.PP
.B mawk
dzieli pliki na rekordy przy pomocy tego samego algorytmu, ale z t± niewielk±
ró¿nic±, i¿
.B RS
jest faktycznie ci±giem koñcz±cym a nie separatorem.
(\fBORS\fR te¿ jest faktycznie ci±giem koñcz±cym).
.RS
.PP
Np., je¿eli
.B FS
= ":+" a
.B $0
= "a::b:" , to
.B NF
= 3 a
.B $1
= "a",
.B $2
= "b" i
.B $3
= "", ale
je¿eli zawarto¶ci± pliku wej¶ciowego jest "a::b:", za¶
.B RS
= ":+", to
istniej± dwa rekordy "a" i "b".
.RE
.PP
.B RS
= " " nie ma specjalnego znaczenia.
.PP
Je¿eli
.B FS
= "", to
.B mawk
rozbija rekord na pojedyncze znaki, i, podobnie
.RI split( s , A ,"")
umieszcza poszczególne znaki
.I s
w
.IR A .
.\"
.SS "12. Rekordy wielowierszowe"
Poniewa¿
.B mawk
interpretuje
.B RS
jako wyra¿enie regularne, obs³uga rekordów wielowierszowych jest ³atwa.
Ustawienie
.B RS
= "\en\en+", powoduje, ¿e rekordy rozdzielane s± co najmniej jednym pustym
wierszem. Je¿eli
.B FS
= " " (domy¶lnie), to pojedyncze znaki nowej linii, wed³ug zasad <ODSTÊPU>
powy¿ej, staj± siê odstêpami a pojedyncze znaki nowej linii s± separatorami
pól.
.RS
.PP
Na przyk³ad, je¶li w pliku jest "a\ b\enc\en\en",
.B RS
= "\en\en+" a
.B FS
= "\ ", to mamy jeden rekord "a\ b\enc" z trzema polami "a", "b" i "c".
Zmiana
.B FS
= "\en", daje dwa pola "a b" i "c"; zmieniaj±c
.B FS
= "", otrzymujemy jedno pole identyczne jak rekord.
.RE
.PP
Traktowanie wierszy ze spacjami lub tabulacjami jako pustych mo¿na uzyskaæ
ustawiaj±c
.B RS
= "\en([\ \et]*\en)+".
W celu utrzymania zgodno¶ci z innymi implementacjami awk, ustawienie
.B RS
= "" daje te same wyniki, co usuniêcie pustych wierszy z pocz±tku i koñca
pliku i okre¶lanie rekordów tak, jakby
.B RS
= "\en\en+".
Posix wymaga, by "\en" zawsze separowa³o rekordy gdy
.B RS
= "" niezale¿nie od warto¶ci
.BR FS .
.B mawk
nie obs³uguje tej konwencji, gdy¿ zdefiniowanie "\en" jako <ODSTÊPU>
czyni j± zbêdn±.
.\"
.PP
W wiêkszo¶ci przypadków zmieniaj±c
.B RS
w celu obs³ugi rekordów wielowierszowych, stosuje siê te¿ zmienione
na "\en\en"
.BR ORS ,
aby na wyj¶ciu zachowaæ odstêpy miêdzy rekordami.
.\"
.SS "13. Wykonywanie programu"
Ta sekcja opisuje kolejno¶æ wykonywania programu.
Po pierwsze,
.B ARGC
ustawiane jest na ca³kowit± liczbê argumentów wiersza poleceñ przekazanych
do fazy wykonania programu.
.B ARGV[0]
ustawiane jest na nazwê interpretera AWK a
\fBARGV[1]\fR ...
.B ARGV[ARGC-1]
przechowuje pozosta³e argumenty wiersza poleceñ z wyj±tkiem opcji
i ¼ród³a programu.
Na przyk³ad, dla
.nf
.sp
	mawk  \-f  prog  v=1  A  t=hello  B
.sp
.fi
.B ARGC
= 5 oraz
.B ARGV[0]
= "mawk",
.B ARGV[1]
= "v=1",
.B ARGV[2]
= "A",
.B ARGV[3]
= "t=hello" i
.B ARGV[4]
= "B".
.PP
Nastêpnie wykonywany jest kolejno ka¿dy z bloków
.BR BEGIN .
Je¿eli program sk³ada siê wy³±cznie z bloków
.BR BEGIN ,
to na tym wykonywanie siê koñczy, w przeciwnym razie otwierany jest strumieñ
wej¶ciowy i wykonywanie jest kontynuowane.
Je¿eli
.B ARGC
równa siê 1,
strumieñ wej¶ciowy ustawiany jest na stdin, w przypadku przeciwnym
w poszukiwaniu argumentu plikowego sprawdzane s± argumenty wiersza poleceñ
.BR ARGV[1]  " ..."
.BR ARGV[ARGC-1] .
.PP
Argumenty wiersza poleceñ dziel± siê na trzy grupy:
argumenty plikowe, argumenty przypisañ i ³añcuchy puste "".
Przypisanie ma postaæ
\fIzmn\fR=\fI³añcuch\fR.
Podczas sprawdzania
.B ARGV[i]
jako mo¿liwego argumentu plikowego, je¶li jest ono puste to jest
pomijane; je¶li jest argumentem typu przypisania, odbywa siê przypisanie
warto¶ci zmiennej
.I zmn
a
.B i
zmienia siê na nastêpny argument; w pozosta³ych przypadkach
.B ARGV[i]
jest otwierane jako wej¶cie.
Je¿eli otwarcie nie powiedzie siê, wykonywanie programu jest koñczone
z kodem 2.
Je¿eli ¿aden z argumentów wiersza poleceñ nie jest argumentem plikowym, to
wej¶cie pochodzi z stdin.
Getline w akcji
.B BEGIN
otwiera wej¶cie.  "\-" jako argument plikowy oznacza stdin.
.PP
Po otwarciu strumienia wej¶ciowego ka¿dy z rekordów wej¶cia sprawdzany jest
z ka¿dym ze
.IR wzorców ,
a je¶li pasuje, to wykonywana jest
.I akcja
skojarzona z danym wzorcem.
Wzorzec w postaci wyra¿enia pasuje je¶li jego warto¶ci± logiczn± jest prawda
(zobacz koniec sekcji 2).
Wzorzec
.B BEGIN
zestawiany jest przed rozpoczêciem odczytu wej¶cia,
za¶ wzorzec
.B END
po przeczytaniu ca³ego wej¶cia.
Wzorzec zakresu, \fIwyra¿1\fP\fB,\fP\fIwyra¿2\fP, dopasowuje
ka¿dy rekord pomiêdzy rekordem pasuj±cym do
.I wyra¿1
a rekordem pasuj±cym do
.I wyra¿2
³±cznie z nimi.
.PP
Po napotkaniu koñca pliku w strumieniu wej¶ciowym, sprawdzane s± pozosta³e
argumenty wiersza poleceñ w poszukiwaniu kolejnego argumentu plikowego.
Je¶li taki istnieje, to jest otwierany, w przeciwnym wypadku przyjmuje siê,
¿e zosta³ dopasowany
.I wzorzec
.B END
i wykonywane s± wszystkie
.I akcje
.BR END .
.PP
W rozwa¿anym przyk³adzie, przypisanie
v=1
ma miejsce po wykonaniu
.I akcji
.BR BEGIN ,
a dana umieszczona w
v
otrzymuje typ liczbowo-³añcuchowy.
Nastêpnie z pliku A jest czytane wej¶cie.
Po koñcu pliku A, zmienna
t
jest ustawiana na ³añcuch "hello", a B jest otwierany jako wej¶cie.
Po osi±gniêciu koñca pliku B s± wykonywane
.I akcje
wzorca
.BR END .
.PP
Przebieg programu na poziomie
.I wzorzec
.I {akcja}
mo¿na zmieniæ przy pomocy instrukcji
.nf
.sp
     \fBnext
     \fBexit  \fIwyra¿-opcjonalne\fR.
.sp
.fi
Instrukcja
.B next
powoduje, ¿e odczyt nastêpnego rekordu wej¶ciowego i ponowne sprawdzanie
wzorców, od pierwszej pary
.I "wzorzec {akcja}"
programu.
Polecenie
.B  exit
powoduje natychmiastowe wykonanie akcji
.B END
lub zakoñczenie programu, je¶li nie ma takich akcji lub je¿eli
.B exit
wyst±pi³o w akcji
.BR END .
.I wyra¿-opcjonalne
ustawia warto¶æ kodu zakoñczenia programu, chyba ¿e zostanie ona przes³oniêta
przez pó¼niejszy
.B exit
lub ujawniony potem b³±d.
.SH PRZYK£ADY
.nf
1. emulacja cat.

     { print }

2. emulacja wc.

     { chars += length($0) + 1  # dodaje jeden dla \en
       words += NF
     }

     END{ print NR, words, chars }

3. zliczanie niepowtarzaj±cych siê "faktycznych s³ów".

     BEGIN { FS = "[^A-Za-z]+" }

     { for(i = 1 ; i <= NF ; i++)  word[$i] = "" }

     END { delete word[""]
           for ( i in word )  cnt++
           print cnt
     }

.fi
4. sumowanie drugiego pola ka¿dego rekordu w oparciu
o pierwsze pole.
.nf

     $1 ~ /credit\||\|gain/ { sum += $2 }
     $1 ~ /debit\||\|loss/  { sum \-= $2 }

     END { print sum }

5. sortowanie pliku, porównywanie ³añcuchowe

     { line[NR] = $0 "" }  # wymusza typ porównywania: gdyby
                           # jakie¶ wiersze wygl±da³y
                           # na numeryczne

     END {  isort(line, NR)
       for(i = 1 ; i <= NR ; i++) print line[i]
     }

     #sortowanie A[1..n] metod± wstawiania
     function isort( A, n,   i, j, hold)
     {
       for( i = 2 ; i <= n ; i++)
       {
         hold = A[j = i]
         while ( A[j\-1] > hold )
         { j\-\|\- ; A[j+1] = A[j] }
         A[j] = hold
       }
       # w razie potrzeby bêdzie utworzony wartownik A[0] = ""
     }

.fi
.SH "KWESTIE ZGODNO¦CI"
Posix-owa 1003.2 (propozycja 11.3) definicja jêzyka AWK jest AWK opisanym
w ksi±¿ce AWK z kilkoma rozszerzeniami, jakie pojawi³y siê w nawk
z SystemVR4. Rozszerzeniami tymi s±:
.sp
.RS
Nowe funkcje: toupper() i tolower().

Nowe zmienne: ENVIRON[\|] i CONVFMT.

Specyfikacje konwersji w printf() i sprintf() wziête z ANSI C.

Nowe opcje polecenia:  \-v zmn=warto¶æ, wielokrotne opcje -f i opcje
charakterystyczne dla implementacji jako argumenty \-W.
.RE
.sp

Posix-owy AWK przetwarza pojedyncze wiersze plików.
.B RS
mo¿na zmieniæ z "\en" na inny pojedynczy znak, ale trudno jest znale¼æ
jakie¶ tego zastosowanie \(em w ksi±¿ce AWK brak odpowiednich przyk³adów.
Zgodnie z konwencj±, \fBRS\fR = "", powoduje, ¿e jeden lub wiêcej pustych
wierszy rozdziela rekordy, umo¿liwiaj±c obs³ugê rekordów wielowierszowych.
Gdy \fBRS\fR = "", "\en" jest zawsze separatorem pól, niezale¿nie od warto¶ci
.BR FS .
.PP
.BR mawk ,
z kolei,
pozwala by
.B RS
by³o wyra¿eniem regularnym.
Pojawiaj±ce siê w rekordach "\en" jest traktowane jak odstêp, a
.B FS
zawsze okre¶la pola.
.PP
Pozbycie siê paradygmatu operowania pojedynczym wierszem mo¿e upro¶ciæ
niektóre programy i czêsto poprawiæ wydajno¶æ. Na przyk³ad, zmienieniony
przyk³ad 3 (zobacz powy¿ej),
.nf
.sp
	BEGIN { RS = "[^A-Za-z]+" }

	{ word[ $0 ] = "" }

	END { delete  word[ "" ]
	  for( i in word )  cnt++
	  print cnt
	}
.sp
.fi
zlicza ilo¶æ niepowtarzaj±cych siê s³ów przez
traktowanie ka¿dego s³owa jako rekordu.
Przy plikach ¶rednich rozmiarów
.B mawk
wykonuje go dwukrotnie szybciej, dziêki uproszczonej pêtli wewnêtrznej.
.PP
Poni¿szy program zastêpuje ka¿dy z komentarzy w pliku programu C
pojedyncz± spacj±,
.nf
.sp
	BEGIN {
	  RS = "/\|\e*([^*]\||\|\e*+[^/*])*\e*+/"
                # komentarz jest separatorem rekordów
	  ORS = " "
	  getline  hold
       }

       { print hold ; hold = $0 }

       END { printf "%s" , hold }
.sp
.fi
Buforowanie rekordu jest niezbêdne, by unikn±æ zakoñczenia ostatniego
z rekordów spacj±.
.PP
W
.B mawk
poni¿sze wyra¿enia s± równowa¿ne,
.nf
.sp
	x ~ /a\e+b/    x ~ "a\e+b"     x ~ "a\e\e+b"
.sp
.fi
Powy¿sze ³añcuchy bêd± analizowane dwukrotnie: raz jako ³añcuch i raz jako
wyra¿enie regularne. Przy analizie ³añcucha
.B mawk
ignoruje stosowanie cytowania odwrotnym uko¶nikiem do znaków nie bêd±cych
znakami specjalnymi, zatem
.I \ec
interpretuje jako
.IR \ec .
Natomiast ksi±¿ka AWK przychyla siê do tego, by
.I \ec
by³o rozpoznawane jako
.IR c ,
co wymaga podwojonego cytowania metaznaków w ³añcuchach.
Posix wprost odmawia zdefiniowania po¿±danego zachowania, przez co
po¶rednio wymusza na programach musz±cych dzia³aæ z ró¿nymi wersjami
awk stosowanie bardziej przeno¶nego, lecz mniej czytelnego, cytowania
z u¿yciem podwójnych odwrotnych uko¶ników.
.PP
Posix-owy AWK nie rozpoznaje "/dev/std{out,err}" ani sekwencji
specjalnej \ex hex w ³añcuchach. W przeciwieñstwie do ANSI C,
.B mawk
ogranicza liczbê cyfr, jakie mog± wystêpowaæ po \ex do dwóch, gdy¿ obecna
implementacja obs³uguje tylko znaki 8-bitowe.
Wbudowane
.B fflush
pojawi³o siê po raz pierwszy w ostatnim (1993) awk AT&T wydanym dla netlib,
i nie jest czê¶ci± standardu Posix. Ca³o¶ciowe usuwanie tablicy przez
.B delete
.I tablica
nie jest czê¶ci± standardu Posix.
.PP
Posix jawnie zostawia niezdefiniowane zachowanie siê
.B FS
= "" i wspomina o podziale rekordów na znaki jako
mo¿liwej interpretacji, ale obecnie takie zastosowanie nie jest przeno¶ne
miêdzy implementacjami.
.PP
Na koniec, sposób w jaki
.B mawk
obs³uguje przypadki wyj±tkowe nie opisane w ksi±¿ce AWK ani w propozycji
Posix. Niebezpiecznie jest zak³adanie spójno¶ci pomiêdzy implementacjami
awk, a bezpiecznie przej¶æ do nastêpnej sekcji.
.PP
.RS
substr(s, i, n) zwraca znaki ³añcucha s o pozycjach z czê¶ci wspólnej
przedzia³u zamkniêtego [1, length(s)] i pó³otwartego [i, i+n).  Gdy
czê¶æ wspólna jest pusta, zwracany jest ³añcuch pusty; zatem
substr("ABC", 1, 0) = "" a substr("ABC", \-4, 6) = "A".
.PP
Ka¿dy ³añcuch, nawet pusty, pasuje pocz±tkiem do ³añcucha pustego, wiêc
s ~ // i s ~ "", s± zawsze równe 1, tak jak match(s, //) i match(s, "").
Ostanie dwa ustawiaj±
.B RLENGTH
na 0.
.PP
index(s, t) jest zawsze tym samym, co match(s, t1), gdzie t1, to to samo, co
t z cytowanymi metaznakami. St±d spójno¶æ z match wymaga, by index(s, "")
zawsze zwraca³o 1.
Równie¿ warunek: index(s,t) != 0 wtedy i tylko wtedy, gdy t jest pod³añcuchem
³añcucha s, wymusza by index("","") = 1.
.PP
Je¿eli getline napotka koniec pliku, getline zmn pozostawia zmienn± zmn
bez zmian. Podobnie, w momencie rozpoczêcia akcji
.BR END ,
warto¶ci
.BR $0 ,
pól i
.B NF
pozostaj± niezmienione od ostatniego rekordu.
.SH ZOBACZ TAK¯E
.BR egrep (1)
.PP
Aho, Kernighan and Weinberger,
.IR "The AWK Programming Language" ,
Addison-Wesley Publishing, 1988, (ksi±¿ka AWK),
definiuje jêzyk, rozpoczynaj±c siê samouczkiem a dochodz±c do wielu
interesuj±cych programów i wchodz±c g³êboko w kwestie projektowania
i analizy programów istotne przy programowaniu w ka¿dym jêzyku.
.PP
.IR "The GAWK Manual" ,
The Free Software Foundation, 1991, stanowi podrêcznik i opis
jêzyka nie usi³uj±cy siêgn±æ g³êbi ksi±¿ki AWK. Zak³ada, ¿e
czytelnik mo¿e byæ pocz±tkuj±cym programist±. Sekcja po¶wiêcona tablicom
w AWK jest doskona³a. Omawia tak¿e wymagania stawiane AWK przez Posix.
.SH B£ÊDY
.B mawk
nie obs³uguje znaku ascii NUL \e0 w plikach ¼ród³owych czy plikach danych.
Mo¿na wypisaæ NUL przy pomocy printf z %c, a w wej¶ciu
s± dopuszczalne wszystkie inne znaki 8-bitowe.
.PP
.B mawk
implementuje printf() i sprintf() przy pomocy funkcji bibliotecznych C,
printf i sprintf, wiêc pe³na zgodno¶æ z ANSI wymaga biblioteki ANSI C.
W praktyce oznacza to, ¿e kwalifikator konwersji h mo¿e nie byæ dostêpny.
.B mawk
przejmuje te¿ wszystkie b³êdy czy ograniczenia tych funkcji.
.PP
Twórcy implementacji jêzyka AWK ukazali zgodny brak wyobra¼ni
w nazywaniu swych programów.
.SH AUTOR
Mike Brennan (brennan@whidbey.com).
