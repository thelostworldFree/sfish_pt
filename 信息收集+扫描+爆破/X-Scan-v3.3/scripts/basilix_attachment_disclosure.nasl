#
# This script was written by George A. Theall, <theall@tifaware.com>.
#
# See the Nessus Scripts License for details.
#

if (description) {
  script_id(14306);
  script_version ("$Revision: 1.8 $"); 

  script_cve_id("CAN-2002-1711");
  script_bugtraq_id(5065);

  name["english"] = "BasiliX Attachment Disclosure Vulnerability";
  script_name(english:name["english"]);
 
  desc["english"] = "
The target is running at least one instance of BasiliX whose version
number is 1.1.0 or lower.  Such versions save attachments by default
under /tmp/BasiliX, which is world-readable and apparently never emptied
by BasiliX itself.  As a result, anyone with shell access to the target
or who can place CGI files on it can access attachments uploaded to
BasiliX. 

***** Nessus has determined the vulnerability exists on the target
***** simply by looking at the version number(s) of BasiliX
***** installed there.

Solution : Upgrade to BasiliX version 1.1.1 or later.
Risk factor : Low";
  script_description(english:desc["english"]);
 
  summary["english"] = "Checks for Attachment Disclosure Vulnerability in BasiliX";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2004 George A. Theall");

  family["english"] = "Misc.";
  script_family(english:family["english"]);

  script_dependencie("basilix_detect.nasl");
  script_require_ports("services/www", 80);

  exit(0);
}


include("http_func.inc");


port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);
if (!can_host_php(port:port)) exit(0);

# Test an install.
install = get_kb_item(string("www/", port, "/basilix"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches)) {
  ver = matches[1];

  if (ver =~ "^(0\..*|1\.(0.*|1\.0))$") {
    security_warning(port);
    exit(0);
  }
}
