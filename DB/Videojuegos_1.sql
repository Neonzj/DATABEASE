create extension if not exists pgcrypto;

create table empresas (
    id uuid primary key default gen_random_uuid(),
    nombre text not null unique
);

create table videojuegos (
    id uuid primary key default gen_random_uuid(),
    titulo text not null,
    empresa_id uuid not null references empresas(id),
    fecha_lanzamiento date
);

create table personajes (
    id uuid primary key default gen_random_uuid(),
    videojuego_id uuid not null references videojuegos(id),
    nombre text not null
);

insert into empresas (nombre) values ('Nintendo'), ('Sega');

insert into videojuegos (titulo, fecha_lanzamiento, empresa_id) select 'Sonic y el Caballero Oscuro', date '2009-03-03', id from empresas where nombre = 'Sega';

insert into personajes (nombre, videojuego_id) select 'Shadow', id from videojuegos where titulo = 'Sonic y el Caballero Oscuro';
