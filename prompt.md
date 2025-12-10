Write an R script which creates a US states choropleth map with ggplot using data from [data.gov](https://catalog.data.gov/dataset/data-anthropogenic-secondary-organic-aerosol-and-ozone-production-from-asphalt-related-emi), specifically the file AP_2018_State_County_Inventory.xlsx, and more specifically, the "Output - State" sheet and the columns State and "Total kg/person". 

Use the same color scale as displayed in the Total kg/person column, with reds indicating high values, yellows/oranges indicating medium values, and greens indicating low values. State borders should be grey. 

The script should save the map to a PNG file stored in a "plots" folder. The plot should mention the data source in the plot caption in the lower left corner of the plot margin. 

Include the code to conditionally download the data file from data.gov if the file has not already been downloaded. Save the data file to a "data" folder. Use pacman::p_load() to load R packages. 

Your code should create the "data" and "plots" folders if they do not already exist. 

Include error handling in the code. Test and debug your code. 

Create a README.md that displays the map by linking to the PNG plot file. Save the implementation plan as plan.md. Save the walkthrough as walkthrough.md. Create a .gitignore file to exclude VS Code or RStudio metadata files. 

Link to the prompt.md, plan.md, and walkthrough.md files in the README.md and list all of these files in the project structure section of the README.md.
