"""
This module defines all automated schedules for the Dagster deployment.

Schedules are defined using cron strings and target specific jobs or 
asset selections (often derived from dbt assets) to automate pipeline runs.
"""
from typing import List
from dagster_dbt import build_schedule_from_dbt_selection
from dagster import ScheduleDefinition
from .assets import dbt_models_assets

daily_dbt_schedule: ScheduleDefinition = build_schedule_from_dbt_selection(
    dbt_assets = [
        dbt_models_assets
    ],
    job_name = "daily_dbt_run_job",
    cron_schedule = "0 9 * * *",
)

schedules: List[ScheduleDefinition] = [daily_dbt_schedule]
