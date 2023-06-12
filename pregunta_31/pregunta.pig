/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar los datos desde el archivo data.csv
data = LOAD 'data.csv' USING PigStorage(',') AS (id:int, firstname:chararray, lastname:chararray, birthday:chararray, color:chararray, number:int);

-- Obtener el año de nacimiento de cada persona
years = FOREACH data GENERATE SUBSTRING(birthday, 0, 4) AS year;

-- Contar la cantidad de personas por año
count_by_year = GROUP years BY year;
result = FOREACH count_by_year GENERATE group AS year, COUNT(years) AS count;

-- Guardar el resultado en la carpeta output
STORE result INTO 'output' USING PigStorage(',');
