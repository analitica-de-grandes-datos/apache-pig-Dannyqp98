/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/

-- Carga el archivo data.tsv
data = LOAD 'data.tsv' AS (letter:chararray, date:chararray, value:int);

-- Ordena los datos por letra y valor
sorted_data = ORDER data BY letter, value;

-- Genera el resultado separado por comas
result = FOREACH sorted_data GENERATE letter, date,(chararray)value AS numero;

-- Escribe el resultado en la carpeta output
STORE result INTO 'output' USING PigStorage(',');
