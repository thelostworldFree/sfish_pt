# This script was automatically generated from the dsa-1101
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22643);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1101");
 script_cve_id("CVE-2006-2659");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1101 security update');
 script_set_attribute(attribute: 'description', value:
'A bug has been discovered in the Courier Mail Server that can result
in a number of processes to consume arbitrary amounts of CPU power.
For the old stable distribution (woody) this problem has been fixed in
version 0.37.3-2.9.
For the stable distribution (sarge) this problem has been fixed in
version 0.47-4sarge5.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1101');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your courier packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1101] DSA-1101-1 courier");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1101-1 courier");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'courier-authdaemon', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-authmysql', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-base', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-debug', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-doc', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-imap', release: '3.0', reference: '1.4.3-2.9');
deb_check(prefix: 'courier-ldap', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-maildrop', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-mlm', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-mta', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-pcp', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-pop', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-webadmin', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'sqwebmail', release: '3.0', reference: '0.37.3-2.9');
deb_check(prefix: 'courier-authdaemon', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-authmysql', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-authpostgresql', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-base', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-doc', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-faxmail', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-imap', release: '3.1', reference: '3.0.8-4sarge5');
deb_check(prefix: 'courier-imap-ssl', release: '3.1', reference: '3.0.8-4sarge5');
deb_check(prefix: 'courier-ldap', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-maildrop', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-mlm', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-mta', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-mta-ssl', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-pcp', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-pop', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-pop-ssl', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-ssl', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier-webadmin', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'sqwebmail', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier', release: '3.1', reference: '0.47-4sarge5');
deb_check(prefix: 'courier', release: '3.0', reference: '0.37.3-2.9');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
