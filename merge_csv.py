import pandas as pd
import os
from glob import glob
os.chdir("/Users/swain/Desktop/新竹黑客松/台北市路燈位置分佈")



# df_all = pd.read_csv("LI3159.csv")

path_to_csv = '/Users/swain/Desktop/新竹黑客松/台北市路燈位置分佈'
csv_file = [pos_csv for pos_csv in os.listdir(path_to_csv) if pos_csv.endswith('.csv')]

with open('main.csv', 'a') as singleFile:
	for csv in glob('*.csv'):
		# print(csv)
		if csv == 'main.csv':
			pass
		else:
			for line in open(csv, 'r'):
				singleFile.write(line)

	# name.append(df['name'])
	# lat.append(df['lat'])
	# lng.append(df['lng'])
	# print(pd.read_csv(file_name).loc[:, ~df.columns.str.contains('^Unnamed')])




