#!/bin/bash


cassandra -R
python3 langflow_setup.py &
uv run langflow run 
