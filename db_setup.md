# Setting up a Pluggable Database
using this chatgpt discussion : https://chatgpt.com/share/675ef136-1940-8000-a695-2f6240503818

## Create the PDB
Connect to sqlplus using a terminal :
```bash
sqplus / as sysdba
```
'SQL>' should be displayed.

Verify which container you are in :
```bash
SHOW CON_NAME;
```
To find the seed path :
```bash
SELECT NAME FROM V$DATAFILE;
```
Create DB using :
- a new admin username and password
- the seed path you found
- a new path (next to PDBSEED) named like the DB
```bash
CREATE PLUGGABLE DATABASE UCL_STATS
   ADMIN USER ldc IDENTIFIED BY motdepasse
   FILE_NAME_CONVERT = ('C:\APP\CTSWI\PRODUCT\21C\ORADATA\XE\PDBSEED\', 'C:\APP\CTSWI\PRODUCT\21C\ORADATA\XE\UCL_STATS\');
```

## Activate the PDB

Open and save the state of the PDB (to ensure the PDB opens automatically after a restart) :
```bash
ALTER PLUGGABLE DATABASE UCL_STATS OPEN;
ALTER PLUGGABLE DATABASE UCL_STATS SAVE STATE;
```
Then, verify the database is open :
```bash
SELECT NAME, OPEN_MODE FROM V$PDBS;
```
You should be able to see 'READ WRITE' under UCL_STATS.

Then, verify the file locations you provided : 
```bash
SELECT NAME FROM V$DATAFILE WHERE CON_ID = (SELECT CON_ID FROM V$PDBS WHERE NAME = 'UCL_STATS');
```

## Connect to the PDB
### From the Terminal :
First, change the current container to you PDB :
```bash
ALTER SESSION SET CONTAINER = UCL_STATS;
```
Then, verify :
```bash
SHOW CON_NAME;
```
It should display UCL_STATS.

Give all the privileges to ldc (in order to create the tables and everything) :
```bash
GRANT ALL PRIVILEGES TO ldc;
GRANT UNLIMITED TABLESPACE TO ldc;
```

If you want to connect to the PDB as ldc from the terminal :
```bash
CONNECT ldc/motdepasse@localhost:1521/UCL_STATS
```
But it's better to do it from SQLdeveloper to run the scripts and etc.
### From SQLdeveloper :
Create a new connection :
- Name : **UCL_STATS**
- username : **ldc**
- password : **motdepasse**
- host : **localhost**
- port : **1521**
- Service Name (check) : **UCL_STATS**
Test the connection and connect if success.
