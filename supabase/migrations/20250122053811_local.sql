create policy "Enable read access for all users"
on "public"."level_rating"
as permissive
for select
to public
using (true);



