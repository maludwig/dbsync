#!/usr/bin/python

import json
import subprocess
import sys

def run_script(cmd):
    if type(cmd) is str:
        cmd = cmd.split(" ")
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = p.communicate()
    return out

def list_dbs(user,password):
    run_script(["./mysql.sh",user,password,"list-dbs"])
    
rdb_user = sys.argv[1]
rdb_pass = sys.argv[2]
print(json.dumps(list_dbs(rdb_user,rdb_pass)))  
# bash("./mysql.sh")
# data = json.dumps({"list":[1,2,"three3"],"str":"boo"})
# print(data)
