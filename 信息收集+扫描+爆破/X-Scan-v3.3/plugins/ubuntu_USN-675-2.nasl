# This script was automatically generated from the 675-2 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(37355);
script_version("$Revision: 1.1 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "675-2");
script_summary(english:"gaim vulnerability");
script_name(english:"USN675-2 : gaim vulnerability");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- gaim 
- gaim-data 
- gaim-dev 
');
script_set_attribute(attribute:'description', value: 'It was discovered that Gaim did not properly handle certain malformed
messages in the MSN protocol handler. A remote attacker could send a specially
crafted message and possibly execute arbitrary code with user privileges.
(CVE-2008-2927)');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- gaim-1.5.0+1.5.1cvs20051015-1ubuntu10.1 (Ubuntu 6.06)
- gaim-data-1.5.0+1.5.1cvs20051015-1ubuntu10.1 (Ubuntu 6.06)
- gaim-dev-1.5.0+1.5.1cvs20051015-1ubuntu10.1 (Ubuntu 6.06)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P');
script_end_attributes();

script_cve_id("CVE-2008-2927");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "6.06", pkgname: "gaim", pkgver: "1.5.0+1.5.1cvs20051015-1ubuntu10.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package gaim-',found,' is vulnerable in Ubuntu 6.06
Upgrade it to gaim-1.5.0+1.5.1cvs20051015-1ubuntu10.1
');
}
found = ubuntu_check(osver: "6.06", pkgname: "gaim-data", pkgver: "1.5.0+1.5.1cvs20051015-1ubuntu10.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package gaim-data-',found,' is vulnerable in Ubuntu 6.06
Upgrade it to gaim-data-1.5.0+1.5.1cvs20051015-1ubuntu10.1
');
}
found = ubuntu_check(osver: "6.06", pkgname: "gaim-dev", pkgver: "1.5.0+1.5.1cvs20051015-1ubuntu10.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package gaim-dev-',found,' is vulnerable in Ubuntu 6.06
Upgrade it to gaim-dev-1.5.0+1.5.1cvs20051015-1ubuntu10.1
');
}

if (w) { security_warning(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
