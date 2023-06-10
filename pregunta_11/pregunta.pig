/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código que genere la siguiente salida.

   Boyer,BOYER,boyer
   Coffey,COFFEY,coffey
   Conway,CONWAY,conway
   Crane,CRANE,crane
   Diaz,DIAZ,diaz
   Estes,ESTES,estes
   Fry,FRY,fry
   Garrett,GARRETT,garrett
   Guy,GUY,guy
   Hamilton,HAMILTON,hamilton
   Holcomb,HOLCOMB,holcomb
   Jarvis,JARVIS,jarvis
   Kinney,KINNEY,kinney
   Klein,KLEIN,klein
   Knight,KNIGHT,knight
   Noel,NOEL,noel
   Sexton,SEXTON,sexton
   Silva,SILVA,silva

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar los datos del archivo data.csv
data = LOAD 'data.csv' USING PigStorage(',') AS (
    id:int, firstName:chararray, lastName:chararray, birthDate:chararray, color:chararray, number:int);

-- Obtener los apellidos en minúsculas, mayúsculas y originales
out = FOREACH data GENERATE lastName, UPPER(lastName), LOWER(lastName);

-- Ordenar la salida por apellido
sortedOutput = ORDER out BY lastName;

-- Guardar el resultado en la carpeta output
STORE sortedOutput INTO 'output' USING PigStorage(',');
