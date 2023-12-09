#!/usr/bin/env python3
#
# Modified from https://github.com/tom-doerr/zsh_codex/blob/main/create_completion.py
#

import os
import sys

from dotenv import dotenv_values
from openai import OpenAI

LOCALRC = os.path.join(os.getenv("HOME"), ".localrc")
if not os.path.isfile(LOCALRC):
    print("~/.localrc not found")
    sys.exit(1)

config = dotenv_values(LOCALRC)
# ORG_ID = os.getenv("ZSHAI_OPENAI_ORG_ID")
client = OpenAI(api_key=config["ZSHAI_OPENAI_API_KEY"])

cursor_position_char = int(sys.argv[1])

# Read the input prompt from stdin.
buffer = sys.stdin.read()
prompt_prefix = "#!/bin/zsh\n\n" + buffer[:cursor_position_char]
prompt_suffix = buffer[cursor_position_char:]
full_command = prompt_prefix + prompt_suffix
response = client.chat.completions.create(
    model="gpt-4-1106-preview",
    messages=[
        {
            "role": "system",
            "content": "\
                You are a zsh shell expert.\
                You should only output the completed command, do not include conversation or explanation.\
                You do not need to enclose your output in markdown, only valid shellscript.\
                Please help me complete the following command.",
        },
        {
            "role": "user",
            "content": full_command,
        },
    ],
)
top_choice = response.choices.pop()
completed_command = top_choice.message.content

sys.stdout.write(f"\n{completed_command.replace(prompt_prefix, '', 1)}")
