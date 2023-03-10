CREATE OR REPLACE PACKAGE BiblioTK AS
  FUNCTION alta_obra(p_titulo VARCHAR2, p_año INTEGER DEFAULT NULL) RETURN VARCHAR2;
  FUNCTION borrado_obra(p_id VARCHAR) RETURN INTEGER;
  FUNCTION alta_autor(p_nombre VARCHAR, p_apellidos VARCHAR, p_nacimiento DATE DEFAULT NULL) RETURN VARCHAR2;
  FUNCTION borrado_autor(p_id VARCHAR) RETURN INTEGER;
  FUNCTION vincular(p_id_autor VARCHAR, p_id_obra VARCHAR) RETURN INTEGER;
  FUNCTION desvincular(p_id_autor VARCHAR, p_id_obra VARCHAR) RETURN INTEGER;
  FUNCTION alta_edicion(p_id_obra VARCHAR, p_isbn VARCHAR, p_año INTEGER DEFAULT NULL) RETURN VARCHAR2;
  FUNCTION borrado_edicion(p_id VARCHAR) RETURN INTEGER;
  FUNCTION alta_ejemplar(p_id_edicion VARCHAR) RETURN INTEGER;
  FUNCTION borrado_ejemplar(p_id_edicion VARCHAR, p_numero INTEGER) RETURN INTEGER;
  FUNCTION baja_ejemplar(p_id_edicion VARCHAR, p_numero INTEGER) RETURN INTEGER;

END BiblioTK;
/

CREATE OR REPLACE PACKAGE BODY BiblioTK AS

-- 08. El alta de obras se implementará mediante una función alta_obra.
-------------------------------------------------------------------------------
-- efectos: alta de obra con título y año
-- retorno: id asignado
-------------------------------------------------------------------------------
FUNCTION alta_obra(p_titulo VARCHAR2, p_año INTEGER DEFAULT NULL)
 RETURN VARCHAR2 IS 
    v_id obra.id%TYPE;
 BEGIN
    v_id := dbms_random.string('X', 5);
    INSERT INTO obra (id, titulo, año) VALUES (v_id, p_titulo, p_año);
    -- si el insert no devuelve nada devolvemos null, si no, devolvemos el id
    IF SQL%FOUND THEN
        RETURN v_id;
    ELSE 
        RETURN null;
    END IF;
 END;
 

-- 09. El borrado de obras se implementará mediante una función borrado_obra.
-------------------------------------------------------------------------------
-- efectos: borrado de obra por id
-- retorno: 1 si borrado efectuado, 0 si no existe id
-------------------------------------------------------------------------------
FUNCTION borrado_obra(p_id VARCHAR)
 RETURN INTEGER IS
  v_resultado INTEGER;
 BEGIN
    v_resultado := 0;
     DELETE FROM obra WHERE id = p_id;
     IF SQL%FOUND THEN
    v_resultado := 1;
  END IF;
  RETURN v_resultado;
    

 END;

-- 10. El alta de autores se implementará mediante una función alta_autor.
 -------------------------------------------------------------------------------
-- efectos: alta de autor con nombre, apellidos y nacimiento
-- retorno: id asignado
-------------------------------------------------------------------------------
FUNCTION alta_autor(p_nombre VARCHAR, p_apellidos VARCHAR, p_nacimiento DATE DEFAULT NULL)
 RETURN VARCHAR2 IS 
    v_id autor.id%TYPE;
BEGIN
    -- segun la definición de la tabla,los id de los autores don de 4 caracteres
    v_id := dbms_random.string('X', 4);
    INSERT INTO autor (id, nombre, apellidos, nacimiento) VALUES (v_id, p_nombre, p_apellidos, p_nacimiento);
     -- si el insert no devuelve nada devolvemos null, si no, devolvemos el id
    IF SQL%FOUND THEN
        RETURN v_id;
    ELSE 
        RETURN null;
    END IF;
END;

--11. El borrado de autores se implementará mediante una función borrado_autor.
-------------------------------------------------------------------------------
-- efectos: borrado de autor por id
-- retorno: 1 si borrado efectuado, 0 si no existe id
-------------------------------------------------------------------------------
FUNCTION borrado_autor(p_id VARCHAR)
 RETURN INTEGER IS
  v_resultado INTEGER;
 BEGIN
    v_resultado := 0;
       DELETE FROM autor WHERE id = p_id;
        IF SQL%FOUND THEN
        v_resultado := 1;
    END IF;
  RETURN v_resultado;    
 END;
 
 
 --12. La vinculación de un autor a una obra se implementará mediante una función vincular.
