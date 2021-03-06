
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(21722);
 script_version ("$Revision: 1.5 $");
 script_name(english: "RHSA-2006-0548: kdebase");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2006-0548");
 script_set_attribute(attribute: "description", value: '
  Updated kdebase packages that correct a security flaw in kdm are now
  available for Red Hat Enterprise Linux 4.

  This update has been rated as having important security impact by the Red
  Hat Security Response Team.

  The kdebase packages provide the core applications for KDE, the K Desktop
  Environment. These core packages include the KDE Display Manager (KDM).

  Ludwig Nussel discovered a flaw in KDM. A malicious local KDM user could
  use a symlink attack to read an arbitrary file that they would not normally
  have permissions to read. (CVE-2006-2449)

  Note: this issue does not affect the version of KDM as shipped with Red Hat
  Enterprise Linux 2.1 or 3.

  All users of KDM should upgrade to these updated packages which contain a
  backported patch to correct this issue.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:H/Au:N/C:C/I:N/A:N");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2006-0548.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2006-2449");
script_summary(english: "Check for the version of the kdebase packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"kdebase-3.3.1-5.12", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kdebase-devel-3.3.1-5.12", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
