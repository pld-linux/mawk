Summary:	An interpreter for the awk programming language.
Summary(pl):	Interpreter jêzyka programowania awk.
Name:		mawk
Version:	1.3.3
Release:	13
Copyright:	GPL
Group:		Utilities/Text
Group(pl):	Narzêdzia/Tekst
Source:		ftp://ftp.whidbey.net/pub/brennan/%{name}%{version}.tar.gz
BuildRoot:	/tmp/%{name}-%{version}-root

%description
Mawk is a version of the awk programming language.  Awk interprets a 
special-purpose programming language to do quick text pattern matching
and reformatting.  Mawk improves on awk in certain ways and can 
sometimes outperform gawk, the standard awk program for Linux.  Mawk
conforms to the POSIX 1003.2 (draft 11.3) definition of awk.

You should install mawk if you use awk.

%description -l pl
Mawk jest wersj± interpretera jêzyka programowania awk. Awk jest
specjalizowanym jêzykiem programowania do szybkiego przetwarzania tekstów.
Mawk w pewien sposób ulepsza awk i czasem przerasta nawet gawk - standardowy
interpreter awk-a w Linuksie. Mawk jest zgodny ze standardem jêzyka awk
opisanym w POSIX 1003.2 (draft 11.3).

%prep
%setup -q

%build
CFLAGS="$RPM_OPT_FLAGS" \
./configure \
	--prefix=%{_prefix}
make

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/man1,/usr/src/examples/%{name},/bin}

make install \
	prefix=$RPM_BUILD_ROOT%{_prefix} \
	MANDIR=$RPM_BUILD_ROOT%{_mandir}/man1 \
	BINDIR=$RPM_BUILD_ROOT%{_bindir}

ln -s %{_bindir}/mawk $RPM_BUILD_ROOT/bin/awk

mv examples/* $RPM_BUILD_ROOT/usr/src/examples/%{name}

strip $RPM_BUILD_ROOT%{_bindir}/*

gzip -9nf ACKNOWLEDGMENT CHANGES README \
	$RPM_BUILD_ROOT%{_mandir}/man1/*

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc *.gz
%attr(755,root,root) %{_bindir}/mawk
/bin/awk
/usr/src/examples/%{name}
%{_mandir}/man1/mawk.1*
