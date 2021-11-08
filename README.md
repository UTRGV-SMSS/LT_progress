# LT_progress


To run this script, you need to have the CSV and DataFrames packages.  To add them run the following:

`using Pkg; Pkg.add(["CSV", "DataFrames"])`


The gradebook should be exported from Blackboard in the CSV format using commas not tabs as the seperators. You also need to delete any "Preview Users" from the CSV file.
The name of the exported CSV file is expected to be `gb.csv`.


After running the `process.jl` file, compile the `progress.tex` file using $\LaTeX$. 