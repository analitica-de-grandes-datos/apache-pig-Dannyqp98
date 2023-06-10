/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.tsv
data = LOAD 'data.tsv' AS (col1: chararray, col2: bag{}, col3: chararray);

-- Genera un nuevo registro para cada letra minúscula en la columna 2
expanded_data = FOREACH data GENERATE FLATTEN(col2) AS letter;

-- Filtra las letras que son minúsculas
lowercase_letters = FILTER expanded_data BY letter MATCHES '[a-z]';

-- Agrupa los registros por letra y calcula la cantidad
letter_counts = GROUP lowercase_letters BY letter;
result = FOREACH letter_counts GENERATE group AS letter, COUNT(lowercase_letters) AS count;

-- Guarda el resultado en la carpeta 'output'
STORE result INTO 'output' USING PigStorage(',');
