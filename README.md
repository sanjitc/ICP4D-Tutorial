# ICP4Data Tutorial 

This is the repository for the ICP4D Tutorial Data and setup. ICP4D Tutorial is based on IBM ICP for Data v1.2.0. For more information on this exciting new Data Science Platform, please visit  [ibm.com](http://ibm.com). ICP for Data provides an end-to-end, integrated & governed data & analytics solution platform where Data Engineers Data Stewards, Data Scientists and Business Users collaborate to bring forward the best insights from the existing data in the enterprise.



## Flow
1. Download and Load the core setup modules.
2. Import the dataset into IBM ICP4Data
3. Prepare and shape the dataset using Data Transform.
4. Using Imported Jupyter notebook , train a simple linear regression model.
5. Save the resulting model into ICP4Data.
6. Use the saved model to predict for additional datasets.


# Steps
Follow these steps to create the required services and run the notebook locally.

1. [Clone the repo](#1-clone-the-repo)
2. [List the Samples](#2-list-vailable-samples)
3. [Load the Samples](#3-load-samples)
4. [Create a Data Connection](#4-create-data-connection)
5. [Load Machine Learning Project](#5-load-machine-learning-project)

### 1. Clone the repo

Clone the `icp4data tutorial` repository locally. In a terminal, run the following command:

```
$ git clone https://github.com/sanjitc/ICP4XTutorial.git
```

### 2. List Available Samples


```
$ ./load_samples.sh -l
- mortgage
- data_virtualization

```


### 3. Load Samples

Depending on your interest of domain, you would pass the domain in the loader.

```
$  ./load_samples.sh -t mortgage
```

### 4. Create Data Connection


### 5. Load Machine Learning Project

