#!/usr/bin/python

import json
import subprocess
import sys

def run_script(cmd):
    print("Running: " + json.dumps(cmd))
    if type(cmd) is str:
        cmd = cmd.split(" ")
    cmd = ['sudo']+cmd
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = p.communicate()
    return out

def sudo_script(cmd):
    if type(cmd) is str:
        cmd = cmd.split(" ")
    cmd = ['sudo']+cmd
    run_script(cmd)

def mysql_script(func,args=[]):
    return run_script(["./mysql.sh",rdb_user,rdb_pass,func]+args)

def list_dbs():
    return mysql_script("list-dbs").split("\n")

def list_tables(db):
    return mysql_script("list-tables",[db]).split("\n")

cmd = sys.argv[1]
rdb_user = sys.argv[2]
rdb_pass = sys.argv[3]
# print(json.dumps(run_script(["./echoer.sh",rdb_user,rdb_pass,"list-dbs"])))
tablist = list_tables(sys.argv[4])
for table in tablist:
    print("#- %s -#" % table)
# bash("./mysql.sh")
# data = json.dumps({"list":[1,2,"three3"],"str":"boo"})
# print(data)
