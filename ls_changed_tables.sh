#!/bin/bash
find /var/lib/mysql/realtalk/ -name '*.ibd' -newer $1 | cut -d'/' -f2 | cut -d'.' -f1
