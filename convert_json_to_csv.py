import json
import pprint
import pandas as pd
import os
import json
import codecs
os.chdir("/Users/swain/Desktop/新竹黑客松/台北市路燈位置分佈")

# LI3159
# file_name = "LI3159.json"
path_to_json = '/Users/swain/Desktop/新竹黑客松/台北市路燈位置分佈'
json_files = [pos_json for pos_json in os.listdir(path_to_json) if pos_json.endswith('.json')]
# pprint.pprint(json_files)  # for me this prints ['foo.json']
for file_name in json_files:
	print(file_name)
	with codecs.open(file_name, 'rb',encoding='utf-8', errors='ignore') as f:
		data_store = json.load(f)

	keep_data = []
	name = []
	lat = []
	lng = []
	lights = {}

	# pprint.pprint(data_store['features'])
	for datas in data_store['features']:
		if datas['geometry']['type'] == "Point":
			if datas['properties']['Text'] != '' and datas['properties']['Text'][0].isalpha():
				# print(datas['properties']['Text'])
				lights['name'] = datas['properties']['Text']
				lights['lat'] = datas['geometry']['coordinates'][0]
				lights['lng'] = datas['geometry']['coordinates'][1]
				# pprint.pprint(lights)
				name.append(datas['properties']['Text'])
				lat.append(datas['geometry']['coordinates'][0])
				lng.append(datas['geometry']['coordinates'][1])
				keep_data.append(lights.copy())
	# pprint.pprint(keep_data)

	# print(name[0],lat[0],lng[0])
	# print(keep_data[0])

	df = pd.DataFrame({
		'name':name,
		'lat':lat,
		'lng':lng
		})

	df.to_csv(file_name[:-5] + ".csv")

	# for line in html.split('\n'):
	#     if line != "":
	#         jsonResponse = json.loads(line)
	#         data.append(jsonResponse)

	# pprint.pprint(data)


	    

