#!/bin/zsh
#
# Modified from https://github.com/tom-doerr/zsh_codex/blob/main/zsh_codex.plugin.zsh
#

SCRIPT_DIR="$(dirname "$0")"

# This ZSH plugin reads the text from the current buffer
# and uses a Python script to complete the text.

zsh_ai_completion() {
    # Get the text typed until now.
    text=${BUFFER}
    
    # echo $cursor_line $cursor_col
    completion=$(echo -n "$text" | $SCRIPT_DIR/zshai.py $CURSOR)
    
    text_before_cursor=${text:0:$CURSOR}
    text_after_cursor=${text:$CURSOR}
    
    # Add completion to the current buffer.
    BUFFER="${text_before_cursor}${completion}${text_after_cursor}"
    prefix_and_completion="${text_before_cursor}${completion}"
    
    # Put the cursor at the end of the completion
    CURSOR=${#prefix_and_completion}
}
