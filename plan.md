# Implementation Plan: US States Choropleth Map

Create an R script that generates a choropleth map of US states showing asphalt emissions data (Total kg/person) from the data.gov dataset.

## User Review Required

> [!IMPORTANT]
> The data source URL from data.gov will be used to conditionally download the Excel file. The script will check if the file exists locally before downloading to avoid unnecessary downloads.

> [!NOTE]
> The color scheme will be based on a continuous scale for "Total kg/person" values, using ggplot2's default color gradients unless the original Excel file contains specific color coding that needs to be extracted.

## Proposed Changes

### R Script

#### [NEW] [create_choropleth_map.R](file:///c:/Users/high/Documents/asphalt_emissions_2018_claude45/create_choropleth_map.R)

Main R script that will:
- Load required packages using `pacman::p_load()` (readxl, ggplot2, dplyr, maps, httr, etc.)
- Create `data/` and `plots/` directories if they don't exist
- Conditionally download `AP_2018_State_County_Inventory.xlsx` from data.gov
- Read the "Output - State" sheet from the Excel file
- Extract "State" and "Total kg/person" columns
- Merge with US states map data
- Create choropleth map with ggplot2
- Add data source citation in plot caption
- Include comprehensive error handling with tryCatch blocks
- Save the plot as PNG to `plots/` folder

---

### Documentation

#### [NEW] [README.md](file:///c:/Users/high/Documents/asphalt_emissions_2018_claude45/README.md)

Project README that will:
- Display the generated choropleth map using markdown image syntax
- Link to [prompt.md](file:///c:/Users/high/Documents/asphalt_emissions_2018_claude45/prompt.md)
- Link to [plan.md](file:///c:/Users/high/Documents/asphalt_emissions_2018_claude45/plan.md)
- Provide project description and usage instructions

#### [NEW] [plan.md](file:///c:/Users/high/Documents/asphalt_emissions_2018_claude45/plan.md)

Copy of this implementation plan for reference.

---

### Project Structure

The final project structure will be:
```
asphalt_emissions_2018_claude45/
├── create_choropleth_map.R
├── README.md
├── prompt.md (already exists)
├── plan.md
├── data/
│   └── AP_2018_State_County_Inventory.xlsx (downloaded)
└── plots/
    └── us_states_asphalt_emissions.png (generated)
```

## Verification Plan

### Automated Tests
- Run the R script: `Rscript create_choropleth_map.R`
- Verify no errors during execution
- Check that all required packages are installed
- Verify data file is downloaded to `data/` folder
- Verify PNG plot is created in `plots/` folder

### Manual Verification
- Visually inspect the generated choropleth map
- Verify all US states are displayed
- Confirm color coding represents "Total kg/person" values
- Check that data source citation appears in plot caption
- Verify README.md displays the plot image correctly
- Confirm all links in README.md work properly
