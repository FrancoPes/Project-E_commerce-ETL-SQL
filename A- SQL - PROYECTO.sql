#creacion de la empresa
create database empresa_practica_sql;
use empresa_practica_sql;

#creacion de sus tablas 
CREATE TABLE IF NOT EXISTS venta (
  IdVenta				INTEGER,
  Fecha 				DATE NOT NULL,
  Fecha_Entrega 		DATE NOT NULL,
  IdCanal				INTEGER, 
  IdCliente			INTEGER, 
  IdSucursal			INTEGER,
  IdEmpleado			INTEGER,
  IdProducto			INTEGER,
  Precio				VARCHAR(30),
  Cantidad			VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE empleado (
	IDEmpleado					INTEGER,
	Apellido					VARCHAR(100),
	Nombre						VARCHAR(100),
	Sucursal					VARCHAR(50),
	Sector						VARCHAR(50),
	Cargo						VARCHAR(50),
	Salario2					VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE  cliente (
	ID					INTEGER,
	Provincia			VARCHAR(50),
	Nombre_y_Apellido	VARCHAR(80),
	Domicilio			VARCHAR(150),
	Telefono			VARCHAR(30),
	Edad				VARCHAR(5),
	Localidad			VARCHAR(80),
	X					VARCHAR(30),
	Y					VARCHAR(30),
	col10				VARCHAR(1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE  tipo_gasto (
  IdTipoGasto int(11) NOT NULL AUTO_INCREMENT,
  Descripcion varchar(100) NOT NULL,
  Monto_Aproximado DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (IdTipoGasto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE canal_venta (
  IdCanal				INTEGER,
  Canal 				VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE compra (
  IdCompra			INTEGER,
  Fecha 				DATE,
  IdProducto			INTEGER,
  Cantidad			INTEGER,
  Precio				DECIMAL(10,2),
  IdProveedor			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE  gasto (
  	IdGasto 		INTEGER,
  	IdSucursal 	INTEGER,
  	IdTipoGasto 	INTEGER,
    Fecha			DATE,
  	Monto 		DECIMAL(10,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


CREATE TABLE  proveedor (
	IDProveedor		INTEGER,
	Nombre			VARCHAR(80),
	Domicilio		VARCHAR(150),
	Ciudad			VARCHAR(80),
	Provincia		VARCHAR(50),
	Pais			VARCHAR(20),
	Departamento	VARCHAR(80)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


CREATE TABLE producto (
	IDProducto					INTEGER,
	Concepto					VARCHAR(100),
	Tipo						VARCHAR(50),
	Precio2						VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


CREATE TABLE calendario (
        id                      INTEGER PRIMARY KEY,  
        fecha                 	DATE NOT NULL,
        anio                    INTEGER NOT NULL,
        mes                   	INTEGER NOT NULL, 
        dia                     INTEGER NOT NULL, 
        trimestre               INTEGER NOT NULL,
        semana                  INTEGER NOT NULL, 
        dia_nombre              VARCHAR(9) NOT NULL,
        mes_nombre              VARCHAR(9) NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE sucursal (
	ID			INTEGER,
	Sucursal	VARCHAR(40),
	Domicilio	VARCHAR(150),
	Localidad	VARCHAR(80),
	Provincia	VARCHAR(50),
	Latitud2	VARCHAR(30),
	Longitud2	VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

# Importacion de datos apartir de csv
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\gasto.csv' 
INTO TABLE `gasto` 
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\compra.csv' 
INTO TABLE `compra` 
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\venta.csv' 
INTO TABLE `venta` 
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

ALTER TABLE `empresa_practica_sql`.`venta` 
CHANGE COLUMN `IdVenta` `IdVenta` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdVenta`);
;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CanalDeVenta.csv' 
INTO TABLE `canal_venta` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\TiposDeGasto.csv' 
INTO TABLE `tipo_gasto` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Cliente.csv'
INTO TABLE cliente
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Proveedor.csv' 
INTO TABLE proveedor
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Producto.csv' 
INTO TABLE `producto` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Empleado.csv' 
INTO TABLE empleado
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Sucursal.csv' 
INTO TABLE sucursal
FIELDS TERMINATED BY ';' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

#---------------------------------------------------------------------------------------------------------------------------------------
# PROCESO DE LIMPIEZA DE LOS DATOS Y NORMALIZACION
#PASO 1) NORMALIZAMOS LOS NOMBRES DE LOS CAMPOS. EN OTRAS PALABRAS, TRATAMOS DE MANTENER UNA CONSISTENCIA ENTRE LOS CAMPOS DE TODAS LAS TABLAS
# POR EJEMPLO, VAMOS A LLAMAR 'Id' SEGUIDO DEL NOMBRE DE LA TABLA, A TODAS LAS PK DE TODAS LAS TABLAS
# ADEMAS, PONDREMOS UN NOMBRE ACORDE A TODAS LAS COLUMNAS


ALTER TABLE sucursal CHANGE ID IdSucursal INT(11) NULL DEFAULT NULL;

ALTER TABLE `tipo_gasto` CHANGE `Descripcion` `Tipo_Gasto` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;

ALTER TABLE `producto` CHANGE `IDProducto` `IdProducto` INT(11) NULL DEFAULT NULL;

ALTER TABLE `producto` CHANGE `Concepto` `Producto` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NULL DEFAULT NULL;

ALTER TABLE `empresa_practica_sql`.`empleado` 
CHANGE COLUMN `ID_empleado` `Idempleado` INT NULL DEFAULT NULL ;

aLTER TABLE `empresa_practica_sql`.`proveedor` 
CHANGE COLUMN `Departamento` `Localidad` VARCHAR(80) NULL DEFAULT NULL ;

aLTER TABLE `empresa_practica_sql`.`CLIENTE` 
CHANGE COLUMN `ID` `Idcliente` VARCHAR(80) NULL DEFAULT NULL ;

ALTER TABLE `empresa_practica_sql`.`proveedor` 
CHANGE COLUMN `Departamento` `Localidad` VARCHAR(80) NULL DEFAULT NULL ;

SELECT * FROM EMPLEADO;
SELECT * FROM SUCURSAL;
SELECT * FROM GASTO;
SELECT * FROM PROVEEDOR;
SELECT * FROM PRODUCTO;
SELECT * FROM CLIENTE;
SELECT * FROM canal_venta;
SELECT * FROM calendario;
SELECT * FROM venta;
SELECT * FROM tipo_gasto;

#---------------------------------------------------------------------------------------------------------------------------------------
# PROCESO DE LIMPIEZA DE LOS DATOS Y NORMALIZACION
#PASO 2) DESCARTAR COLUMNAS QUE NO TENGAS RELEVANCIA

ALTER TABLE `empresa_practica_sql`.`empleado` 
DROP COLUMN `MyUnknownColumn`;

ALTER TABLE `cliente` DROP `col10`;

#---------------------------------------------------------------------------------------------------------------------------------------
# PROCESO DE LIMPIEZA DE LOS DATOS Y NORMALIZACION
#PASO 3) VERIFICAR Y CAMBIAR LOS TIPOS DE DATOS NUMERICOS. SI LOS MISMOS ESTASN ESCRITOS CORRECTAMENTE
#EN LATITUD Y LONGITUD DE LA TABLA CLIENTES, DEBEMOS CAMBIAR PUNTOS POR COMA
#ESTO SE HACE CON LA FUNCION REPLACE

#PRIMERO CAMBIAMOS EL NOMBRE, EN VEZ DE LLAMARLOS X Y, LOS LAMMAMOS LATITUD Y LONGITUD

ALTER TABLE `empresa_practica_sql`.`cliente` 
CHANGE COLUMN `X` `Longitud` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `Y` `Latitud` VARCHAR(30) NULL DEFAULT NULL ;

                        
#CUANDO HAY UN VALOR EN BLANCO(BLANK), VAMOS A PONER UN CERO
UPDATE cliente SET Latitud = 0 WHERE Latitud = '';
UPDATE cliente SET Longitud = 0 WHERE Longitud = '';

# EN LAS COLUMNAS LATITUD Y LONGITUD
UPDATE `cliente` SET Latitud = REPLACE(Latitud,',','.');      #EL PRIMERO ARGUMENTO EN LA COLUMNA QUE QUIERO MODIFICA, EL SEGUNDO ES QUE QUIERO Y EL TERCERO POR CUAL
UPDATE `cliente` SET Longitud = REPLACE(Longitud,',','.');   

#Cambiamos el tipo de dato de latitud y longitud
ALTER TABLE `empresa_practica_sql`.`cliente` 
CHANGE COLUMN `Longitud` `Longitud` DECIMAL(10,2) NULL DEFAULT NULL ,
CHANGE COLUMN `Latitud` `Latitud` DECIMAL(10,2) NULL DEFAULT NULL ;


#hacemos lo mismo pero con sucursal
UPDATE sucursal SET Latitud = 0 WHERE Latitud = '';
UPDATE sucursal SET longitud = 0 WHERE longitud = '';

#Reemplazamos punto por coma
UPDATE `sucursal` SET Latitud = REPLACE(Latitud,',','.');      
UPDATE `sucursal` SET Longitud = REPLACE(longitud,',','.');

#cambiamos el tipo de dato
ALTER TABLE `empresa_practica_sql`.`sucursal` 
CHANGE COLUMN `Latitud` `Latitud` INT NULL DEFAULT NULL ,
CHANGE COLUMN `Longitud` `Longitud` INT NULL DEFAULT NULL ;

#lo mismo con la tabla empleado 
 UPDATE empleado SET salario = 0 WHERE salario = '';


#---------------------------------------------------------------------------------------------------------------------------------------
# LIMPIEZA DE LOS DATOS Y NORMALIZACION
#PASO 4) NORMALIZAR LAS COLUMNAS Y COLOVAR UN VALOR A LAS QUE NO TIENEN DATO ('SIN DATO').

#de momento, colocamos 'sin datos' a los valores faltantes
UPDATE `cliente` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);  #USAMOS TRIM PARA CORTAR VALORES VACIOS
UPDATE `cliente` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);
UPDATE `cliente` SET Nombre_y_Apellido = 'Sin Dato' WHERE TRIM(Nombre_y_Apellido) = "" OR ISNULL(Nombre_y_Apellido);
UPDATE `cliente` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);

UPDATE `empleado` SET Apellido = 'Sin Dato' WHERE TRIM(Apellido) = "" OR ISNULL(Apellido);
UPDATE `empleado` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `empleado` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `empleado` SET Sector = 'Sin Dato' WHERE TRIM(Sector) = "" OR ISNULL(Sector);
UPDATE `empleado` SET Cargo = 'Sin Dato' WHERE TRIM(Cargo) = "" OR ISNULL(Cargo);

UPDATE `producto` SET Producto = 'Sin Dato' WHERE TRIM(Producto) = "" OR ISNULL(Producto);
UPDATE `producto` SET Tipo = 'Sin Dato' WHERE TRIM(Tipo) = "" OR ISNULL(Tipo);

UPDATE `proveedor` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `proveedor` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `proveedor` SET Ciudad = 'Sin Dato' WHERE TRIM(Ciudad) = "" OR ISNULL(Ciudad);
UPDATE `proveedor` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `proveedor` SET Pais = 'Sin Dato' WHERE TRIM(Pais) = "" OR ISNULL(Pais);
UPDATE `proveedor` SET localidad = 'Sin Dato' WHERE TRIM(localidad) = "" OR ISNULL(localidad);

UPDATE `sucursal` SET Direccion = 'Sin Dato' WHERE TRIM(Direccion) = "" OR ISNULL(Direccion);
UPDATE `sucursal` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `sucursal` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `sucursal` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);



# A LA TABLA VENTAS, TENEMOS QUE DARLE ESPECIAL ATENCION, YA QUE LOS VALORES FALTANTES DE PRECIO Y CANTIDAD SON PREOCUPANTES
#CON LO CUAL, LO OPTIMO SERIA COPIAR ESOS VALORES FALTANTES (PRECIO O CANTIDAD) A UNA tabla auxiliar para un estudio minusioso posteriormente

CREATE TABLE   `aux_venta` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCliente`			INTEGER, 
  `IdSucursal`			INTEGER,
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				FLOAT,
  `Cantidad`			INTEGER,
  `Motivo`				INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

UPDATE venta SET Cantidad = REPLACE(Cantidad, '\r', '');



#INSERTAMOS LOS VALORES EN LA AUXILIAR APARTIR DE UNA CONSULTA

INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM venta WHERE precio = '\r' or precio is null; 


UPDATE venta SET Cantidad = '1' WHERE Cantidad = '\r' or Cantidad is null;

#Cambiamos el tipo de dato en cantidad a entero
ALTER TABLE `empresa_practica_sql`.`venta` 
CHANGE COLUMN `Cantidad` `Cantidad` INT NULL DEFAULT 0 ;


#---------------------------------------------------------------------------------------------------------------------------------------
# LIMPIEZA Y NORMALIZACION DE LOS DATOS
# paso 6) usamos una funcion para que los datos empiecen con una letra capital, seguido de minusculas
#para ello se crea la funcion UC_Words
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS `UC_Words`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `UC_Words`( str VARCHAR(255) ) RETURNS varchar(255) CHARSET utf8
BEGIN  
  DECLARE c CHAR(1);  
  DECLARE s VARCHAR(255);  
  DECLARE i INT DEFAULT 1;  
  DECLARE bool INT DEFAULT 1;  
  DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';  
  SET s = LCASE( str );  
  WHILE i < LENGTH( str ) DO  
     BEGIN  
       SET c = SUBSTRING( s, i, 1 );  
       IF LOCATE( c, punct ) > 0 THEN  
        SET bool = 1;  
      ELSEIF bool=1 THEN  
        BEGIN  
          IF c >= 'a' AND c <= 'z' THEN  
             BEGIN  
               SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));  
               SET bool = 0;  
             END;  
           ELSEIF c >= '0' AND c <= '9' THEN  
            SET bool = 0;  
          END IF;  
        END;  
      END IF;  
      SET i = i+1;  
    END;  
  END WHILE;  
  RETURN s;  
END$$
DELIMITER ;


#aplicamos esa funciona  todos los campos que sean texto
UPDATE cliente SET 	Provincia = UC_Words(TRIM(Provincia)),
					Localidad = UC_Words(TRIM(Localidad)),
                    Domicilio = UC_Words(TRIM(Domicilio)),
                    Nombre_y_Apellido = UC_Words(TRIM(Nombre_y_Apellido));
                    
UPDATE sucursal SET Provincia = UC_Words(TRIM(Provincia)),
					Localidad = UC_Words(TRIM(Localidad)),
                    direccion = UC_Words(TRIM(direccion)),
                    Sucursal = UC_Words(TRIM(Sucursal));
					
UPDATE proveedor SET Provincia = UC_Words(TRIM(Provincia)),
					Ciudad = UC_Words(TRIM(Ciudad)),
                    localidad = UC_Words(TRIM(localidad)),
                    Pais = UC_Words(TRIM(Pais)),
                    Nombre = UC_Words(TRIM(Nombre)),
                    Domicilio = UC_Words(TRIM(Domicilio));

UPDATE producto SET Producto = UC_Words(TRIM(Producto)),
					Tipo = UC_Words(TRIM(Tipo));
					
UPDATE empleado SET Sucursal = UC_Words(TRIM(Sucursal)),
                    Sector = UC_Words(TRIM(Sector)),
                    Cargo = UC_Words(TRIM(Cargo)),
                    Nombre = UC_Words(TRIM(Nombre)),
                    Apellido = UC_Words(TRIM(Apellido));

#Revision visual
SELECT * FROM EMPLEADO;
SELECT * FROM SUCURSAL;
SELECT * FROM GASTO;
SELECT * FROM PROVEEDOR;
SELECT * FROM PRODUCTO;
SELECT * FROM CLIENTE;
SELECT * FROM canal_venta;
SELECT * FROM calendario;
SELECT * FROM venta;
SELECT * FROM tipo_gasto;
#---------------------------------------------------------------------------------------------------------------------------------------
# CHEQUEO DE LOS DATOS DE ID
# paso 7) CHEQUEO DE LA COLUMNA ID DE TODAS LOS TABLAS

#
SELECT IdCliente, COUNT(*) FROM cliente GROUP BY IdCliente HAVING COUNT(*) > 1;
SELECT IdSucursal, COUNT(*) FROM sucursal GROUP BY IdSucursal HAVING COUNT(*) > 1;
SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado HAVING COUNT(*) > 1;   #---> CLAVES DUPLICADAS
SELECT IdProveedor, COUNT(*) FROM proveedor GROUP BY IdProveedor HAVING COUNT(*) > 1;
SELECT IdProducto, COUNT(*) FROM producto GROUP BY IdProducto HAVING COUNT(*) > 1;


#cuantas repetidad tiene la columna empleados?

select count(*) from (SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado  HAVING COUNT(*) > 1 ) as t;  #17 
select * from empleado;

#para arreglar la id de los empleados, hacemos una combinacion entre la clave empleado y la id sucursal
#primero traemos idsucursal a empleados
ALTER TABLE `empleado` ADD `IdSucursal` INT NULL DEFAULT '0' AFTER `Sucursal`;

#cambios a tener en cuenta
update empleado set sucursal = 'Mendoza1' where sucursal = 'Mendoza 1';
update empleado set sucursal = 'Mendoza2' where sucursal = 'Mendoza 2';
update empleado set sucursal = 'Cã³rdoba Quiroz' where sucursal = 'Cordoba Quiroz';

#llenamos esa tabla, para ello usamos un join
UPDATE empleado e JOIN sucursal s
	ON (e.Sucursal = s.Sucursal)           #tener en cuenta 
SET e.IdSucursal = s.IdSucursal;

ALTER TABLE `empleado` DROP `Sucursal`;  #---> respetando la 3ra ley de la normalizacion

#anado una nueva columna llamada codigo emplreado
ALTER TABLE `empleado` ADD `CodigoEmpleado` INT NULL DEFAULT '0' AFTER `IdEmpleado`;

UPDATE empleado SET CodigoEmpleado = IdEmpleado;

#el id es igual al id anterior mas idsucursal por un escalar
#CREAMOS UNA CLAVE SUBRROGADA
UPDATE empleado SET IdEmpleado = (IdSucursal * 1000000) + CodigoEmpleado;


SELECT * FROM `empleado`;
SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado HAVING COUNT(*) > 1;   



#para no perder la correlacion entre tablas, modificamos la claveforanea en ventas
UPDATE venta SET IdEmpleado = (IdSucursal * 1000000) + IdEmpleado;

#---------------------------------------------------------------------------------------------------------------------------------------
# PROCESO DE NORMALIZACION DE TABLAS
# paso 8) Normalizamos la tabla de empleados. vamos a usar dos nuevas tablas, cargo y sector
#hacemos lo mismo con productos
CREATE TABLE cargo (
  IdCargo int(11) NOT NULL AUTO_INCREMENT,
  Cargo varchar(50) NOT NULL,
  PRIMARY KEY (`IdCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE sector (
  `IdSector` int(11) NOT NULL AUTO_INCREMENT,
  `Sector` varchar(50) NOT NULL,
  PRIMARY KEY (`IdSector`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

#insertamos los valores en sectores y cargo
#REALIZAMOS UN INSERT APARTIR DE UNA CONSULTA
INSERT INTO cargo (Cargo) SELECT DISTINCT Cargo FROM empleado ORDER BY 1;    ####CHEQUEAR ERROR
INSERT INTO sector (Sector) SELECT DISTINCT Sector FROM empleado ORDER BY 1;  ####CHEQUEAR ERROR


#agregamos a empleado las COLUMNAS idsector e idcargo
ALTER TABLE `empleado` 	ADD `IdSector` INT NOT NULL DEFAULT '0' AFTER `IdSucursal`, 
						ADD `IdCargo` INT NOT NULL DEFAULT '0' AFTER `IdSector`;



SELECT * FROM CARGO;
SELECT * FROM SECTOR;
SELECT * FROM EMPLEADO;

#ACTUALIZAMOS EL IDSECTOr E IDCARGO APARTIR DE UN JOIN 
UPDATE empleado e JOIN cargo c ON (c.Cargo = e.Cargo)   SET e.IdCargo = c.IdCargo ;


select * from empleado;
update empleado set sector = 'Aux. Tecnico' where sector = 'Aux. Tã©cnico';


# normalizamos la tabla producto
ALTER TABLE `producto` ADD `IdTipoProducto` INT NOT NULL DEFAULT '0' AFTER `Precio2`;
DROP TABLE IF EXISTS `tipo_producto`;
CREATE TABLE IF NOT EXISTS `tipo_producto` (
  `IdTipoProducto` int(11) NOT NULL AUTO_INCREMENT,
  `TipoProducto` varchar(50) NOT NULL,
  PRIMARY KEY (`IdTipoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tipo_producto (TipoProducto) SELECT DISTINCT Tipo FROM producto ORDER BY 1;

#actualizamos idtipoproducto con un join
update producto p join tipo_producto t on (p.tipo = t.tipoproducto) set p.idtipoproducto = t.idtipoproducto;


ALTER TABLE `producto`
  DROP `Tipo`;
  
  
    # normalizamos los nombres de las provincias y localidad
  #para ello, reeamplazamos los valores distintos y los transformamos en un unico dato, 
  #y eso lo hacemos de forma IGUAL, tanto en cliente, como proveedor y sucursal
UPDATE `cliente` SET provincia = 'Buenos Aires'
WHERE Provincia IN ('B. Aires',
                            'B.Aires',
                            'Bs As',
                            'Bs.As.',
                            'Buenos Aires',
                            'C Debuenos Aires',
                            'Caba',
                            'Ciudad De Buenos Aires',
                            'Pcia Bs As',
                            'Prov De Bs As.',
                            'Provincia De Buenos Aires');

UPDATE `proveedor` SET provincia = 'Buenos Aires'
WHERE Provincia IN ('B. Aires',
                            'B.Aires',
                            'Bs As',
                            'Bs.As.',
                            'Buenos Aires',
                            'C Debuenos Aires',
                            'Caba',
                            'Ciudad De Buenos Aires',
                            'Pcia Bs As',
                            'Prov De Bs As.',
                            'Provincia De Buenos Aires');


UPDATE `sucursal` SET provincia = 'Buenos Aires'
WHERE Provincia IN ('B. Aires',
                            'B.Aires',
                            'Bs As',
                            'Bs.As.',
                            'Buenos Aires',
                            'C Debuenos Aires',
                            'Caba',
                            'Ciudad De Buenos Aires',
                            'Pcia Bs As',
                            'Prov De Bs As.',
                            'Provincia De Buenos Aires');
                            
UPDATE `proveedor` SET Localidad = 'Capital Federal'
WHERE Localidad IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND Provincia = 'Buenos Aires';

UPDATE `cliente` SET Localidad = 'Capital Federal'
WHERE Localidad IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND provincia = 'Buenos Aires';

UPDATE `sucursal` SET Localidad = 'Capital Federal'
WHERE Localidad IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND provincia = 'Buenos Aires';
  
#introduzco los dastos de provincia y localidad de las 3 tablas
#id provincia lo dejo en cero de modemto
INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT	DISTINCT localidad, provincia, 0
FROM proveedor;

INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT	DISTINCT localidad, provincia, 0
FROM cliente;

INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT	DISTINCT localidad, provincia, 0
FROM sucursal;


select * from localidad group by localidad;

#debo tener un distint de cada localidad en la tabla. con lo cual creo una nueva tabla de localidad
# pero esta vez con distint


CREATE TABLE localidad1 as
(select * from localidad group by localidad);

#BORRAMOS LOCALIDAD Y CONVERTIMOS A LOCALIDAD1 EN LOCALIDAD

DROP TABLE LOCALIDAD;

ALTER TABLE `empresa_practica_sql`.`localidad1` 
RENAME TO  `empresa_practica_sql`.`localidad` ;


#Realizamos lo mismo con provincia

INSERT INTO provincia (Provincia)
SELECT DISTINCT provincia
FROM proveedor;

INSERT INTO provincia (Provincia)
SELECT DISTINCT provincia
FROM cliente;

INSERT INTO provincia (Provincia)
SELECT DISTINCT provincia
FROM sucursal;

#creamos una tabla con solo distints de provincia
CREATE TABLE provincia1 as
(select * from provincia group by provincia);

drop table provincia;
ALTER TABLE `empresa_practica_sql`.`provincia1` 
RENAME TO  `empresa_practica_sql`.`provincia` ;

#A continuacion llevamos a cabo los joins correspondientes
select * from provincia;
select * from localidad;
update localidad l join provincia p on (l.provincia = p.provincia) set l.idprovincia = p.idprovincia;
#normalizamos las tablas cliente, sucursal y proveedor

ALTER TABLE `empresa_practica_sql`.`proveedor` 
ADD COLUMN `idlocalidad` INT NULL AFTER `Localidad`;

ALTER TABLE `empresa_practica_sql`.`cliente` 
ADD COLUMN `idlocalidad` INT NULL AFTER `Localidad`;

ALTER TABLE `empresa_practica_sql`.`sucursal` 
ADD COLUMN `idlocalidad` INT NULL AFTER `Localidad`;

#hacemos los joins de localidad con cada tabla

update cliente c 
join localidad l
on (l.localidad = c.localidad)
set c.idlocalidad = l.idlocalidad;

update proveedor p
join localidad l
on (l.localidad = p.localidad)
set p.idlocalidad = l.idlocalidad;


select * from sucursal; #----> seleccionar problema con collate para normalizar
#eliminamos las columnas redundantes

ALTER TABLE `empresa_practica_sql`.`cliente` 
DROP COLUMN `Localidad`,
DROP COLUMN `Provincia`;

select * from cliente;

ALTER TABLE `empresa_practica_sql`.`proveedor` 
DROP COLUMN `Localidad`,
DROP COLUMN `Provincia`,
DROP COLUMN `Ciudad`,
DROP COLUMN `Pais`;

select * from proveedor;

#--------------------------------------------------------------------------------------------------------------------------------
#Creamos un rango en base a las edades de los clientes, para su posterior uso
ALTER TABLE `cliente` ADD `Rango_Etario` VARCHAR(20) NOT NULL DEFAULT '-' AFTER `Edad`;

UPDATE cliente SET Rango_Etario = '1_Hasta 30 años' WHERE Edad <= 30;
UPDATE cliente SET Rango_Etario = '2_De 31 a 40 años' WHERE Edad <= 40 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '3_De 41 a 50 años' WHERE Edad <= 50 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '4_De 51 a 60 años' WHERE Edad <= 60 AND Rango_Etario = '-';
UPDATE cliente SET Rango_Etario = '5_Desde 60 años' WHERE Edad > 60 AND Rango_Etario = '-';



#---------------------------------------------------------------------------------------------------------------------------------------
# BUSQUEDA DE OUTLIERS Y VALORES INCORRECTOS
#PASO 10) BUSCAMOS OUTLIERS EN PRECIO, YA QUE PUEDEN HABER ERRORES DE TIPEO
use empresa_practica_sql;

#sacamos media, desvio, precio minimo y precio maximo de cada producto y lo dejamos en una nueva tablas
#CREAMOS UNA TABLA QUE SAQUE EL PROMEDIO DE VENTA DE CADA PRODUCTO, SU DESVIEO Y UN RANGO DE 'NORMALIDAD'


#OBTENEMOS EL PROMEDIO, DESVIO Y RANGO PARA CARA CADA PRODUCTO
SELECT P.PRODUCTO as producto, 
P.IDPRODUCTO as idproducto, 
AVG(V.PRECIO) AS PRECIO_PROMEDIO, 
STD(V.PRECIO) as desvio_precio, 
AVG(V.PRECIO) + std(v.precio)*5 as limite_derecho, 
AVG(V.PRECIO) - std(v.precio)*2 as limite_izquierdo  
FROM VENTA V 
JOIN PRODUCTO P ON (V.IDPRODUCTO = P.IDPRODUCTO) 
group by P.IDPRODUCTO;

#CREAMOS UNA TABLA CON LA CONSULTA ANTERIOR
CREATE TABLE aux_venta_outliers as
SELECT P.PRODUCTO as producto, 
P.IDPRODUCTO as idproducto, 
AVG(V.PRECIO) AS PRECIO_PROMEDIO, 
STD(V.PRECIO) as desvio_precio, 
AVG(V.PRECIO) + std(v.precio)*5 as limite_derecho, 
AVG(V.PRECIO) - std(v.precio)*2 as limite_izquierdo  
FROM VENTA V 
JOIN PRODUCTO P ON (V.IDPRODUCTO = P.IDPRODUCTO) 
group by P.IDPRODUCTO;


#VISUALIZAMOS LA TABLA
SELECT * FROM aux_venta_outliers;
select count(*) from aux_venta_outliers;  #---> NO COINCIDE CON EL TOTAL DE PRODUCTOS PORQUE HAY PRODUCTOS QUE NUNCA SE VENDIERON

select count(*) from producto;
#HACEMOS UN JOIN CON VENTAS Y TESTEAMOS VENTAS POR VENTAS. CUANDO UNA VENTA ESTA FUERA DE LOS UMBRALES, TOMA EL VALOR CERO EN UNA VARIABLE LLAMADA BINARIA
#SI NO ES ASI, TOMA EL VALOR 1
#PARA ELLO ANADIMOS NUEVAS COLUMNAS A VENTAS
ALTER TABLE `empresa_practica_sql`.`venta` 
ADD COLUMN `limite_izquierdo` INT NULL AFTER `Cantidad`,
ADD COLUMN `limite_derecho` INT NULL AFTER `limite_izquierdo`,
ADD COLUMN `binaria` INT NULL AFTER `limite_derecho`;
ALTER TABLE `empresa_practica_sql`.`venta` 
CHANGE COLUMN `binaria` `binaria` INT NULL DEFAULT 0 ;

ALTER TABLE `empresa_practica_sql`.`venta` 
ADD COLUMN `promedio` INT NULL AFTER `Cantidad`,
ADD COLUMN `desvio` INT NULL AFTER `promedio`;

select * from venta;
#INSERTAMOS EN VENTAS LOS VALORES QUE SACAMOS EN LA OTRA TABLA Y LOS INSERTAMOS
update venta v join aux_venta_outliers a on (a.idproducto = v.idproducto) set v.promedio = a.PRECIO_PROMEDIO;
update venta v join aux_venta_outliers a on (a.idproducto = v.idproducto) set v.desvio = a.desvio_precio;
update venta v join aux_venta_outliers a on (a.idproducto = v.idproducto) set v.limite_izquierdo = a.limite_izquierdo;
update venta v join aux_venta_outliers a on (a.idproducto = v.idproducto) set v.limite_derecho = a.limite_derecho;

#es outlier cuando esta afuera del rango
#agregamos como NO outlier cuando su desvio es menor a 10. basicamente para no incluir como outliers a valores incorrectos
update venta set binaria = 1 where precio < limite_derecho and precio > limite_izquierdo or desvio = 0;
update venta set binaria = 0 where binaria is null;

#agregamos como NO outlier cuando su desvio es menor a 10. basicamente para no incluir como outliers a valores incorrectos

#contamos la cantidad de outliers
select count(*) from venta where binaria = 0;


#RAPIDA REVISION DE OUTLIERS (VISUAL)
SELECT * FROM VENTA WHERE BINARIA = 0;

#BORRAMOS LAS TABLAS AUXILIARES QUE USAMOS PARA FILTRAR OUTLIERS
ALTER TABLE VENTA 
DROP COLUMN promedio;

ALTER TABLE VENTA 
DROP COLUMN limite_izquierdo;

ALTER TABLE VENTA 
DROP COLUMN limite_DERECHO;

ALTER TABLE VENTA 
DROP COLUMN DESVIO;

ALTER TABLE VENTA 
CHANGE COLUMN `binaria` `OUTLIERS` INT NULL DEFAULT 0;


#---------------------------------------------------------------------------------------------------------------------------------------
# INDICES Y CLAVES
#PASO 11) CREAMOS LAS PK Y FK DE CADA TABLA

# DEFINIMOS LAS PK PARA LAS TABLAS QUE FALTAN


ALTER TABLE `empresa_practica_sql`.`sucursal` 
CHANGE COLUMN `IdSucursal` `IdSucursal` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdSucursal`);

ALTER TABLE `empresa_practica_sql`.`proveedor` 
CHANGE COLUMN `IDProveedor` `IDProveedor` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IDProveedor`);


ALTER TABLE `empresa_practica_sql`.`producto` 
CHANGE COLUMN `IdProducto` `IdProducto` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdProducto`);


ALTER TABLE `empresa_practica_sql`.`gasto` 
CHANGE COLUMN `IdGasto` `IdGasto` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdGasto`);


ALTER TABLE `empresa_practica_sql`.`cliente` 
CHANGE COLUMN `Idcliente` `Idcliente` VARCHAR(80) NOT NULL ,
ADD PRIMARY KEY (`Idcliente`);


ALTER TABLE `empresa_practica_sql`.`empleado` 
CHANGE COLUMN `Idempleado` `Idempleado` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`Idempleado`);



ALTER TABLE `empresa_practica_sql`.`canal_venta` 
CHANGE COLUMN `IdCanal` `IdCanal` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdCanal`);


ALTER TABLE `empresa_practica_sql`.`aux_venta` 
CHANGE COLUMN `IdVenta` `IdVenta` INT NOT NULL AUTO_INCREMENT ,
ADD PRIMARY KEY (`IdVenta`);
;


# DEFINIMOS LAS PK PARA LAS TABLAS QUE FALTAN
#para ello anadimos un indice para cada fk
#VENTA
ALTER TABLE `venta` ADD INDEX(`IdProducto`);
ALTER TABLE `venta` ADD INDEX(`IdEmpleado`);
ALTER TABLE `venta` ADD INDEX(`Fecha`);
ALTER TABLE `venta` ADD INDEX(`Fecha_Entrega`);
ALTER TABLE `venta` ADD INDEX(`IdCliente`);
ALTER TABLE `venta` ADD INDEX(`IdSucursal`);
ALTER TABLE `venta` ADD INDEX(`IdCanal`);

#FK DEFINIDAS
ALTER TABLE venta ADD CONSTRAINT `venta_fk_fecha` FOREIGN KEY (fecha) REFERENCES calendario (fecha) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_cliente` FOREIGN KEY (IdCliente) REFERENCES cliente (IdCliente) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_sucursal` FOREIGN KEY (IdSucursal) REFERENCES sucursal (IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_producto` FOREIGN KEY (IdProducto) REFERENCES producto (IdProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_empleado` FOREIGN KEY (IdEmpleado) REFERENCES empleado (IdEmpleado) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_canal` FOREIGN KEY (IdCanal) REFERENCES canal_venta (IdCanal) ON DELETE RESTRICT ON UPDATE RESTRICT;

SELECT * FROM VENTA;

SHOW VARIABLES;



#---------------------------------------------------------------------------------------------------------------------------------------
#11) TRIGGERS 
#CREACION DE TRIGGER DE INSERCION PARA LAS TABLAS VENTA, PRODUCTO, CLIENTE, COMNPRA, empleado

# CREACION DE LAS TABLAS CORRESPONDIENTES
CREATE TABLE `empresa_practica_sql`.`log_insertion_venta` (
  `Idloginsertionventa` INT NOT NULL AUTO_INCREMENT,
  `Idventa` INT NOT NULL,
  `Tiempo` DATETIME NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Idloginsertionventa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Registra las inserciones en la tabla venta';

CREATE TABLE `empresa_practica_sql`.`log_insertion_cliente` (
  `Idloginsertioncliente` INT NOT NULL AUTO_INCREMENT,
  `Idcliente` INT NOT NULL,
  `Tiempo` DATETIME NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Idloginsertioncliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Registra las inserciones en la tabla cliente';

CREATE TABLE `empresa_practica_sql`.`log_insertion_producto` (
  `Idloginsertionproducto` INT NOT NULL AUTO_INCREMENT,
  `Idproducto` INT NOT NULL,
  `Tiempo` DATETIME NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Idloginsertionproducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Registra las inserciones en la tabla producto';

CREATE TABLE `empresa_practica_sql`.`log_insertion_compra` (
  `Idloginsertioncompra` INT NOT NULL AUTO_INCREMENT,
  `Idcompra` INT NOT NULL,
  `Tiempo` DATETIME NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Idloginsertioncompra`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Registra las inserciones en la tabla compra';

CREATE TABLE `empresa_practica_sql`.`log_insertion_EMPLEADO` (
  `IdloginsertionEMPLEADO` INT NOT NULL AUTO_INCREMENT,
  `IdEMPLEADO` INT NOT NULL,
  `Tiempo` DATETIME NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdloginsertionEMPLEADO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Registra las inserciones en la tabla EMPLEADO';


# creacion del trigger para cada tabla 

# venta
create trigger venta_ai 
after insert on venta 
for each row 
insert into log_insertion_venta(idventa, tiempo, usuario) values (new.idventa, now(), current_user());

#cliente
create trigger cliente_ai 
after insert on cliente 
for each row 
insert into log_insertion_cliente(idcliente, tiempo, usuario) values (new.idcliente, now(), current_user());

# Producto
create trigger producto_ai 
after insert on producto 
for each row 
insert into log_insertion_producto(idproducto, tiempo, usuario) values (new.idproducto, now(), current_user());

#compra
create trigger compra_ai 
after insert on compra 
for each row 
insert into log_insertion_compra(idcompra, tiempo, usuario) values (new.idcompra, now(), current_user());

#EMPLEADO
create trigger EMPLEADO_ai 
after insert on EMPLEADO 
for each row 
insert into log_insertion_EMPLEADO(idEMPLEADO, tiempo, usuario) values (new.idEMPLEADO, now(), current_user());


#CREACION DE TRIGGER DE ACTUALIZACION PARA VENTAS
# TABLA

CREATE TABLE `empresa_practica_sql`.`log_update_venta` (
  `Idlogupdateventa` INT NOT NULL AUTO_INCREMENT,
  `Idventa` INT NOT NULL,
  PRECIO_VIEJO INT,
  PRECIO_NUEVO INT,
  CANTIDAD_VIEJO INT,
  CANTIDAD_VIEJO INT,
  `Tiempo` DATETIME NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Idlogupdateventa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Registra las actualizaciones en la tabla venta';


# CREAMOS EL TRIGGER
#?create trigger carrera_update_before before update on carrera for each row 
#?insert into log_carera_update(antes_carrera, despues_carrera, antes_duracion, despues_duracion, tiempo_update, usuario) 
#?values (old.nombre, new.nombre, old.duracion, new.duracion, now(), current_user());

CREATE TRIGGER VENTA_UPDATE_BEFORE  BEFORE UPDATE ON VENTA 
FOR EACH ROW 
INSERT INTO LOG_UPDATE_VENTA(IDVENTA, PRECIO_VIEJO, PRECIO_NUEVO, CANTIDAD_VIEJO, CANTIDAD_VIEJO, Tiempo, Usuario) 
VALUES (IDVENTA, OLD.PRECIO, NEW.PRECIO, OLD.CANTIDAD, NEW.CANTIDAD, NOW(), CURRENT_USER());



#CREACION DE TRIGGER DE ELIMINACION DE FILAS  PARA VENTAS
# TABLA

CREATE TABLE `empresa_practica_sql`.`log_deletion_venta` (
  `Idldeletionteventa` INT NOT NULL AUTO_INCREMENT,
  `Idventa` INT NOT NULL,
  PRECIO INT,
  CANTIDAD INT,
  `Tiempo` DATETIME NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Idldeletionteventa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Registra las eliminaciones en la tabla venta';

#trigger de eliminacion
create trigger venta_deletion_before before delete on venta for each row
insert into log_deletion_venta (Idventa, PRECIO, CANTIDAD, Tiempo, Usuario) values (old.idventa, old.precio, old.cantidad, now(), current_user());



#---------------------------------------------------------------------------------------------------------------------------------------
#12) PROCEDURES

# PROCEDURE DE INSERCION EN VENTA
use empresa_practica_sql;
SELECT * FROM VENTA;	
delimiter //
create procedure insertion_venta (in par_fecha date, in par_fecha_entrega date, in par_idcanal int, in par_idcliente int, in par_idsucursal int, in par_idempleado int, in par_idproducto int, in par_precio int, in par_outliers int)
begin 
insert into venta (Fecha, Fecha_Entrega, IdCanal, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, OUTLIERS) 
values (par_fecha, par_fecha_entrega, par_idcanal, par_idcliente, par_idsucursal, par_idempleado, par_idproducto, par_precio, par_cantidad, par_outliers);
end //
DELIMITER ;
# PROCEDURE DE INSERCION EN CLIENTE
SELECT * FROM CLIENTE;

delimiter //
create procedure insertion_cliente (in par_Nombre_y_Apellido VARCHAR(50), in par_Domicilio VARCHAR(100), in par_Telefono CHAR, in par_Edad int, in par_Rango_Etario char, in par_idlocalidad int, in par_Longitud decimal(10,2), in par_Latitud decimal(10,2))
begin 
insert into cliente (Nombre_y_Apellido,  Domicilio ,  Telefono ,  Edad ,  Rango_Etario ,  idlocalidad ,  Longitud ,  Latitud)
values (par_Nombre_y_Apellido,  par_Domicilio ,  par_Telefono ,  par_Edad ,  par_Rango_Etario ,  par_idlocalidad ,  par_Longitud ,  par_Latitud);
end //


# PROCEDURE DE INSERCION EN COMPRA
delimiter ;
select * from compra;

delimiter //
create procedure insertion_compra (in par_Fecha date, in par_IdProducto int, in par_Cantidad int, in par_Precio int, in par_IdProveedor int)
begin 
insert into compra (Fecha,  IdProducto ,  Cantidad ,  Precio ,  IdProveedor )
values (par_Fecha,  par_IdProducto ,  par_Cantidad ,  par_Precio ,  par_IdProveedor )
;
end //


# PROCEDURE DE INSERCION EN EMPLEADO
 delimiter ;
select * from  empleado;
delimiter //
create procedure insertion_empleado (in par_CodigoEmpleado int, in par_Apellido char,in  par_Nombre char,in par_Sucursal char,in  par_IdSucursal int,in par_IdSector int,in par_IdCargo int,in par_Sector int,in par_Cargo int,in par_Salario int)
begin 
insert into empleado (CodigoEmpleado,  Apellido ,  Nombre ,  Sucursal ,  IdSucursal, IdSector, IdCargo, Sector, Cargo, Salario)
values (par_CodigoEmpleado,  par_Apellido ,  par_Nombre ,  par_Sucursal ,  par_IdSucursal, par_IdSector, par_IdCargo, par_Sector, par_Cargo, par_Salario);
end //


#---------------------------------------------------------------------------------------------------------------------------------------
#12) CONSULTAS RELEVANTES PARA EL NEGOCIO, PROCEDURES KPIS

#KP1  ganancia neta por sucursal  (Ganancia = Venta - Gasto) ¿Cuál es la sucursal con mayor ganancia neta cada anio? 

 ## lo hago para un anio determinado
DELIMITER ; 
select v.idsucursal as idsucursal, 
s.sucursal as sucursal, 
sum(v.precio * v.cantidad) as total_venta 
from venta v join sucursal s on (v.idsucursal = s.idsucursal) and year(fecha) = 2020
group by v.idsucursal;

-- 2) sacos los gastos totales por sucursal en 2020
select * from gasto;
#select * from tipo_gasto;

select g.IdSucursal as idsucursal, 
s.Sucursal as sucursal, 
sum(g.monto) as gasto_total 
from gasto g join sucursal s on (g.Idsucursal = s.idsucursal) and year(fecha) = 2020 
group by s.IdSucursal; 

-- 3) los junto y hago el kpi

SELECT *, V.TOTAL_VENTA - G.GASTO_TOTAL AS GANANCIA
 FROM (select v.idsucursal as idsucursal, 
s.sucursal as sucursal, 
sum(v.precio * v.cantidad) as total_venta 
from venta v join sucursal s on (v.idsucursal = s.idsucursal) and year(fecha) = 2020
group by v.idsucursal) AS V
JOIN (select g.IdSucursal as idsucursal, 
s.Sucursal as sucursal, 
sum(g.monto) as gasto_total 
from gasto g join sucursal s on (g.Idsucursal = s.idsucursal) and year(fecha) = 2020 
group by s.IdSucursal) AS G 
ON (V.IDSUCURSAL = G.IDSUCURSAL) ORDER BY GANANCIA DESC ;


#Generalizamos la consulta anterior y creamos un procedure para generalizar la consulta anterior a cualquier anio de operacion de la empresa 

DELIMITER //
CREATE PROCEDURE kpi1 (in anio int)
begin
set @m1 = 'introducir un año etario correcto'; 
if exists (select year(fecha) = anio from venta) then 
	SELECT *, V.TOTAL_VENTA - G.GASTO_TOTAL AS GANANCIA
	 FROM (select v.idsucursal as idsucursal, 
	s.sucursal as sucursal, 
	sum(v.precio * v.cantidad) as total_venta 
	from venta v join sucursal s on (v.idsucursal = s.idsucursal) and year(fecha) = anio
	group by v.idsucursal) AS V
	JOIN (select g.IdSucursal as idsucursal, 
	s.Sucursal as sucursal, 
	sum(g.monto) as gasto_total 
	from gasto g join sucursal s on (g.Idsucursal = s.idsucursal) and year(fecha) = anio 
	group by s.IdSucursal) AS G 
	ON (V.IDSUCURSAL = G.IDSUCURSAL) ORDER BY GANANCIA DESC ;
else  
	select @m1;
end if;
end //


DELIMITER ; 
call kpi1(2015);
call kpi1(2016);
call kpi1(2020);

-- -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----

#KPi2  ganancia neta por producto es las ventas menos las compras (Ganancia = Venta - Compra) ¿Cuál es el tipo de producto con mayor ganancia por anio?

-- SACO LAS VENTAS TOTALES POR TIPO PARA 2020
SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(V.PRECIO * V.CANTIDAD) AS VENTA_POR_TIPO
 FROM VENTA V JOIN PRODUCTO P ON (V.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = 2020
 group by T.IDTIPOPRODUCTO;


-- SACO LAS COMPRAS POR TIPO DE PRODUCTO

SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(C.PRECIO * C.CANTIDAD) AS COMPRA_POR_TIPO
 FROM COMPRA C JOIN PRODUCTO P ON (C.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = 2020
 group by T.IDTIPOPRODUCTO;
#C

-- JOIN 
SELECT *, V.VENTA_POR_TIPO - C.COMPRA_POR_TIPO AS GANANCIA_TIPO_2020 
FROM (SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(V.PRECIO * V.CANTIDAD) AS VENTA_POR_TIPO
 FROM VENTA V JOIN PRODUCTO P ON (V.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = 2020
 group by T.IDTIPOPRODUCTO) AS V
 JOIN 
 (SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(C.PRECIO * C.CANTIDAD) AS COMPRA_POR_TIPO
 FROM COMPRA C JOIN PRODUCTO P ON (C.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = 2020
 group by T.IDTIPOPRODUCTO) AS C
 ON (V.IDTIPOPRODUCTO = C.IDTIPOPRODUCTO)
 ORDER BY GANANCIA_TIPO_2020 DESC;

#Generalizamos la consulta anterior y creamos un procedure para generalizar la consulta anterior a cualquier anio de operacion de la empresa 

DELIMITER //
CREATE PROCEDURE kpi2 (in anio int)
begin
set @m2 = 'introducir un año  correcto'; 
if exists (select year(fecha) = anio from venta) then 
	SELECT *, V.VENTA_POR_TIPO - C.COMPRA_POR_TIPO AS GANANCIA_TIPO_2020 
FROM (SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(V.PRECIO * V.CANTIDAD) AS VENTA_POR_TIPO
 FROM VENTA V JOIN PRODUCTO P ON (V.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = anio
 group by T.IDTIPOPRODUCTO) AS V
 JOIN 
 (SELECT T.IDTIPOPRODUCTO AS IDTIPOPRODUCTO, T.TIPOPRODUCTO AS TIPO, SUM(C.PRECIO * C.CANTIDAD) AS COMPRA_POR_TIPO
 FROM COMPRA C JOIN PRODUCTO P ON (C.IDPRODUCTO = P.IDPRODUCTO) 
 JOIN tipo_producto AS T ON (T.IdTipoProducto = P.IdTipoProducto) AND YEAR(FECHA) = anio
 group by T.IDTIPOPRODUCTO) AS C
 ON (V.IDTIPOPRODUCTO = C.IDTIPOPRODUCTO)
 ORDER BY GANANCIA_TIPO_2020 DESC;
else  
	select @m2;
end if;
end //

DELIMITER ; 
call kpi2(2015);
call kpi2(2016);
call kpi2(2020);

-- -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----
#KPi3 Del total de clientes que realizaron compras en un anio determinado ¿Qué porcentaje lo hizo sólo en una única sucursal?

-- TOTAL DE CLIENTES QUE HICIERON COMPRA EN 2020 (DISTINCT DE CLIENTES QUE WHERE YEAR 2020)
 SELECT COUNT(*) FROM (SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE) AS C; 
 -- lo guardo en una variable
 SET @VAR1 = 0;
 SET  @VAR1 =  (SELECT COUNT(*) FROM (SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE) AS C);
 SELECT @VAR1;
 -- veo en que sucursal compro cada cliente, agrupando por cliente y por sucursal a la vez (tabla T)
SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE, IDSUCURSAL order by IDCLIENTE;
-- CONTAR LA CANTIDAD DE VECES QUE SE REPITE IDCLIENTE EN LA TABLA ANTERIOR (en cuantas sucursal compro cada cliente)
-- TABLA P
SELECT COUNT(IDCLIENTE) AS SUCURSAL_DISTINTA, IDCLIENTE 
FROM (SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE, IDSUCURSAL order by IDCLIENTE) as t 
GROUP BY IDCLIENTE;
 
 
 # NOS QUEDAMOS SOLO CON LOS QUE COMPRARON EN UNA SUCURSAL
 SELECT COUNT(*) FROM (
 SELECT COUNT(IDCLIENTE) AS SUCURSAL_DISTINTA, IDCLIENTE 
FROM (SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020  group by IDCLIENTE, IDSUCURSAL order by IDCLIENTE) as t 
GROUP BY IDCLIENTE) AS P 
WHERE SUCURSAL_DISTINTA = 1;
#LO GUARDO EN UNA VARIABLE
 SET  @VAR2 =  (SELECT COUNT(*) FROM (
 SELECT COUNT(IDCLIENTE) AS SUCURSAL_DISTINTA, IDCLIENTE 
FROM (SELECT * FROM VENTA WHERE YEAR(FECHA) = 2020  group by IDCLIENTE, IDSUCURSAL order by IDCLIENTE) as t 
GROUP BY IDCLIENTE) AS P 
WHERE SUCURSAL_DISTINTA = 1);
 SELECT @VAR2;
 
 SET @VAR3 = @VAR2/@VAR1;
 SELECT  @VAR3;


# CREAMOS UN PROCEEDURE CON LO ANTERIOR

DELIMITER //
CREATE PROCEDURE KPi3 (in anio int)
begin 
SET  @kpi3_VAR1 =  (SELECT COUNT(*) FROM (SELECT * FROM VENTA WHERE YEAR(FECHA) = anio group by IDCLIENTE) AS C);
SET  @kpi3_VAR2  =  (SELECT COUNT(*) FROM (
SELECT COUNT(IDCLIENTE) AS SUCURSAL_DISTINTA, IDCLIENTE 
FROM (SELECT * FROM VENTA WHERE YEAR(FECHA) = anio  group by IDCLIENTE, IDSUCURSAL order by IDCLIENTE) as t 
GROUP BY IDCLIENTE) AS P 
WHERE SUCURSAL_DISTINTA = 1);
SET @kpi3_VAR3 = @kpi3_VAR2 / @kpi3_VAR1 ;
SET @MENSAJE_ERROR_KPI3 = 'SELECCION UN ANIO DE OPERACION';


IF ANIO IN (2015, 2016, 2017, 2018, 2019, 2020) THEN
	SELECT @kpi3_VAR3;
 ELSE 
	SELECT @MENSAJE_ERROR_KPI3;
END IF;
end //
 DELIMITER ;
CALL KPi3(2019);

-- -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----     -----
#KPi4 Del total de clientes que realizaron compras en ANIO1 ¿Qué porcentaje no había realizado compras en ANIO2?
#ANIO1 = 2020
#ANIO2 = 2019
# QUIENES COMPRAROS EN 2020 
SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE; #---> LISTA DE CLIENTES QUE REALIZARON UNA COMPRA EN 2020

#LISTA DE CLIENTES DE QUIENES COMPRARON EN 2019
SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE;   #---> REALIZARON UNA COMPRA EN 2019

#QUIENES NO REALIZARON UNA COMPRA EN 2019
SELECT IDCLIENTE FROM CLIENTE WHERE IDCLIENTE NOT IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE); #CLIENTES QUE NO REALIZARON 

#SACO LA INTERSECCION DE LAS DOS LISTAS
SELECT IDCLIENTE 
FROM (SELECT IDCLIENTE FROM CLIENTE WHERE IDCLIENTE NOT IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE)) AS T 
WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE);

#CUENTO LO ANTERIOR
SELECT COUNT(*) 
FROM (SELECT IDCLIENTE 
FROM (SELECT IDCLIENTE FROM CLIENTE WHERE IDCLIENTE NOT IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2019 group by IDCLIENTE)) AS T 
WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = 2020 group by IDCLIENTE)) AS A;

#CREACION DEL PROCEDURE
DELIMITER //
CREATE PROCEDURE KPi4 (in anio1 int, in anio2 int)
-- del total de clientes que compraron en anio1, que porcentaje no compro en anio2 pero in en anio1
begin 
SET  @kpi4_VAR1 =  (SELECT COUNT(*) from (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = anio1 group by IDCLIENTE) AS C);
SET  @kpi4_VAR2  =  (SELECT COUNT(*) 
FROM (SELECT IDCLIENTE 
FROM (SELECT IDCLIENTE FROM CLIENTE WHERE IDCLIENTE NOT IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = anio2 group by IDCLIENTE)) AS T 
WHERE IDCLIENTE IN (SELECT IDCLIENTE FROM VENTA WHERE YEAR(FECHA) = anio1 group by IDCLIENTE)) AS A);
SET @kpi4_VAR3 = @kpi4_VAR2 / @kpi4_VAR1 ;
SET @MENSAJE_ERROR_KPI4 = 'SELECCION UN ANIO DE OPERACION';
IF ANIO1  IN (2015, 2016, 2017, 2018, 2019, 2020) and anio2 in (2015, 2016, 2017, 2018, 2019, 2020) THEN
	SELECT @kpi4_VAR3;
 ELSE 
	SELECT @MENSAJE_ERROR_KPI4;
END IF;
end //
 DELIMITER ;
CALL KPi4(2020, 2019);
CALL KPi4(2019, 2016);

#kpi5; ventas por cliente pro provincia por anio