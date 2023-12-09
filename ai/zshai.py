#!/usr/bin/env python3

import configparser
import os
import sys

import openai

LOCALRC = os.path.join(os.getenv("HOME"), ".localrc")
API_KEY = os.getenv("ZSHAI_OPENAI_API_KEY")
ORG_ID = os.getenv("ZSHAI_OPENAI _ORG_ID")

if not os.path.isfile(LOCALRC):
    print("~/.localrc not found")

openai.organization_id = ORG_ID
openai.api_key = API_KEY


cursor_position_char = int(sys.argv[1])

# Read the input prompt from stdin.
buffer = sys.stdin.read()
prompt_prefix = "#!/bin/zsh\n\n" + buffer[:cursor_position_char]
prompt_suffix = buffer[cursor_position_char:]
full_command = prompt_prefix + prompt_suffix
response = openai.ChatCompletion.create(
    model="gpt-4-1106-preview",
    messages=[
        {
            "role": "system",
            "content": "You are a zsh shell expert, please help me complete the following command, you should only output the completed command, no need to include any other explanation",
        },
        {
            "role": "user",
            "content": full_command,
        },
    ],
)
completed_command = response["choices"][0]["message"]["content"]

sys.stdout.write(f"\n{completed_command.replace(prompt_prefix, '', 1)}")
