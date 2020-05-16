package org.myorg;

import java.io.FileReader;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.HashMap;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;
import java.io.StringReader;
import com.opencsv.CSVReader;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class CombineDaily extends Configured implements Tool {
	private static long start,end;

  public static void main(String[] args) throws Exception {
				start = new Date().getTime();
    int res = ToolRunner.run(new CombineDaily(), args);
    System.exit(res);
  }

  public int run(String[] args) throws Exception {

    		Job job1 = Job.getInstance(getConf(), "combineDat");
		job1.setJarByClass(CombineDaily.class);
		job1.setMapperClass(Map.class);
		job1.setReducerClass(Reduce.class);
		job1.setMapOutputKeyClass(Text.class);
		job1.setMapOutputValueClass(DoubleWritable.class);
		FileInputFormat.addInputPath(job1, new Path(args[0]));
		FileOutputFormat.setOutputPath(job1, new Path(args[1]+"Daily"));
		


		boolean status = job1.waitForCompletion(true);
		if (status == true) 
		{
			end = new Date().getTime();
			System.out.println("\nJob took " + (end-start) + "milliseconds\n");
			return 0;
		}
		else
			return 1;
  }

  public static class Map extends Mapper<LongWritable, Text, Text, DoubleWritable> {
    private LongWritable views = new LongWritable();
    private Text word = new Text();
    private long numRecords = 0;
	private long viewInteger;
	//,likeInteger,dislikeInteger,comment_count;    

    public void map(LongWritable offset, Text lineText, Context context)
        throws IOException, InterruptedException {
      String line = lineText.toString();
      Text currentKey = new Text();
	DoubleWritable currentVal;
		if(line.length()>0)
		{
			CSVReader reader = new CSVReader(new StringReader(line));
			String[] nextLine;
			double closeValNum;
			try {
	    		  	if ((nextLine = reader.readNext()) != null) 
				{
		        	 if(nextLine.length==7 && !(nextLine[0].trim().equals("date")))
		        	 {	
					String compName=nextLine[1].trim();
					String date = nextLine[0].trim();//dd-mm-yyyy
					String closeVal = nextLine[3].trim();
					if(closeVal!="null")
						closeValNum = Double.parseDouble(closeVal);
					else
						closeValNum = -1;
					String[] dateSplit = date.split("-");
					currentKey = new Text(compName+"\t"+dateSplit[2]+"-"+dateSplit[1]+"-"+dateSplit[0]);//yyyy-mm-dd
					currentVal =new DoubleWritable(closeValNum);
						
					context.write(currentKey,currentVal);
				 }
		        	 else
		        	 { throw new Exception();//avoid ds related exceptions and remove 1st row
					}

	    		  	}
	    		  }
			catch(NumberFormatException e)
			{}
	    	  	catch(NoClassDefFoundError e)
	    	  	{}
	    	  	catch(Exception e)
	    	  	{}
	    	  	finally {reader.close();}//for single line
		}
        }
    }
  

  public static class Reduce extends Reducer<Text, DoubleWritable, Text, Text> {
    //@Override
		public static long headerFlag=0;
		double cVal;
    public void reduce(Text word, Iterable<DoubleWritable> vals, Context context)
        throws IOException, InterruptedException {
	if(headerFlag==0)
	{	headerFlag++;context.write(new Text("stock_name\tdate"),new Text("close"));}
	      Text currentKey = new Text(),currentVal;
			currentKey = new Text(word);
      for (DoubleWritable val : vals) {
	cVal=val.get();
	Double wrapVal = new Double(cVal);
		currentVal = new Text(wrapVal.toString());
		context.write(currentKey,currentVal);	
      }
	
    }
  }
}

