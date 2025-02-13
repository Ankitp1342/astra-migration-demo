import requests
import json

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


print(response)