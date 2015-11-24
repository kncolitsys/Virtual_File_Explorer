component {

function getFiles() access="remote" returntype="Query" {
	return directoryList("ram://",true, "query", "*.*", "directory desc");
}

function getFile( required String directory, required String file ) access="remote" returntype="Query"  {
	var filePath = arguments.directory & "/" & arguments.file;
	var q = queryNew("name,content","VarChar,varchar");
	queryAddRow(q);
	if ( validRAMFile( filePath ) ) {
		querySetCell( q, "name", filePath );
		querySetCell( q, "content", fileRead( filePath ));
	} else {
		querySetCell( q, "name", "not found");
		querySetCell( q, "content", "");
	} 
	return q;
}

function setFile( required String filePath, required String content ) access="remote" returntype="boolean" {
	if ( validRAMFile( arguments.filePath ) ) {
		fileWrite( arguments.filePath, arguments.content );
		return true;
	} else {
		return false;
	}
}

function deleteFile( required String filePath ) access="remote" returntype="boolean" {
	if ( validRAMFile( arguments.filePath ) ) {
		fileDelete( arguments.filePath );
		return true;
	} else if ( validRAMDirectory( arguments.filePath ) ) {
		directoryDelete( arguments.filePath, true );
		return true;
	} else {
		return false;
	}
}

function getUsage() access="remote" returntype="Query" {
	var usage = getVFSMetaData("ram");
	var q = queryNew("label,amount","varchar,Integer");
	queryAddRow(q,2);
	querySetCell( q, "label", "Used", 1 );
	querySetCell( q, "amount", usage.used, 1 );
	querySetCell( q, "label", "Free", 2 );
	querySetCell( q, "amount", usage.free, 2 );
	writeDump(var=q, output="c:\wtf.html", format="html");
	return q;
}

private function validRAMFile( filePath ) {
	if ( left( arguments.filePath, 3 ) eq "ram" && fileExists( filePath ) ) {
		return true;
	} else {
		return false;
	}
}

private function validRAMDirectory( filePath ) {
	if ( left( arguments.filePath, 3 ) eq "ram" && directoryExists( filePath ) ) {
		return true;
	} else {
		return false;
	}
}

}
