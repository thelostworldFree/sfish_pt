#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if(description)
{
 script_id(15975);
 script_cve_id("CVE-2004-1403");
 script_bugtraq_id(11948);
 script_version ("$Revision: 1.7 $");
 script_xref(name:"OSVDB", value:"12389");
 script_name(english:"SIR GNUBoard Remote File Inclusion");
 script_summary(english:"Checks for the presence of index.php");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server is running a PHP application that is affected by
a remote file inclusion vulnerability." );
 script_set_attribute(attribute:"description", value:
"It is possible to make the remote web server read arbitrary files by 
using the GNUBoard CGI suite which is installed.

An attacker may use this flaw to inject arbitrary code in the remote
host and gain a shell with the privileges of the web server." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/384522/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to GNUBoard 3.40 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );


script_end_attributes();

 
 script_category(ACT_ATTACK);
 
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 family["english"] = "CGI abuses";
 script_family(english:family["english"]);
 script_dependencie("http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#


include("http.inc");
include("global_settings.inc");
include("misc_func.inc");

port = get_http_port(default:80, embedded: 0);
if(!can_host_php(port:port))exit(0);



function check(loc)
{
 local_var r;

 r = http_send_recv3(method:"GET", item:string(loc, "/index.php?doc=http://xxxxxx./foo.php"), port:port);
 if (isnull(r)) exit(0);
 if( "http://xxxxxx./" >< r[2] &&
     "php_network_getaddresses" >< r[2] )
 {
   security_hole(port);
   exit(0);
 }
}

foreach dir ( cgi_dirs() )
{
 check(loc:dir);
}
