DROP DATABASE IF EXISTS StadiumEventsDB;
CREATE DATABASE StadiumEventsDB;
USE StadiumEventsDB;

create table if not exists auditorio
(
    id        int auto_increment
        primary key,
    nombre    varchar(200) not null,
    capacidad int          not null,
    ubicacion varchar(200) not null
)
    collate = utf8mb4_unicode_ci;

create table if not exists evento
(
    id        int auto_increment
        primary key,
    evento    varchar(200) not null,
    fecha     date         not null,
    capacidad int          null
)
    collate = utf8mb4_unicode_ci;

create table if not exists failed_jobs
(
    id         bigint unsigned auto_increment
        primary key,
    uuid       varchar(255)                        not null,
    connection text                                not null,
    queue      text                                not null,
    payload    longtext                            not null,
    exception  longtext                            not null,
    failed_at  timestamp default CURRENT_TIMESTAMP not null,
    constraint failed_jobs_uuid_unique
        unique (uuid)
)
    collate = utf8mb4_unicode_ci;

create table if not exists formato
(
    id           int auto_increment
        primary key,
    nombre       varchar(200) not null,
    descripcion  int          not null,
    id_auditorio int          not null,
    constraint formato_auditorio_id_auditorio_fk
        foreign key (id_auditorio) references auditorio (id)
)
    collate = utf8mb4_unicode_ci;

create table if not exists migrations
(
    id        int unsigned auto_increment
        primary key,
    migration varchar(255) not null,
    batch     int          not null
)
    collate = utf8mb4_unicode_ci;

create table if not exists password_reset_tokens
(
    email      varchar(255) not null
        primary key,
    token      varchar(255) not null,
    created_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table if not exists personal_access_tokens
(
    id             bigint unsigned auto_increment
        primary key,
    tokenable_type varchar(255)    not null,
    tokenable_id   bigint unsigned not null,
    name           varchar(255)    not null,
    token          varchar(64)     not null,
    abilities      text            null,
    last_used_at   timestamp       null,
    expires_at     timestamp       null,
    created_at     timestamp       null,
    updated_at     timestamp       null,
    constraint personal_access_tokens_token_unique
        unique (token)
)
    collate = utf8mb4_unicode_ci;

create index personal_access_tokens_tokenable_type_tokenable_id_index
    on personal_access_tokens (tokenable_type, tokenable_id);

create table if not exists rol
(
    id     int auto_increment
        primary key,
    nombre varchar(100)      not null,
    estado tinyint default 1 null
)
    collate = utf8mb4_unicode_ci;

create table if not exists usuarios
(
    id                int auto_increment
        primary key,
    nombre            varchar(255)         not null,
    email             varchar(255)         not null,
    email_verified_at timestamp            null,
    password          varchar(255)         not null,
    dui               varchar(255)         not null,
    telefono          varchar(255)         not null,
    estado            tinyint(1) default 1 not null,
    id_rol            int                  not null,
    remember_token    varchar(100)         null,
    created_at        timestamp            null,
    updated_at        timestamp            null,
    constraint usuarios_dui_unique
        unique (dui),
    constraint usuarios_email_unique
        unique (email),
    constraint usuarios_rol_id_tipo_usuario_fk
        foreign key (id_rol) references rol (id)
)
    collate = utf8mb4_unicode_ci;

create table if not exists zonas
(
    id        int auto_increment
        primary key,
    nombre    varchar(100) not null,
    capacidad varchar(100) not null,
    ubicacion varchar(100) not null
)
    collate = utf8mb4_unicode_ci;

create table if not exists asientos
(
    id      int auto_increment
        primary key,
    numero  int null,
    fila    int not null,
    id_zona int null,
    constraint asientos_zonas_id_zona_fk
        foreign key (id_zona) references zonas (id)
)
    collate = utf8mb4_unicode_ci;

create table if not exists zona_formato
(
    id         int auto_increment
        primary key,
    id_zona    int not null,
    id_formato int not null,
    constraint zona_formato_id_formato_fk
        foreign key (id_formato) references formato (id),
    constraint zona_formato_id_zona_fk
        foreign key (id_zona) references zonas (id)
)
    collate = utf8mb4_unicode_ci;

create table if not exists evento_zona
(
    id              int auto_increment
        primary key,
    id_evento       int     not null,
    id_zona_formato int     not null,
    precio          decimal not null,
    constraint evento_formato_id_evento_fk
        foreign key (id_evento) references evento (id),
    constraint evento_formato_id_zona_formato_fk
        foreign key (id_zona_formato) references zona_formato (id)
)
    collate = utf8mb4_unicode_ci;

create table if not exists boleto
(
    id             int auto_increment
        primary key,
    fecha          datetime   not null,
    id_evento_zona int        not null,
    id_asiento     int        not null,
    estado         tinyint(1) not null,
    constraint boleto_asiento_id_evento_fk
        foreign key (id_asiento) references asientos (id),
    constraint boleto_evento_zona_id_evento_fk
        foreign key (id_evento_zona) references evento_zona (id)
)
    collate = utf8mb4_unicode_ci;

create index boleto_evento_id_evento_fk
    on boleto (id_evento_zona);

create table if not exists reservas
(
    id         int auto_increment
        primary key,
    dui        int               not null,
    telefono   varchar(10)       not null,
    estado     tinyint default 1 not null,
    leido      tinyint           not null,
    id_usuario int               null,
    id_boleto  int               not null,
    constraint reservas_boletos_id_boleto_fk
        foreign key (id_boleto) references boleto (id),
    constraint reservas_usuarios_id_usuario_fk
        foreign key (id_usuario) references usuarios (id)
)
    collate = utf8mb4_unicode_ci;

