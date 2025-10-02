"""
The definitions file defines the core elements of the Dagster repository.

This includes all assets, schedules, sensors, and resources used within the 
data platform. It serves as the primary configuration entry point for the 
Dagster Webserver and Daemon.
"""

from dagster import Definitions
from dagster_dbt import DbtCliResource
from .assets import DBT_PROJECT_DIR, all_assets
from .schedules import schedules

defs = Definitions(
    assets = all_assets,
    schedules = schedules,
    resources = {
        "dbt": DbtCliResource(
            project_dir = DBT_PROJECT_DIR,
        ),
    },
)
