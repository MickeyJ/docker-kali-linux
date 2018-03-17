#!/bin/zsh

TABLE_NAME=persons

printf "\nSelect Persons\n"
psql -d ${USERNAME} -U ${USERNAME} << EOF


SELECT * FROM ${TABLE_NAME}


EOF