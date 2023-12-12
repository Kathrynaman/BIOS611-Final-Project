<h1>Katie Aman's 611 Final Project: An Analysis on Sleep and Lifestyle Data</h1> 

Hi, this is my, Katie Aman's, 611 Data Science Project. Please read the entire instructions document to learn more. My data set includes information on sleep duration and quality, along with lifestyle factors like BMI and heart rate.

<h2>Running This Project: Docker Instructions</h2> 
In order to run this project, you will need to use Docker. The Dockerfile included here should be helpful. Docker will create an environment in which all the software will be built to run my project. Setting the user ID (UID) manually in a rocker/verse Docker container is important for aligning permissions settings across computers. My project was all created on an Apple Silicon
M1 MacBook and I used the UNC Virtual Machine for this project (CD to 611bios). 

Then, I run the following code to build and start the docker container: 

docker build -t 611bios .
docker run -e USERID=$(id -u) -v $HOME/.ssh:/home/rstudio/.ssh -v $(pwd):/home/rstudio/work -p 8787:8787 -it 611bios

You then type the link http://localhost:8787 in a browser on your machine to access the machine and development environment. 

<h3> A Note On Directories</h3>
I expect this code to only run in the project directory. This is located in bios611-final-project at the following file directory: ~/work/611bios/bios611-final-project
The data is found in the source_data folder. 
 
<h2> Makefile Instructions</h2>
Please examine my Makefile to understand my project better. A Makefile is a code book of sorts that creates the relationships between artifacts (like data, figures, source files, etc). In helps show you what is needed to construct different data artifacts and also how to construct them. Using the tool make inside a Docker Container in the terminal, the Makefile allows for the automatic reproduction of an artifact (and all the artifacts which it depends on) through simple commands. You will want to type in make clean to remove all of my previous work. To build things simply write the directory name and the thing you want to build. For example if you want to build figure 1 and the rest of the artifacts on that line: make figures/figure1_age_hist.png will generate the image in my figures folder. 

<h3>Here is the Data Dictionary for our source_data file.</h3>
Dataset Columns:

Person ID: An identifier for each individual.

Gender: The gender of the person (Male/Female).

Age: The age of the person in years.

Occupation: The occupation or profession of the person.

Sleep Duration (hours): The number of hours the person sleeps per day.

Quality of Sleep (scale: 1-10): A subjective rating of the quality of sleep, ranging from 1 to 10.

Physical Activity Level (minutes/day): The number of minutes the person engages in physical activity daily.

Stress Level (scale: 1-10): A subjective rating of the stress level experienced by the person, ranging from 1 to 10.

BMI Category: The BMI category of the person (e.g., Underweight, Normal, Overweight).

Blood Pressure (systolic/diastolic): The blood pressure measurement of the person, indicated as systolic pressure over diastolic pressure.

Heart Rate (bpm): The resting heart rate of the person in beats per minute.

Daily Steps: The number of steps the person takes per day.

Sleep Disorder: The presence or absence of a sleep disorder in the person (None, Insomnia, Sleep Apnea).
Details about Sleep Disorder Column:
None: The individual does not exhibit any specific sleep disorder.
Insomnia: The individual experiences difficulty falling asleep or staying asleep, leading to inadequate or poor-quality sleep.
Sleep Apnea: The individual suffers from pauses in breathing during sleep, resulting in disrupted sleep patterns and potential health risks.


