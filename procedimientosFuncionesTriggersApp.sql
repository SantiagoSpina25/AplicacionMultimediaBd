-- DELIMITER cambia el delimitador predeterminado a // para evitar que sql se confunda con el ; dentro del procedimiento

DELIMITER //

--  Procedimiento que devuelve el nombre de la pelicula de un usuario (introducido por parametro) dentro de su lista
CREATE PROCEDURE getListaPeliculasPorUsuario(IN usuarioId INT)
BEGIN
    SELECT p.titulo, lv.estado 
    FROM Lista_de_vistos lv
    JOIN Pelicula p ON lv.idPelicula = p.idPelicula
    WHERE lv.idUsuario = usuarioId;
END //

DELIMITER ;


CALL getListaPeliculasPorUsuario(1);

DELIMITER //

-- Procedimiento que devuelve el nombre y el genero de la serie
CREATE PROCEDURE getSeriesYGeneros()
BEGIN
    SELECT s.titulo, g.nombre
    FROM Serie s
    JOIN Serie_Genero sg ON s.idSerie = sg.idSerie
    JOIN Genero g ON sg.idGenero = g.idGenero;
END //

DELIMITER ;

CALL getSeriesYGeneros();


-- -------------------- FUNCIONES --------------------
DELIMITER //
-- funcion que devuelve la cantidad de peliculas por el genero pasado por parametros
CREATE FUNCTION contarPeliculasPorGenero(idGeneroIntroducido INT) 
RETURNS INT
-- hay que indicar READS SQL DATA para indicar a sql que esta funcion realiza solo una lectura
READS SQL DATA
BEGIN
    DECLARE total INT;
    
    SELECT COUNT(*) INTO total 
    FROM pelicula_Genero
    WHERE idGenero = idGeneroIntroducido;

    RETURN total;
END //
DELIMITER ;

SELECT contarPeliculasPorGenero(3);

-- -----------------------

DELIMITER //
-- Esta funcion calcula y devuelve la duracion de una pelicula pero en horas
CREATE FUNCTION duracionEnHoras(idPeliculaIntroducida INT) 
RETURNS DOUBLE(4, 2)
READS SQL DATA
BEGIN
    DECLARE duracion_horas DOUBLE(4, 2);

    SELECT duracion/60 INTO duracion_horas 
    FROM Pelicula
    WHERE idPelicula = idPeliculaIntroducida;
    
    RETURN duracion_horas;
END //

DELIMITER ;

select duracionEnHoras(1);


-- -------------------- TRIGGERS --------------------
DELIMITER //

-- Trigger que guarda los usuarios creados y su fecha de creacion en una tabla
CREATE TRIGGER registrarUsuarioCreado
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO registro_usuarios_creados (nombre, fecha_creacion)
    VALUES (NEW.nombre, SYSDATE());
END //

DELIMITER ;

INSERT INTO usuario VALUES (null, 'prueba','trigger@gmail.com','triggerssss','premium');


DELIMITER //
-- trigger que controla que un usuario no pueda actualizar su tipo de suscripcion de basico a premium sin "autorizacion" y envia un mensaje de error
CREATE TRIGGER validarSuscripcion
BEFORE UPDATE ON Usuario
FOR EACH ROW
BEGIN
    IF NEW.tipo_suscripcion = 'premium' AND OLD.tipo_suscripcion = 'basica' THEN
		-- signal sqlstate 45000 permite generar un error "personalizado" y sirve para detener una operacion, en este caso, la actualizacion de un usuario
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite actualizar a premium sin autorización';
    END IF;
END //

DELIMITER ;

update usuario set tipo_suscripcion='premium' where idUsuario = 2;
