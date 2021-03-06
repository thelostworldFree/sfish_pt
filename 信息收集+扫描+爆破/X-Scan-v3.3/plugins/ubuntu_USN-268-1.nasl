# This script was automatically generated from the 268-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(21204);
script_version("$Revision: 1.3 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "268-1");
script_summary(english:"kaffeine vulnerability");
script_name(english:"USN268-1 : kaffeine vulnerability");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- kaffeine 
- kaffeine-gstreamer 
- kaffeine-xine 
');
script_set_attribute(attribute:'description', value: 'Marcus Meissner discovered a buffer overflow in the http_peek()
function. By tricking an user into opening a specially crafted
playlist URL with Kaffeine, a remote attacker could exploit this to
execute arbitrary code with the user\'s privileges.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- kaffeine-0.7-0ubuntu4.1 (Ubuntu 5.10)
- kaffeine-gstreamer-0.7-0ubuntu4.1 (Ubuntu 5.10)
- kaffeine-xine-0.7-0ubuntu4.1 (Ubuntu 5.10)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_end_attributes();

script_cve_id("CVE-2006-0051");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "5.10", pkgname: "kaffeine", pkgver: "0.7-0ubuntu4.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package kaffeine-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to kaffeine-0.7-0ubuntu4.1
');
}
found = ubuntu_check(osver: "5.10", pkgname: "kaffeine-gstreamer", pkgver: "0.7-0ubuntu4.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package kaffeine-gstreamer-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to kaffeine-gstreamer-0.7-0ubuntu4.1
');
}
found = ubuntu_check(osver: "5.10", pkgname: "kaffeine-xine", pkgver: "0.7-0ubuntu4.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package kaffeine-xine-',found,' is vulnerable in Ubuntu 5.10
Upgrade it to kaffeine-xine-0.7-0ubuntu4.1
');
}

if (w) { security_warning(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
