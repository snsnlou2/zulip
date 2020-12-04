#!/bin/bash
serverIp=159.89.154.87
pip install mypy
python3 typecheck.py
eval "$(ssh-agent -s)"
chmod 600 root_key
ssh-keyscan $serverIp >> ~/.ssh/known_hosts
ssh-add root_key
yes | scp -i root_key ./.mypy_cache/$(python --version | cut -c8-10)/cache.db root@$serverIp:~/cache/zulip---zulip.db
yes | scp -i root_key ./mypy_test_report.txt root@$serverIp:~/report/zulip---zulip.txt
