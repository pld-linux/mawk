Summary:	An interpreter for the awk programming language.
Name:		mawk
Version:	1.2.2
Release:	12
Copyright:	GPL
Group:		Applications/Text
Source:		ftp://ftp.oxy.edu/public/%{name}%{version}.tar.gz
Patch:		mawk-prefix.patch
BuildRoot:	/tmp/%{name}-%{version}-root

%description
Mawk is a version of the awk programming language.  Awk interprets a 
special-purpose programming language to do quick text pattern matching
and reformatting.  Mawk improves on awk in certain ways and can 
sometimes outperform gawk, the standard awk program for Linux.  Mawk
conforms to the POSIX 1003.2 (draft 11.3) definition of awk.

You should install mawk if you use awk.

%prep
%setup -q
%patch -p1

%build
CFLAGS="$RPM_OPT_FLAGS" \
./configure \
	--prefix=%{_prefix}
make

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_bindir},%{_mandir}/man1}

make install \
	prefix=$RPM_BUILD_ROOT%{_prefix} \
	MANDIR=$RPM_BUILD_ROOT%{_mandir}/man1

strip $RPM_BUILD_ROOT%{_bindir}/*

gzip -9nf ACKNOWLEDGMENT CHANGES README

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc *.gz
%attr(755,root,root) %{_bindir}/mawk
%{_mandir}/man1/mawk.1*

%changelog
* Wed May 26 1999 Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
  [1.2.2-12]
- based on RH spec,
- spec rewrited in PLD coding style.
