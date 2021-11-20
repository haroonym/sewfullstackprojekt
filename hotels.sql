--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: austattungen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.austattungen (
    bezeichnung character varying(50) NOT NULL
);


ALTER TABLE public.austattungen OWNER TO postgres;

--
-- Name: bezirke; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bezirke (
    postleitzahl character(4) NOT NULL,
    bzrk_nr smallint,
    bzrk_name character varying(100)
);


ALTER TABLE public.bezirke OWNER TO postgres;

--
-- Name: hotels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotels (
    hotel_id smallint NOT NULL,
    name character varying(100),
    preis_pro_nacht numeric(5,2),
    bewertung smallint,
    unterkunftsart character varying(50),
    postleitzahl character(4),
    CONSTRAINT positive_price CHECK (((bewertung >= 0) AND (bewertung <= 6)))
);


ALTER TABLE public.hotels OWNER TO postgres;

--
-- Name: hotels_austattungen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotels_austattungen (
    bezeichnungen character varying(50) NOT NULL,
    hotel_id smallint NOT NULL
);


ALTER TABLE public.hotels_austattungen OWNER TO postgres;

--
-- Name: hotels_hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hotels_hotel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hotels_hotel_id_seq OWNER TO postgres;

--
-- Name: hotels_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hotels_hotel_id_seq OWNED BY public.hotels.hotel_id;


--
-- Name: hotels hotel_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels ALTER COLUMN hotel_id SET DEFAULT nextval('public.hotels_hotel_id_seq'::regclass);


--
-- Data for Name: austattungen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.austattungen (bezeichnung) FROM stdin;
Kostenloses WLAN
Pool
Kostenlose Parkplätze
Bar / Lounge
Café
Fitnesstudio
\.


--
-- Data for Name: bezirke; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bezirke (postleitzahl, bzrk_nr, bzrk_name) FROM stdin;
1010	1	Innere Stadt
1020	2	Leopoldstadt
1030	3	Landstraße
1040	4	Wieden
1050	5	Margareten
1060	6	Mariahilf
1070	7	Neubau
1080	8	Josefstadt
1090	9	Alsergrund
1100	10	Favoriten
1110	11	Simmering
1120	12	Meidling
1130	13	Hietzing
1140	14	Penzing
1150	15	Rudolfsheim-Fünfhaus
1160	16	Ottakring
1170	17	Hernals
1180	18	Währing
1190	19	Döbling
1200	20	Brigittenau
1210	21	Floridsdorf
1220	22	Donaustadt
1230	23	Liesing
\.


--
-- Data for Name: hotels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotels (hotel_id, name, preis_pro_nacht, bewertung, unterkunftsart, postleitzahl) FROM stdin;
1	Hotel Josefshof Am Rathau	112.00	4	Hotel	1080
2	Hotel Kaiserhof Wien	156.00	5	Hotel	1040
3	Boutique Hotel Am Stephensplatz	251.00	5	Hotel	1010
4	Apartment with Roof Top Terrace	68.00	3	Ferienwohnung	1090
5	Wombat's City Hostel Vienna The Naschmarkt	32.00	4	Hostel	1040
6	Vienna Hostel Ruthensteiner	52.00	5	Hostel	1150
\.


--
-- Data for Name: hotels_austattungen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotels_austattungen (bezeichnungen, hotel_id) FROM stdin;
Kostenloses WLAN	1
Kostenloses WLAN	2
Kostenloses WLAN	4
Kostenloses WLAN	5
Kostenloses WLAN	6
Pool	3
Kostenlose Parkplätze	1
Kostenlose Parkplätze	2
Bar / Lounge	1
Bar / Lounge	2
Bar / Lounge	3
Café	5
Café	6
Fitnesstudio	3
Fitnesstudio	4
\.


--
-- Name: hotels_hotel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hotels_hotel_id_seq', 6, true);


--
-- Name: austattungen austattungen_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.austattungen
    ADD CONSTRAINT austattungen_pk PRIMARY KEY (bezeichnung);


--
-- Name: bezirke bezirke_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bezirke
    ADD CONSTRAINT bezirke_pk PRIMARY KEY (postleitzahl);


--
-- Name: hotels hotels_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pk PRIMARY KEY (hotel_id);


--
-- Name: austattungen_bezeichnung_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX austattungen_bezeichnung_uindex ON public.austattungen USING btree (bezeichnung);


--
-- Name: bezirke_bzrk_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX bezirke_bzrk_name_uindex ON public.bezirke USING btree (bzrk_name);


--
-- Name: bezirke_bzrk_nr_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX bezirke_bzrk_nr_uindex ON public.bezirke USING btree (bzrk_nr);


--
-- Name: hotels_austattungen bezeichnung___fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels_austattungen
    ADD CONSTRAINT bezeichnung___fk FOREIGN KEY (bezeichnungen) REFERENCES public.austattungen(bezeichnung) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hotels_austattungen hotel_id___fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels_austattungen
    ADD CONSTRAINT hotel_id___fk FOREIGN KEY (hotel_id) REFERENCES public.hotels(hotel_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hotels postleitzahl_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT postleitzahl_fk FOREIGN KEY (postleitzahl) REFERENCES public.bezirke(postleitzahl) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

