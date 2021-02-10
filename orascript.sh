#!/bin/bash

# Agregar ORACLE_HOME, ORACLE_SID, PATH

for i in $(ls ${4}/*.sql)
do
echo "
      conn ${1}/${2}@${3}
      spool trace.out
      @${i}
      exit" | sqlplus /nolog

if [ -f trace.out ]; then
	error=$(grep "ORA-[0-9]{4,5}" trace.out)
	if [ "$error" != "" ]; then
		echo "ERROR: $error"
		exit 1
	fi
else
	echo "ERROR: No se generó el trace.out"
fi
done
