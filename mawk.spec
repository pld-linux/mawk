Summary:	An interpreter for the awk programming language
Summary(de):	Mikes neuer Posix AWK-Interpretierer
Summary(es):	Nuevo interpretador (Posix) AWK del Mike
Summary(fr):	Mike's New/Posix AWK Interpreter : interpréteur AWK
Summary(pl):	Interpreter jêzyka programowania awk
Summary(pt_BR):	Novo interpretador (Posix) AWK do Mike
Summary(tr):	Posix AWK Yorumlayýcýsý
Name:		mawk
Version:	1.3.3
Release:	22
License:	GPL
Group:		Applications/Text
Source0:	ftp://ftp.whidbey.net/pub/brennan/%{name}%{version}.tar.gz
Source1:	%{name}.1.pl
Patch0:		%{name}-fix_%{name}_path.patch
Patch1:		%{name}-ac-workaround.patch
Provides:	/bin/awk
Provides:	awk
BuildRequires:	autoconf
%{?BOOT:BuildRequires:	glibc-static}
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%define		_exec_prefix	/

%description
Mawk is a version of the awk programming language. Awk interprets a
special-purpose programming language to do quick text pattern matching
and reformatting. Mawk improves on awk in certain ways and can
sometimes outperform gawk, the standard awk program for Linux. Mawk
conforms to the POSIX 1003.2 (draft 11.3) definition of awk.

%description -l de
Mawk ist eine Version von awk, einem leistungsfähigen
Textverarbeitungsprogramm. In bestimmten Bereichen leistet mawk mehr
als gawk, das Standard-awk-Programm auf Linux.

%description -l es
Mawk es una versión del awk, que es un fuerte programa procesador de
texto. En algunas áreas mawk puede superar gawk, que es el programa
awk padrón del Linux.

%description -l fr
mawk est une version d'awk, un puissant programme de traitement du
texte. Dans certains cas, mawk peut être supérieur à gawk, qui est le
programme awk standard sur Linux

%description -l pl
Mawk jest wersj± interpretera jêzyka programowania awk. Awk jest
specjalizowanym jêzykiem programowania do szybkiego przetwarzania
tekstów. Mawk w pewien sposób ulepsza awk i czasem przerasta nawet
gawk - standardowy interpreter awk-a w Linuksie. Mawk jest zgodny ze
standardem jêzyka awk opisanym w POSIX 1003.2 (draft 11.3).

%description -l pt_BR
Mawk é uma versão do awk, que é um poderoso programa processador de
texto. Em algumas áreas mawk pode superar gawk, que é o programa awk
padrão do Linux.

%description -l tr
Mawk, çok güçlü bir metin iþleme programý olan awk'ýn bir sürümüdür.
Bazý durumlarda Linux un standart awk programý olan gawk'dan daha
üstündür.

%package BOOT
Summary:	An interpreter for the awk programming language - BOOT
Summary(de):	Mikes neuer Posix AWK-Interpretierer - BOOT
Summary(fr):	Mike's New/Posix AWK Interpreter : interpréteur AWK - BOOT
Summary(pl):	Interpreter jêzyka programowania awk - BOOT
Summary(tr):	Posix AWK Yorumlayýcýsý - BOOT
Group:		Applications/Text

%description BOOT
Bootdisk awk version.

%description BOOT -l pl
Wersja awka na bootkietkê.

%prep
%setup -q
%patch0 -p1
%patch1 -p1

%build
autoconf
%configure
%if %{?BOOT:1}%{!?BOOT:0}
%{__make} MATHLIB=/usr/lib/libm.a
mv -f mawk mawk.BOOT
%{__make} clean
%endif
%{__make}

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/{man1,pl/man1},%{_examplesdir}/%{name},/bin}

%{__make} install \
	prefix=$RPM_BUILD_ROOT%{_prefix} \
	MANDIR=$RPM_BUILD_ROOT%{_mandir}/man1 \
	BINDIR=$RPM_BUILD_ROOT%{_bindir}

ln -sf mawk $RPM_BUILD_ROOT%{_bindir}/awk
echo ".so mawk.1" > $RPM_BUILD_ROOT%{_mandir}/man1/awk.1

install %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/mawk.1
echo ".so mawk.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/awk.1

mv -f examples/* $RPM_BUILD_ROOT%{_examplesdir}/%{name}

%if %{?BOOT:1}%{!?BOOT:0}
install -d $RPM_BUILD_ROOT/usr/lib/bootdisk/bin
install mawk.BOOT $RPM_BUILD_ROOT/usr/lib/bootdisk/bin/awk
%endif

gzip -9nf ACKNOWLEDGMENT CHANGES README

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc *.gz
%attr(755,root,root) %{_bindir}/mawk
%attr(755,root,root) /bin/awk
%{_examplesdir}/%{name}
%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*

%if %{?BOOT:1}%{!?BOOT:0}
%files BOOT
%defattr(644,root,root,755)
%attr(755,root,root) /usr/lib/bootdisk/bin/awk
%endif
