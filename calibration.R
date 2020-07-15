# devtools::install_github("ncsu-landscape-dynamics/rpops")
library(PoPS)
library(folderfun)
library(raster)

folderfun::setff("In", "H:/My Drive/EEID/Wheat Stripe Rust/PureLine/")
folderfun::setff("Out", "H:/My Drive/EEID/Wheat Stripe Rust/PureLine/calibration/")

infected_years_file <- ffIn("purelines_7weeks.tif")
number_of_observations <- 100  ### This is the number of infected cells or total observations - just make sure it's consistent across years 
prior_number_of_observations <- 0
prior_means <- c(0, 0, 0, 0, 0, 0)    ### leave as 0 for now, means that you are giving them no weight
prior_cov_matrix <- matrix(ncol = 6, nrow = 6, 0)
params_to_estimate <- c(T, T, T, T, T, F)  ### 1st: reproductive rates, 2nd: natural distance, 3rd: percent natural, 4tH: anthropogenic distance, 5th Natural Kappa, 6th anthropogenic kappa
number_of_generations <- 6
generation_size <- 50
checks = c(90, 20000, 164000, 8000)   ### 1: difference between number of infected cells in different years * 2
### 2: difference in distance in different years *2
### 3 and 4 don't matter if you keep the metric of success the same
infected_file <- ffIn("Pure_infected.tif")
host_file <- ffIn("Pure_host.tif")
total_plants_file <- ffIn("Pure_host.tif")
temp <- FALSE
temperature_coefficient_file <- ""
precip <- FALSE
precipitation_coefficient_file <- ""
model_type = "SEI"
latency_period = 14
time_step <- "day"
season_month_start <- 1
season_month_end <- 12
start_date <- '2003-01-01'
end_date <- '2003-02-18'
use_lethal_temperature <- FALSE
temperature_file <- ""
lethal_temperature <- -30
lethal_temperature_month <- 1
mortality_on <- FALSE
mortality_rate <- 0
mortality_time_lag <- 0
management <- FALSE
treatment_dates <- c('2003-01-24')
treatments_file <- ""
treatment_method <- "ratio"
natural_kernel_type <- "cauchy"
anthropogenic_kernel_type <- "cauchy"
natural_dir <- "E"
natural_kappa <- 0
anthropogenic_dir <- "NONE"
anthropogenic_kappa <- 0
pesticide_duration <- c(0)
pesticide_efficacy <- 1.0
mask <- NULL
success_metric <- "residual error"  ### keep this the same
output_frequency <- "week"
movements_file = ""  ## ignore - for pigs
use_movements = FALSE
percent_natural_dispersal <- 1.0
anthropogenic_distance_scale <- 0.0

hyslop_farm <- abc_calibration(infected_years_file, 
                               number_of_observations, 
                               prior_number_of_observations,
                               prior_means, prior_cov_matrix, 
                               params_to_estimate,
                               number_of_generations,
                               generation_size,
                               checks,
                               infected_file, 
                               host_file, 
                               total_plants_file, 
                               temp, 
                               temperature_coefficient_file, 
                               precip, 
                               precipitation_coefficient_file,
                               model_type,
                               latency_period,
                               time_step, 
                               season_month_start, 
                               season_month_end, 
                               start_date, 
                               end_date, 
                               use_lethal_temperature, 
                               temperature_file,
                               lethal_temperature, 
                               lethal_temperature_month,
                               mortality_on, 
                               mortality_rate, 
                               mortality_time_lag, 
                               management, 
                               treatment_dates, 
                               treatments_file,
                               treatment_method,
                               natural_kernel_type, 
                               anthropogenic_kernel_type,
                               natural_dir, 
                               natural_kappa, 
                               anthropogenic_dir, 
                               anthropogenic_kappa,
                               pesticide_duration, 
                               pesticide_efficacy,
                               mask, 
                               success_metric, 
                               output_frequency,
                               movements_file, 
                               use_movements)


means_purelines = as.data.frame(hyslop_farm$posterior_means)
cov_purelines = as.data.frame(hyslop_farm$posterior_cov_matrix)
raw_calib_purelines = as.data.frame(hyslop_farm$raw_calibration_data)
total_obs_purelines = as.data.frame(hyslop_farm$total_number_of_observations)
write.csv(total_obs_purelines, ffOut("total_obs.csv"))
write.csv(means_purelines, ffOut("means_purelines.csv"), row.names = FALSE)
write.csv(cov_purelines, ffOut("cov_purelines.csv"), row.names = FALSE)
write.csv(raw_calib_purelines, ffOut("raw_calib_purelines.csv"))
