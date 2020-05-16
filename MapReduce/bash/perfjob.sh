#!/bin/bash

#sh script to automate the compilation running and fetching of data from hadoop fs.
#AAPL, GOOGL and MS separate files

rm -rf ./yearly/build
rm -rf ./monthly/build
rm -rf ./daily/build
#remove prev build 
rm ./yearly/*.jar
rm ./monthly/*.jar
rm ./daily/*.jar
#remove jars
mkdir ./yearly/build
mkdir ./monthly/build
mkdir ./daily/build
#make a build dir
javac -d ./yearly/build ./yearly/CombineYearly.java
javac -d ./monthly/build ./monthly/CombineMonthly.java
javac -d ./daily/build ./daily/CombineDaily.java
#compile and build
jar -cvf ./yearly/yearly.jar -C ./yearly/build/ .
jar -cvf ./monthly/monthly.jar -C ./monthly/build/ .
jar -cvf ./daily/daily.jar -C ./daily/build/ .
#make a jar of the build
hadoop fs -rm -r /user/woir_hadoop/STM/outputa1
hadoop fs -rm -r /user/woir_hadoop/STM/outputa2
hadoop fs -rm -r /user/woir_hadoop/STM/outputa3
#remove any exisitng folder from hadoop fs
hadoop jar ./daily/daily.jar org.myorg.CombineDaily /user/woir_hadoop/STM/input/csv/companies/AAPL.csv /user/woir_hadoop/STM/outputa1/
hadoop jar ./monthly/monthly.jar org.myorg.CombineMonthly /user/woir_hadoop/STM/input/csv/companies/AAPL.csv /user/woir_hadoop/STM/outputa2/
hadoop jar ./yearly/yearly.jar org.myorg.CombineYearly /user/woir_hadoop/STM/input/csv/companies/AAPL.csv /user/woir_hadoop/STM/outputa3/
#running job at hadoop system

#make a jar of the build
hadoop fs -rm -r /user/woir_hadoop/STM/outputg1
hadoop fs -rm -r /user/woir_hadoop/STM/outputg2
hadoop fs -rm -r /user/woir_hadoop/STM/outputg3
#remove any exisitng folder from hadoop fs
hadoop jar ./daily/daily.jar org.myorg.CombineDaily /user/woir_hadoop/STM/input/csv/companies/GOOGL.csv /user/woir_hadoop/STM/outputg1/
hadoop jar ./monthly/monthly.jar org.myorg.CombineMonthly /user/woir_hadoop/STM/input/csv/companies/GOOGL.csv /user/woir_hadoop/STM/outputg2/
hadoop jar ./yearly/yearly.jar org.myorg.CombineYearly /user/woir_hadoop/STM/input/csv/companies/GOOGL.csv /user/woir_hadoop/STM/outputg3/
#running job at hadoop system

#make a jar of the build
hadoop fs -rm -r /user/woir_hadoop/STM/outputm1
hadoop fs -rm -r /user/woir_hadoop/STM/outputm2
hadoop fs -rm -r /user/woir_hadoop/STM/outputm3
#remove any exisitng folder from hadoop fs
hadoop jar ./daily/daily.jar org.myorg.CombineDaily /user/woir_hadoop/STM/input/csv/companies/MSFT.csv /user/woir_hadoop/STM/outputm1/
hadoop jar ./monthly/monthly.jar org.myorg.CombineMonthly /user/woir_hadoop/STM/input/csv/companies/MSFT.csv /user/woir_hadoop/STM/outputm2/
hadoop jar ./yearly/yearly.jar org.myorg.CombineYearly /user/woir_hadoop/STM/input/csv/companies/MSFT.csv /user/woir_hadoop/STM/outputm3/
#running job at hadoop system

#copying back the op files to local unix system
#rm -rf ./*ly/outputc

mkdir ./yearly/outyear
mkdir ./daily/outday
mkdir ./monthly/outmonth
mkdir ./yearly/outyear/GOOGL
mkdir ./daily/outday/GOOGL
mkdir ./monthly/outmonth/GOOGL
mkdir ./yearly/outyear/AAPL
mkdir ./daily/outday/AAPL
mkdir ./monthly/outmonth/AAPL
mkdir ./yearly/outyear/MSFT
mkdir ./daily/outday/MSFT
mkdir ./monthly/outmonth/MSFT

hadoop fs -copyToLocal /user/woir_hadoop/STM/outputa1/* ./daily/outday/AAPL/
hadoop fs -copyToLocal /user/woir_hadoop/STM/outputa2/* ./monthly/outmonth/AAPL/
hadoop fs -copyToLocal /user/woir_hadoop/STM/outputa3/* ./yearly/outyear/AAPL/

hadoop fs -copyToLocal /user/woir_hadoop/STM/outputg1/* ./daily/outday/GOOGL/
hadoop fs -copyToLocal /user/woir_hadoop/STM/outputg2/* ./monthly/outmonth/GOOGL/
hadoop fs -copyToLocal /user/woir_hadoop/STM/outputg3/* ./yearly/outyear/GOOGL/

hadoop fs -copyToLocal /user/woir_hadoop/STM/outputm1/* ./daily/outday/MSFT/
hadoop fs -copyToLocal /user/woir_hadoop/STM/outputm2/* ./monthly/outmonth/MSFT/
hadoop fs -copyToLocal /user/woir_hadoop/STM/outputm3/* ./yearly/outyear/MSFT/


