library(auk)
library(raster)
library(tidyverse)
library(sf)
library(rnaturalearth)
library(tigris)
library(viridisLite)
library(lubridate)
library(dplyr)
library(gridExtra)


select <- dplyr::select
filter <- dplyr::filter

# path to data
ebd_dir <- "C:/Users/vazqu/1.COMPU/Posdoc/Expansion/Data_raw" 

# define the paths to the EBD and SED (Sampling Event Data)
# make sure that the version of both datasets match
f_in_ebd <- file.path(ebd_dir, "ebd_crbthr1_relOct-2023.txt")
f_in_sampling <- file.path(ebd_dir, "ebd_sampling_relOct-2023.txt")

# create an object in R that references these files
auk_ebd(file = f_in_ebd, file_sampling = f_in_sampling)

# FILTERING

ebd_filters <- auk_ebd(f_in_ebd, f_in_sampling) %>% 
  # filter by species
  auk_species(c("Turdus amaurochalinus")) %>% 
  # filter by country
  auk_country(c("Argentina", "Brazil", "Bolivia", "Paraguay", "Chile", "Falckland Islands (Malvinas)", "Peru", "Uruguay")) %>%
  # filter by date
  auk_year(year = c(1993: 2023)) %>% 
  # filter by protocol
  auk_protocol(protocol = c("Stationary", "Traveling")) %>% 
  # duration: length in minutes of checklists
  auk_duration(duration = c(0, 300)) %>%
    # filter by travelled distance
  auk_distance(distance = c(0, 5)) %>%
  # only complete checklists
  auk_complete()

ebd_filters

# export filtered data
f_out_ebd <- "C:/Users/vazqu/1.COMPU/Posdoc/Expansion/Data_raw/Filtrados/ebd_amauro.txt"
f_out_sampling <- "C:/Users/vazqu/1.COMPU/Posdoc/Expansion/Data_raw/Filtrados/ebd_amauro_sampling.txt"
ebd_filtered <- auk_filter(ebd_filters, file = f_out_ebd, file_sampling = f_out_sampling, overwrite = T)

# import filtered data with read_ebd function. this will generate a checklist identifier
ebd <- read_ebd(f_out_ebd)

glimpse(ebd)

# zero-filling -----------------------------------------------------------------
# this process creates a presence/absence dataset
ebd_zf <- auk_zerofill(f_out_ebd, f_out_sampling)
ebd_zf <- collapse_zerofill(ebd_zf)

# in the resulting dataset we will have a column "species_observed" with logical values 'TRUE' or 'FALSE', 
#which indicates whether or not the focal species was detected in that sampling event.
ebd_zf

# aditional filter
ebd_zf_filtered <- ebd_zf %>% 
  filter(number_observers <= 10)

# Finally, we keep only the variables of interest.
zf_filtered_amauro <- ebd_zf_filtered %>% 
  select(scientific_name, longitude, latitude, checklist_id, country, observer_id, sampling_event_identifier,  
         observation_count, species_observed, state_code, locality_id, protocol_type, observation_date, year, 
         time_observations_started, duration_minutes, effort_distance_km, number_observers)

zf_filtered_amauro

# we filter by age range of interest

zf_filtered_amauro_r1 <- zf_filtered_amauro %>% 
  filter(
    between(observation_date, as.Date('2003-01-01'), as.Date('2007-12-31')))

zf_filtered_amauro_r2 <- zf_filtered_amauro %>% 
  filter(
    between(observation_date, as.Date('2008-01-01'), as.Date('2013-12-31')))

zf_filtered_amauro_r3 <- zf_filtered_amauro %>% 
  filter(
    between(observation_date, as.Date('2014-01-01'), as.Date('2018-12-31')))

zf_filtered_amauro_r4 <- zf_filtered_amauro %>% 
  filter(
    between(observation_date, as.Date('2019-01-01'), as.Date('2023-10-31')))

write_csv(zf_filtered_amauro_r1, "C:/Users/vazqu/1.COMPU/Posdoc/Expansion/Amaurochalinus/Preprocesados/zf_amauro_r1.csv", na = "")
write_csv(zf_filtered_amauro_r2, "C:/Users/vazqu/1.COMPU/Posdoc/Expansion/Amaurochalinus/Preprocesados/zf_amauro_r2.csv", na = "")
write_csv(zf_filtered_amauro_r3, "C:/Users/vazqu/1.COMPU/Posdoc/Expansion/Amaurochalinus/Preprocesados/zf_amauro_r3.csv", na = "")
write_csv(zf_filtered_amauro_r4, "C:/Users/vazqu/1.COMPU/Posdoc/Expansion/Amaurochalinus/Preprocesados/zf_amauro_r4.csv", na = "")

