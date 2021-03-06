
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(33224);
 script_version ("$Revision: 1.3 $");
 script_name(english: "SuSE Security Update:  Opera: Security upgrade to version 9.50 (opera-5354)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch opera-5354");
 script_set_attribute(attribute: "description", value: "This patch brings Opera to security update level 9.50

Following security problems were fixed: CVE-2008-2714:
Opera before 9.26 allows remote attackers to misrepresent
web page addresses using 'certain characters' that 'cause
the page address text to be misplaced.'

CVE-2008-2715: Unspecified vulnerability in Opera before
9.5 allows remote attackers to read cross-domain images via
HTML CANVAS elements that use the images as patterns.

CVE-2008-2716: Unspecified vulnerability in Opera before
9.5 allows remote attackers to spoof the contents of
trusted frames on the same parent page by modifying the
location, which can facilitate phishing attacks.

It also contains lots of new features and other bugfixes,
see the Changelog at:
http://www.opera.com/docs/changelogs/linux/950/
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N");
script_set_attribute(attribute: "solution", value: "Install the security patch opera-5354");
script_end_attributes();

script_cve_id("CVE-2008-2714", "CVE-2008-2715", "CVE-2008-2716");
script_summary(english: "Check for the opera-5354 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"opera-9.50-0.1", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
