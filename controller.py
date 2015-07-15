#!/usr/bin/python

import json
import subprocess
import sys

def run_script(cmd):
    print("Running: " + json.dumps(cmd))
    if type(cmd) is str:
        cmd = cmd.split(" ")
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = p.communicate()
    return out

def mysql_script(func,args=[]):
    return run_script(["./mysql.sh",rdb_user,rdb_pass,func]+args)

def list_dbs():
    return mysql_script("list-dbs")

def list_tables(db):
    return mysql_script("list-tables",[db])

rdb_user = sys.argv[1]
rdb_pass = sys.argv[2]
# print(json.dumps(run_script(["./echoer.sh",rdb_user,rdb_pass,"list-dbs"])))
print(list_tables(sys.argv[3]))  
# bash("./mysql.sh")
# data = json.dumps({"list":[1,2,"three3"],"str":"boo"})
# print(data)
