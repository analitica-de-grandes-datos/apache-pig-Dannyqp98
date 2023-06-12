/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga los datos desde el archivo data.csv
data = LOAD 'data.csv' USING PigStorage(',') AS (id:int, firstname:chararray, lastname:chararray, birthday:chararray, color:chararray, quantity:int);

-- Extrae el segundo grupo capturado por la expresión regular
extractedData =  FOREACH data GENERATE REGEX_EXTRACT(birthday, '(....)-(..)-(..)', 2) AS extracted_birthday;

-- Guarda el resultado en la carpeta 'output'
STORE extractedData INTO 'output' USING PigStorage(',');
