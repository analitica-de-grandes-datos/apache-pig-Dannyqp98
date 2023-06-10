/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.tsv
data = LOAD 'data.tsv' AS (letter:chararray, date:chararray, value:int);

-- Ordena los datos por la tercera columna en orden ascendente
sorted_data = ORDER data BY value ASC;

-- Limita los resultados a los cinco valores más pequeños
limited_data = LIMIT sorted_data 5;

-- Proyecta solo el valor (tercera columna)
result = FOREACH limited_data GENERATE value;

-- Escribe el resultado en la carpeta output
STORE result INTO 'output' USING PigStorage(',');