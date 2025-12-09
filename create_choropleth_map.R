#!/usr/bin/env Rscript
# US States Choropleth Map - Asphalt Emissions Data
# Data source: data.gov - AP_2018_State_County_Inventory.xlsx

# Load required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readxl, ggplot2, dplyr, maps, httr, stringr)

# Function to create directories if they don't exist
create_dir <- function(dir_path) {
  tryCatch({
    if (!dir.exists(dir_path)) {
      dir.create(dir_path, recursive = TRUE)
      message(sprintf("Created directory: %s", dir_path))
    } else {
      message(sprintf("Directory already exists: %s", dir_path))
    }
  }, error = function(e) {
    stop(sprintf("Error creating directory %s: %s", dir_path, e$message))
  })
}

# Create necessary directories
create_dir("data")
create_dir("plots")

# Download data file if it doesn't exist
data_file <- "data/AP_2018_State_County_Inventory.xlsx"
# Direct download URL from EPA ScienceHub via data.gov
data_url <- "https://pasteur.epa.gov/uploads/10.23719/1531683/AP_2018_State_County_Inventory.xlsx"

if (!file.exists(data_file)) {
  message("Downloading data file from data.gov...")
  tryCatch({
    response <- GET(data_url, write_disk(data_file, overwrite = TRUE), progress())
    if (status_code(response) == 200) {
      message("Data file downloaded successfully!")
    } else {
      stop(sprintf("Failed to download file. HTTP status code: %d", status_code(response)))
    }
  }, error = function(e) {
    stop(sprintf("Error downloading data file: %s", e$message))
  })
} else {
  message("Data file already exists. Skipping download.")
}

# Read the Excel file
message("Reading Excel file...")
tryCatch({
  # Read the "Output - State" sheet
  state_data <- read_excel(data_file, sheet = "Output - State")
  message(sprintf("Successfully read data with %d rows and %d columns", 
                  nrow(state_data), ncol(state_data)))
  
  # Display column names for debugging
  message("Available columns:")
  print(colnames(state_data))
  
}, error = function(e) {
  stop(sprintf("Error reading Excel file: %s", e$message))
})

# Process the data
message("Processing data...")
tryCatch({
  # Select and rename columns
  # Handle potential column name variations
  total_col <- grep("Total.*kg.*person", colnames(state_data), ignore.case = TRUE, value = TRUE)[1]
  state_col <- grep("^State$", colnames(state_data), ignore.case = TRUE, value = TRUE)[1]
  
  if (is.na(total_col) || is.na(state_col)) {
    stop("Could not find required columns 'State' and 'Total kg/person'")
  }
  
  # Create clean dataset
  map_data <- state_data %>%
    select(state = all_of(state_col), 
           emissions = all_of(total_col)) %>%
    mutate(
      # Convert state names to lowercase for merging with map data
      state = tolower(state),
      # Ensure emissions is numeric
      emissions = as.numeric(emissions)
    ) %>%
    filter(!is.na(emissions))
  
  message(sprintf("Processed %d states with valid emissions data", nrow(map_data)))
  
}, error = function(e) {
  stop(sprintf("Error processing data: %s", e$message))
})

# Get US states map data
message("Loading US states map data...")
tryCatch({
  us_states <- map_data("state")
  
  # Merge emissions data with map data
  map_merged <- us_states %>%
    left_join(map_data, by = c("region" = "state"))
  
  message("Successfully merged map and emissions data")
  
}, error = function(e) {
  stop(sprintf("Error loading or merging map data: %s", e$message))
})

# Create the choropleth map
message("Creating choropleth map...")
tryCatch({
  p <- ggplot(map_merged, aes(x = long, y = lat, group = group, fill = emissions)) +
    geom_polygon(color = "grey50", linewidth = 0.2) +
    coord_fixed(1.3) +
    scale_fill_gradient2(
      low = "#2ca25f",      # Green for low values
      mid = "#ffff00",      # Yellow for medium values
      high = "#de2d26",     # Red for high values
      midpoint = median(map_data$emissions, na.rm = TRUE),
      na.value = "grey90",
      name = "Total kg/person",
      breaks = pretty(map_data$emissions, n = 5)
    ) +
    labs(
      title = "Asphalt-Related Emissions by US State (2018)",
      subtitle = "Anthropogenic Secondary Organic Aerosol and Ozone Production",
      caption = "Data Source: data.gov - AP_2018_State_County_Inventory.xlsx\nAnthropogenic secondary organic aerosol and ozone production from asphalt-related emissions"
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(size = 12, hjust = 0.5, margin = margin(b = 10)),
      plot.caption = element_text(size = 8, hjust = 0, margin = margin(t = 10)),
      axis.text = element_blank(),
      axis.title = element_blank(),
      axis.ticks = element_blank(),
      panel.grid = element_blank(),
      legend.position = "right",
      legend.title = element_text(size = 10, face = "bold"),
      legend.text = element_text(size = 9)
    )
  
  message("Choropleth map created successfully!")
  
}, error = function(e) {
  stop(sprintf("Error creating map: %s", e$message))
})

# Save the plot
output_file <- "plots/us_states_asphalt_emissions.png"
message(sprintf("Saving plot to %s...", output_file))
tryCatch({
  ggsave(
    filename = output_file,
    plot = p,
    width = 12,
    height = 8,
    dpi = 300,
    bg = "white"
  )
  message(sprintf("Plot saved successfully to %s", output_file))
  
}, error = function(e) {
  stop(sprintf("Error saving plot: %s", e$message))
})

message("\n=== Script completed successfully! ===")
message(sprintf("Output file: %s", normalizePath(output_file)))
