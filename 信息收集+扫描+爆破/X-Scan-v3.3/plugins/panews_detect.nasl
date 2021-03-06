#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description) {
  script_id(17253);
  script_version("$Revision: 1.9 $");

  script_name(english:"paNews Detection");
  script_summary(english:"Checks for presence of paNews");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a news management application written
in PHP." );
 script_set_attribute(attribute:"description", value:
"The remote host is running paNews, a news management application
written in PHP." );
 script_set_attribute(attribute:"see_also", value:"http://www.phparena.net/panews.php" );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");
 
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

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


# Loop through directories.
if (thorough_tests) dirs = list_uniq(make_list("/panews", "/news", cgi_dirs()));
else dirs = make_list(cgi_dirs());

installs = 0;
foreach dir (dirs) {
  res = http_get_cache(item:string(dir, "/index.php"), port:port);
  if (res == NULL) exit(0);

  # If it's paNews.
  if (res =~ "<p align=.*paNews .+www\.phparena\.net.*phpArena") {
    if (dir == "") dir = "/";

    # Identify the version number.
    pat = "<p align=.*paNews (.+) &copy; .*www\.phparena\.net.*phpArena";
    matches = egrep(pattern:pat, string:res);
    ver = NULL;
    if (matches) {
      foreach match (split(matches)) {
        match = chomp(match);
        ver = eregmatch(pattern:pat, string:match);
        if (!isnull(ver)) {
          ver = ver[1];
          break;
        }
      }
    }
    if (isnull(ver)) ver = "unknown";

    if (dir == "") dir = "/";
    set_kb_item(
      name:string("www/", port, "/panews"), 
      value:string(ver, " under ", dir)
    );
    installations[dir] = ver;
    ++installs;

    # Scan for multiple installations only if "Thorough Tests" is checked.
    if (!thorough_tests) break;
  }
}


# Report any instances found unless Report verbosity is "Quiet".
if (installs && report_verbosity > 0) {
  if (installs == 1) {
    foreach dir (keys(installations)) {
      # empty - just need to set 'dir'.
    }
    if (ver == "unknown") {
      info = string("An unknown version of paNews was detected on the remote\nhost under the path ", dir, ".");
    }
    else {
      info = string("paNews ", ver, " was detected on the remote host under\nthe path ", dir, ".");
    }
  }
  else {
    info = string(
      "Multiple instances of paNews were detected on the remote host:\n",
      "\n"
    );
    foreach dir (keys(installations)) {
      info = info + string("    ", installations[dir], ", installed under ", dir, "\n");
    }
    info = chomp(info);
  }

  security_note(port:port, extra:'\n'+info);
}
