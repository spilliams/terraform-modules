# terraform-modules

An examples folder exists in `terraform/examples` to provide examples of how to use these modules.

A brief description of each module follows. Find out more about each module in its respective README.

- `static-site` builds S3 buckets and CloudFronts for hosting a static website under a given domain
- `tld` creates a Hosted Zone and Certificate for a top-level domain

## Version History & Releases

This repo uses tags to denote releases.  
Each tag may or may not be marked as a "release" in GitHub.  
Not every tag updates every module. Check the tag annotations and/or Release notes to see which modules got updated.  
Every module maintains its own Version History section of its README, where it goes into depth on its history.  

The examples are kept up-to-date with the latest modules on purpose. Maintainers make no guarantee as to the functionality or performance of outdated tagged versions.

## TODO

- keep splitting static-site up. It does not need to create two domains. Either it should create one and there should be a new module for the "redirect" domain, or it should create one and leave the redirect up to callers, or it should take in a flag for whether or not the domain should be a redirect.
- static-site should require the zone_id of the delegating domain, not its name. And make a separation between domain name and route name (so that I can tell it to host spencerenglish.com under spencerenglish.com, or blog.spencerenglish.com under spencerenglish.com).
- fold in modules from tissuebots?
- set up a multi-site example.
- start using DynamoDB for lock files.
