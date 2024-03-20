cd "${PASSWORD_STORE_DIR:-$HOME/.password-store}"

selected=$(find -L . -not -path '*\/.*' -path "*.gpg" -type f -printf '%P\n' |
	sed 's/.gpg$//g' |
	tofi --prompt-text "Select Password: ") || exit 2

if [ -z "$selected" ]; then
	exit 1
fi

username=$(echo "$selected" | cut -d '/' -f2)
url=$(echo "$selected" | cut -d '/' -f1)

fields="Password
Username
OTP
URL"

field=$(printf "$fields" | tofi --prompt-text "Select Field: ") || field="Password"

case "$field" in
"Password")
	value="$(pass "$selected" | head -n 1)"
	if [ -z "$value" ]; then
		{
			notify-send "Error" "No password for $selected" -i error -t 6000
			exit 3
		}
	fi
	;;
"Username")
	value="$username"
	;;
"URL")
	value="$url"
	;;
"OTP")
	value="$(pass otp "$selected")"
	if [ -z "$value" ]; then
		{
			notify-send "Error" "No OTP for $selected" -i error -t 6000
			exit 3
		}
	fi
	;;
*)
	exit 4
	;;
esac

wl-copy "$value"
case "$field" in
"Password")
	notify-send "Password Copied!" -i edit-copy -t 4000
	;;
*)
	notify-send "Copied $field:" "$value" -i edit-copy -t 4000
	;;
esac
