# Learning Targets Progress Tracker


These files generate a PDF checklist of Learning Targets and a Progress Grid updated from a Blackboard gradebook for all students.

To run this script and to generate the PDF:

1. Make sure you have a LaTeX distribution and a recent version of Julia installed.
2. Download the gradebook from Blackboard in the CSV format using commas not tabs as the separators.
3. Rename the downloaded CSV file to 'gb.csv'
4. In Julia run the code `using Pkg; Pkg.add(["CSV", "DataFrames"])`  to install the required packages.  This only needs to be run the first time Julia is run.
5. Run the Julia file 'process.jl' in the same directory where you unzip these files.  This will generate the file 'students.tex'
6. Compile the LaTeX file 'progress.tex'.
