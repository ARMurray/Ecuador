#Basic StreamPULSE data processing pipeline
#Updated 10/29/18
#Contact Mike Vlah (vlahm13@gmail.com) with questions or comments.

library(devtools)

# Install StreamPULSE pipeline tools from GitHub
# The StreamPULSE package is in development and changes frequently!
# If something doesn't work as expected, first try reinstalling.
install_github('streampulse/StreamPULSE', dependencies=TRUE)

# Install latest version of streamMetabolizer.
install.packages('streamMetabolizer', dependencies=TRUE,
                 repos=c('https://owi.usgs.gov/R','https://cran.rstudio.com'))

# Load packages.
library(StreamPULSE)
library(streamMetabolizer)

# View all available sites and their metadata
query_available_data(region='all')
query_available_data(region='EC')

# View all variables at a site, and full available time range for that site.
# Note that USGS depth and discharge data may be available for sites that
# have associated USGS gage IDs, even if depth and discharge do not appear among
# the variables returned here. If USGS data are available, they will be acquired
# automatically when you use prep_metabolism below. Likewise, air pressure and
# PAR estimates will be automatically acquired below, if necessary.
query_available_data(region='AZ', site='OC')
query_available_data(region='EC', site='IRU1')

# Select site and date range for which to acquire StreamPULSE data.
# site_code is a combination of regionID and siteID
site_code = 'AZ_OC'
start_date = '2018-06-01'
end_date = '2018-07-01'

site_code = 'EC_IRU1'
start_date = '2019-07-12'
end_date = '2019-08-14'
token = '7c34ed468efbcae57cb6'


# Download data from streampulse.
# Token parameter not needed if downloading public data.
# If you need a token, contact Mike at streampulse.info@gmail.com
sp_data = request_data(sitecode=site_code,
                       startdate=start_date, enddate=end_date, token = token)

# Choose model type for streamMetabolizer.
# Only "bayes" is available at this time.
model_type = 'bayes'

# Which modeling framework to use:
# Use "streamMetabolizer" (the default); "BASE" is not available at this time.
model_name = 'streamMetabolizer'

# Format data for metabolism modeling.
sp_data_prepped = prep_metabolism(d=sp_data, type=model_type,
                                  model=model_name#, 
                                #  estimate_areal_depth=TRUE #this was unable to be estimated so changed to TRUE
                                  )

# Fit metabolism model and generate predictions (calls streamMetabolizer
# functions: mm_name, specs, metab, predict_metab).
model_fit = fit_metabolism(sp_data_prepped)

# Plot results and diagnostics (Note that this may not work properly if your
# data do not all occur within the same calendar year.)
# You can explore all StreamPULSE model results at
# http://data.streampulse.org:3838/streampulse_diagnostic_plots/
plot_output(model_fit)

write.csv(details, "C:/Users/kriddie/Documents/kriddie_personal/Ecuador Proyecto IRU/StreamPulse/details_arizona.csv")
