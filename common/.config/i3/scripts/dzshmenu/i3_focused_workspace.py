import json, sys

for l in json.load(sys.stdin):
	if l['focused'] == True:
		print(l['name'])
