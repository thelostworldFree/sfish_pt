
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandriva Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(38970);
 script_version ("$Revision: 1.1 $");
 script_name(english: "MDVA-2009:076-1: kdelibs");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDVA-2009:076-1 (kdelibs).");
 script_set_attribute(attribute: "description", value: "On Mandriva Linux 2009.0, installing a KDE3 package wouldn't
automatically install the locales package for the system's language.
This update fixes the issue.
Update:
On the previous kdelibs update we added a require on kde-i18n. After
some discussion it appears that adding a suggests is a better choice.
This also fixes the update, which would not work via MandrivaUpdate.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDVA-2009:076-1");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the kdelibs package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"kdelibs-common-3.5.10-4.4mdv2009.0", release:"MDK2009.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kdelibs-devel-doc-3.5.10-4.4mdv2009.0", release:"MDK2009.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libkdecore4-3.5.10-4.4mdv2009.0", release:"MDK2009.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libkdecore4-devel-3.5.10-4.4mdv2009.0", release:"MDK2009.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
