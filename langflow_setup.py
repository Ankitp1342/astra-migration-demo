import requests
import json
import time


def my_function():
    api_url = f"http://127.0.0.1:7860/api/v1/folders/"

    payload = {
        "name": "MigrationDemo",
        "descrition": "string",
    }
    headers = None

    response = requests.post(api_url, json=payload, headers=headers)

    folder_id = response.json().get("id")


    api_url = f"http://127.0.0.1:7860/api/v1/flows/upload/?folder_id={folder_id}"
    response = requests.post(api_url, files={"file": open("3_historical_data.json", "rb")});
    response = requests.post(api_url, files={"file": open("2_app_setup.json", "rb")});
    response = requests.post(api_url, files={"file": open("1_setup_zdm.json", "rb")});
    response = requests.post(api_url, files={"file": open("Load Historical.json", "rb")});
    return response  


while(True):

    try:
        if(my_function().status_code == 201):
            break
        print("Retrying")
    except requests.exceptions.ConnectionError:
        print("Exception Retrying")
    time.sleep(5)

print("Migration Langflow Setup Completed")
