
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(27564);
 script_version ("$Revision: 1.4 $");
 script_name(english: "RHSA-2007-0888: php");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2007-0888");
 script_set_attribute(attribute: "description", value: '
  Updated PHP packages that fix several security issues are now available for
  Red Hat Enterprise Linux 2.1

  This update has been rated as having moderate security impact by the Red
  Hat Security Response Team.

  PHP is an HTML-embedded scripting language commonly used with the Apache
  HTTP Web server.

  Various integer overflow flaws were found in the PHP gd extension. A script
  that could be forced to resize images from an untrusted source could
  possibly allow a remote attacker to execute arbitrary code as the apache
  user. (CVE-2007-3996)

  An integer overflow flaw was found in the PHP chunk_split function. If a
  remote attacker was able to pass arbitrary data to the third argument of
  chunk_split they could possibly execute arbitrary code as the apache user.
  Note that it is unusual for a PHP script to use the chunk_script function
  with a user-supplied third argument. (CVE-2007-2872)

  A previous security update introduced a bug into PHP session cookie
  handling. This could allow an attacker to stop a victim from viewing a
  vulnerable web site if the victim has first visited a malicious web page
  under the control of the attacker, and that page can set a cookie for the
  vulnerable web site. (CVE-2007-4670)

  A bug was found in PHP session cookie handling. This could allow an
  attacker to create a cross-site cookie insertion attack if a victim follows
  an untrusted carefully-crafted URL. (CVE-2007-3799)

  A flaw was found in the PHP \'ftp\' extension. If a PHP script used this
  extension to provide access to a private FTP server, and passed untrusted
  script input directly to any function provided by this extension, a remote
  attacker would be able to send arbitrary FTP commands to the server.
  (CVE-2007-2509)

  Users of PHP should upgrade to these updated packages which contain
  backported patches to correct these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2007-0888.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2007-2509", "CVE-2007-2872", "CVE-2007-3799", "CVE-2007-3996", "CVE-2007-4670");
script_summary(english: "Check for the version of the php packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"php-4.1.2-2.19", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-devel-4.1.2-2.19", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-imap-4.1.2-2.19", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-ldap-4.1.2-2.19", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-manual-4.1.2-2.19", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-mysql-4.1.2-2.19", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-odbc-4.1.2-2.19", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"php-pgsql-4.1.2-2.19", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
