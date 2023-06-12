/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- Cargar los datos desde el archivo data.tsv
data = LOAD 'data.tsv' USING PigStorage('\t') AS (col1: chararray, col2: chararray, col3: map[]);

-- Dividir la columna 3 en claves individuales
split_data = FOREACH data GENERATE FLATTEN(col3) AS key;

--llaves
keys_vals= FOREACH split_data GENERATE $0;

-- Generar grupos por clave y contar los registros en cada grupo
grouped_data = GROUP keys_vals BY key;
result = FOREACH grouped_data GENERATE group AS key, COUNT(keys_vals) AS count;

-- Escribir el resultado en la carpeta output
STORE result INTO 'output' USING PigStorage(',');