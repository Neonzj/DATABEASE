CREATE TABLE empresas (
    id CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    nombre VARCHAR(100) NOT NULL UNIQUE
) ENGINE = InnoDB;


CREATE TABLE videojuegos (
    id CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    empresa_id CHAR(36) NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    fecha_lanzamiento DATE,
    consola VARCHAR(100) NOT NULL,

    CONSTRAINT fk_videojuegos_empresas
        FOREIGN KEY (empresa_id)
        REFERENCES empresas(id)
) ENGINE = InnoDB;


CREATE TABLE personajes (
    id CHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    nombre VARCHAR(255) NOT NULL
) ENGINE = InnoDB;


CREATE TABLE pj_vj (
    videojuego_id CHAR(36) NOT NULL,
    personaje_id CHAR(36) NOT NULL,

    PRIMARY KEY (videojuego_id, personaje_id),

    CONSTRAINT fk_pj_vj_videojuegos
        FOREIGN KEY (videojuego_id)
        REFERENCES videojuegos(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_pj_vj_personajes
        FOREIGN KEY (personaje_id)
        REFERENCES personajes(id)
        ON DELETE CASCADE
) ENGINE = InnoDB;


INSERT INTO empresas (nombre)
VALUES
    ('Nintendo'),
    ('Sega');


INSERT INTO videojuegos (
    titulo,
    fecha_lanzamiento,
    consola,
    empresa_id
)
SELECT
    'Sonic y el Caballero Oscuro',
    '2009-03-03',
    'Wii',
    id
FROM empresas
WHERE nombre = 'Sega';


INSERT INTO videojuegos (
    titulo,
    fecha_lanzamiento,
    consola,
    empresa_id
)
SELECT
    'Super Smash Bros. Ultimate',
    '2018-12-07',
    'Switch 1-2',
    id
FROM empresas
WHERE nombre = 'Nintendo';


INSERT INTO personajes (nombre)
VALUES
    ('Sonic'),
    ('Shadow'),
    ('Blaze'),
    ('Mario');


INSERT INTO pj_vj (
    videojuego_id,
    personaje_id
)
SELECT
    videojuegos.id,
    personajes.id
FROM videojuegos
CROSS JOIN personajes
WHERE videojuegos.titulo IN (
    'Sonic y el Caballero Oscuro',
    'Super Smash Bros. Ultimate'
)
AND personajes.nombre = 'Sonic';


INSERT INTO pj_vj (
    videojuego_id,
    personaje_id
)
SELECT
    videojuegos.id,
    personajes.id
FROM videojuegos
CROSS JOIN personajes
WHERE videojuegos.titulo = 'Sonic y el Caballero Oscuro'
AND personajes.nombre IN (
    'Shadow',
    'Blaze'
);


INSERT INTO pj_vj (
    videojuego_id,
    personaje_id
)
SELECT
    videojuegos.id,
    personajes.id
FROM videojuegos
CROSS JOIN personajes
WHERE videojuegos.titulo = 'Super Smash Bros. Ultimate'
AND personajes.nombre = 'Mario';