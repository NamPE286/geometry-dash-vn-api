drop materialized view if exists "public"."records_view";

create table "public"."level_creator" (
    "level_id" bigint not null,
    "user_id" uuid not null default gen_random_uuid()
);


alter table "public"."level_creator" enable row level security;

CREATE UNIQUE INDEX level_creator_pkey ON public.level_creator USING btree (level_id, user_id);

alter table "public"."level_creator" add constraint "level_creator_pkey" PRIMARY KEY using index "level_creator_pkey";

alter table "public"."level_creator" add constraint "level_creator_level_id_fkey" FOREIGN KEY (level_id) REFERENCES levels(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."level_creator" validate constraint "level_creator_level_id_fkey";

alter table "public"."level_creator" add constraint "level_creator_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE not valid;

alter table "public"."level_creator" validate constraint "level_creator_user_id_fkey";

create materialized view "public"."records_view" as  WITH tmp AS (
         SELECT records.user_id,
            records.level_id,
            records.progress,
            records.video_link,
            level_rating.list,
            level_rating.rating,
            users.is_hidden,
                CASE
                    WHEN (level_rating.list = 'featured'::text) THEN (0)::double precision
                    WHEN (records.progress = 100) THEN (level_rating.rating)::double precision
                    ELSE ((((((level_rating.rating * records.progress) / 100))::numeric * (100)::numeric) / (150)::numeric))::double precision
                END AS point
           FROM ((records
             LEFT JOIN level_rating ON ((records.level_id = level_rating.id)))
             LEFT JOIN users ON ((records.user_id = users.user_id)))
        )
 SELECT tmp.user_id,
    tmp.level_id,
    tmp.video_link,
    tmp.progress,
    tmp.list,
    tmp.point,
    rank() OVER (PARTITION BY tmp.list, tmp.user_id ORDER BY tmp.point DESC) AS no,
        CASE
            WHEN (tmp.list = 'featured'::text) THEN (100)::double precision
            WHEN (tmp.list = 'challenge'::text) THEN (tmp.point / (5)::double precision)
            ELSE tmp.point
        END AS exp
   FROM tmp
  WHERE (tmp.is_hidden = false);


grant delete on table "public"."level_creator" to "anon";

grant insert on table "public"."level_creator" to "anon";

grant references on table "public"."level_creator" to "anon";

grant select on table "public"."level_creator" to "anon";

grant trigger on table "public"."level_creator" to "anon";

grant truncate on table "public"."level_creator" to "anon";

grant update on table "public"."level_creator" to "anon";

grant delete on table "public"."level_creator" to "authenticated";

grant insert on table "public"."level_creator" to "authenticated";

grant references on table "public"."level_creator" to "authenticated";

grant select on table "public"."level_creator" to "authenticated";

grant trigger on table "public"."level_creator" to "authenticated";

grant truncate on table "public"."level_creator" to "authenticated";

grant update on table "public"."level_creator" to "authenticated";

grant delete on table "public"."level_creator" to "service_role";

grant insert on table "public"."level_creator" to "service_role";

grant references on table "public"."level_creator" to "service_role";

grant select on table "public"."level_creator" to "service_role";

grant trigger on table "public"."level_creator" to "service_role";

grant truncate on table "public"."level_creator" to "service_role";

grant update on table "public"."level_creator" to "service_role";

create policy "Enable read access for all users"
on "public"."level_creator"
as permissive
for select
to public
using (true);



