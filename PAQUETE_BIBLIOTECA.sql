CREATE OR REPLACE PACKAGE BiblioTK AS
  FUNCTION alta_obra(p_titulo VARCHAR2, p_año INTEGER DEFAULT NULL) RETURN VARCHAR2;
  FUNCTION borrado_obra(p_id VARCHAR) RETURN INTEGER;
  FUNCTION alta_autor(p_nombre VARCHAR, p_apellidos VARCHAR, p_nacimiento DATE DEFAULT NULL) RETURN VARCHAR2;
  FUNCTION borrado_autor(p_id VARCHAR) RETURN INTEGER;
  FUNCTION vincular(p_id_autor VARCHAR, p_id_obra VARCHAR) RETURN INTEGER;
  FUNCTION desvincular(p_id_autor VARCHAR, p_id_obra VARCHAR) RETURN INTEGER;


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
    v_id CHAR(5);
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
    v_id CHAR(4);
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




END BiblioTK;
 
 
 
 /
 

