# This script was automatically generated from the dsa-924
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22790);
 script_version("$Revision: 1.4 $");
 script_xref(name: "DSA", value: "924");
 script_cve_id("CVE-2005-3534");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-924 security update');
 script_set_attribute(attribute: 'description', value:
'Kurt Fitzner discovered a buffer overflow in nbd, the network block
device client and server that could potentially allow arbitrary code on
the NBD server.
For the old stable distribution (woody) this problem has been fixed in
version 1.2cvs20020320-3.woody.3.
For the stable distribution (sarge) this problem has been fixed in
version 2.7.3-3sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-924');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your nbd-server package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA924] DSA-924-1 nbd");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-924-1 nbd");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'nbd-client', release: '3.0', reference: '1.2cvs20020320-3.woody.3');
deb_check(prefix: 'nbd-server', release: '3.0', reference: '1.2cvs20020320-3.woody.3');
deb_check(prefix: 'nbd-client', release: '3.1', reference: '2.7.3-3sarge1');
deb_check(prefix: 'nbd-server', release: '3.1', reference: '2.7.3-3sarge1');
deb_check(prefix: 'nbd', release: '3.1', reference: '2.7.3-3sarge1');
deb_check(prefix: 'nbd', release: '3.0', reference: '1.2cvs20020320-3.woody.3');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
