# Conditional build:
%bcond_with	bootdisk		# build bootdisk version (linked with glibc-static)
%bcond_without	tests

%define	snap	20130219

Summary:	An interpreter for the awk programming language
Summary(de.UTF-8):	Mikes neuer Posix AWK-Interpretierer
Summary(es.UTF-8):	Nuevo interpretador (Posix) AWK del Mike
Summary(fr.UTF-8):	Mike's New/Posix AWK Interpreter : interpréteur AWK
Summary(pl.UTF-8):	Interpreter języka programowania awk
Summary(pt_BR.UTF-8):	Novo interpretador (Posix) AWK do Mike
Summary(ru.UTF-8):	Интерпретатор языка программирования awk
Summary(tr.UTF-8):	Posix AWK Yorumlayıcısı
Summary(uk.UTF-8):	Інтерпретатор мови програмування awk
Name:		mawk
Version:	1.3.4
Release:	0.%{snap}.1
License:	GPL
Group:		Applications/Text
Source0:	ftp://invisible-island.net/mawk/%{name}-%{version}-%{snap}.tgz
# Source0-md5:	5106dcce3988b86cb104a06c1070ce81
Source1:	%{name}.1.pl
Patch0:		%{name}-fix_%{name}_path.patch
URL:		http://invisible-island.net/mawk/mawk.html
BuildRequires:	autoconf
BuildRequires:	automake
BuildRequires:	bison
%{?with_bootdisk:BuildRequires:	glibc-static}
Provides:	/bin/awk
Provides:	awk
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%define		_exec_prefix	/
%define		_bindir		/bin

%description
Mawk is a version of the awk programming language. Awk interprets a
special-purpose programming language to do quick text pattern matching
and reformatting. Mawk improves on awk in certain ways and can
sometimes outperform gawk, the standard awk program for Linux. Mawk
conforms to the POSIX 1003.2 (draft 11.3) definition of awk.

%description -l de.UTF-8
Mawk ist eine Version von awk, einem leistungsfähigen
Textverarbeitungsprogramm. In bestimmten Bereichen leistet mawk mehr
als gawk, das Standard-awk-Programm auf Linux.

%description -l es.UTF-8
Mawk es una versión del awk, que es un fuerte programa procesador de
texto. En algunas áreas mawk puede superar gawk, que es el programa
awk padrón del Linux.

%description -l fr.UTF-8
mawk est une version d'awk, un puissant programme de traitement du
texte. Dans certains cas, mawk peut être supérieur à gawk, qui est le
programme awk standard sur Linux

%description -l pl.UTF-8
Mawk jest wersją interpretera języka programowania awk. Awk jest
specjalizowanym językiem programowania do szybkiego przetwarzania
tekstów. Mawk w pewien sposób ulepsza awk i czasem przerasta nawet
gawk - standardowy interpreter awk-a w Linuksie. Mawk jest zgodny ze
standardem języka awk opisanym w POSIX 1003.2 (draft 11.3).

%description -l pt_BR.UTF-8
Mawk é uma versão do awk, que é um poderoso programa processador de
texto. Em algumas áreas mawk pode superar gawk, que é o programa awk
padrão do Linux.

%description -l ru.UTF-8
Mawk - это версия языка программирования awk, мощного инструмента для
обработки текста. Mawk имеет улучшенную реализацию некоторых
возможностей awk и иногда быстрее gawk, стандартной программы awk для
Linux. Mawk соответствует POSIX 1003.2 (draft 11.3) определению языка
awk.

%description -l tr.UTF-8
Mawk, çok güçlü bir metin işleme programı olan awk'ın bir sürümüdür.
Bazı durumlarda Linux un standart awk programı olan gawk'dan daha
üstündür.

%description -l uk.UTF-8
Mawk - це версія мови програмування awk, потужного інструменту для
обробки тексту. Mawk має покращену реалізацію деяких можливостей awk і
іноді швидший за gawk, стандартну програму awk для Linux. Mawk
відповідає POSIX 1003.2 (draft 11.3) визначенню мови awk.

%package BOOT
Summary:	An interpreter for the awk programming language - BOOT
Summary(de.UTF-8):	Mikes neuer Posix AWK-Interpretierer - BOOT
Summary(fr.UTF-8):	Mike's New/Posix AWK Interpreter : interpréteur AWK - BOOT
Summary(pl.UTF-8):	Interpreter języka programowania awk - BOOT
Summary(tr.UTF-8):	Posix AWK Yorumlayıcısı - BOOT
Group:		Applications/Text

%description BOOT
Bootdisk awk version.

%description BOOT -l pl.UTF-8
Wersja awka na bootkietkę.

%prep
%setup -q -n %{name}-%{version}-%{snap}
%patch0 -p1

%build
%configure \
	 --enable-init-srand

%if %{with bootdisk}
%{__make} -j1 \
	MATHLIB=%{_prefix}/%{_lib}/libm.a \
	LDFLAGS="%{rpmldflags}"
mv -f mawk mawk.BOOT
%{__make} clean
%endif
%{__make} -j1 \
	LDFLAGS="%{rpmldflags}"

%{?with_tests:%{__make} -j1 check}

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/{man1,pl/man1},%{_examplesdir}/%{name}-%{version},/bin}

%{__make} install \
	prefix=$RPM_BUILD_ROOT%{_prefix} \
	MANDIR=$RPM_BUILD_ROOT%{_mandir}/man1 \
	BINDIR=$RPM_BUILD_ROOT%{_bindir}

ln -sf mawk $RPM_BUILD_ROOT%{_bindir}/awk
echo ".so mawk.1" > $RPM_BUILD_ROOT%{_mandir}/man1/awk.1

install %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/mawk.1
echo ".so mawk.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/awk.1

cp -p examples/* $RPM_BUILD_ROOT%{_examplesdir}/%{name}-%{version}

%if %{with bootdisk}
install -d $RPM_BUILD_ROOT%{_libdir}/bootdisk/bin
install mawk.BOOT $RPM_BUILD_ROOT%{_libdir}/bootdisk/bin/awk
%endif

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc ACKNOWLEDGMENT CHANGES README
%attr(755,root,root) %{_bindir}/mawk
%attr(755,root,root) %{_bindir}/awk
%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*
%{_examplesdir}/%{name}-%{version}

%if %{with bootdisk}
%files BOOT
%defattr(644,root,root,755)
%attr(755,root,root) %{_libdir}/bootdisk/bin/awk
%endif
