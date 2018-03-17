#!/bin/zsh

TABLE_NAME=persons

printf "\nCreate Persons table\n"
psql -d ${USERNAME} -U ${USERNAME} << EOF


DROP TABLE IF EXISTS ${TABLE_NAME};

CREATE TABLE ${TABLE_NAME}(
	id SERIAL,
	name varchar(25)
);


EOF
