
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(42253);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  Security update for Apache 2 (apache2-6571)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch apache2-6571");
 script_set_attribute(attribute: "description", value: "This update of the Apache webserver fixes various security
issues:
- the option IncludesNOEXEC could be bypassed via .htaccess
  (CVE-2009-1195) 
- mod_proxy could run into an infinite loop when used as
  reverse  proxy (CVE-2009-1890) 
- mod_deflate continued to compress large files even after
  a network connection was closed, causing mod_deflate to
  consume large amounts of CPU (CVE-2009-1891)
- The ap_proxy_ftp_handler function in
  modules/proxy/proxy_ftp.c in the mod_proxy_ftp module
  allows remote FTP servers to cause a denial of service
  (NULL pointer dereference and child process crash) via a
  malformed reply to an EPSV command. (CVE-2009-3094)
- access restriction bypass in mod_proxy_ftp module
  (CVE-2009-3095)

Also a incompatibility between mod_cache and mod_rewrite
was fixed.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch apache2-6571");
script_end_attributes();

script_cve_id("CVE-2009-1195", "CVE-2009-1890", "CVE-2009-1891", "CVE-2009-3094", "CVE-2009-3095");
script_summary(english: "Check for the apache2-6571 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"apache2-2.2.3-16.25.4", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"apache2-devel-2.2.3-16.25.4", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"apache2-doc-2.2.3-16.25.4", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"apache2-example-pages-2.2.3-16.25.4", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"apache2-prefork-2.2.3-16.25.4", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"apache2-worker-2.2.3-16.25.4", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
