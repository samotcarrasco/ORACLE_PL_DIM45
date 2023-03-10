-- ejercicio 8

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

-- ejercicio 9
DECLARE
  v_resultado INTEGER;
BEGIN   
  v_resultado := bibliotk.borrado_obra('RGEU5');
 IF v_resultado = 1 THEN
    dbms_output.put_line('La obra se ha borrado correctamente');
  ELSE
    dbms_output.put_line('La obra no existe y no se ha podido borrar');
  END IF;
END;
/


-- ejercicio 10
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


select * from autor;
select * from obra;

 --12. La vinculación de un autor a una obra se implementará mediante una función vincular.
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



select * from autor;