-------------------------------------------------------------------------------
-- efectos: vincula un autor a una obra
-- retorno: 1 (siempre)
-------------------------------------------------------------------------------
FUNCTION vincular(p_id_autor VARCHAR, p_id_obra VARCHAR)
 RETURN INTEGER IS
 v_resultado INTEGER := 0;
BEGIN
  INSERT INTO autor_obra (id_autor, id_obra) VALUES (p_id_autor, p_id_obra);
  IF SQL%FOUND THEN
    v_resultado := 1;
  END IF;
  RETURN v_resultado;
END;


--13. La desvinculación de un autor de una obra se implementará mediante una función desvincular.
-------------------------------------------------------------------------------
-- efectos: desvincula un autor de una obra
-- retorno: 1 si desvinculación efectuada, 0 si no existe vínculo
-------------------------------------------------------------------------------

FUNCTION desvincular(p_id_autor VARCHAR, p_id_obra VARCHAR)
RETURN INTEGER IS
  v_resultado INTEGER := 0;
BEGIN
  DELETE FROM autor_obra WHERE id_autor = p_id_autor AND id_obra = p_id_obra;
  IF SQL%FOUND THEN
    v_resultado := 1;
  END IF;
  RETURN v_resultado;
END;


-- 14. El alta de ediciones se implementará mediante una función alta_edicion.
-------------------------------------------------------------------------------
-- efectos: alta de edición con obra, isbn y año
-- retorno: id asignado
-------------------------------------------------------------------------------


FUNCTION alta_edicion(p_id_obra VARCHAR, p_isbn VARCHAR, p_año INTEGER DEFAULT NULL)
RETURN VARCHAR2 IS
  v_id_edicion edicion.id%TYPE;
BEGIN
  -- los ids de las ediciones tinenen 6 caractres
  v_id_edicion := dbms_random.string('X', 6);
  --dbms_output.put_line(v_id_edicion);
  INSERT INTO edicion (id, id_obra, isbn, año) VALUES (v_id_edicion, p_id_obra, p_isbn, p_año);
 IF SQL%FOUND THEN
        RETURN v_id_edicion;
    ELSE 
        RETURN null;
    END IF;
END;

-- 15. El borrado de ediciones se implementará mediante una función borrado_edicion.
-------------------------------------------------------------------------------
-- efectos: borrado de edición por id
-- retorno: 1 si borrado efectuado, 0 si no existe id
-------------------------------------------------------------------------------

FUNCTION borrado_edicion(p_id VARCHAR)
 RETURN INTEGER IS
  v_resultado INTEGER;
 BEGIN
    v_resultado := 0;
       DELETE FROM edicion WHERE id = p_id;
        IF SQL%FOUND THEN
        v_resultado := 1;
    END IF;
  RETURN v_resultado;    
 END;




--16, 17 y 18. El alta de ejemplares se implementará mediante una función alta_ejemplar.
-------------------------------------------------------------------------------
-- efectos: alta de ejemplar con id_edicion
-- retorno: número asignado, -1 si no existe id_edicion.
-------------------------------------------------------------------------------
FUNCTION alta_ejemplar(p_id_edicion VARCHAR)
RETURN INTEGER IS
  v_contador INTEGER;
  v_max_ejemplares INTEGER;
  v_resultado INTEGER;
BEGIN
    -- Verifficamos si la edición existe
  SELECT COUNT(*) INTO v_contador
  FROM edicion
  WHERE id = p_id_edicion;
  
  IF v_contador = 0 THEN
    v_resultado := -1;
  ELSE
    SELECT MAX(numero) INTO v_max_ejemplares
    FROM ejemplar
    WHERE id_edicion = p_id_edicion;
    
    -- si no hay ejemplares, al maximo le asignamos el 0
    IF v_max_ejemplares IS NULL 
    THEN v_max_ejemplares := 0;
    END IF;
    
       -- ponemos la fecha de hoy, no puede ser nulo
    INSERT INTO ejemplar (id_edicion, numero, alta) VALUES (p_id_edicion,v_max_ejemplares + 1, sysdate);
    IF SQL%FOUND THEN
        v_resultado := v_max_ejemplares+1;
    ELSE v_resultado := NULL;    
    END IF;
  END IF;
  
  RETURN v_resultado;
