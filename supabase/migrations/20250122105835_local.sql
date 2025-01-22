alter table "public"."level_rating" drop constraint "level_rating_list_check";

alter table "public"."level_rating" add constraint "level_rating_list_check" CHECK (((length(list) > 0) AND (list = ANY (ARRAY['demon'::text, 'featured'::text, 'challenge'::text])))) not valid;

alter table "public"."level_rating" validate constraint "level_rating_list_check";


