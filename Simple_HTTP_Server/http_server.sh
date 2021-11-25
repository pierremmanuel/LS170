#!/usr/bin/bash

function server () {
  while true
  do
    # accomodate for multiple line request message
    message_arr=()
    check=true
    while $check
    do
      read line
      message_arr+=($line)
      # line length of 1 indicates final line of the request
      # ${#line} => Bash Parameter Expansion, returns the length of the parameter
      if [[ "${#line}" -eq 1 ]]
      then
        check=false
      fi
    done
    method=${message_arr[0]}  # assign element at index 0 to $method variable
    path=${message_arr[1]}    # assign element at index1 to $path variable
    if [[ $method = 'GET' ]]
    then
      if [[ -e "./www$path" ]]
      then
        echo -ne "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: $(wc -c <'./www/'$path)\r\n\r\n"; cat "./www/$path"
      else
        echo -ne 'HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\n\r\n'
      fi
    else
      echo -ne 'HTTP/1.1 400 Bad Request\r\nContent-Length: 0\r\n\r\n'
    fi
  done
}

coproc SERVER_PROCESS { server; }

netcat -lkv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}
