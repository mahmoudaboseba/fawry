#!/bin/bash

n_flag=0
v_flag=0

# Process command line options
while [[ $1 == -* ]]; do
    case "$1" in
        --help)
            echo "Usage: $0 [OPTIONS] PATTERN FILE"
            echo "Options:"
            echo "  -n         Show line numbers"
            echo "  -v         Invert match"
            echo "  --help     Display this help message"
            exit 0
            ;;
        -*) 
            options="${1#-}"
            for ((i=0; i<${#options}; i++)); do
                char="${options:$i:1}"
                case "$char" in
                    n) n_flag=1 ;;
                    v) v_flag=1 ;;
                    *) echo "Error: Invalid option -$char" >&2; exit 1 ;;
                esac
            done
            ;;
    esac
    shift
done

# Validate remaining arguments
if [ $# -ne 2 ]; then
    echo "Error: Missing search string or filename. Usage: $0 [OPTIONS] PATTERN FILE" >&2
    exit 1
fi

if [[ $n_flag -eq 1 && $v_flag -eq 1 ]];then
	grep "$1" -inv "$2"
elif [ $n_flag -eq 1 ]; then 
	grep "$1" -in "$2"
elif [ $v_flag -eq 1 ]; then
	grep "$1" -iv "$2"
fi
