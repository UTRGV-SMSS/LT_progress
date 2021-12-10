# Learning Targets Progress Tracker


These files generate a PDF checklist of Learning Targets and a Progress Grid updated from a Blackboard gradebook for all students.


To generate the PDF on Github via Github Actions:

1. Go to your Blackboard course shell and go to download your grades.  Under "OPTIONS" on the download page, choose "Comma" as the Delimiter Type.
2. After downloading the gradebook, rename the file to "gb.csv".
3. On the Github page for this project, click on the button "Add file" which is next to the green "Code" buttom.  Choose "Upload files" in the dropdown menu that appears.
4. Click "Choose your files" and select the "gb.csv" file that you renamed previously.  Then click the green button "Commit changes".
5. Click on the "Actions" text that is shown just under the project name.  (The compilation should be running as indicated by slightly animated yellow bullet point at the top of the workflow runs.)
6. Select the topmost workflow run with the yellow bullet point (or green checkmark if the action has been completed).
7. Scroll to the "Artifacts" section.  Click on the "PDF" button to download the compiled PDF.


To generate the PDF on your computer:

1. Make sure you have a LaTeX distribution and a recent version of Julia installed.
2. Download the gradebook from Blackboard in the CSV format using commas not tabs as the separators.
3. Rename the downloaded CSV file to 'gb.csv'
4. In Julia run the code `using Pkg; Pkg.add(["CSV", "DataFrames"])`  to install the required packages.  This only needs to be run the first time Julia is run.
5. Run the Julia file 'process.jl' in the same directory where you unzip these files.  This will generate the file 'students.tex'
6. Compile the LaTeX file 'progress.tex'.


A possible issue may arise from how you name the WeBWorK homework column in the gradebook.  The code will search for the column with the text "WeBWorK" and rename it "hw_grade".  If there is an error when the code is searching for this column, then either change the text to search for in the file "process.jl" or rename the column in the gradebook file.