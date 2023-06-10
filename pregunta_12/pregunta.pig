/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar los datos del archivo data.csv
data = LOAD 'data.csv' USING PigStorage(',') AS (
    id:int, firstName:chararray, lastName:chararray, birthDate:chararray, color:chararray, number:int);

-- Filtrar los apellidos que empiezan con las letras entre 'd' y 'k'
filteredData = FILTER data BY SUBSTRING(lastName, 0, 1) MATCHES '[d-kD-K]';

-- Proyectar solo el apellido correspondiente
out = FOREACH filteredData GENERATE lastName;

-- Guardar el resultado en la carpeta output
STORE out INTO 'output' USING PigStorage();
