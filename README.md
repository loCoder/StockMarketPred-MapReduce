# StockMarketPred-MapReduce
The repository consists of the Hadoop MapReduce code extracting only the information required by the ML algorithm for processing. The ML algorithm(linear regression) uses daily close/adj_close prices to get the next day's price. Some MR is done for demonstration purposes and can also be used for analysis. Also general analysis is done on the output of MR code using python.

#### GitHub 	link1:  https://github.com/loCoder/StockMarketPred-MapReduce
#### (alternate) link2: https://github.com/smaransandri/Big-Data
The Project has two parts:
 ## Part1: Apache Hadoop Mapreduce
 It has MapReduce code in Java, and is implemented on single-node Apache Hadoop v2.6.0 on (Linux-based) Ubuntu 14.04 OS.
 There are three directories in MapReduce 
 ### bash 
  : contains bash shell script to run the job(should be modified according to the final directory structure) 
    !!Some additional shell commands may be required to complete the MR job. Refer Hadoop documentation here -> https://hadoop.apache.org/docs/r2.6.0/.
  
 ### Test1: 
  Processing is done on 30 different(files) stocks from 2015-2020. Has two versions: v1 eliminates null values, v2 replaces null values(if any) with -1; obtained from online APIs like Yahoo finance, Google finance, MSN money etc.(use gsqlcmd for getting datsets easily, with varying frequency)
 ### Test2: 
  Processing is done on one file of 50MB, consisting data from 500 companies for the period 2010-2016; dataset taken from kaggle (https://www.kaggle.com/borismarjanovic/price-volume-data-for-all-us-stocks-etfs)

Each Test folder contains a dataset csv folder, and three folders with source code, class files and outputs, one each for daily, monthly and yearly analysis on the data.
 Refer INFO for more data in MapReduce folder.
 
 ## Part2: Python Visualization and Prediction
 This part can be readily executed by running these files on jupyter notebook.
 Here we use python libraries to visualize and predict the stock price using linear regression.
 It has four .ipynb files.
 ### StockAnalysis
   Data Analysis is done for 1 company of choice out of 500companies DS.
 ### Stock30Analysis
   Data Analysis is done for 1 company of choice out of 30companies DS.
 ### StockPrediction
  Prediction done using linear regression for 1 company of choice out of 500companies.
 ### Stock30Prediction
  Prediction done using linear regression for 1 company of choice out of 30companies.

 ##### Further/Future scope/improvements: XGBoost as Prediction model.
 
 For further details refer markdown cells of the .ipynb files.
 
 #### Credits:
  ##### AP (Data Analysis and improvements in ML)
  ##### SSS (Machine Learning and dataset extraction)
  ##### JF (MapReduce and improvements in Data Analysis and Predictions)
