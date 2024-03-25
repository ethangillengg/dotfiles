#!/usr/bin/env bash
#list of args to exit immediately
ARGS_TO_EXIT_IMMEDIATELY=(
	"-h"
	"--help"
	"-s"
	"--show"
	"-S"
	"--show-last"
	"-l"
	"--list"
	"-d"
	"--delete"
)

# if no args, skip the checks
if [[ "$#" -gt 0 ]]; then
	# # if any of the args are in the list, exit immediately
	for arg in "${ARGS_TO_EXIT_IMMEDIATELY[@]}"; do
		if [[ "$*" == *"$arg"* ]]; then
			mods "$@"
			exit 0
		fi
	done
fi

while true; do
	# Create a temporary markdown file
	tmpfile=$(mktemp /tmp/tmpfile.XXXXXX.md)

	# Ensure the temporary file is removed when done
	trap 'rm -f "$tmpfile"' EXIT

	# Open the temporary file in neovim
	nvim "$tmpfile"

	# Check if neovim exited successfully
	# if [ $? -eq 0 ]; then
	#better way to check if neovim exited
	if [ -f "$tmpfile" ]; then
		# Check if the file is empty
		if [ ! -s "$tmpfile" ]; then
			echo "The buffer was empty. Exiting."
			exit 0
		else
			# If the file is not empty, pipe its contents to the 'mods'
			command
			OPENAI_API_KEY=$(pass show personal/openai) mods "$@" <"$tmpfile"
		fi
	else
		echo "Neovim did not exit successfully. Exiting."
		exit 1
	fi

	# Optional: Prompt the user to continue or exit the loop
	echo "Press Enter to send another question or 'q' to quit."
	read -r input
	if [[ "$input" == "q" ]]; then
		exit 0
	fi

	# if -c or --no-cahe were not provided, add -C to the existing
	# this ensures we continue the conversation
	if [[ "$*" != *"-c"* && "$*" != *"--no-cache"* ]]; then
		set -- -C "$@"
	fi
done
