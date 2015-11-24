<cfscript>
if ( ! len( cgi.HTTPS ) ) {
	serverRoot = "http://" & cgi.HTTP_HOST & ":" & cgi.SERVER_PORT;
} else {
	serverRoot = "https://" & cgi.HTTP_HOST & ":" & cgi.SERVER_PORT_SECURE;
}
serverRoot &= getDirectoryFromPath( cgi.script_name );
wsdlPath = serverRoot & "Service.cfc?wsdl";
flashPath = serverRoot & "flash/VFSe.swf?wsdlPath=#urlEncodedFormat( wsdlPath )#";
</cfscript>	

<cfcontent reset="true">
<cfheader name="Content-Type" value="text/xml">
<cfoutput> 
<response showresponse="true"> 
	<ide url="#flashPath#" > 
		<dialog title="All these files are virtual..." width="1000" height="1000" /> 
	</ide> 
</response> 
</cfoutput>