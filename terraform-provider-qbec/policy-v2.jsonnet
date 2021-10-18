local lib = import './lib/aws-s3-deny-non-corp.libsonnet';
// Import the list of known Ips from multiple files using the glob importer
local knownAllowedIpsRef = import 'glob-import:lib/known-allowed-ips/*.json';
// The glob importer returns key/val fo each imported file. We are interested to
// extract the IPs from each value and then flatten the list.
local knownAllowedIps = std.flattenArrays([
  obj.ips
  for obj in
    std.objectValues(knownAllowedIpsRef)
]);
// knownAllowedIps has the followig IPs now
//[
//  "11.11.11.11/32",
//  "22.22.22.22/32"
//]

// Use the list of well known IPs combined with
// two hard-coded IPs (that would eventually come dynamically from an API)
lib.s3DenyNonCorpPolicy('the-bucket', knownAllowedIps + [
  '33.33.33.33/32',
  '44.44.44.44/32',
])
