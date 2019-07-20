# These files are the sensor specific workflows which should be used to process field data at the end of each day

**Vaisala_Processing.R**
This script iterates through all of our Vaisala data that was collected at the four permanent stations within the stream located between the primary study wetland and the ranger station. The coordinates for each station are:
+ Station 1:
+ Station 2:
+ Station 3:
+ Station 4:

All four sensors were deployed on Tuesday July 9, 2019. Sensors were initially colocated in order to establish a field calibration. The Vaisala sensors we use have a range of 0-10,000 ppm and a margin of error of 150 ppm. Sensors were colocated for thirty minutes to quantify measurement differences between sensors. To adjust for measurement differences we found the mean reading for all sensors and adjust readings from each sensor by the difference between the average reading accross all four and the average reading for each sensor individually. The following offsets were determined:

+ Sensor 1: -5 (subtract 5 ppm from reading)
+ Sensor 2: -30 (subtract 30 ppm from reading)
+ Sensor 3: +17.5 (add 17.5 ppm to reading)
+ Sensor 4: +17.5 (add 17.5 ppm to reading)

We attempt to collect data from the sensors as often as possible (almost every weekday). Additionally we do not delete data as the capacity of the dataloggers exceeds the needs of our entire field season. After each collection, data is stored in the ~Ecuador/FieldData/Vaisala/ folder. In acknowledgement of the fact that at times the data logger was cleared (necessitating multiple files to be included) and the fact the multiple files will include identical rows of data, this script is designed to iterate through all of the available files, merge them together, and then to delete duplicates. This method ensures total inclusion of all collected data while keeping the dataset tidy. The cost of this method is computation time required, which should be negligible considering the amount of data we are processing (not that much computationally speaking). Each sensor is processed individually and then merged together at the end to create a comprehensive dataset.


**Vaisala_Flux.r:**
This script converts vaisala readings to flux
