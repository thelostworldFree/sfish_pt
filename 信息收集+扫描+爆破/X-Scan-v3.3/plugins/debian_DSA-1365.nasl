# This script was automatically generated from the dsa-1365
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(25965);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1365");
 script_cve_id("CVE-2007-4460");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1365 security update');
 script_set_attribute(attribute: 'description', value:
'Nikolaus Schulz discovered that a programming error in id3lib, an ID3 Tag
Library, may lead to denial of service through symlink attacks.
For the oldstable distribution (sarge) this problem has been fixed in
version 3.8.3-4.1sarge1.
Due to a technical limitation in the archive management scripts the fix
for the stable distribution (etch) can only be released in a few days.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2007/dsa-1365');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your id3lib3.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1365] DSA-1365-3 id3lib3.8.3");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1365-3 id3lib3.8.3");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'libid3-3.8.3', release: '3.1', reference: '3.8.3-4.1sarge1');
deb_check(prefix: 'libid3-3.8.3-dev', release: '3.1', reference: '3.8.3-4.1sarge1');
deb_check(prefix: 'id3lib3.8.3', release: '3.1', reference: '3.8.3-4.1sarge1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
