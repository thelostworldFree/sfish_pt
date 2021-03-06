#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(29926);
  script_version("$Revision: 1.9 $");

  script_cve_id("CVE-2008-0239", "CVE-2008-0240", "CVE-2008-0241");
  script_bugtraq_id(27214);
  script_xref(name:"OSVDB", value:"40748");
  script_xref(name:"OSVDB", value:"40749");
  script_xref(name:"OSVDB", value:"40750");
  script_xref(name:"OSVDB", value:"42024");
  script_xref(name:"OSVDB", value:"43279");

  script_name(english:"Sun Java System Identity Manager Multiple XSS");
  script_summary(english:"Checks for XSS flaws in Identity Manager");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains an application that is affected by
multiple cross-site scripting vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Sun Java System Identity Manager, a Java
application for user provisioning and identity auditing in enterprise
environments. 

The version of Identity Manager installed on the remote host fails to
sanitize user-supplied input to various JSP scripts before using it to
generate dynamic content.  An unauthenticated remote attacker may be
able to leverage these issues to inject arbitrary HTML or script code
into a user's browser to be executed within the security context of
the affected site. 

Known to be affected are the 'cntry' and 'lang' parameters of the
'login.jsp' script, the 'resultsForm' parameter of the
'account/findForSelect.jsp' script, the 'activeControl' parameter of
the 'user/main.jsp' script, the 'helpUrl' parameter of the
'help/index.jsp' script, and the 'nextPage' parameter of the
'user/login.jsp' script" );
 script_set_attribute(attribute:"see_also", value:"http://www.procheckup.com/vulnerability_manager/vulnerabilities/pr07-06" );
 script_set_attribute(attribute:"see_also", value:"http://www.procheckup.com/vulnerability_manager/vulnerabilities/pr07-07" );
 script_set_attribute(attribute:"see_also", value:"http://www.procheckup.com/vulnerability_manager/vulnerabilities/pr07-08" );
 script_set_attribute(attribute:"see_also", value:"http://www.procheckup.com/vulnerability_manager/vulnerabilities/pr07-09" );
 script_set_attribute(attribute:"see_also", value:"http://www.procheckup.com/vulnerability_manager/vulnerabilities/pr07-10" );
 script_set_attribute(attribute:"see_also", value:"http://www.procheckup.com/vulnerability_manager/vulnerabilities/pr07-12" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/486076" );
 script_set_attribute(attribute:"see_also", value:"http://sunsolve.sun.com/search/document.do?assetkey=1-26-103180-1" );
 script_set_attribute(attribute:"solution", value:
"None at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses : XSS");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("sun_idm_detect.nasl", "cross_site_scripting.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80, 8080);

  exit(0);
}


include("global_settings.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("misc_func.inc");
include("url_func.inc");


port = get_http_port(default:8080);
if (get_kb_item("Services/www/"+port+"/embedded")) exit(0);
if (get_kb_item("www/"+port+"/generic_xss")) exit(0);


# A simple alert.
xss = string("<script>alert('", SCRIPT_NAME, "')</script>");
exploit = string("-->", xss, "<!--");


# Test an install.
install = get_kb_item(string("www/", port, "/sun_idm"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches))
{
  dir = matches[2];

  req = http_get(
    item:string(
      dir, "/login.jsp?",
      "lang=", exploit, "&",
      "cntry="
    ), 
    port:port
  );
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
  if (isnull(res)) exit(0);

  # There's a problem if the display name uses our exploit.
  if (string("The local display name is: ", exploit, " -->") >< res)
  {
    security_warning(port);
    set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
    exit(0);
  }
}
