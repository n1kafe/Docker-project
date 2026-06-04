#!/bin/bash

exec > >(sed 's/^/[SCRIPT INFO] /')

req=('docker' 'docker-compose' 'python3' 'pip')
ins=(
    'curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh'
    'sudo apt install docker-compose-plugin -y'
    'sudo apt update && sudo apt install python3'
    'sudo apt update && sudo apt install python3-pip python3-venv -y'
)



for i in ${!req[@]}
do
    ${req[$i]} --version > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "${req[$i]} installed."
    else
        echo "${req[$i]} is not installed."
        echo "Installing ${req[$i]} ..."
        eval "${ins[$i]}"
        echo "Done. ${req[$i]} is installed."
    fi
done


if [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate
elif [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
else
    echo ".venv was not found."
    echo "Creating virual enviroment..."
    python3 -m venv .venv
    source .venv/bin/activate
    echo ".venv was created and activeted" 
fi


lib_req=('django' 'torch' 'torchvision' 'PIL')
for i in ${lib_req[@]}
do
    python3 -c "import $i" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "$i installed."
    else
        echo "$i is not installed."
        echo "Installing $i ..."
        pip install $i
        echo "Done. $i is installed."
    fi
done

echo "The script was successful. Your environment is ready for work."