#!/bin/bash
echo
echo
echo -e "\e[31mTHAT BETA\e[0m"

echo "to change the directory just end the script by writing exit"
echo
echo



user_name=$(whoami)


echo "Choose a directory for saving files (or press Enter for the current directory): "
read selected_folder


if [ -z "$selected_folder" ]; then
    selected_folder="."
fi


if [ ! -d "$selected_folder" ]; then
    mkdir -p "$selected_folder"
fi


while true; do
    
    echo "Choose the file type (.cpp/.h) or type 'exit' to quit: "
    read file_extension

   
    if [ "$file_extension" = "exit" ]; then
        echo "Exiting the script."
        exit 0
    fi

    
    if [ "$file_extension" != "cpp" ] && [ "$file_extension" != "h" ]; then
        echo "Error: Invalid file type. Choose .cpp or .h."
        continue
    fi

  
    echo "Enter the file name: "
    read file_name


    full_file_name="${selected_folder}/${file_name}.${file_extension}"

    
    touch $full_file_name

    
    file_extension_uppercase=$(echo $file_extension | tr '[:lower:]' '[:upper:]')

    
    file_name_uppercase=$(echo $file_name | tr '[:lower:]' '[:upper:]')

  
    echo "// File: ${file_name}.${file_extension}" >> $full_file_name
    echo "// Created on: $(date)" >> $full_file_name
    echo "// User: $user_name" >> $full_file_name
    echo "" >> $full_file_name

    
    case $file_extension in
        "cpp")
            echo "#include <iostream>" >> $full_file_name
            echo "" >> $full_file_name
            echo "int main() {" >> $full_file_name
            echo "    // Your code here" >> $full_file_name
            echo "    return 0;" >> $full_file_name
            echo "}" >> $full_file_name
            ;;
        "h")
            echo "#ifndef ${file_name_uppercase}_H" >> $full_file_name
            echo "#define ${file_name_uppercase}_H" >> $full_file_name
            echo "" >> $full_file_name
            echo "class ${file_name} {" >> $full_file_name
            echo "public:" >> $full_file_name
            echo "    ${file_name}();" >> $full_file_name
            echo "    ~${file_name}();" >> $full_file_name
            echo "};" >> $full_file_name
            echo "" >> $full_file_name
            echo "#endif // ${file_name_uppercase}_H" >> $full_file_name
            ;;
    esac

    echo "File created: $full_file_name"
done