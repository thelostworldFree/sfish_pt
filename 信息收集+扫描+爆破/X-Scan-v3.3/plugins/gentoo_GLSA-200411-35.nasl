# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200411-35.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(15837);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200411-35");
 script_cve_id("CVE-2004-1516");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200411-35 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200411-35
(phpWebSite: HTTP response splitting vulnerability)


    Due to lack of proper input validation, phpWebSite has been found to be
    vulnerable to HTTP response splitting attacks.
  
Impact

    A malicious user could inject arbitrary response data, leading to
    content spoofing, web cache poisoning and other cross-site scripting or
    HTTP response splitting attacks. This could result in compromising the
    victim\'s data or browser.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All phpWebSite users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=www-apps/phpwebsite-0.9.3_p4-r2"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N');
script_set_attribute(attribute: 'see_also', value: 'http://www.securityfocus.com/archive/1/380894');
script_set_attribute(attribute: 'see_also', value: 'http://phpwebsite.appstate.edu/index.php?module=announce&ANN_user_op=view&ANN_id=863');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-1516');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200411-35.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200411-35] phpWebSite: HTTP response splitting vulnerability');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'phpWebSite: HTTP response splitting vulnerability');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "www-apps/phpwebsite", unaffected: make_list("ge 0.9.3_p4-r2"), vulnerable: make_list("lt 0.9.3_p4-r2")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
