
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandriva Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(41615);
 script_version("$Revision: 1.1 $");
 script_name(english: "MDVA-2009:169-1: drakxtools");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDVA-2009:169-1 (drakxtools).");
 script_set_attribute(attribute: "description", value: "These updated packages fix a bug preventing the use of firefox if the
user had seen the help of drak3d in the drak3d session before first
running firefox (bug #29775).
These updated packages also adds support for VirtIO devices. Last
but not least it ensures we have a recent enough perl-Gtk2 binding
(eg: after failed KDE3 upgrade (bug #51870)).
Update:
The previous update was incomplete, this update corrects this.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDVA-2009:169-1");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the drakxtools package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"drakx-installer-binaries-1.32.1-1.1mdv2009.0", release:"MDK2009.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"drakx-installer-binaries-probe-1.32.1-1.1mdv2009.0", release:"MDK2009.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"drakx-installer-images-1.31.1-1.1mdv2009.0", release:"MDK2009.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"drakx-installer-stage2-11.71.10-1.1mdv2009.0", release:"MDK2009.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
