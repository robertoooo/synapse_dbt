# This repository demonstrates using dbt togehter with synapse dedicated SQL pool
In this project we will use dbt togheter with synapse to load the SAP Bikes Sales sample data to create tables and views in Synapse dedicated SQL server.
* Setup Azure Synapse
* Load the data from the data lake using Synapse Pipelines
* Run dbt to create views of the Sales data, more specifically group the sales orders table, join it with products table and calculate the total weight sold.


## Branches
In this project I am currently using github to version control both the dbt project and the synapse workspace.

* **main:** Synapse code base
* **workspace_publish:** Synapse ARM templates
* **main_dbt:** dbt source code

# Azure Synapse
## Getting Started
1. Download the synapse_workspace branch (including the ARM templates) and import it to your own Synapse workspace.
2. Setup is the data lake linked service to your own data lake inside azure.
Go to Manage -> Linked Services --> AzureDataLakeStorage
![image](https://user-images.githubusercontent.com/16771332/147113976-1d6e603e-41c2-4256-af0c-8759e5074d76.png)

3. In this example we will use the SAP Bikes Sales sample data.
Download the SalesOrderItems.csv and Products.csv and place them inside your own data lake, in a container called synapse and then in a folder called raw. (or change the endpoint inside the integration dataset dl_csv_dataset)


![image](https://user-images.githubusercontent.com/16771332/147114182-6be7aebf-14f6-4260-aad2-f9c8636e5408.png)



## The ETL Process using Synapse Pipelines
The etl pipelines consists of two activities. To simplify things, we are using the data lake as the data source and the Synapse SQL dedicated SQL pool as the sink.
Check out the pipeline dl_to_stage.

Run the pipeline, this should create two tables inside your Synapse dedicated SQL service:
![image](https://user-images.githubusercontent.com/16771332/147113220-63280700-be08-4b24-aa9e-732f62743ab4.png)


# dbt
## clone the dbt repository
Clone the dbt repository called main_dbt and change branch to dbt_vault
```sh
git clone https://github.com/robertoooo/synapse_dbt.git
git checkout dbt_vault
```
## create a virtual environment and activate it.
```sh
python -m venv venv
source venv/scripts/activate #For windows using bash
```

## Install dbt & dbtvault
Install dbt.
```sh
pip install dbt
```
To ensure that dbt is installed run the following command:
```sh
dbt --version
```
Your root folder should now look like this:
![image](https://user-images.githubusercontent.com/16771332/147116905-4b670b6d-24e5-487c-9c9e-a4629eca3af9.png)

## Connect to Synapse dedicated pool
Establish a connection to Synapase.
In order to manage connection settings we need to find the profiles.yml file where we set up the connection to your Synapse SQL instance.

```sh
dbt debug --config-dir
```
Follow these instructions to setup your connection:
https://docs.getdbt.com/reference/warehouse-profiles/azuresynapse-profile

Test your connection running:
```sh
dbt debug
```

## run the dbt models
In the models folder there are two models and one schema file.
![image](https://user-images.githubusercontent.com/16771332/147122721-6ee0a092-089f-4b6c-9377-3bde1731982e.png)

In the Schema.yml we have two models and two sources defined.
* The sources are stage tables already ingested into the warehouse (using the Synapse Pipelines).
* The models are used to create the views  SalesOrderItems_Total and SalesOrderItems_TotalWeight. 
** Under models you also find Tests, they are also triggered with every run. Failing the tests if there are duplicates or null values.

The two models SalesOrderItems_Total.sql and SalesOrderItems_TotalWeight.sql contain the logic for the views that will be created inside the Synapse warehouse.
The tables will have the same name in Synapse as the name of the sql file:
![image](https://user-images.githubusercontent.com/16771332/147127947-c6c6b377-2424-4897-9fe0-4bbf4aff3c86.png)


## dbt documentation and data lineage
One very nice feature with dbt is the possibility to generate documentation.
Run the following commands: 
```
dbt docs generate
dbt docs serve
```
The serve command will host a local website on your computer where you can see the whole project such as table details and data lineage:
![image](https://user-images.githubusercontent.com/16771332/147128883-7de57c7d-3aed-4dc1-b96d-33c60c1f7205.png)
![image](https://user-images.githubusercontent.com/16771332/147128984-499df4e0-f0ab-4d87-9ed6-a3acf7fa96f6.png)


# Check out
Also check out my medium article on how to build a dbt vault using Google BigQuery
https://medium.com/d-one/building-a-data-vault-using-dbtvault-with-google-big-query-9b69428d79e7




