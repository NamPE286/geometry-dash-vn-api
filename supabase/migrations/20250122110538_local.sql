alter table "public"."level_rating" drop constraint "level_rating_list_check";

create table "public"."lists" (
    "name" text not null,
    "description" text
);


alter table "public"."lists" enable row level security;

CREATE UNIQUE INDEX lists_pkey ON public.lists USING btree (name);

alter table "public"."lists" add constraint "lists_pkey" PRIMARY KEY using index "lists_pkey";

alter table "public"."level_rating" add constraint "level_rating_list_fkey" FOREIGN KEY (list) REFERENCES lists(name) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."level_rating" validate constraint "level_rating_list_fkey";

grant delete on table "public"."lists" to "anon";

grant insert on table "public"."lists" to "anon";

grant references on table "public"."lists" to "anon";

grant select on table "public"."lists" to "anon";

grant trigger on table "public"."lists" to "anon";

grant truncate on table "public"."lists" to "anon";

grant update on table "public"."lists" to "anon";

grant delete on table "public"."lists" to "authenticated";

grant insert on table "public"."lists" to "authenticated";

grant references on table "public"."lists" to "authenticated";

grant select on table "public"."lists" to "authenticated";

grant trigger on table "public"."lists" to "authenticated";

grant truncate on table "public"."lists" to "authenticated";

grant update on table "public"."lists" to "authenticated";

grant delete on table "public"."lists" to "service_role";

grant insert on table "public"."lists" to "service_role";

grant references on table "public"."lists" to "service_role";

grant select on table "public"."lists" to "service_role";

grant trigger on table "public"."lists" to "service_role";

grant truncate on table "public"."lists" to "service_role";

grant update on table "public"."lists" to "service_role";


