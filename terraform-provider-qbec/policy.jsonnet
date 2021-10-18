local lib = import './lib/aws-s3-deny-non-corp.libsonnet';
// Import the list of known Ips from multiple files using the glob importer
local knownAllowedIpsRef = import 'glob-import:lib/known-allowed-ips/*.json';
// The glob importer returns key/val fo each imported file. We are interested to
// extract the IPs from each value and then flatten the list.
local knownAllowedIps = std.flattenArrays([obj.ips for obj in std.objectValues(knownAllowedIpsRef)]);
// knownAllowedIps has the followig IPs now
//[
//  "11.11.11.11/32",
//  "22.22.22.22/32"
//]

local apiOutput = importstr 'data://my-corp-ip-api';
// Use the qbec provided native function parseYaml
local parseYaml = std.native('parseYaml');
// parse the first yaml doc
local corpIps = parseYaml(apiOutput)[0];

// Use the list of well known IPs combined with
// the dynamic list of corporate IPs
lib.s3DenyNonCorpPolicy('the-bucket', knownAllowedIps + corpIps.corpIPs)

