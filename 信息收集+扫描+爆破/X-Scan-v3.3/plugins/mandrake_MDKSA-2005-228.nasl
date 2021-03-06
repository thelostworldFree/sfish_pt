
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(20459);
 script_version ("$Revision: 1.3 $");
 script_name(english: "MDKSA-2005:228: xine-lib");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2005:228 (xine-lib).");
 script_set_attribute(attribute: "description", value: "Simon Kilvington discovered a vulnerability in FFmpeg libavcodec,
which can be exploited by malicious people to cause a DoS (Denial
of Service) and potentially to compromise a user's system.
The vulnerability is caused due to a boundary error in the
'avcodec_default_get_buffer()' function of 'utils.c' in libavcodec.
This can be exploited to cause a heap-based buffer overflow when a
specially-crafted 1x1 '.png' file containing a palette is read.
Xine-lib is built with a private copy of ffmpeg containing this
same code. (Corporate Server 2.1 is not vulnerable)
The updated packages have been patched to prevent this problem.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2005:228");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2005-4048");
script_summary(english: "Check for the version of the xine-lib package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"libxine1-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libxine1-devel-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-aa-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-arts-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-dxr3-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-esd-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-flac-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-gnomevfs-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-image-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-plugins-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-polyp-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xine-smb-1.1.0-9.2.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"xine-lib-", release:"MDK2006.0") )
{
 set_kb_item(name:"CVE-2005-4048", value:TRUE);
}
exit(0, "Host is not affected");
