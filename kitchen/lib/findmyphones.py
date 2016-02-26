#! /usr/bin/python2.7
# -*- coding: utf-8 -*-

# to use:
#   brew install python
#   pip install pyicloud

from pyicloud import PyiCloudService
import sys
import json

def get_location(device):

  api = PyiCloudService(device['username'], device['password'])

  for dev in api.devices:
    if dev.content["id"].strip().lower() == device['deviceid'].strip().lower():
      return dev.location();

def main(args=None):

  if args is None:
    args = sys.argv[1:]

  devices = json.loads(args[0])
  result = {}

  for device in devices:
    result[device['label']] = get_location(device)

  print json.dumps(result, indent=2)

if __name__ == '__main__':
    main()
