README
========================================================

This document describes how to run the analysis that creates a tidy dataset with the mean of a subset of variables grouped by subject and activity.

The R script, *run_analysis.R*, should be placed in a directory with the following files and directories (containing files)  for the script to execute successfully.

- features.txt
- activity_labels.txt
- test (directory)
  - X_test.txt
  - y_test.txt
  - subject_test.txt
- train (directory)
  - X_train.txt
  - y_train.txt
  - subject_train.txt
  
In your R console, set your working directory to the directory where you placed the *run_analysis.R* script and the data files. Once your working directory has been changed, you can use the source command to run the script as shown below.

```{r}
source("run_analysis.R")
```

The CodeBook markdown file describes the variables that are created by the script and the process used to transform the data. The script will write out a .txt file named *tidy.txt* to the current working directory that contains 180 observations and 68 variables (subject id, activity name, and 66 measurements).

