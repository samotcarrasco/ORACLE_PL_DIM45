CREATE OR REPLACE PACKAGE BiblioTK AS
  FUNCTION alta_obra(p_titulo VARCHAR2, p_año INTEGER DEFAULT NULL) RETURN VARCHAR2;
  FUNCTION borrado_obra(p_id VARCHAR) RETURN INTEGER;
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
    INSERT INTO obra (id, titulo) VALUES (v_id, p_titulo);
    -- Devolver el ID de la nueva obra
    RETURN v_id;
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
    -- Comprobar si existe la obra con el ID proporcionado
    SELECT COUNT(*) INTO v_resultado FROM obra WHERE id = p_id;
    -- Si se encuentra la obra, borrarla
    IF v_resultado > 0 THEN
        DELETE FROM obra WHERE id = p_id;
        v_resultado := 1;
    END IF;
    
    -- Devolver el resultado del borrado (1 si se borra, 0 si no se encuentra el ID)
    RETURN v_resultado;
 END;

 
 END BiblioTK;
 /
 

