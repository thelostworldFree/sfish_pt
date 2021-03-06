
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(42328);
 script_version ("$Revision: 1.2 $");
 script_name(english: "SuSE Security Update:  viewvc security update (viewvc-6578)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch viewvc-6578");
 script_set_attribute(attribute: "description", value: "Update of viewvc to version 1.0.9 fixes a cross-site
scripting (XSS) problem and enhances filtering of illegal
characters when displaying error messages (CVE-2009-3618,
CVE-2009-3619).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N");
script_set_attribute(attribute: "solution", value: "Install the security patch viewvc-6578");
script_end_attributes();

script_cve_id("CVE-2009-3618", "CVE-2009-3619");
script_summary(english: "Check for the viewvc-6578 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"viewvc-1.0.9-0.1", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
