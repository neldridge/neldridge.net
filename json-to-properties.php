<?php

// Purpose of this file is to be able to convert a json manifest from packer into a properties file to be readable by Jenkins
// We'll be able to grab the AMI ID for the newly generated ami from packer, and pass it to the next build step via an Env variable
// We _could_ bypas this and use the UUID tagged on the AMI, with an additional call to AWS
// I'd like to see if this is possible, as we may need something else later.
//
$build_uuid = $_ENV['BUILD_UUID'];

$json_file = "$build_uuid-manifest.json";

if(!file_exists($json_file)){
	fwrite(STDERR, "JSON manifest not found, nothing to do here.");
	exit(1);
}

$json = json_decode(file_get_contents($json_file));

/*
{
  "builds": [
    {
      "name": "amazon-ebs",
      "builder_type": "amazon-ebs",
      "build_time": 1487884144,
      "files": null,
      "artifact_id": "us-east-1:ami-d075a5c6",
      "packer_run_uuid": "ae0eee4c-9871-5900-2493-33e359941fc8"
    }
  ],
  "last_run_uuid": "ae0eee4c-9871-5900-2493-33e359941fc8"
}
*/

foreach($json['builds'] AS $build){
	

}

