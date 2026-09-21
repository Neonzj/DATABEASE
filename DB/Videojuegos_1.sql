create table empresas (
id uuid primary key default gen_random_uuid(),
nombre text not null unique
);

create table videojuegos (
id uuid primary key default gen_random_uuid(),
empresa_id uuid not null references empresas(id),
titulo text not null,
fecha_lanzamiento date,
consola text not null
);

create table personajes (
id uuid primary key default gen_random_uuid(),
nombre text not null
);

create table pj_vj (
videojuego_id uuid not null
references videojuegos(id)
on delete cascade,
personaje_id uuid not null
references personajes(id)
on delete cascade,
primary key (videojuego_id, personaje_id)
);

insert into empresas (nombre) values ('Nintendo'), ('Sega');

insert into videojuegos (titulo, fecha_lanzamiento, consola, empresa_id) select 'Sonic y el Caballero Oscuro', date '2009-03-03', 'Wii', id from empresas where nombre = 'Sega';

insert into videojuegos (titulo, fecha_lanzamiento, consola, empresa_id) select 'Super Smash Bros. Ultimate', date '2018-12-07', 'Switch 1-2', id from empresas where nombre = 'Nintendo';

insert into personajes (nombre) values ('Sonic'), ('Shadow'), ('Blaze'), ('Mario');

insert into pj_vj (videojuego_id, personaje_id) select videojuegos.id, personajes.id from videojuegos cross join personajes where videojuegos.titulo in ( 'Sonic y el Caballero Oscuro', 'Super Smash Bros. Ultimate') and personajes.nombre = 'Sonic';
insert into pj_vj (videojuego_id, personaje_id) select videojuegos.id, personajes.id from videojuegos cross join personajes where videojuegos.titulo = 'Sonic y el Caballero Oscuro' and personajes.nombre in ('Shadow', 'Blaze');
insert into pj_vj (videojuego_id, personaje_id) select videojuegos.id, personajes.id from videojuegos cross join personajes where videojuegos.titulo = 'Super Smash Bros. Ultimate' and personajes.nombre = 'Mario';
