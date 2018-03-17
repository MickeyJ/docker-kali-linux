#!/bin/zsh

TABLE_NAME=persons
NEW_USER="${1}"

printf "\nInserting Person ${NEW_USER}\n"
psql -d ${USERNAME} -U ${USERNAME} << EOF


INSERT INTO ${TABLE_NAME}(
	name
)
VALUES (
	'${NEW_USER}'
);



EOF