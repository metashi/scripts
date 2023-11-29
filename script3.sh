#!/bin/bash

# Script for managing user accounts
add_user() {
    read -p "Enter the new username: " username
    useradd -m -s /bin/bash "$username"
    echo "User $username has been added."
}

remove_user() {
    read -p "Enter the username to remove: " username
    userdel -r "$username"
    echo "User $username has been removed along with the home directory."
}

manage_permissions() {
    echo "1. Grant permissions"
    echo "2. Revoke permissions"
    echo "3. Exit"

    read -p "Choose option (1-3): " option

    case $option in
        1)
            read -p "Enter the file path: " file_path
            read -p "Grant read permission (r)? (y/n): " read_permission
            read -p "Grant write permission (w)? (y/n): " write_permission
            read -p "Grant execute permission (x)? (y/n): " execute_permission

            permissions=""
            [ "$read_permission" == "y" ] && permissions+="r"
            [ "$write_permission" == "y" ] && permissions+="w"
            [ "$execute_permission" == "y" ] && permissions+="x"

            chmod u+"$permissions" "$file_path"
            echo "Granted permissions to the user for the file $file_path."
            ;;

        2)
            read -p "Enter the file path: " file_path
            read -p "Revoke read permission (r)? (y/n): " read_permission
            read -p "Revoke write permission (w)? (y/n): " write_permission
            read -p "Revoke execute permission (x)? (y/n): " execute_permission

            permissions=""
            [ "$read_permission" == "y" ] && permissions+="r"
            [ "$write_permission" == "y" ] && permissions+="w"
            [ "$execute_permission" == "y" ] && permissions+="x"

            chmod u-"$permissions" "$file_path"
            echo "Revoked permissions from the user for the file $file_path."
            ;;

        3)
            echo "Exiting the program."
            ;;

        *)
            echo "Invalid choice. Choose again."
            ;;
    esac
}

owner_file() {
    read -p "Enter the file path: " file_path
    read -p "Enter the new owner: " new_owner

    if [ -e "$file_path" ]; then
        echo "Current owner of the file $file_path:"
        ls -l "$file_path" | awk '{print $3}'
        if id "$new_owner" &>/dev/null; then
            chown "$new_owner": "$file_path"
            echo "Changed the owner of the file $file_path to $new_owner."
        else
            echo "User $new_owner does not exist."
        fi
    else
        echo "File $file_path does not exist."
    fi
}

while true; do
    echo "1. Add a user"
    echo "2. Remove a user"
    echo "3. Manage permissions"
    echo "4. Manage owner file"
    echo "5. Exit"

    read -p "Choose an option (1-5): " choice

    case $choice in
        1) add_user;;
        2) remove_user;;
        3) manage_permissions;;
        4) owner_file;;
        5) exit;;
        *) echo "Invalid choice. Please choose again.";;
    esac
done
