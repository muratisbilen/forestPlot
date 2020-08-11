Input file format should be as followed:

- There are 4 required and 1 optional columns: 
	1) The name of the variable (to be shown in y-axis of the plot)
	2) Hazard ratios (or any other values) in natural scale (e.g. exp(HR) in mUSAT output)
	3) Lower confidence interval in natural scale
	4) Upper confidence interval in natural scale
	5) (Optional) Standard error values for hazard ratios (or any other values). This option will define the size of squares that define hazard ratios. The size of the squares will be inversely proportional to the standard error values. If this column is not present, all the squares will be the same size. 

- Output of the script is a pdf file with the forest plot corresponding to the input file. Significant results are shown in blue lines. Non-significant results are shown with black lines. 
	
There are two variables you can define at the top of the forestplot.r script. You can find the explanations for these variables in the same line in the script. You can set the label for x-axis and you can define the scale of the x-axis with these variables. 

To run the forestplot.r script set the working directory to the path the script is located. Put the input files into Input folder. Run the script with source("forestplot.r") command. The output forest plot will be created in the output folder for each input file.  