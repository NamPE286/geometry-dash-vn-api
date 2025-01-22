create table "public"."level_rating" (
    "id" bigint generated by default as identity not null,
    "list" text not null,
    "rating" bigint not null,
    "min_progress" bigint not null default '100'::bigint
);


alter table "public"."level_rating" enable row level security;

create table "public"."records" (
    "created_at" timestamp with time zone not null default now(),
    "user_id" uuid not null,
    "level_id" bigint not null,
    "video_link" text not null,
    "progress" bigint not null
);


alter table "public"."records" enable row level security;

CREATE UNIQUE INDEX level_rating_pkey ON public.level_rating USING btree (id);

CREATE UNIQUE INDEX records_pkey ON public.records USING btree (user_id, level_id);

alter table "public"."level_rating" add constraint "level_rating_pkey" PRIMARY KEY using index "level_rating_pkey";

alter table "public"."records" add constraint "records_pkey" PRIMARY KEY using index "records_pkey";

alter table "public"."level_rating" add constraint "level_rating_id_fkey" FOREIGN KEY (id) REFERENCES levels(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."level_rating" validate constraint "level_rating_id_fkey";

alter table "public"."level_rating" add constraint "level_rating_list_check" CHECK ((length(list) > 0)) not valid;

alter table "public"."level_rating" validate constraint "level_rating_list_check";

alter table "public"."level_rating" add constraint "level_rating_min_progress_check" CHECK (((min_progress >= 0) AND (min_progress <= 100))) not valid;

alter table "public"."level_rating" validate constraint "level_rating_min_progress_check";

alter table "public"."level_rating" add constraint "level_rating_rating_check" CHECK ((rating > 0)) not valid;

alter table "public"."level_rating" validate constraint "level_rating_rating_check";

alter table "public"."records" add constraint "records_level_id_fkey" FOREIGN KEY (level_id) REFERENCES levels(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."records" validate constraint "records_level_id_fkey";

alter table "public"."records" add constraint "records_progress_check" CHECK (((progress >= 0) AND (progress <= 100))) not valid;

alter table "public"."records" validate constraint "records_progress_check";

alter table "public"."records" add constraint "records_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE SET NULL not valid;

alter table "public"."records" validate constraint "records_user_id_fkey";

alter table "public"."records" add constraint "records_video_link_check" CHECK ((length(video_link) > 0)) not valid;

alter table "public"."records" validate constraint "records_video_link_check";

grant delete on table "public"."level_rating" to "anon";

grant insert on table "public"."level_rating" to "anon";

grant references on table "public"."level_rating" to "anon";

grant select on table "public"."level_rating" to "anon";

grant trigger on table "public"."level_rating" to "anon";

grant truncate on table "public"."level_rating" to "anon";

grant update on table "public"."level_rating" to "anon";

grant delete on table "public"."level_rating" to "authenticated";

grant insert on table "public"."level_rating" to "authenticated";

grant references on table "public"."level_rating" to "authenticated";

grant select on table "public"."level_rating" to "authenticated";

grant trigger on table "public"."level_rating" to "authenticated";

grant truncate on table "public"."level_rating" to "authenticated";

grant update on table "public"."level_rating" to "authenticated";

grant delete on table "public"."level_rating" to "service_role";

grant insert on table "public"."level_rating" to "service_role";

grant references on table "public"."level_rating" to "service_role";

grant select on table "public"."level_rating" to "service_role";

grant trigger on table "public"."level_rating" to "service_role";

grant truncate on table "public"."level_rating" to "service_role";

grant update on table "public"."level_rating" to "service_role";

grant delete on table "public"."records" to "anon";

grant insert on table "public"."records" to "anon";

grant references on table "public"."records" to "anon";

grant select on table "public"."records" to "anon";

grant trigger on table "public"."records" to "anon";

grant truncate on table "public"."records" to "anon";

grant update on table "public"."records" to "anon";

grant delete on table "public"."records" to "authenticated";

grant insert on table "public"."records" to "authenticated";

grant references on table "public"."records" to "authenticated";

grant select on table "public"."records" to "authenticated";

grant trigger on table "public"."records" to "authenticated";

grant truncate on table "public"."records" to "authenticated";

grant update on table "public"."records" to "authenticated";

grant delete on table "public"."records" to "service_role";

grant insert on table "public"."records" to "service_role";

grant references on table "public"."records" to "service_role";

grant select on table "public"."records" to "service_role";

grant trigger on table "public"."records" to "service_role";

grant truncate on table "public"."records" to "service_role";

grant update on table "public"."records" to "service_role";


