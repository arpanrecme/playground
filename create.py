import json


root_cert = open("ansible/generated_resources/rootca/cert.pem", "r").read()

global_json = json.load(open("/home/user/.config/global.json"))
global_json["ROOT_CA"]["CERTIFICATE"] = root_cert
print(global_json)
with open('/home/user/.config/global.json', 'w', encoding='utf-8') as f:
    json.dump(global_json, f, indent=4, ensure_ascii=False)
