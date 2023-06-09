/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',') AS (id: int, firstname: chararray, lastname: chararray, birthday: chararray, color: chararray, quantity: int);

formatted_result = FOREACH data GENERATE birthday, ToDate(birthday, 'yyyy-MM-dd') AS date;
result = FOREACH formatted_result GENERATE ToString(date, 'yyyy-MM-dd') AS formatted_date, ToString(date, 'dd') AS day, ToString(date, 'd') AS day_number, ToString(date, 'EEE') AS weekday_short, ToString(date, 'EEEE') AS weekday_full;
rep_result = FOREACH result GENERATE formatted_date, day, day_number, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(weekday_short,'Mon','lun')
,'Tue','mar')
,'Wed','mie')
,'Thu','jue')
,'Fri','vie')
,'Sat','Sab')
,'Sun','dom'),
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(weekday_full,'Monday','lunes')
,'Tuesday','martes')
,'Wednesday','miercoles')
,'Thursday','jueves')
,'Friday','viernes')
,'Saturday','Sabado')
,'Sunday','domingo') AS Full_name_day;

STORE rep_result INTO 'output' USING PigStorage(',');