END;


--21. Sólo se podrá borrar un ejemplar si es el último de su serie, no tiene fecha de baja y además no
--han pasado más de 30 días desde la fecha de alta.
--22. El borrado de ejemplares se implementará mediante una función borrado_ejemplar.
-------------------------------------------------------------------------------
-- efectos: borrado de ejemplar por id_edicion y número
-- retorno: 1 si borrado efectuado (cumpliendo cláusula 21),
-- 0 borrado no efectuado (no existe el ejemplar indicado)
-- -1 borrado no efectuado (existe pero no cumple la cláusula 21)
-------------------------------------------------------------------------------

FUNCTION borrado_ejemplar(p_id_edicion VARCHAR, p_numero INTEGER)
 RETURN INTEGER IS
  v_ultimo ejemplar.numero%TYPE;
  v_resultado INTEGER := 0;
  v_dias INTEGER;
  v_exite_numero BOOLEAN := FALSE;
  v_contador INTEGER;
  
BEGIN
  --  dbms_output.put_line('borrando ejemplar '||p_numero||' de la edicion ' || p_id_edicion);
  SELECT COUNT(*) INTO v_contador 
  FROM ejemplar
  WHERE id_edicion = p_id_edicion and p_numero = numero;
  
  IF v_contador > 0 THEN 
    v_exite_numero := TRUE;
  END IF;
  

  --IF (v_ultimo IS NULL or p_numero <> v_ultimo OR v_numero IS NULL) THEN   
  IF (v_exite_numero = FALSE) THEN   
     v_resultado :=  0;
  ELSE 
     SELECT MAX(numero) INTO v_ultimo
       FROM ejemplar
     WHERE id_edicion = p_id_edicion;
  
    SELECT TRUNC(sysdate - alta) INTO v_dias
    FROM ejemplar
    WHERE id_edicion = p_id_edicion AND numero = p_numero;
    
    IF (v_dias <= 30) AND (v_ultimo = p_numero) THEN
      DELETE FROM ejemplar WHERE id_edicion = p_id_edicion AND numero = p_numero;
      v_resultado := 1;
    ELSE
      v_resultado := -1;
    END IF;
  END IF;
  RETURN v_resultado;

END;



--23. La baja de un ejemplar consistirá en establecer la fecha de baja, y su aplicación será reflejar que
--éste ha sido retirado del sistema por deterioro o extravío.
--24. La operación de baja no requiere especificar la fecha, porque se utilizará la del sistema.
--25. Sólo se podrá dar de baja un ejemplar si no tiene fecha de baja.
--26. La baja de ejemplares se implementará mediante una función baja_ejemplar.
-------------------------------------------------------------------------------
-- efectos: baja de ejemplar por id_edicion y número
-- retorno: 1 si baja efectuada (cumpliendo la cláusula 25)
-- 0 baja no efectuada (no existe el ejemplar indicado)
-- -1 baja no efectuada (existe pero no cumple la cláusula 25)
-------------------------------------------------------------------------------
FUNCTION baja_ejemplar(p_id_edicion VARCHAR, p_numero INTEGER)
 RETURN INTEGER IS
    v_resultado INTEGER := 0;
    v_contador INTEGER;
    v_exite_numero BOOLEAN := FALSE;
    v_fecha_baja ejemplar.baja%TYPE;
BEGIN
    -- Verificamos si el ejemplar existe 
    SELECT COUNT(*) INTO v_contador
    FROM ejemplar
    WHERE id_edicion = p_id_edicion AND numero = p_numero;
        
    IF v_contador > 0 THEN 
       v_exite_numero := TRUE;
    END IF;
        
      IF (v_exite_numero = FALSE) THEN   
         v_resultado :=  0;
      ELSE 
      
      SELECT baja INTO v_fecha_baja  FROM ejemplar
        WHERE id_edicion = p_id_edicion
        AND numero = p_numero;
  
       IF v_fecha_baja IS NULL THEN
        UPDATE ejemplar
        SET baja = SYSDATE
        WHERE id_edicion = p_id_edicion
            AND numero = p_numero;
            v_resultado := 1;
        ELSE
        v_resultado := -1;
        END IF;
        
    END IF;
  
    RETURN v_resultado;
END;

END BiblioTK;
 
 
 
 /
 

