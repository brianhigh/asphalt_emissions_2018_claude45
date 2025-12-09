# Walkthrough: US States Asphalt Emissions Choropleth Map

## Project Overview

Successfully created an R script that generates a choropleth map of US states showing asphalt-related emissions data from the EPA's 2018 State County Inventory dataset.

## What Was Accomplished

### 1. R Script Implementation

Created [`create_choropleth_map.R`](file:///C:/Users/high/Documents/asphalt_emissions_2018_claude45/create_choropleth_map.R) with the following features:

- **Package Management**: Uses `pacman::p_load()` to automatically install and load required packages (readxl, ggplot2, dplyr, maps, httr, stringr)
- **Directory Creation**: Automatically creates `data/` and `plots/` directories if they don't exist
- **Conditional Data Download**: Downloads the Excel file from EPA ScienceHub only if not already present locally
- **Data Processing**: Reads the "Output - State" sheet and extracts "State" and "Total kg/person" columns
- **Choropleth Visualization**: Creates a professional choropleth map using ggplot2 with:
  - Red-yellow-green diverging color scale (green = low emissions, yellow = medium, red = high)
  - Midpoint set at the median emissions value for balanced color distribution
  - Grey state borders for clarity
  - Proper title, subtitle, and data source citation
  - Clean, minimal theme
- **Error Handling**: Comprehensive tryCatch blocks throughout for robust error handling
- **Output**: Saves high-resolution PNG (300 DPI, 12x8 inches) to `plots/` folder

### 2. Documentation

Created comprehensive project documentation:

- **[README.md](file:///C:/Users/high/Documents/asphalt_emissions_2018_claude45/README.md)**: Project overview with embedded map image and links to all project files
- **[plan.md](file:///C:/Users/high/Documents/asphalt_emissions_2018_claude45/plan.md)**: Implementation plan detailing the technical approach

### 3. Data Source

- **Dataset**: AP_2018_State_County_Inventory.xlsx from EPA ScienceHub via data.gov
- **URL**: https://pasteur.epa.gov/uploads/10.23719/1531683/AP_2018_State_County_Inventory.xlsx
- **Sheet**: "Output - State"
- **Metrics**: State-level asphalt emissions in kg/person

## Generated Choropleth Map

![US States Asphalt Emissions Map](C:\Users\high\.gemini\antigravity\brain\286799ae-b462-4d7e-babe-0f6f45bc1ccb\us_states_asphalt_emissions.png)

The map shows:
- **51 states** with valid emissions data
- **Red-yellow-green color scale** where:
  - Green indicates low emissions (environmentally better)
  - Yellow indicates medium emissions
  - Red indicates high emissions (areas of concern)
- **Midpoint** set at median value for balanced visualization
- **Data source citation** in the plot caption
- **Professional styling** suitable for reports and presentations

## Testing Results

### Initial Testing
- ✅ Script executed successfully without errors
- ✅ Data file downloaded correctly (657 KB)
- ✅ Excel file read successfully (52 rows, 19 columns)
- ✅ Processed 51 states with valid emissions data
- ✅ Map generated and saved as PNG (323 KB)

### Code Quality
- ✅ Fixed ggplot2 deprecation warning (changed `size` to `linewidth`)
- ✅ Comprehensive error handling throughout
- ✅ Informative console messages for debugging
- ✅ Clean execution with no warnings

### File Verification

```
asphalt_emissions_2018_claude45/
├── create_choropleth_map.R (5.6 KB)
├── README.md (1.9 KB)
├── prompt.md (1.1 KB)
├── plan.md (3.0 KB)
├── data/
│   └── AP_2018_State_County_Inventory.xlsx (657 KB)
└── plots/
    └── us_states_asphalt_emissions.png (323 KB)
```

## Key Features Implemented

1. ✅ Conditional data download (checks if file exists before downloading)
2. ✅ Automatic directory creation
3. ✅ Package management with pacman::p_load()
4. ✅ Error handling with tryCatch blocks
5. ✅ Data source citation in plot caption
6. ✅ High-quality PNG output (300 DPI)
7. ✅ Professional visualization with ggplot2
8. ✅ Comprehensive documentation
9. ✅ Links to prompt.md and plan.md in README

## Usage

To regenerate the map:

```r
Rscript create_choropleth_map.R
```

The script will:
1. Load/install required packages
2. Create necessary directories
3. Download data if needed
4. Process and visualize the data
5. Save the map to `plots/us_states_asphalt_emissions.png`

## Conclusion

The project successfully delivers a complete, well-documented solution for visualizing US state-level asphalt emissions data. The R script is robust, reusable, and produces publication-quality output.
