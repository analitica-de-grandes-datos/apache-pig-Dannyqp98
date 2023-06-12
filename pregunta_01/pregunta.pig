/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/


-- Carga los datos desde el archivo data.tsv
data = LOAD 'data.tsv' AS (letter:chararray, date:chararray, value:int);

-- Agrupa los datos por letra y cuenta los registros
grouped_data = GROUP data BY letter;
result = FOREACH grouped_data GENERATE group AS letter, COUNT(data) AS count;

-- Guarda el resultado en un archivo de salida
STORE result INTO 'output' USING PigStorage(',');
