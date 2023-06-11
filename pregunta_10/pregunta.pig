/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar los datos del archivo data.csv
data = LOAD 'data.csv' USING PigStorage(',') AS (
    id:int, firstName:chararray, lastName:chararray, birthDate:chararray, color:chararray, number:int);

-- Obtener la longitud de cada apellido
lastNameLength = FOREACH data GENERATE lastName, STRSPLIT(lastName, '') AS chars;
lastNameWithLength = FOREACH lastNameLength GENERATE lastName, SIZE(chars) AS length;

-- Ordenar la relación por longitud y apellido
sortedData = ORDER lastNameWithLength BY length DESC, lastName;

-- Generar la salida requerida
out = LIMIT sortedData 5;

-- Guardar el resultado en la carpeta output
STORE out INTO 'output' USING PigStorage(',');
