--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: citties; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.citties (
    id integer NOT NULL,
    name character varying,
    train_id integer,
    train_name character varying
);


ALTER TABLE public.citties OWNER TO "Guest";

--
-- Name: citties_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.citties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.citties_id_seq OWNER TO "Guest";

--
-- Name: citties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.citties_id_seq OWNED BY public.citties.id;


--
-- Name: trains; Type: TABLE; Schema: public; Owner: Guest
--

CREATE TABLE public.trains (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.trains OWNER TO "Guest";

--
-- Name: trains_id_seq; Type: SEQUENCE; Schema: public; Owner: Guest
--

CREATE SEQUENCE public.trains_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trains_id_seq OWNER TO "Guest";

--
-- Name: trains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Guest
--

ALTER SEQUENCE public.trains_id_seq OWNED BY public.trains.id;


--
-- Name: citties id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.citties ALTER COLUMN id SET DEFAULT nextval('public.citties_id_seq'::regclass);


--
-- Name: trains id; Type: DEFAULT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.trains ALTER COLUMN id SET DEFAULT nextval('public.trains_id_seq'::regclass);


--
-- Data for Name: citties; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.citties (id, name, train_id, train_name) FROM stdin;
1	Portland	1	\N
2	Clackamas	1	\N
4	Portland	2	\N
\.


--
-- Data for Name: trains; Type: TABLE DATA; Schema: public; Owner: Guest
--

COPY public.trains (id, name) FROM stdin;
1	Blue Train
2	Green Train
\.


--
-- Name: citties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.citties_id_seq', 4, true);


--
-- Name: trains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Guest
--

SELECT pg_catalog.setval('public.trains_id_seq', 2, true);


--
-- Name: citties citties_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.citties
    ADD CONSTRAINT citties_pkey PRIMARY KEY (id);


--
-- Name: trains trains_pkey; Type: CONSTRAINT; Schema: public; Owner: Guest
--

ALTER TABLE ONLY public.trains
    ADD CONSTRAINT trains_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

