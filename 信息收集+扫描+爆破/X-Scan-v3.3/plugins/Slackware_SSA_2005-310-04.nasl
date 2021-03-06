# This script was automatically generated from the SSA-2005-310-04
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2009 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(20151);
script_version("$Revision: 1.3 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2009 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");

script_set_attribute(attribute:'synopsis', value:
'The remote host is missing the SSA-2005-310-04 security update');
script_set_attribute(attribute:'description', value: '
New apache packages are available for Slackware 8.1, 9.0, 9.1, 10.0, 10.1,
10.2, and -current to fix potential security issues:

      * If a request contains both Transfer-Encoding and Content-Length
        headers, remove the Content-Length, mitigating some HTTP Request
        Splitting/Spoofing attacks.

      * Added TraceEnable [on|off|extended] per-server directive to alter
        the behavior of the TRACE method.

It\'s hard to say how much real-world impact these have, as there\'s no more
information about that in the announcement.  The original Apache announement
can be read here:

  http://www.apache.org/dist/httpd/Announcement1.3.html

Note that if you use mod_ssl, you will also need a new mod_ssl package.  These
have been provided for the same releases of Slackware.

');
script_set_attribute(attribute:'solution', value: 
'Update the packages that are referenced in the security advisory.');
script_xref(name: "SSA", value: "2005-310-04");
script_summary("SSA-2005-310-04 apache ");
script_name(english: "SSA-2005-310-04 apache ");
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_end_attributes();
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

if ( ! get_kb_item('Host/Slackware/packages') ) exit(1, 'Could not obtain the list of packages');

extrarep = NULL;
if (slackware_check(osver: "8.1", pkgname: "apache", pkgver: "1.3.34", pkgnum:  "1", pkgarch: "i386")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apache is vulnerable in Slackware 8.1
Upgrade to apache-1.3.34-i386-1 or newer.
');
}
if (slackware_check(osver: "8.1", pkgname: "mod_ssl", pkgver: "2.8.25_1.3.34", pkgnum:  "1", pkgarch: "i386")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package mod_ssl is vulnerable in Slackware 8.1
Upgrade to mod_ssl-2.8.25_1.3.34-i386-1 or newer.
');
}
if (slackware_check(osver: "9.0", pkgname: "apache", pkgver: "1.3.34", pkgnum:  "1", pkgarch: "i386")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apache is vulnerable in Slackware 9.0
Upgrade to apache-1.3.34-i386-1 or newer.
');
}
if (slackware_check(osver: "9.0", pkgname: "mod_ssl", pkgver: "2.8.25_1.3.34", pkgnum:  "1", pkgarch: "i386")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package mod_ssl is vulnerable in Slackware 9.0
Upgrade to mod_ssl-2.8.25_1.3.34-i386-1 or newer.
');
}
if (slackware_check(osver: "9.1", pkgname: "apache", pkgver: "1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apache is vulnerable in Slackware 9.1
Upgrade to apache-1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "9.1", pkgname: "mod_ssl", pkgver: "2.8.25_1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package mod_ssl is vulnerable in Slackware 9.1
Upgrade to mod_ssl-2.8.25_1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "10.0", pkgname: "apache", pkgver: "1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apache is vulnerable in Slackware 10.0
Upgrade to apache-1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "10.0", pkgname: "mod_ssl", pkgver: "2.8.25_1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package mod_ssl is vulnerable in Slackware 10.0
Upgrade to mod_ssl-2.8.25_1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "10.1", pkgname: "apache", pkgver: "1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apache is vulnerable in Slackware 10.1
Upgrade to apache-1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "10.1", pkgname: "mod_ssl", pkgver: "2.8.25_1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package mod_ssl is vulnerable in Slackware 10.1
Upgrade to mod_ssl-2.8.25_1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "10.2", pkgname: "apache", pkgver: "1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apache is vulnerable in Slackware 10.2
Upgrade to apache-1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "10.2", pkgname: "mod_ssl", pkgver: "2.8.25_1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package mod_ssl is vulnerable in Slackware 10.2
Upgrade to mod_ssl-2.8.25_1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "-current", pkgname: "apache", pkgver: "1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package apache is vulnerable in Slackware -current
Upgrade to apache-1.3.34-i486-1 or newer.
');
}
if (slackware_check(osver: "-current", pkgname: "mod_ssl", pkgver: "2.8.25_1.3.34", pkgnum:  "1", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) extrarep = strcat(extrarep, '
The package mod_ssl is vulnerable in Slackware -current
Upgrade to mod_ssl-2.8.25_1.3.34-i486-1 or newer.
');
}

if (w) { security_hole(port: 0, extra: extrarep); }

else exit(0, "Host is not affected");
