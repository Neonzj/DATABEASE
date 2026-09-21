create table empresas(
    id uuid primary key default gen_random_uuid(), 
    nombre text not null unique
);

create table videojuegos(
    id uuid primary key default gen_random_uuid(),
    titulo text not null,
    empresa_id uuid not null references empresas(id),
    fecha_lanzamiento date
);

create table personajes(
    id uuid primary key default gen_random_uuid(),
    vj_id uuid not null references videojuegos(id),
    nombre text not null
);


inset into empresas (nombre) values ('Nintendo');
inset into empresas (nombre) values ('Hoyoverse');

