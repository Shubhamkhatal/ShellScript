#!/bin/bash 

function update_apt(){
    sudo apt-get update
}

function install_package(){
    sudo apt-get install -y ${1}
}

function clone_repo(){
    git clone ${1}
}

function change_dir(){
    cd ${1}
}

function install_requirements(){
    pip3 install -r ${1} 
    pip3 install psycopg2-binary
}

function setup_postgres_db(){
    sudo -u postgres -H -- psql  -c "ALTER USER postgres PASSWORD '123'"
    sudo -u postgres createdb website
}

function run_python_files(){
    sed -i "s/'password_of_database'/123/g" main.py
    python3 ${1}
}

update_apt
install_package "python3"
install_package "postgresql"
install_package "git"
install_package "python3-pip"
clone_repo "https://github.com/Shubhamkhatal/Blogging-site.git"
change_dir "Blogging-site"
install_requirements "requirements.txt"
setup_postgres_db
run_python_files "main.py"
