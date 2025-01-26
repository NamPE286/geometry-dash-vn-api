alter table "public"."levels" drop constraint "levels_creator_check";

alter table "public"."users" drop constraint "users_name_check";

alter table "public"."levels" drop column "creator";

alter table "public"."levels" add column "creator_alt" text not null;

alter table "public"."levels" add constraint "levels_creator_alt_check" CHECK ((length(creator_alt) > 0)) not valid;

alter table "public"."levels" validate constraint "levels_creator_alt_check";

alter table "public"."users" add constraint "users_name_check" CHECK ((length(name) <= 35)) not valid;

alter table "public"."users" validate constraint "users_name_check";


