### Data Engineering Pipeline
This project is a hands-on data engineering pipeline built using the modern data stack. It covers the full workflow from raw data ingestion to transformation, modeling, and analytics.

### Tech Stack
- Dagster
- PostgreSQL
- dbt
- Python
- Docker

### Dagster DAG overview
![Alt text](/assets/dagster-dag.png "Dagster Graph")

### Repository Structure
```markdown
├── big_star_warehouse
│    ├── README.md
│    ├── dbt_project.yml
│    ├── packages.yml
│    ├── models/
│    │   ├── staging/
│    │   ├── marts/
│    ├── target/
├── dagster_pipelien
│    ├── dagster_pipeline/
│    │   ├── __init__.py
│    │   ├── assets.py
│    │   ├── definitions.py
│    │   ├── schedules.py
├── README.md
├── docker-compose.yml
├── setup.py
├── .gitignore
├── .env
└── requirements.txt
```

### Local setup
```markdown
1. Create virtual environment
python -m venv env && source env/bin/activate

2. Install dependencies
python setup.py
```

👋 Built by [Saurabh Joshi](https://www.linkedin.com/in/saurabhjoshi2403/)  
If you found this helpful, feel free to connect or ⭐ the repo!