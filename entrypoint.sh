#!/bin/bash

cat << EOF > /rathena/conf/import/char_conf.txt
server_name: ${SERVER_NAME}
wisp_server_name: ${WISP_SERVER_NAME}
login_ip: ${PUBLIC_IP}
login_port: ${LOGIN_PORT}
char_ip: ${PUBLIC_IP}
char_port: ${CHAR_PORT}
bind_ip: ${CHAR_BIND_IP}
EOF

cat << EOF > /rathena/conf/import/login_conf.txt
login_port: ${LOGIN_PORT}
bind_ip: ${LOGIN_BIND_IP}
EOF

cat << EOF > /rathena/conf/import/map_conf.txt
char_ip: ${PUBLIC_IP}
char_port: ${CHAR_PORT}
map_ip: ${PUBLIC_IP}
map_port: ${MAP_PORT}
bind_ip: ${MAP_BIND_IP}
EOF

cat << EOF > /rathena/conf/import/inter_conf.txt
// MySQL Login server
login_server_ip: ${MYSQL_HOST}
login_server_port: ${MYSQL_HOST_PORT}
login_server_id: ${MYSQL_USER}
login_server_pw: ${MYSQL_PASS}
login_server_db: ${MYSQL_RAG_DB}

ipban_db_ip: ${MYSQL_HOST}
ipban_db_port: ${MYSQL_HOST_PORT}
ipban_db_id: ${MYSQL_USER}
ipban_db_pw: ${MYSQL_PASS}
ipban_db_db: ${MYSQL_RAG_DB}

// MySQL Character server
char_server_ip: ${MYSQL_HOST}
char_server_port: ${MYSQL_HOST_PORT}
char_server_id: ${MYSQL_USER}
char_server_pw: ${MYSQL_PASS}
char_server_db: ${MYSQL_RAG_DB}

// MySQL Map Server
map_server_ip: ${MYSQL_HOST}
map_server_port: ${MYSQL_HOST_PORT}
map_server_id: ${MYSQL_USER}
map_server_pw: ${MYSQL_PASS}
map_server_db: ${MYSQL_RAG_DB}

// MySQL Log Database
log_db_ip: ${MYSQL_HOST}
log_db_port: ${MYSQL_HOST_PORT}
log_db_id: ${MYSQL_USER}
log_db_pw: ${MYSQL_PASS}
log_db_db: ${MYSQL_LOG_DB}
EOF

case $1 in
    "login-server")
        echo "Starting login server:"
        login-server
    ;;
    "char-server")
        echo "Starting char server:"
        char-server
    ;;
    "map-server")
        echo "Starting map server:"
        map-server
    ;;
    "all-in-one")
        echo "Starting login, char and map server:"
        login-server && char-server && map-server
    ;;        
    *)
        echo "Opcao invalida."
        exit 0
    ;;
esac