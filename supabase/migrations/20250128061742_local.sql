drop materialized view if exists "public"."records_view";

alter table "public"."records" add column "comment" text;

alter table "public"."records" add column "moderator_note" text;

alter table "public"."records" add column "reviewer_id" uuid;

alter table "public"."records" add column "reviewer_note" text;

alter table "public"."records" add column "status" bigint not null default '0'::bigint;

alter table "public"."records" add constraint "records_reviewer_id_fkey" FOREIGN KEY (reviewer_id) REFERENCES users(user_id) not valid;

alter table "public"."records" validate constraint "records_reviewer_id_fkey";

alter table "public"."records" add constraint "records_status_check" CHECK (((status >= 0) AND (status <= 3))) not valid;

alter table "public"."records" validate constraint "records_status_check";

create materialized view "public"."records_view" as  WITH tmp AS (
         SELECT records.user_id,
            records.level_id,
            records.progress,
            records.video_link,
            level_rating.list,
            level_rating.rating,
            users.is_hidden,
            rank() OVER (PARTITION BY level_rating.list, records.user_id ORDER BY
                CASE
                    WHEN (level_rating.list = 'featured'::text) THEN (0)::double precision
                    WHEN (records.progress = 100) THEN (level_rating.rating)::double precision
                    ELSE ((((((level_rating.rating * records.progress) / 100))::numeric * (100)::numeric) / (150)::numeric))::double precision
                END DESC) AS no
           FROM ((records
             LEFT JOIN level_rating ON ((records.level_id = level_rating.id)))
             LEFT JOIN users ON ((records.user_id = users.user_id)))
        )
 SELECT tmp.user_id,
    tmp.level_id,
    tmp.video_link,
    tmp.progress,
    tmp.list,
        CASE
            WHEN (tmp.list = 'featured'::text) THEN (0)::double precision
            ELSE floor(((
            CASE
                WHEN (tmp.no IS NULL) THEN NULL::double precision
                WHEN (tmp.no = 1) THEN (((tmp.rating * 7) / 10))::double precision
                WHEN ((tmp.no > 1) AND (tmp.no <= 20)) THEN GREATEST((5)::double precision, floor((((tmp.rating * (25 / tmp.no)) / 100))::double precision))
                WHEN ((tmp.no > 20) AND (tmp.no <= 50)) THEN (5)::double precision
                ELSE (1)::double precision
            END * (tmp.progress)::double precision) / (
            CASE
                WHEN (tmp.progress = 100) THEN 100
                ELSE 150
            END)::double precision))
        END AS point,
        CASE
            WHEN (tmp.list = 'featured'::text) THEN (100)::double precision
            WHEN ((tmp.list = 'challenge'::text) AND (tmp.progress = 100)) THEN ((tmp.rating)::double precision / (5)::double precision)
            ELSE (((tmp.rating * tmp.progress) / 100))::double precision
        END AS exp
   FROM tmp
  WHERE (tmp.is_hidden = false);



