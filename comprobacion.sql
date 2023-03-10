-- ejercicio 8

DECLARE
  v_id CHAR(5);
BEGIN   
  v_id := bibliotk.alta_obra('Historias del DIM45', 2022);
  dbms_output.put_line('Obra dada de ALTA: ' || v_id);
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

select * from obra;