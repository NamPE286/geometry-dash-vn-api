drop materialized view if exists "public"."records_view";

create materialized view "public"."records_view" as  WITH tmp AS (
         SELECT records.user_id,
            records.level_id,
            records.progress,
            records.video_link,
            level_rating.list,
            level_rating.rating,
            users.is_hidden,
                CASE
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
    rank() OVER (PARTITION BY tmp.list, tmp.user_id ORDER BY tmp.point DESC) AS no
   FROM tmp
  WHERE (tmp.is_hidden = false);



