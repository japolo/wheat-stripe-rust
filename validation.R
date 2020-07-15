# devtools::install_github("ncsu-landscape-dynamics/rpops")
library(PoPS)
library(folderfun)
library(raster)
folderfun::setff("In", "H:/My Drive/EEID/Wheat Stripe Rust/PureLine/")
folderfun::setff("Incal", "H:/My Drive/EEID/Wheat Stripe Rust/PureLine/calibration/")
folderfun::setff("Out", "H:/My Drive/EEID/Wheat Stripe Rust/PureLine/validtation/")

infected_years_file <- ffIn("purelines_7weeks.tif")
parameter_means <- read.csv(ffIncal("means_purelines.csv"))[[1]]
parameter_cov_matrix <- read.csv(ffIncal("cov_purelines.csv"))
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
anthropogenic_dir <- "NONE"
pesticide_duration <- c(0)
pesticide_efficacy <- 1.0
mask <- NULL
success_metric <- "residual error"  ### keep this the same
output_frequency <- "week"
movements_file = ""  ## ignore - for pigs
use_movements = FALSE
number_of_iterations <- 10
number_of_cores <- 2

val_purlines <- abc_validate(infected_years_file, 
                             number_of_iterations, 
                             number_of_cores,
                             parameter_means,
                             parameter_cov_matrix,
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
                             anthropogenic_dir, 
                             pesticide_duration, 
                             pesticide_efficacy,
                             mask, 
                             success_metric, 
                             output_frequency,
                             movements_file, 
                             use_movements)

s <- pops_multirun(infected_file, 
                   host_file, 
                   total_plants_file,
                   parameter_means,
                   parameter_cov_matrix,
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
                   anthropogenic_dir, 
                   number_of_iterations, 
                   number_of_cores,
                   pesticide_duration,
                   pesticide_efficacy,
                   random_seed = NULL,
                   output_frequency,
                   movements_file, 
                   use_movements)


s2 <- pops(infected_file, 
           host_file, 
           total_plants_file, 
           parameter_means,
           parameter_cov_matrix,
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
           anthropogenic_dir, 
           pesticide_duration, 
           pesticide_efficacy,
           random_seed = NULL, 
           output_frequency, 
           movements_file, 
           use_movements)
