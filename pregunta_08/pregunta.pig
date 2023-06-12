/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar los datos del archivo data.tsv
data = LOAD 'data.tsv' AS (col1:chararray, col2:bag{}, col3:map[]);

-- Generar una tabla con la letra de la columna 2 y la clave de la columna 3
table = FOREACH data GENERATE FLATTEN(col2) AS letter, FLATTEN(TOBAG(TOTUPLE(col3))) AS key;
table_keys = FOREACH table GENERATE letter, FLATTEN(key);

--Seleccionar columnas
letter_keys= FOREACH table_keys GENERATE $0 AS letters, $1 AS keys;

-- Agrupar los registros por la combinación de letra y clave
grouped = GROUP letter_keys BY (letters, keys);

-- Contar la cantidad de registros por cada combinación
result = FOREACH grouped GENERATE group AS vals, COUNT(letter_keys) AS count;

-- Guardar el resultado en la carpeta output
STORE result INTO 'output' USING PigStorage(',');
