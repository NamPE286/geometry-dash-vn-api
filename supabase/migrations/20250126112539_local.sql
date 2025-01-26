alter table "public"."level_creator" add column "is_decorator" boolean not null default true;

alter table "public"."level_creator" add column "is_gameplay_maker" boolean not null default true;

alter table "public"."level_creator" add column "part_end" bigint not null default '100'::bigint;

alter table "public"."level_creator" add column "part_start" bigint not null default '0'::bigint;


