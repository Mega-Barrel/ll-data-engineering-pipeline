"""
This module defines Dagster assets generated from a dbt project.

It uses the dagster-dbt library to load dbt models, seeds, and snapshots as 
Software-Defined Assets (SDAs), enabling Dagster to orchestrate and observe them.
"""

import os
from pathlib import Path
from typing import List, Union

from dotenv import load_dotenv

from dagster import AssetExecutionContext, AssetsDefinition
from dagster_dbt import DbtCliResource, dbt_assets

load_dotenv()

DBT_PROJECT_ROOT_STR: Union[str, None] = os.environ.get('DBT_PROJECT_PATH')

# Enforce the presence of the required environment variable.
if not DBT_PROJECT_ROOT_STR:
    raise ValueError(
        "DBT_PROJECT_PATH environment variable is missing or empty. "
        "Please ensure it is set correctly in your .env file or environment."
    )

DBT_PROJECT_DIR: Path = Path(DBT_PROJECT_ROOT_STR.strip())
DBT_MANIFEST_PATH: Path = DBT_PROJECT_DIR.joinpath("target", "manifest.json")

@dbt_assets(manifest=DBT_MANIFEST_PATH)
def dbt_models_assets(
        context: AssetExecutionContext,
        dbt: DbtCliResource
    ):
    """
    Defines Dagster assets corresponding to all resources (models, seeds, snapshots) 
    found in the dbt project's manifest.

    Args:
        context (AssetExecutionContext): The execution context provided by Dagster.
        dbt (DbtCliResource): The configured resource for executing dbt CLI commands.

    Yields:
        An event stream from the dbt CLI command execution, which Dagster translates
        into AssetMaterialization, AssetObservation, and other events.
    """

    context.log.info(f"Starting dbt build in project: {DBT_PROJECT_DIR}")

    # Execute the 'dbt build' command, which runs models, tests, seeds, and snapshots.
    # The .stream() method yields Dagster events for granular observation.
    yield from dbt.cli(
        ["build"],
        context=context
    ).stream()

# List of all asset definitions exposed by this module for Dagster to load.
all_assets: List[AssetsDefinition] = [dbt_models_assets]
