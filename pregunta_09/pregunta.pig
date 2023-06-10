/*
Pregunta
===========================================================================

Para el archivo `data.csv` escriba una consulta en Pig que genere la 
siguiente salida:

  Vivian@Hamilton
  Karen@Holcomb
  Cody@Garrett
  Roth@Fry
  Zoe@Conway
  Gretchen@Kinney
  Driscoll@Klein
  Karyn@Diaz
  Merritt@Guy
  Kylan@Sexton
  Jordan@Estes
  Hope@Coffey
  Vivian@Crane
  Clio@Noel
  Hope@Silva
  Ayanna@Jarvis
  Chanda@Boyer
  Chadwick@Knight

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar los datos del archivo data.csv
data = LOAD 'data.csv' USING PigStorage(',') AS (
    id:int, firstName:chararray, lastName:chararray, birthDate:chararray, color:chararray, number:int);

-- Generar la salida requerida
out = FOREACH data GENERATE CONCAT(firstName, '@', lastName) AS fullName;

-- Guardar el resultado en la carpeta output
STORE out INTO 'output' USING PigStorage();
