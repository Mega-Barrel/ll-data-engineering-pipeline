### Big Star Warehouse
Welcome to the dbt transformation layer of the Big Star Data Engineering project! This repo contains modular dbt models that transform raw data into analytics-ready tables.

### Lineage Graph
![Alt text](/assets/dbt-dag.png "Lineage Graph")

### Project Structure
- **staging:** cleans and standardizes raw data
- **marts:** Final fact & dimension tables (e.g. daily sales, orders facts)

### Using the starter project
Try running the following commands:
- dbt deps
- dbt run
- dbt test
- dbt docs generate / serve

### Project Highlight
- Incremental models for scalable pipelines
- Data quality tests using dbt_utils and dbt_expectations
- Clean modular structure for analytics engineering workflows

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)