
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(28246);
 script_version ("$Revision: 1.4 $");
 script_name(english: "RHSA-2007-1017: samba");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2007-1017");
 script_set_attribute(attribute: "description", value: '
  Updated samba packages that fix security issues are now available for Red
  Hat Enterprise Linux 5.

  This update has been rated as having critical security impact by the Red
  Hat Security Response Team.

  Samba is a suite of programs used by machines to share files, printers, and
  other information.

  A buffer overflow flaw was found in the way Samba creates NetBIOS replies.
  If a Samba server is configured to run as a WINS server, a remote
  unauthenticated user could cause the Samba server to crash or execute
  arbitrary code. (CVE-2007-5398)

  A heap based buffer overflow flaw was found in the way Samba authenticates
  users. A remote unauthenticated user could trigger this flaw to cause the
  Samba server to crash. Careful analysis of this flaw has determined that
  arbitrary code execution is not possible, and under most circumstances will
  not result in a crash of the Samba server. (CVE-2007-4572)

  A flaw was found in the way Samba assigned group IDs under certain
  conditions. If the "winbind nss info" parameter in smb.conf is set to
  either "sfu" or "rfc2307", Samba users are incorrectly assigned the group
  ID of 0. (CVE-2007-4138)

  Red Hat would like to thank Alin Rad Pop of Secunia Research, Rick King,
  and the Samba developers for responsibly disclosing these issues.

  All Samba users are advised to upgrade to these updated packages, which
  contain a backported patch to correct these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2007-1017.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2007-4138", "CVE-2007-4572", "CVE-2007-5398");
script_summary(english: "Check for the version of the samba packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"samba-3.0.25b-1.el5_1.2", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"samba-client-3.0.25b-1.el5_1.2", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"samba-common-3.0.25b-1.el5_1.2", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"samba-swat-3.0.25b-1.el5_1.2", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
