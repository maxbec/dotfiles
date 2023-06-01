pw_name="brew autoupdate"
pw_account="max"

if ! cli_password=$(security find-generic-password -w -s "$pw_name" -a "$pw_account"); then
    echo "error $?"
    exit 1
fi

echo "$cli_password"
