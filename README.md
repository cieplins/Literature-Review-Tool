# Literature-Review-Tool
To use the tool, dowload bibtex files from databases and store them in one directory, in which you don't have any other files.
Please keep the bibtex files coming from IEEE database in such a form "iee*.bib"!
To use the code RStudio and R are needed. 
Before you use the code you need to download the libraries - to do so just type in install.packages("name_of_the_library") in R console for the following libraries: "bib2df","plyr","tidyverse","dplyr","bibliometrix". 
Just click on Source button, pick the directory with your bibtex files and the tool will automatically save the csv file in your directory, with a name merged.csv.
You can also uncomment the first and nineth line, switch the path in the first one to yours and delate seventh and eight line if you are not working on Windows.

If you have some comments or something is not working contact me directly :)
