# This repository demonstrates using dbt togehter with synapse dedicated SQL pool

## Branches
In this project I am currently using github to version control both the dbt project and the synapse workspace.

* **main:** Synapse code base
* **workspace_publish:** Synapse ARM templates
* **main_dbt:** dbt source code


# Getting Started
1. Download the synapse_workspace branch (including the ARM templates) and import it to your own Synapse workspace.
2. Setup is the data lake linked service to your own data lake inside azure.
Go to Manage -> Linked Services --> AzureDataLakeStorage
![image](https://user-images.githubusercontent.com/16771332/147113976-1d6e603e-41c2-4256-af0c-8759e5074d76.png)

3. In this example we will use the SAP Bikes Sales sample data.
Download the SalesOrderItems.csv and Products.csv and place them inside your own data lake, in a container called synapse and then in a folder called raw. (or change the endpoint inside the integration dataset dl_csv_dataset)
![image](https://user-images.githubusercontent.com/16771332/147114182-6be7aebf-14f6-4260-aad2-f9c8636e5408.png)



# The ETL Process using Synapse Pipelines
The etl pipelines consists of two activities. To simplify things, we are using the data lake as the data source and the Synapse SQL dedicated SQL pool as the sink.
![image](https://user-images.githubusercontent.com/16771332/147113220-63280700-be08-4b24-aa9e-732f62743ab4.png)

