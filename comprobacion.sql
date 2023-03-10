/*

AUTOR: TOMÁS CARRASCO DEL REY
DESCRIPCIÓN: Comprobación de las funciones del PKG Bibliotk

IMPORTANTE: IR EJECUTANDO PASO A PASO Y COMPRAR CON SELECT LOS RESULTADOS

*/



-- 08. El alta de obras se implementará mediante una función alta_obra.


DECLARE
  v_id CHAR(5);
BEGIN   
  v_id := bibliotk.alta_obra('Historias del DIM45', '2023');

  IF v_id IS NOT NULL THEN
    dbms_output.put_line('La obra '||v_id||' se ha dado de alta correctamente');
  ELSE
    dbms_output.put_line('La obra no se ha dado de alta');
  END IF;
  
END;
/

select * from obra;



--09. El borrado de obras se implementará mediante una función borrado_obra.
DECLARE
  v_resultado INTEGER;
BEGIN   
  v_resultado := bibliotk.borrado_obra('ARSJT');
 IF v_resultado = 1 THEN
    dbms_output.put_line('La obra se ha borrado correctamente');
  ELSE
    dbms_output.put_line('La obra no existe o no se ha podido borrar');
  END IF;
END;
/



select * from autor;

-- 10. El alta de autores se implementará mediante una función alta_autor.
DECLARE
  v_id CHAR(5);
BEGIN   
  v_id := bibliotk.alta_autor('TOMAS', 'PEREZ', (TO_DATE('01-01-1990', 'DD-MM-YYYY')));
  IF v_id IS NOT NULL THEN
    dbms_output.put_line('El autor '||v_id||' se ha dado de alta correctamente');
  ELSE
    dbms_output.put_line('El autor no se ha dado de alta');
  END IF;
  
END;
/

-- 11. El borrado de autores se implementará mediante una función borrado_autor.
DECLARE
  v_resultado INTEGER;
BEGIN   
  v_resultado := bibliotk.borrado_autor('YXEZ');
 IF v_resultado = 1 THEN
    dbms_output.put_line('El autor se ha borrado correctamente');
  ELSE
    dbms_output.put_line('El autor no existe o no se ha podido borrar');
  END IF;
END;
/

select * from autor;
select * from obra;

 -- 12. La vinculación de un autor a una obra se implementará mediante una función vincular.
DECLARE
  v_resultado INTEGER;
BEGIN   
  v_resultado := bibliotk.vincular('GX8S','AX87N');
 IF v_resultado = 1 THEN
    dbms_output.put_line('El autor y la obra se han vinculado');
  ELSE
    dbms_output.put_line('No se han podido vincular');
  END IF;
END;
/



select * from autor_obra;


--13. La desvinculación de un autor de una obra se implementará mediante una función desvincular.
DECLARE
  v_resultado INTEGER;
BEGIN   
  v_resultado := bibliotk.desvincular('GX8S','AX87N');
 IF v_resultado = 1 THEN
    dbms_output.put_line('El autor y la obra se han desvinculado');
  ELSE
    dbms_output.put_line('No se han podido desvincular');
  END IF;
END;
/

select * from obra;
SELeCT * from edicioN;

--14. El alta de ediciones se implementará mediante una función alta_edicion.

DECLARE
  v_id_edicion CHAR(6);
BEGIN
  v_id_edicion := bibliotk.alta_edicion('LY2TI', 'ISBN-123', 2022);
    IF v_id_edicion IS NOT NULL THEN
    dbms_output.put_line('Nueva edición dada de alta con ID: ' || v_id_edicion);
  ELSE
    dbms_output.put_line( 'La edicion no se ha podido dar de alta');
  END IF;
END;

delete  from edicion;

-- 15. El borrado de ediciones se implementará mediante una función borrado_edicion.
    DECLARE
      v_resultado INTEGER;
    BEGIN   
      v_resultado := bibliotk.borrado_edicion('ELEP92');
     IF v_resultado = 1 THEN
        dbms_output.put_line('La edición se ha eliminado');
      ELSE
        dbms_output.put_line('La edición no existe o no se ha podido eliminar');
      END IF;
    END;
    /

 select * from edicion;   
 
  select * from ejemplar;   
  delete from ejemplar;
    
--16. El alta de ejemplares se implementará mediante una función alta_ejemplar.

DECLARE
  v_id CHAR(6);
BEGIN   
  v_id := bibliotk.alta_ejemplar('KNB2FU');
  IF v_id = -1 THEN
    dbms_output.put_line('La edición no existe, no se puede dar de alta el ejemplar');
  ELSE 
    IF v_id IS NULL THEN
        dbms_output.put_line('El ejemplar no se ha dado de alta correctamente');
    ELSE dbms_output.put_line('El ejemplar '||v_id||' se ha dado de alta correctamente');
    END IF;
  END IF;
  
END;


select * from ejemplar;

--21. Sólo se podrá borrar un ejemplar si es el último de su serie, no tiene fecha de baja y además no
--han pasado más de 30 días desde la fecha de alta.
--22. El borrado de ejemplares se implementará mediante una función borrado_ejemplar.

 DECLARE
      v_resultado INTEGER;
    BEGIN   
      v_resultado := bibliotk.borrado_ejemplar('KNB2FU',12);
     IF v_resultado = 1 THEN
        dbms_output.put_line('El ejemplar se ha eliminado');
      ELSE
        IF v_resultado = 0 THEN
            dbms_output.put_line('El ejemplar no existe en la edición seleccionada');
        ELSE
            IF v_resultado = -1 THEN
            dbms_output.put_line('El ejemplar existe pero no cumple los reguisitos para el borrado. No se ha borrado');
        END IF;
      END IF;
      END IF;
    END;
    /

select * from ejemplar;



--23. La baja de un ejemplar consistirá en establecer la fecha de baja, y su aplicación será reflejar que
--éste ha sido retirado del sistema por deterioro o extravío.
--24. La operación de baja no requiere especificar la fecha, porque se utilizará la del sistema.
--25. Sólo se podrá dar de baja un ejemplar si no tiene fecha de baja.
--26. La baja de ejemplares se implementará mediante una función baja_ejemplar.


DECLARE
  v_resultado INTEGER;
BEGIN   
  v_resultado := bibliotk.baja_ejemplar('KNB2FU', 5);
 
  IF v_resultado = 1 THEN
    dbms_output.put_line('La baja del ejemplar se ha efectuado');
  ELSIF v_resultado = 0 THEN
    dbms_output.put_line('El ejemplar no existe y no se ha podido dar de baja');
  ELSE
    dbms_output.put_line('El ejemplar ya tiene fecha de baja');
  END IF;
END;
/

select * from ejemplar;
--comprobamos que hay fecha de baja;




