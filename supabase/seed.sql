SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."levels" ("id", "created_at", "name", "youtube_video_id", "creator_alt") VALUES
	(71025973, '2025-01-18 10:25:33.965152+00', 'Oblivion', 'bsWqS5QPhz8', 'dice88 & more'),
	(52374843, '2025-01-19 18:16:01.572288+00', 'Zodiac', 'FX9paD5rRsM', 'Bianox and more'),
	(79484035, '2025-01-26 11:17:35.230536+00', 'The Moon Below', '4JA0NXdo4Wc', 'Onvil');


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."user_role" ("name", "add_level", "modify_level", "delete_level", "review_submission", "modify_record", "remove_record", "submit", "edit_own_profile") VALUES
	('default', false, false, false, false, false, false, true, true),
	('trusted', false, false, false, true, false, false, true, true),
	('admin', true, true, true, true, true, true, true, true),
	('banned', false, false, false, false, false, false, false, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."users" ("user_id", "created_at", "name", "city", "province", "role", "is_hidden") VALUES
	('ded6b269-a856-4a49-a1ae-d8837d50e350', '2025-01-18 09:56:19.965229+00', 'default', 'Hạ Long', 'Quảng Ninh', 'default', false),
	('fa49b543-083c-4577-958f-ca86a8e295bd', '2025-01-24 04:02:28.566346+00', 'default1', NULL, NULL, 'default', false),
	('570eef3f-5510-4b72-94f7-b5d325a70d11', '2025-01-26 11:19:35.451648+00', 'Onvil', NULL, NULL, 'default', false);


--
-- Data for Name: level_creator; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."level_creator" ("level_id", "user_id", "is_decorator", "is_gameplay_maker", "part_end", "part_start") VALUES
	(79484035, '570eef3f-5510-4b72-94f7-b5d325a70d11', true, true, 100, 0);


--
-- Data for Name: lists; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."lists" ("name", "description") VALUES
	('demon', 'Hardest demon beaten by Vietnamese'),
	('challenge', 'Quick challenges to hone your skill'),
	('featured', 'Best levels made by Vietnamese');


--
-- Data for Name: level_rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."level_rating" ("id", "list", "rating", "min_progress") VALUES
	(71025973, 'demon', 4100, 60),
	(52374843, 'featured', 2, 100),
	(79484035, 'featured', 2, 100),
	(79484035, 'demon', 3000, 52),
	(52374843, 'demon', 3500, 60);


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."records" ("created_at", "user_id", "level_id", "video_link", "progress", "reviewer_id", "status", "comment", "reviewer_note", "moderator_note") VALUES
	('2025-01-19 18:23:15.798575+00', 'ded6b269-a856-4a49-a1ae-d8837d50e350', 52374843, 'https://www.youtube.com/watch?v=uCuSX3Y004E&pp=ygUKcHJpcyBtYWdpYw%3D%3D', 87, NULL, 1, NULL, NULL, NULL),
	('2025-01-19 18:23:58.679907+00', 'ded6b269-a856-4a49-a1ae-d8837d50e350', 71025973, 'https://www.youtube.com/watch?v=c7E-tgmFuzw&pp=ygUIcG9wIGluIDI%3D', 100, NULL, 1, NULL, NULL, NULL),
	('2025-01-26 13:48:25.821023+00', 'ded6b269-a856-4a49-a1ae-d8837d50e350', 79484035, 'https://www.youtube.com/watch?v=yJWaKc703jc', 100, NULL, 1, NULL, NULL, NULL),
	('2025-01-24 04:03:13.240211+00', 'fa49b543-083c-4577-958f-ca86a8e295bd', 52374843, 'https://www.youtube.com/watch?v=7GJOBkIgWHc', 100, NULL, 1, NULL, NULL, NULL);


--
-- Name: level_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."level_rating_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

RESET ALL;
