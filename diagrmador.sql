--
-- PostgreSQL database dump
--

\restrict Jq8a2EAgxp9ToXVojWoqvjLyDrbfHdvYyXdVjV7JTjNJgQdW1uF8JVhivKhiy3v

-- Dumped from database version 12.22
-- Dumped by pg_dump version 17.10 (Homebrew)

-- Started on 2026-11-10 10:54:08 -04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: dev
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO dev;

--
-- TOC entry 2 (class 3079 OID 963310)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 963396)
-- Name: diagram_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diagram_activity (
    id bigint NOT NULL,
    diagram_id integer NOT NULL,
    user_id integer,
    user_name character varying(100) NOT NULL,
    action_type character varying(30) NOT NULL,
    element_id character varying(100),
    element_label character varying(150),
    payload jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.diagram_activity OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 963394)
-- Name: diagram_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diagram_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diagram_activity_id_seq OWNER TO postgres;

--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 209
-- Name: diagram_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diagram_activity_id_seq OWNED BY public.diagram_activity.id;


--
-- TOC entry 208 (class 1259 OID 963373)
-- Name: diagram_collaborators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diagram_collaborators (
    id integer NOT NULL,
    diagram_id integer NOT NULL,
    user_id integer NOT NULL,
    first_joined_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.diagram_collaborators OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 963371)
-- Name: diagram_collaborators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diagram_collaborators_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diagram_collaborators_id_seq OWNER TO postgres;

--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 207
-- Name: diagram_collaborators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diagram_collaborators_id_seq OWNED BY public.diagram_collaborators.id;


--
-- TOC entry 206 (class 1259 OID 963349)
-- Name: diagrams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diagrams (
    id integer NOT NULL,
    name character varying(150) DEFAULT 'Diagrama sin título'::character varying NOT NULL,
    owner_id integer NOT NULL,
    share_token uuid DEFAULT public.gen_random_uuid() NOT NULL,
    graph_data jsonb DEFAULT '{"cells": []}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.diagrams OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 963347)
-- Name: diagrams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diagrams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diagrams_id_seq OWNER TO postgres;

--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 205
-- Name: diagrams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diagrams_id_seq OWNED BY public.diagrams.id;


--
-- TOC entry 211 (class 1259 OID 963418)
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 963300)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100),
    email character varying(100),
    password character varying(100) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 963298)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 203
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3230 (class 2604 OID 963399)
-- Name: diagram_activity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_activity ALTER COLUMN id SET DEFAULT nextval('public.diagram_activity_id_seq'::regclass);


--
-- TOC entry 3227 (class 2604 OID 963376)
-- Name: diagram_collaborators id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_collaborators ALTER COLUMN id SET DEFAULT nextval('public.diagram_collaborators_id_seq'::regclass);


--
-- TOC entry 3221 (class 2604 OID 963352)
-- Name: diagrams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagrams ALTER COLUMN id SET DEFAULT nextval('public.diagrams_id_seq'::regclass);


--
-- TOC entry 3220 (class 2604 OID 963303)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3391 (class 0 OID 963396)
-- Dependencies: 210
-- Data for Name: diagram_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diagram_activity (id, diagram_id, user_id, user_name, action_type, element_id, element_label, payload, created_at) FROM stdin;
57	2	1	Rister Yasir Arce Cuéllar	class:update	class_sjlvqjhzj	\N	{"patch": {"position": {"x": 30, "y": 500}}, "elementId": "class_sjlvqjhzj"}	2026-09-16 01:08:21.08703-04
58	2	5	dddd	class:add	class_hie9zit5u	categoría	{"name": "categoría", "methods": [], "position": {"x": 95, "y": 297}, "elementId": "class_hie9zit5u", "attributes": ["+ nombre:string"], "stereotype": "none"}	2026-09-16 01:12:45.240229-04
59	2	5	dddd	class:add	class_3joau2jxs	producto	{"name": "producto", "methods": [], "position": {"x": 179, "y": 167}, "elementId": "class_3joau2jxs", "attributes": ["+ nombre:string", "+ precio:number", "+ fecha:string"], "stereotype": "none"}	2026-09-16 01:13:39.086863-04
60	2	5	dddd	class:update	class_rmdtw4mbd	\N	{"patch": {"methods": [], "attributes": ["+ nombre:string"]}, "elementId": "class_rmdtw4mbd"}	2026-09-16 01:13:39.093027-04
61	2	5	dddd	class:update	class_wr7yvge88	\N	{"patch": {"methods": [], "attributes": ["+ nombre:string"]}, "elementId": "class_wr7yvge88"}	2026-09-16 01:13:39.093974-04
62	2	5	dddd	class:update	class_sjlvqjhzj	\N	{"patch": {"methods": [], "attributes": []}, "elementId": "class_sjlvqjhzj"}	2026-09-16 01:13:39.095057-04
63	2	5	dddd	class:update	class_fui33bpfo	\N	{"patch": {"methods": [], "attributes": []}, "elementId": "class_fui33bpfo"}	2026-09-16 01:13:39.095873-04
64	2	5	dddd	class:update	class_wr7yvge88	\N	{"patch": {"methods": [], "attributes": []}, "elementId": "class_wr7yvge88"}	2026-09-16 01:13:39.096462-04
65	2	5	dddd	class:add	class_2o4py2c36	venta	{"name": "venta", "methods": [], "position": {"x": 125, "y": 127}, "elementId": "class_2o4py2c36", "attributes": ["+ nombre:string", "+ numeroVenta:number", "+ pago:number", "+ fecha:string"], "stereotype": "none"}	2026-09-16 01:13:59.884276-04
66	2	5	dddd	class:update	class_2o4py2c36	\N	{"patch": {"position": {"x": 170, "y": 170}}, "elementId": "class_2o4py2c36"}	2026-09-16 01:14:09.5832-04
67	2	5	dddd	class:update	class_2o4py2c36	\N	{"patch": {"position": {"x": 350, "y": 450}}, "elementId": "class_2o4py2c36"}	2026-09-16 01:14:12.50673-04
68	2	5	dddd	link:add	link_ypjh7rs96	composition	{"type": "composition", "linkId": "link_ypjh7rs96", "sourceId": "class_2o4py2c36", "targetId": "class_3joau2jxs", "sourceMultiplicity": "1", "targetMultiplicity": "*"}	2026-09-16 01:14:41.94356-04
69	2	5	dddd	class:update	class_2o4py2c36	\N	{"patch": {"position": {"x": 650, "y": 180}}, "elementId": "class_2o4py2c36"}	2026-09-16 01:14:56.591201-04
70	2	1	Rister Yasir Arce Cuéllar	class:add	class_dm1g4po9p	Clase	{"name": "Clase", "methods": [], "position": {"x": 100, "y": 50}, "elementId": "class_dm1g4po9p", "attributes": [], "stereotype": "none"}	2026-09-19 17:18:52.402701-04
71	2	1	Rister Yasir Arce Cuéllar	class:update	class_dm1g4po9p	\N	{"patch": {"position": {"x": 530, "y": 540}}, "elementId": "class_dm1g4po9p"}	2026-09-19 17:18:54.820833-04
72	2	1	Rister Yasir Arce Cuéllar	class:add	class_cb3v13m71	Clase	{"name": "Clase", "methods": [], "position": {"x": 100, "y": 50}, "elementId": "class_cb3v13m71", "attributes": [], "stereotype": "none"}	2026-09-19 17:19:06.94366-04
73	2	1	Rister Yasir Arce Cuéllar	class:update	class_cb3v13m71	\N	{"patch": {"position": {"x": 100, "y": 60}}, "elementId": "class_cb3v13m71"}	2026-09-19 17:19:07.893714-04
74	2	1	Rister Yasir Arce Cuéllar	class:update	class_cb3v13m71	\N	{"patch": {"position": {"x": 140, "y": 240}}, "elementId": "class_cb3v13m71"}	2026-09-19 17:19:09.801557-04
75	2	1	Rister Yasir Arce Cuéllar	class:update	class_cb3v13m71	\N	{"patch": {"position": {"x": 90, "y": 170}}, "elementId": "class_cb3v13m71"}	2026-09-19 17:19:11.362214-04
76	2	1	Rister Yasir Arce Cuéllar	link:add	link_bwnhdrhau	dependency	{"type": "dependency", "linkId": "link_bwnhdrhau", "sourceId": "class_sjlvqjhzj", "targetId": "class_dm1g4po9p"}	2026-09-19 17:19:20.417908-04
77	2	1	Rister Yasir Arce Cuéllar	class:update	class_dm1g4po9p	\N	{"patch": {"position": {"x": 530, "y": 540}}, "elementId": "class_dm1g4po9p"}	2026-09-19 17:19:20.510166-04
78	2	1	Rister Yasir Arce Cuéllar	link:update	link_bwnhdrhau	\N	{"patch": {"sourceMultiplicity": "", "targetMultiplicity": ""}, "linkId": "link_bwnhdrhau"}	2026-09-19 17:19:22.000786-04
79	7	1	Rister Yasir Arce Cuéllar	class:add	class_qbgsxvzkg	Clase	{"name": "Clase", "methods": [], "position": {"x": 100, "y": 50}, "elementId": "class_qbgsxvzkg", "attributes": [], "stereotype": "none"}	2026-10-17 21:53:33.40859-04
80	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 100, "y": 50}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:31:12.641112-04
81	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 80, "y": 130}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:31:13.789887-04
82	7	1	Rister Yasir Arce Cuéllar	class:add	class_wlpti4ps5	Clase	{"name": "Clase", "methods": [], "position": {"x": 100, "y": 50}, "elementId": "class_wlpti4ps5", "attributes": [], "stereotype": "none"}	2026-10-17 22:31:18.488832-04
83	7	1	Rister Yasir Arce Cuéllar	class:update	class_wlpti4ps5	\N	{"patch": {"position": {"x": 100, "y": 50}}, "elementId": "class_wlpti4ps5"}	2026-10-17 22:31:19.604531-04
84	7	1	Rister Yasir Arce Cuéllar	class:update	class_wlpti4ps5	\N	{"patch": {"position": {"x": 550, "y": 90}}, "elementId": "class_wlpti4ps5"}	2026-10-17 22:31:20.598785-04
85	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 80, "y": 130}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:31:22.048423-04
86	7	1	Rister Yasir Arce Cuéllar	link:add	link_w5sa4nmce	composition	{"type": "composition", "linkId": "link_w5sa4nmce", "sourceId": "class_wlpti4ps5", "targetId": "class_qbgsxvzkg"}	2026-10-17 22:31:25.304357-04
87	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 80, "y": 130}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:31:25.448181-04
88	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 80, "y": 130}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:42:38.450279-04
89	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 80, "y": 130}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:42:39.511924-04
90	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 80, "y": 130}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:46:26.629406-04
91	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 80, "y": 130}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:46:27.340122-04
92	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	\N	{"patch": {"position": {"x": 80, "y": 130}}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:46:28.8914-04
93	7	1	Rister Yasir Arce Cuéllar	class:update	class_qbgsxvzkg	Clase23	{"patch": {"name": "Clase23", "stereotype": "none"}, "elementId": "class_qbgsxvzkg"}	2026-10-17 22:46:34.393398-04
94	7	1	Rister Yasir Arce Cuéllar	class:add	class_il1fof91g	Categoria	{"name": "Categoria", "methods": ["+ save(): void"], "position": {"x": 640, "y": 80}, "elementId": "class_il1fof91g", "attributes": ["+ id: string", "+ name: string"], "stereotype": "none"}	2026-10-18 00:18:30.859084-04
95	7	1	Rister Yasir Arce Cuéllar	class:add	class_02cukkgsh	Productos	{"name": "Productos", "methods": ["+ save(): void"], "position": {"x": 920, "y": 80}, "elementId": "class_02cukkgsh", "attributes": ["+ id: string", "+ name: string", "+ price: string"], "stereotype": "none"}	2026-10-18 00:18:30.869863-04
96	7	1	Rister Yasir Arce Cuéllar	class:update	class_il1fof91g	\N	{"patch": {"position": {"x": 640, "y": 80}}, "elementId": "class_il1fof91g"}	2026-10-18 00:18:37.920176-04
97	7	1	Rister Yasir Arce Cuéllar	class:update	class_il1fof91g	\N	{"patch": {"position": {"x": 640, "y": 80}}, "elementId": "class_il1fof91g"}	2026-10-18 00:18:38.586862-04
98	7	1	Rister Yasir Arce Cuéllar	class:update	class_il1fof91g	\N	{"patch": {"position": {"x": 350, "y": 320}}, "elementId": "class_il1fof91g"}	2026-10-18 00:18:40.343828-04
99	7	1	Rister Yasir Arce Cuéllar	class:update	class_02cukkgsh	\N	{"patch": {"position": {"x": 730, "y": 340}}, "elementId": "class_02cukkgsh"}	2026-10-18 00:18:42.685557-04
100	7	1	Rister Yasir Arce Cuéllar	class:update	class_il1fof91g	\N	{"patch": {"position": {"x": 350, "y": 320}}, "elementId": "class_il1fof91g"}	2026-10-18 00:18:44.577732-04
101	7	1	Rister Yasir Arce Cuéllar	class:update	class_il1fof91g	\N	{"patch": {"position": {"x": 350, "y": 320}}, "elementId": "class_il1fof91g"}	2026-10-18 00:18:48.217195-04
102	7	1	Rister Yasir Arce Cuéllar	link:add	link_u9coipvv7	association	{"type": "association", "linkId": "link_u9coipvv7", "sourceId": "class_il1fof91g", "targetId": "class_02cukkgsh"}	2026-10-18 00:18:51.324458-04
103	7	1	Rister Yasir Arce Cuéllar	class:update	class_02cukkgsh	\N	{"patch": {"position": {"x": 730, "y": 340}}, "elementId": "class_02cukkgsh"}	2026-10-18 00:18:51.467712-04
104	7	1	Rister Yasir Arce Cuéllar	link:update	link_u9coipvv7	\N	{"patch": {"sourceMultiplicity": "1", "targetMultiplicity": "0"}, "linkId": "link_u9coipvv7"}	2026-10-18 00:18:57.622149-04
105	7	1	Rister Yasir Arce Cuéllar	class:update	class_il1fof91g	\N	{"patch": {"position": {"x": 300, "y": 390}}, "elementId": "class_il1fof91g"}	2026-10-18 00:19:19.412109-04
106	7	1	Rister Yasir Arce Cuéllar	class:add	class_4cfre80be	Person	{"name": "Person", "methods": ["+ hasParkingPass(): bool"], "position": {"x": 80, "y": 280}, "elementId": "class_4cfre80be", "attributes": ["+ name: string", "+ age: int", "+ phoneNumber: double", "+ emailAddress: string"], "stereotype": "none"}	2026-10-18 01:24:46.044505-04
107	7	1	Rister Yasir Arce Cuéllar	class:add	class_oaiz53h67	Address	{"name": "Address", "methods": ["+ validate(): bool"], "position": {"x": 360, "y": 280}, "elementId": "class_oaiz53h67", "attributes": ["+ street: string", "+ city: string", "+ state: string", "+ postalCode: string", "+ country: string"], "stereotype": "none"}	2026-10-18 01:24:46.052474-04
108	7	1	Rister Yasir Arce Cuéllar	class:add	class_jtaohtjnk	Student	{"name": "Student", "methods": ["+ isEligibleToEnroll(Student): bool", "+ getSeminarHistory(): list", "+ takeExamination(): void"], "position": {"x": 640, "y": 280}, "elementId": "class_jtaohtjnk", "attributes": ["+ studentNumber: double"], "stereotype": "none"}	2026-10-18 01:24:46.054516-04
109	7	1	Rister Yasir Arce Cuéllar	class:add	class_5g9w3su4c	Professor	{"name": "Professor", "methods": ["+ applyExamination(): void"], "position": {"x": 920, "y": 280}, "elementId": "class_5g9w3su4c", "attributes": ["+ listOfStudents: list", "+ Salary: double"], "stereotype": "none"}	2026-10-18 01:24:46.05612-04
110	7	1	Rister Yasir Arce Cuéllar	link:add	link_ahccjqvqe	association	{"type": "association", "linkId": "link_ahccjqvqe", "sourceId": "class_4cfre80be", "targetId": "class_oaiz53h67"}	2026-10-18 01:24:46.057306-04
111	7	1	Rister Yasir Arce Cuéllar	class:update	class_4cfre80be	\N	{"patch": {"position": {"x": 100, "y": 530}}, "elementId": "class_4cfre80be"}	2026-10-18 01:24:53.339491-04
112	7	1	Rister Yasir Arce Cuéllar	class:update	class_oaiz53h67	\N	{"patch": {"position": {"x": 710, "y": 580}}, "elementId": "class_oaiz53h67"}	2026-10-18 01:24:55.213522-04
113	7	1	Rister Yasir Arce Cuéllar	class:update	class_jtaohtjnk	\N	{"patch": {"position": {"x": 1100, "y": 470}}, "elementId": "class_jtaohtjnk"}	2026-10-18 01:24:57.930099-04
114	7	1	Rister Yasir Arce Cuéllar	class:update	class_5g9w3su4c	\N	{"patch": {"position": {"x": 1060, "y": 260}}, "elementId": "class_5g9w3su4c"}	2026-10-18 01:24:59.963229-04
115	9	1	Rister Yasir Arce Cuéllar	class:add	class_qlmpfggma	Categoria	{"name": "Categoria", "methods": ["+ agregarProducto(Producto): void", "+ eliminarProducto(Producto): void"], "position": {"x": 80, "y": 80}, "elementId": "class_qlmpfggma", "attributes": ["- id: Integer", "- nombre: String"], "stereotype": "none"}	2026-10-18 10:50:41.324195-04
116	9	1	Rister Yasir Arce Cuéllar	class:add	class_os6cnh307	Producto	{"name": "Producto", "methods": ["+ calcularDescuento(): Double", "+ obtenerPrecioConDescuento(): Double"], "position": {"x": 360, "y": 80}, "elementId": "class_os6cnh307", "attributes": ["- id: Integer", "- nombre: String", "- precio: Double", "- descripcion: String"], "stereotype": "none"}	2026-10-18 10:50:41.339151-04
117	9	1	Rister Yasir Arce Cuéllar	class:add	class_a7mofgm63	Factura	{"name": "Factura", "methods": ["+ generarFactura(): void", "+ calcularTotal(): Double"], "position": {"x": 640, "y": 80}, "elementId": "class_a7mofgm63", "attributes": ["- id: Integer", "- fecha: Date", "- total: Double", "- cliente: Cliente"], "stereotype": "none"}	2026-10-18 10:50:41.346541-04
118	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 310, "y": 380}}, "elementId": "class_os6cnh307"}	2026-10-18 10:50:48.089971-04
119	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 310, "y": 380}}, "elementId": "class_os6cnh307"}	2026-10-18 10:50:49.670635-04
120	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 310, "y": 380}}, "elementId": "class_os6cnh307"}	2026-10-18 10:50:50.123546-04
121	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 340, "y": 390}}, "elementId": "class_os6cnh307"}	2026-10-18 10:50:52.511637-04
122	9	1	Rister Yasir Arce Cuéllar	class:update	class_a7mofgm63	\N	{"patch": {"position": {"x": 790, "y": 90}}, "elementId": "class_a7mofgm63"}	2026-10-18 10:50:54.119403-04
123	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 340, "y": 390}}, "elementId": "class_os6cnh307"}	2026-10-18 10:50:55.289943-04
124	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 350, "y": 380}}, "elementId": "class_os6cnh307"}	2026-10-18 10:50:56.456648-04
125	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 460, "y": 300}}, "elementId": "class_os6cnh307"}	2026-10-18 10:50:57.70974-04
126	9	1	Rister Yasir Arce Cuéllar	class:add	class_k1sj5nil8	Person	{"name": "Person", "methods": ["+ hasParkingPass(): Boolean"], "position": {"x": 920, "y": 80}, "elementId": "class_k1sj5nil8", "attributes": ["+ name: String", "+ age: Integer", "+ phoneNumber: Double", "+ emailAddress: String", "+ hasParkingPass: Boolean"], "stereotype": "none"}	2026-10-18 10:52:11.987074-04
127	9	1	Rister Yasir Arce Cuéllar	class:add	class_j1uv6s54p	Student	{"name": "Student", "methods": ["+ getSeminarHistory(): List", "+ takeExamination(): void"], "position": {"x": 80, "y": 280}, "elementId": "class_j1uv6s54p", "attributes": ["+ studentNumber: Double", "+ isEligibleToEnroll: Boolean"], "stereotype": "none"}	2026-10-18 10:52:11.991204-04
128	9	1	Rister Yasir Arce Cuéllar	class:add	class_kcfwjtpkj	Professor	{"name": "Professor", "methods": ["+ applyExamination(): void"], "position": {"x": 360, "y": 280}, "elementId": "class_kcfwjtpkj", "attributes": ["+ listOfStudents: List", "+ salary: Double"], "stereotype": "none"}	2026-10-18 10:52:11.992258-04
129	9	1	Rister Yasir Arce Cuéllar	link:add	link_g9vn2ob0p	association	{"type": "association", "linkId": "link_g9vn2ob0p", "sourceId": "class_j1uv6s54p", "targetId": "class_k1sj5nil8", "sourceMultiplicity": "1", "targetMultiplicity": "1"}	2026-10-18 10:52:11.993131-04
130	9	1	Rister Yasir Arce Cuéllar	link:add	link_hj461lv7m	association	{"type": "association", "linkId": "link_hj461lv7m", "sourceId": "class_kcfwjtpkj", "targetId": "class_k1sj5nil8", "sourceMultiplicity": "1", "targetMultiplicity": "1"}	2026-10-18 10:52:11.994286-04
131	9	1	Rister Yasir Arce Cuéllar	class:update	class_kcfwjtpkj	\N	{"patch": {"position": {"x": 310, "y": 550}}, "elementId": "class_kcfwjtpkj"}	2026-10-18 10:52:18.038508-04
132	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 420, "y": 80}}, "elementId": "class_os6cnh307"}	2026-10-18 10:52:20.49035-04
133	9	1	Rister Yasir Arce Cuéllar	class:update	class_k1sj5nil8	\N	{"patch": {"position": {"x": 940, "y": 380}}, "elementId": "class_k1sj5nil8"}	2026-10-18 10:52:22.942545-04
134	9	1	Rister Yasir Arce Cuéllar	class:update	class_os6cnh307	\N	{"patch": {"position": {"x": 420, "y": 80}}, "elementId": "class_os6cnh307"}	2026-10-18 10:55:45.15449-04
135	9	1	Rister Yasir Arce Cuéllar	class:update	class_kcfwjtpkj	\N	{"patch": {"position": {"x": 150, "y": 590}}, "elementId": "class_kcfwjtpkj"}	2026-10-18 10:55:49.221654-04
136	9	1	Rister Yasir Arce Cuéllar	class:update	class_j1uv6s54p	\N	{"patch": {"position": {"x": 100, "y": 350}}, "elementId": "class_j1uv6s54p"}	2026-10-18 10:56:36.238285-04
137	10	1	Rister Yasir Arce Cuéllar	class:add	class_hfkvlngmq	Address	{"name": "Address", "methods": ["+ validate(): bool"], "position": {"x": 80, "y": 80}, "elementId": "class_hfkvlngmq", "attributes": ["+ street: String", "+ city: String", "+ state: String", "+ postalCode: String", "+ country: String"], "stereotype": "none"}	2026-10-18 14:05:10.82771-04
138	10	1	Rister Yasir Arce Cuéllar	class:add	class_4lco2llot	Student	{"name": "Student", "methods": ["+ isEligibleToEnroll(Student): bool", "+ takeExamination(): void"], "position": {"x": 360, "y": 80}, "elementId": "class_4lco2llot", "attributes": ["+ studentNumber: double"], "stereotype": "none"}	2026-10-18 14:05:10.834183-04
139	10	1	Rister Yasir Arce Cuéllar	class:add	class_p9icfro2x	Professor	{"name": "Professor", "methods": ["+ applyExamination(): void"], "position": {"x": 640, "y": 80}, "elementId": "class_p9icfro2x", "attributes": ["+ listOfStudents: list", "+ salary: double"], "stereotype": "none"}	2026-10-18 14:05:10.836426-04
140	10	1	Rister Yasir Arce Cuéllar	class:update	class_hfkvlngmq	\N	{"patch": {"position": {"x": 60, "y": 140}}, "elementId": "class_hfkvlngmq"}	2026-10-18 14:05:15.267157-04
141	10	1	Rister Yasir Arce Cuéllar	class:update	class_4lco2llot	\N	{"patch": {"position": {"x": 360, "y": 140}}, "elementId": "class_4lco2llot"}	2026-10-18 14:05:16.716549-04
142	10	1	Rister Yasir Arce Cuéllar	class:update	class_p9icfro2x	\N	{"patch": {"position": {"x": 640, "y": 150}}, "elementId": "class_p9icfro2x"}	2026-10-18 14:05:18.583873-04
143	10	1	Rister Yasir Arce Cuéllar	class:add	class_sibu30ukv	Categoria	{"name": "Categoria", "methods": [], "position": {"x": 920, "y": 80}, "elementId": "class_sibu30ukv", "attributes": ["- id: int", "- nombre: String"], "stereotype": "none"}	2026-10-18 14:07:13.953902-04
144	10	1	Rister Yasir Arce Cuéllar	class:add	class_x9ie5hqwi	Producto	{"name": "Producto", "methods": [], "position": {"x": 80, "y": 280}, "elementId": "class_x9ie5hqwi", "attributes": ["- id: int", "- nombre: String", "- precio: double", "- stock: int"], "stereotype": "none"}	2026-10-18 14:07:13.958219-04
145	10	1	Rister Yasir Arce Cuéllar	class:add	class_1lsfiat83	Factura	{"name": "Factura", "methods": [], "position": {"x": 360, "y": 280}, "elementId": "class_1lsfiat83", "attributes": ["- id: int", "- fecha: Date", "- total: double"], "stereotype": "none"}	2026-10-18 14:07:13.959008-04
146	10	1	Rister Yasir Arce Cuéllar	class:update	class_1lsfiat83	\N	{"patch": {"position": {"x": 340, "y": 410}}, "elementId": "class_1lsfiat83"}	2026-10-18 14:07:17.124267-04
147	10	1	Rister Yasir Arce Cuéllar	class:update	class_x9ie5hqwi	\N	{"patch": {"position": {"x": 50, "y": 430}}, "elementId": "class_x9ie5hqwi"}	2026-10-18 14:07:18.649504-04
148	10	1	Rister Yasir Arce Cuéllar	class:update	class_sibu30ukv	\N	{"patch": {"position": {"x": 710, "y": 420}}, "elementId": "class_sibu30ukv"}	2026-10-18 14:07:21.24013-04
149	10	1	Rister Yasir Arce Cuéllar	class:update	class_sibu30ukv	\N	{"patch": {"position": {"x": 650, "y": 390}}, "elementId": "class_sibu30ukv"}	2026-10-18 14:07:22.583828-04
150	10	1	Rister Yasir Arce Cuéllar	class:update	class_1lsfiat83	\N	{"patch": {"position": {"x": 340, "y": 410}}, "elementId": "class_1lsfiat83"}	2026-10-18 14:07:24.089816-04
151	10	1	Rister Yasir Arce Cuéllar	class:update	class_x9ie5hqwi	\N	{"patch": {"position": {"x": 50, "y": 430}}, "elementId": "class_x9ie5hqwi"}	2026-10-18 14:07:26.298961-04
152	10	1	Rister Yasir Arce Cuéllar	class:update	class_x9ie5hqwi	\N	{"patch": {"position": {"x": 50, "y": 390}}, "elementId": "class_x9ie5hqwi"}	2026-10-18 14:07:29.148264-04
153	10	1	Rister Yasir Arce Cuéllar	class:update	class_1lsfiat83	\N	{"patch": {"position": {"x": 330, "y": 500}}, "elementId": "class_1lsfiat83"}	2026-10-18 14:07:31.823368-04
154	10	1	Rister Yasir Arce Cuéllar	class:update	class_1lsfiat83	\N	{"patch": {"position": {"x": 330, "y": 500}}, "elementId": "class_1lsfiat83"}	2026-10-18 14:07:33.348654-04
155	10	1	Rister Yasir Arce Cuéllar	class:update	class_1lsfiat83	\N	{"patch": {"position": {"x": 360, "y": 530}}, "elementId": "class_1lsfiat83"}	2026-10-18 14:07:35.365259-04
156	10	1	Rister Yasir Arce Cuéllar	class:update	class_1lsfiat83	\N	{"patch": {"position": {"x": 360, "y": 530}}, "elementId": "class_1lsfiat83"}	2026-10-18 14:11:33.035102-04
157	10	1	Rister Yasir Arce Cuéllar	class:update	class_1lsfiat83	\N	{"patch": {"position": {"x": 360, "y": 530}}, "elementId": "class_1lsfiat83"}	2026-10-18 14:11:33.534458-04
158	10	1	Rister Yasir Arce Cuéllar	class:update	class_1lsfiat83	\N	{"patch": {"position": {"x": 360, "y": 530}}, "elementId": "class_1lsfiat83"}	2026-10-18 14:11:34.126289-04
159	10	1	Rister Yasir Arce Cuéllar	class:remove	class_1lsfiat83	\N	{"elementId": "class_1lsfiat83"}	2026-10-18 14:11:36.526868-04
160	10	1	Rister Yasir Arce Cuéllar	class:update	class_hfkvlngmq	\N	{"patch": {"position": {"x": 60, "y": 140}}, "elementId": "class_hfkvlngmq"}	2026-10-18 14:11:37.226519-04
161	10	1	Rister Yasir Arce Cuéllar	class:remove	class_hfkvlngmq	\N	{"elementId": "class_hfkvlngmq"}	2026-10-18 14:11:39.457631-04
162	10	1	Rister Yasir Arce Cuéllar	class:update	class_4lco2llot	\N	{"patch": {"position": {"x": 360, "y": 140}}, "elementId": "class_4lco2llot"}	2026-10-18 14:11:40.309177-04
163	10	1	Rister Yasir Arce Cuéllar	class:remove	class_4lco2llot	\N	{"elementId": "class_4lco2llot"}	2026-10-18 14:11:42.215394-04
164	10	1	Rister Yasir Arce Cuéllar	class:update	class_p9icfro2x	\N	{"patch": {"position": {"x": 640, "y": 150}}, "elementId": "class_p9icfro2x"}	2026-10-18 14:11:42.776626-04
165	10	1	Rister Yasir Arce Cuéllar	class:remove	class_p9icfro2x	\N	{"elementId": "class_p9icfro2x"}	2026-10-18 14:11:45.107877-04
166	10	1	Rister Yasir Arce Cuéllar	class:add	class_8eoft0y4e	Person	{"name": "Person", "methods": ["+ getSeminarHistory(): list", "+ takeExamination(): void"], "position": {"x": 640, "y": 80}, "elementId": "class_8eoft0y4e", "attributes": ["- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String", "- hasParkingPass: bool"], "stereotype": "none"}	2026-10-18 14:13:04.436236-04
167	10	1	Rister Yasir Arce Cuéllar	class:add	class_vte00fklp	Address	{"name": "Address", "methods": ["+ validate(): bool"], "position": {"x": 920, "y": 80}, "elementId": "class_vte00fklp", "attributes": ["- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"], "stereotype": "none"}	2026-10-18 14:13:04.439775-04
168	10	1	Rister Yasir Arce Cuéllar	class:add	class_e5f9zkfsy	Student	{"name": "Student", "methods": ["+ isEligibleToEnroll(Student): bool", "+ takeExamination(): void"], "position": {"x": 80, "y": 280}, "elementId": "class_e5f9zkfsy", "attributes": ["- studentNumber: double"], "stereotype": "none"}	2026-10-18 14:13:04.441823-04
169	10	1	Rister Yasir Arce Cuéllar	class:add	class_xkgt4qt1d	Professor	{"name": "Professor", "methods": ["+ applyExamination(): void"], "position": {"x": 360, "y": 280}, "elementId": "class_xkgt4qt1d", "attributes": ["- listOfStudents: list", "- salary: double"], "stereotype": "none"}	2026-10-18 14:13:04.443525-04
170	10	1	Rister Yasir Arce Cuéllar	link:add	link_wrixtnzwd	association	{"type": "association", "linkId": "link_wrixtnzwd", "sourceId": "class_8eoft0y4e", "targetId": "class_vte00fklp", "sourceMultiplicity": "0..1", "targetMultiplicity": "1"}	2026-10-18 14:13:04.445959-04
171	10	1	Rister Yasir Arce Cuéllar	link:add	link_ria0h010p	association	{"type": "association", "linkId": "link_ria0h010p", "sourceId": "class_e5f9zkfsy", "targetId": "class_8eoft0y4e", "sourceMultiplicity": "1", "targetMultiplicity": "1"}	2026-10-18 14:13:04.4479-04
172	10	1	Rister Yasir Arce Cuéllar	link:add	link_b68cfjosb	association	{"type": "association", "linkId": "link_b68cfjosb", "sourceId": "class_xkgt4qt1d", "targetId": "class_8eoft0y4e", "sourceMultiplicity": "1", "targetMultiplicity": "1"}	2026-10-18 14:13:04.449503-04
173	10	1	Rister Yasir Arce Cuéllar	class:update	class_8eoft0y4e	\N	{"patch": {"position": {"x": 510, "y": 0}}, "elementId": "class_8eoft0y4e"}	2026-10-18 14:13:10.476083-04
174	10	1	Rister Yasir Arce Cuéllar	class:update	class_vte00fklp	\N	{"patch": {"position": {"x": 910, "y": 150}}, "elementId": "class_vte00fklp"}	2026-10-18 14:13:12.388685-04
175	10	1	Rister Yasir Arce Cuéllar	class:update	class_sibu30ukv	\N	{"patch": {"position": {"x": 600, "y": 590}}, "elementId": "class_sibu30ukv"}	2026-10-18 14:13:15.475329-04
176	10	1	Rister Yasir Arce Cuéllar	class:update	class_x9ie5hqwi	\N	{"patch": {"position": {"x": 60, "y": 610}}, "elementId": "class_x9ie5hqwi"}	2026-10-18 14:13:17.608921-04
177	10	1	Rister Yasir Arce Cuéllar	class:add	class_xjrpl764r	Asignacion	{"name": "Asignacion", "methods": [], "position": {"x": 640, "y": 280}, "elementId": "class_xjrpl764r", "attributes": ["- estado: String"], "stereotype": "none"}	2026-10-24 22:29:18.091827-04
178	10	1	Rister Yasir Arce Cuéllar	class:add	class_pq8zh0zvf	Estado	{"name": "Estado", "methods": [], "position": {"x": 920, "y": 280}, "elementId": "class_pq8zh0zvf", "attributes": ["- nombre: String"], "stereotype": "none"}	2026-10-24 22:29:18.096953-04
179	10	1	Rister Yasir Arce Cuéllar	link:add	link_ef7bdsp7a	association	{"type": "association", "linkId": "link_ef7bdsp7a", "sourceId": "class_xjrpl764r", "targetId": "class_pq8zh0zvf", "sourceMultiplicity": "1", "targetMultiplicity": "0..*"}	2026-10-24 22:29:18.099415-04
180	10	1	Rister Yasir Arce Cuéllar	class:update	class_xkgt4qt1d	\N	{"patch": {"position": {"x": 360, "y": 280}}, "elementId": "class_xkgt4qt1d"}	2026-10-24 22:29:36.800299-04
181	11	1	Rister Yasir Arce Cuéllar	class:add	class_4iz9adeft	Person	{"name": "Person", "methods": ["+ livesAt(): void"], "position": {"x": 80, "y": 80}, "elementId": "class_4iz9adeft", "attributes": ["- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String", "- hasParkingPass: bool"], "stereotype": "none"}	2026-10-24 22:59:01.903212-04
182	11	1	Rister Yasir Arce Cuéllar	class:add	class_izm4ugi4o	Address	{"name": "Address", "methods": ["+ validate(): bool"], "position": {"x": 360, "y": 80}, "elementId": "class_izm4ugi4o", "attributes": ["- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"], "stereotype": "none"}	2026-10-24 22:59:01.905774-04
183	11	1	Rister Yasir Arce Cuéllar	class:add	class_d827o0r72	Student	{"name": "Student", "methods": ["+ isEligibleToEnroll(Student): bool", "+ getSeminarHistory(): list", "+ takeExamination(): void"], "position": {"x": 640, "y": 80}, "elementId": "class_d827o0r72", "attributes": ["- studentNumber: double"], "stereotype": "none"}	2026-10-24 22:59:01.906823-04
184	11	1	Rister Yasir Arce Cuéllar	class:add	class_y4j3etu16	Professor	{"name": "Professor", "methods": ["+ applyExamination(): void"], "position": {"x": 920, "y": 80}, "elementId": "class_y4j3etu16", "attributes": ["- listOfStudents: list", "- salary: double"], "stereotype": "none"}	2026-10-24 22:59:01.908165-04
185	11	1	Rister Yasir Arce Cuéllar	link:add	link_lez0e6cma	inheritance	{"type": "inheritance", "linkId": "link_lez0e6cma", "sourceId": "class_d827o0r72", "targetId": "class_4iz9adeft", "sourceMultiplicity": "1", "targetMultiplicity": "1"}	2026-10-24 22:59:01.909223-04
186	11	1	Rister Yasir Arce Cuéllar	link:add	link_f33pvcja9	inheritance	{"type": "inheritance", "linkId": "link_f33pvcja9", "sourceId": "class_y4j3etu16", "targetId": "class_4iz9adeft", "sourceMultiplicity": "1", "targetMultiplicity": "1"}	2026-10-24 22:59:01.910336-04
187	11	1	Rister Yasir Arce Cuéllar	link:add	link_8nn9wjhao	association	{"type": "association", "linkId": "link_8nn9wjhao", "sourceId": "class_4iz9adeft", "targetId": "class_izm4ugi4o", "sourceMultiplicity": "1", "targetMultiplicity": "0..1"}	2026-10-24 22:59:01.910893-04
188	11	1	Rister Yasir Arce Cuéllar	class:update	class_4iz9adeft	\N	{"patch": {"position": {"x": 80, "y": 80}}, "elementId": "class_4iz9adeft"}	2026-10-24 22:59:04.7643-04
189	11	1	Rister Yasir Arce Cuéllar	class:update	class_4iz9adeft	\N	{"patch": {"position": {"x": 170, "y": 680}}, "elementId": "class_4iz9adeft"}	2026-10-24 22:59:06.705447-04
190	12	1	Rister Yasir Arce Cuéllar	class:add	class_ja7j4lvys	Person	{"name": "Person", "methods": ["+ hasParkingPass(): bool"], "position": {"x": 80, "y": 80}, "elementId": "class_ja7j4lvys", "attributes": ["- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String"], "stereotype": "none"}	2026-10-24 23:15:31.956379-04
191	12	1	Rister Yasir Arce Cuéllar	class:add	class_0o2iwq6av	Address	{"name": "Address", "methods": ["+ validate(): bool"], "position": {"x": 360, "y": 80}, "elementId": "class_0o2iwq6av", "attributes": ["- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"], "stereotype": "none"}	2026-10-24 23:15:31.959142-04
192	12	1	Rister Yasir Arce Cuéllar	class:add	class_goh0xaka9	Student	{"name": "Student", "methods": ["+ isEligibleToEnroll(Student): bool", "+ getSeminarHistory(): list", "+ takeExamination(): void"], "position": {"x": 640, "y": 80}, "elementId": "class_goh0xaka9", "attributes": ["- studentNumber: double"], "stereotype": "none"}	2026-10-24 23:15:31.960218-04
193	12	1	Rister Yasir Arce Cuéllar	class:add	class_t32nvv1x4	Professor	{"name": "Professor", "methods": ["+ applyExamination(): void"], "position": {"x": 920, "y": 80}, "elementId": "class_t32nvv1x4", "attributes": ["- listOfStudents: list", "- salary: double"], "stereotype": "none"}	2026-10-24 23:15:31.961165-04
194	12	1	Rister Yasir Arce Cuéllar	class:update	class_0o2iwq6av	\N	{"patch": {"position": {"x": 250, "y": 470}}, "elementId": "class_0o2iwq6av"}	2026-10-24 23:15:39.958859-04
195	12	1	Rister Yasir Arce Cuéllar	class:add	class_lu25nphiu	Pedido	{"name": "Pedido", "methods": ["+ placeOrder(): void"], "position": {"x": 80, "y": 280}, "elementId": "class_lu25nphiu", "attributes": ["- orderNumber: String", "- orderDate: Date"], "stereotype": "none"}	2026-10-24 23:16:04.82524-04
196	12	1	Rister Yasir Arce Cuéllar	link:add	link_85ic66i4g	association	{"type": "association", "linkId": "link_85ic66i4g", "sourceId": "class_goh0xaka9", "targetId": "class_lu25nphiu", "sourceMultiplicity": "0..*", "targetMultiplicity": "1"}	2026-10-24 23:16:04.827146-04
197	12	1	Rister Yasir Arce Cuéllar	link:add	link_0jhotf2lw	association	{"type": "association", "linkId": "link_0jhotf2lw", "sourceId": "class_t32nvv1x4", "targetId": "class_lu25nphiu", "sourceMultiplicity": "0..*", "targetMultiplicity": "1"}	2026-10-24 23:16:04.828065-04
198	12	1	Rister Yasir Arce Cuéllar	class:update	class_lu25nphiu	\N	{"patch": {"position": {"x": 40, "y": 290}}, "elementId": "class_lu25nphiu"}	2026-10-24 23:16:08.1642-04
199	12	1	Rister Yasir Arce Cuéllar	class:update	class_lu25nphiu	\N	{"patch": {"position": {"x": 180, "y": 290}}, "elementId": "class_lu25nphiu"}	2026-10-24 23:16:09.489347-04
200	12	1	Rister Yasir Arce Cuéllar	class:update	class_ja7j4lvys	\N	{"patch": {"position": {"x": 80, "y": 80}}, "elementId": "class_ja7j4lvys"}	2026-10-24 23:16:13.740606-04
201	12	1	Rister Yasir Arce Cuéllar	class:update	class_ja7j4lvys	\N	{"patch": {"position": {"x": 80, "y": 80}}, "elementId": "class_ja7j4lvys"}	2026-10-24 23:16:14.698301-04
202	12	1	Rister Yasir Arce Cuéllar	class:remove	class_ja7j4lvys	\N	{"elementId": "class_ja7j4lvys"}	2026-10-24 23:16:17.443541-04
203	12	1	Rister Yasir Arce Cuéllar	class:update	class_0o2iwq6av	\N	{"patch": {"attributes": ["- id: Long", "- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"]}, "elementId": "class_0o2iwq6av"}	2026-10-24 23:19:41.345858-04
204	12	1	Rister Yasir Arce Cuéllar	class:update	class_goh0xaka9	\N	{"patch": {"attributes": ["- id: Long", "- studentNumber: double"]}, "elementId": "class_goh0xaka9"}	2026-10-24 23:19:41.349919-04
205	12	1	Rister Yasir Arce Cuéllar	class:update	class_lu25nphiu	\N	{"patch": {"attributes": ["- id: Long", "- orderNumber: String", "- orderDate: Date"]}, "elementId": "class_lu25nphiu"}	2026-10-24 23:19:41.354914-04
206	12	1	Rister Yasir Arce Cuéllar	class:update	class_t32nvv1x4	\N	{"patch": {"attributes": ["- id: Long", "- listOfStudents: list", "- salary: double"]}, "elementId": "class_t32nvv1x4"}	2026-10-24 23:19:41.355212-04
207	12	1	Rister Yasir Arce Cuéllar	link:remove	link_0jhotf2lw	\N	{"linkId": "link_0jhotf2lw"}	2026-10-24 23:20:45.775743-04
208	12	1	Rister Yasir Arce Cuéllar	link:remove	link_85ic66i4g	\N	{"linkId": "link_85ic66i4g"}	2026-10-24 23:20:45.775496-04
209	12	1	Rister Yasir Arce Cuéllar	class:remove	class_0o2iwq6av	\N	{"elementId": "class_0o2iwq6av"}	2026-10-24 23:20:45.777373-04
210	12	1	Rister Yasir Arce Cuéllar	class:remove	class_goh0xaka9	\N	{"elementId": "class_goh0xaka9"}	2026-10-24 23:20:45.78044-04
211	12	1	Rister Yasir Arce Cuéllar	class:remove	class_t32nvv1x4	\N	{"elementId": "class_t32nvv1x4"}	2026-10-24 23:20:45.793268-04
212	12	1	Rister Yasir Arce Cuéllar	class:remove	class_lu25nphiu	\N	{"elementId": "class_lu25nphiu"}	2026-10-24 23:20:45.794758-04
213	12	1	Rister Yasir Arce Cuéllar	class:add	class_1jshcclfw	Person	{"name": "Person", "methods": ["+ livesAt(): void"], "position": {"x": 80, "y": 80}, "elementId": "class_1jshcclfw", "attributes": ["- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String", "- hasParkingPass: bool"], "stereotype": "none"}	2026-10-24 23:21:52.818231-04
214	12	1	Rister Yasir Arce Cuéllar	class:add	class_e7zop3kuy	Address	{"name": "Address", "methods": ["+ validate(): bool"], "position": {"x": 360, "y": 80}, "elementId": "class_e7zop3kuy", "attributes": ["- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"], "stereotype": "none"}	2026-10-24 23:21:52.825904-04
215	12	1	Rister Yasir Arce Cuéllar	class:add	class_pqu3r39n1	Student	{"name": "Student", "methods": ["+ isEligibleToEnroll(Student): bool", "+ getSeminarHistory(): list", "+ takeExamination(): void"], "position": {"x": 640, "y": 80}, "elementId": "class_pqu3r39n1", "attributes": ["- studentNumber: double"], "stereotype": "none"}	2026-10-24 23:21:52.827361-04
216	12	1	Rister Yasir Arce Cuéllar	class:add	class_8qvg1kwp3	Professor	{"name": "Professor", "methods": ["+ applyExamination(): void"], "position": {"x": 920, "y": 80}, "elementId": "class_8qvg1kwp3", "attributes": ["- listOfStudents: list", "- salary: double"], "stereotype": "none"}	2026-10-24 23:21:52.828654-04
217	12	1	Rister Yasir Arce Cuéllar	class:update	class_e7zop3kuy	\N	{"patch": {"position": {"x": 150, "y": 460}}, "elementId": "class_e7zop3kuy"}	2026-10-24 23:22:00.400016-04
218	12	1	Rister Yasir Arce Cuéllar	class:update	class_1jshcclfw	\N	{"patch": {"attributes": ["- id: Long", "- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String", "- hasParkingPass: bool"]}, "elementId": "class_1jshcclfw"}	2026-10-24 23:22:09.813356-04
219	12	1	Rister Yasir Arce Cuéllar	class:update	class_e7zop3kuy	\N	{"patch": {"attributes": ["- id: Long", "- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"]}, "elementId": "class_e7zop3kuy"}	2026-10-24 23:22:09.820333-04
220	12	1	Rister Yasir Arce Cuéllar	class:update	class_8qvg1kwp3	\N	{"patch": {"attributes": ["- id: Long", "- listOfStudents: list", "- salary: double"]}, "elementId": "class_8qvg1kwp3"}	2026-10-24 23:22:09.821379-04
221	12	1	Rister Yasir Arce Cuéllar	class:update	class_pqu3r39n1	\N	{"patch": {"attributes": ["- id: Long", "- studentNumber: double"]}, "elementId": "class_pqu3r39n1"}	2026-10-24 23:22:09.821199-04
222	12	1	Rister Yasir Arce Cuéllar	class:update	class_1jshcclfw	\N	{"patch": {"attributes": ["- id: Long", "- name: String", "- age: int", "- phoneNumber: String", "- emailAddress: String", "- hasParkingPass: bool"]}, "elementId": "class_1jshcclfw"}	2026-10-24 23:27:20.692151-04
223	12	1	Rister Yasir Arce Cuéllar	class:update	class_e7zop3kuy	\N	{"patch": {"attributes": ["- id: Long", "- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: Integer"]}, "elementId": "class_e7zop3kuy"}	2026-10-24 23:27:20.701503-04
224	12	1	Rister Yasir Arce Cuéllar	class:update	class_pqu3r39n1	\N	{"patch": {"attributes": ["- id: Long", "- studentNumber: String"]}, "elementId": "class_pqu3r39n1"}	2026-10-24 23:27:20.701591-04
225	12	1	Rister Yasir Arce Cuéllar	class:update	class_8qvg1kwp3	\N	{"patch": {"attributes": ["- id: Long", "- salary: String"]}, "elementId": "class_8qvg1kwp3"}	2026-10-24 23:27:20.703611-04
226	12	1	Rister Yasir Arce Cuéllar	link:add	link_b3zq85skd	association	{"type": "association", "linkId": "link_b3zq85skd", "sourceId": "class_8qvg1kwp3", "targetId": "class_pqu3r39n1", "sourceMultiplicity": "1", "targetMultiplicity": "0..*"}	2026-10-24 23:27:20.70811-04
227	12	1	Rister Yasir Arce Cuéllar	class:remove	class_1jshcclfw	\N	{"elementId": "class_1jshcclfw"}	2026-10-24 23:27:51.12438-04
228	12	1	Rister Yasir Arce Cuéllar	link:remove	link_b3zq85skd	\N	{"linkId": "link_b3zq85skd"}	2026-10-24 23:27:51.125474-04
229	12	1	Rister Yasir Arce Cuéllar	class:remove	class_e7zop3kuy	\N	{"elementId": "class_e7zop3kuy"}	2026-10-24 23:27:51.126598-04
230	12	1	Rister Yasir Arce Cuéllar	class:remove	class_8qvg1kwp3	\N	{"elementId": "class_8qvg1kwp3"}	2026-10-24 23:27:51.127801-04
231	12	1	Rister Yasir Arce Cuéllar	class:remove	class_pqu3r39n1	\N	{"elementId": "class_pqu3r39n1"}	2026-10-24 23:27:51.128087-04
232	12	1	Rister Yasir Arce Cuéllar	class:add	class_q8afu60wd	Person	{"name": "Person", "methods": ["+ livesAt(): void"], "position": {"x": 80, "y": 80}, "elementId": "class_q8afu60wd", "attributes": ["- id: Long", "- name: String", "- age: Integer", "- phoneNumber: String", "- emailAddress: String", "- hasParkingPass: Boolean"], "stereotype": "none"}	2026-10-24 23:28:25.782173-04
233	12	1	Rister Yasir Arce Cuéllar	class:add	class_qzrxabh9m	Address	{"name": "Address", "methods": ["+ validate(): Boolean"], "position": {"x": 360, "y": 80}, "elementId": "class_qzrxabh9m", "attributes": ["- id: Long", "- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: Integer"], "stereotype": "none"}	2026-10-24 23:28:25.789628-04
234	12	1	Rister Yasir Arce Cuéllar	class:add	class_o1s7odadm	Student	{"name": "Student", "methods": ["+ isEligibleToEnroll(student: Student): Boolean", "+ getSeminarHistory(): void", "+ takeExamination(): void"], "position": {"x": 640, "y": 80}, "elementId": "class_o1s7odadm", "attributes": ["- id: Long", "- studentNumber: String"], "stereotype": "none"}	2026-10-24 23:28:25.79155-04
235	12	1	Rister Yasir Arce Cuéllar	class:add	class_nn921nseu	Professor	{"name": "Professor", "methods": ["+ applyExamination(): void"], "position": {"x": 920, "y": 80}, "elementId": "class_nn921nseu", "attributes": ["- id: Long", "- salary: String"], "stereotype": "none"}	2026-10-24 23:28:25.792624-04
236	12	1	Rister Yasir Arce Cuéllar	link:add	link_gux4udtp7	association	{"type": "association", "linkId": "link_gux4udtp7", "sourceId": "class_q8afu60wd", "targetId": "class_qzrxabh9m", "sourceMultiplicity": "1", "targetMultiplicity": "0..1"}	2026-10-24 23:28:25.793568-04
237	12	1	Rister Yasir Arce Cuéllar	link:add	link_ihcj13i6d	inheritance	{"type": "inheritance", "linkId": "link_ihcj13i6d", "sourceId": "class_q8afu60wd", "targetId": "class_o1s7odadm", "sourceMultiplicity": "1", "targetMultiplicity": "1..*"}	2026-10-24 23:28:25.794626-04
238	12	1	Rister Yasir Arce Cuéllar	link:add	link_syj4cbgro	inheritance	{"type": "inheritance", "linkId": "link_syj4cbgro", "sourceId": "class_q8afu60wd", "targetId": "class_nn921nseu", "sourceMultiplicity": "1", "targetMultiplicity": "1..*"}	2026-10-24 23:28:25.79542-04
239	12	1	Rister Yasir Arce Cuéllar	class:update	class_q8afu60wd	\N	{"patch": {"position": {"x": 90, "y": 710}}, "elementId": "class_q8afu60wd"}	2026-10-24 23:28:29.715411-04
240	12	1	Rister Yasir Arce Cuéllar	class:add	class_veg5iaexh	Clase	{"name": "Clase", "methods": [], "position": {"x": 100, "y": 50}, "elementId": "class_veg5iaexh", "attributes": ["- id: Long"], "stereotype": "none"}	2026-10-25 17:48:06.931891-04
241	12	1	Rister Yasir Arce Cuéllar	ai:user	\N	user	{"kind": "text", "role": "user", "text": "eliminame las calses sobrantes, y cambia los atributos de todas las clases a espaniool", "authorName": "Rister Yasir Arce Cuéllar"}	2026-10-25 17:50:21.275272-04
242	12	\N	TRAZO	ai:assistant	\N	assistant	{"kind": "proposal", "role": "assistant", "text": "Se eliminarán las clases sobrantes y se cambiarán los atributos a español. Las clases que se eliminarán son Address y Clase, ya que no tienen relaciones con otras clases. Los atributos de las clases restantes se actualizarán a su versión en español. Se mantendrán las relaciones existentes entre Person, Student y Professor.", "authorName": "TRAZO"}	2026-10-25 17:50:27.388357-04
243	12	1	Rister Yasir Arce Cuéllar	class:remove	class_qzrxabh9m	\N	{"elementId": "class_qzrxabh9m"}	2026-10-25 17:50:31.356745-04
244	12	1	Rister Yasir Arce Cuéllar	class:remove	class_veg5iaexh	\N	{"elementId": "class_veg5iaexh"}	2026-10-25 17:50:31.357726-04
245	12	1	Rister Yasir Arce Cuéllar	class:update	class_q8afu60wd	\N	{"patch": {"methods": ["+ viveEn(): void"], "attributes": ["- id: Long", "- nombre: String", "- edad: Integer", "- telefono: String", "- correoElectronico: String", "- tieneTarjetaDeEstacionamiento: String"]}, "elementId": "class_q8afu60wd"}	2026-10-25 17:50:31.358709-04
246	12	1	Rister Yasir Arce Cuéllar	class:update	class_o1s7odadm	\N	{"patch": {"methods": ["+ esElegibleParaInscribirse(estudiante: Student): Boolean", "+ obtenerHistorialDeSeminarios(): void", "+ presentarExamen(): void"], "attributes": ["- id: Long", "- numeroEstudiante: String"]}, "elementId": "class_o1s7odadm"}	2026-10-25 17:50:31.359722-04
247	12	1	Rister Yasir Arce Cuéllar	class:update	class_nn921nseu	\N	{"patch": {"methods": ["+ aplicarExamen(): void"], "attributes": ["- id: Long", "- salario: String"]}, "elementId": "class_nn921nseu"}	2026-10-25 17:50:31.360878-04
248	12	1	Rister Yasir Arce Cuéllar	ai:system	\N	system	{"kind": "applied", "role": "system", "text": "Rister Yasir Arce Cuéllar aplicó 5 cambios en la sala.", "authorName": "Rister Yasir Arce Cuéllar"}	2026-10-25 17:50:31.361992-04
249	12	1	Rister Yasir Arce Cuéllar	class:update	class_q8afu60wd	\N	{"patch": {"position": {"x": 720, "y": 460}}, "elementId": "class_q8afu60wd"}	2026-10-25 17:50:40.798679-04
250	13	1	Rister Yasir Arce Cuéllar	class:update	class_44fasmtzb	\N	{"patch": {"position": {"x": 260, "y": 390}}, "elementId": "class_44fasmtzb"}	2026-10-30 21:58:50.308669-04
251	13	1	Rister Yasir Arce Cuéllar	class:update	class_44fasmtzb	\N	{"patch": {"position": {"x": 470, "y": 450}}, "elementId": "class_44fasmtzb"}	2026-10-30 21:58:52.810789-04
252	13	1	Rister Yasir Arce Cuéllar	class:update	class_e64dhmrsb	\N	{"patch": {"position": {"x": 880, "y": 70}}, "elementId": "class_e64dhmrsb"}	2026-10-30 21:58:55.139402-04
253	12	1	Rister Yasir Arce Cuéllar	class:update	class_o1s7odadm	\N	{"patch": {"position": {"x": 450, "y": 80}}, "elementId": "class_o1s7odadm"}	2026-10-30 21:59:11.481826-04
254	12	1	Rister Yasir Arce Cuéllar	ai:user	\N	user	{"kind": "text", "role": "user", "text": "quiero que me cambies los nombres de las clases actuales a espaniol", "authorName": "Rister Yasir Arce Cuéllar"}	2026-10-30 21:59:54.939561-04
255	12	\N	TRAZO	ai:assistant	\N	assistant	{"kind": "proposal", "role": "assistant", "text": "Para Rister Yasir Arce Cuéllar: Se cambiarán los nombres de las clases a español. Las clases 'Person', 'Student' y 'Professor' se renombrarán a 'Persona', 'Estudiante' y 'Profesor', respectivamente. Además, se mantendrán las relaciones de herencia existentes entre las clases. No se eliminarán atributos ni métodos, solo se actualizarán los nombres de las clases. Las relaciones de herencia se conservarán tal como están.", "authorName": "TRAZO"}	2026-10-30 21:59:58.51533-04
256	12	1	Rister Yasir Arce Cuéllar	class:update	class_q8afu60wd	Persona	{"patch": {"name": "Persona"}, "elementId": "class_q8afu60wd"}	2026-10-30 22:00:00.828258-04
257	12	1	Rister Yasir Arce Cuéllar	class:update	class_o1s7odadm	Estudiante	{"patch": {"name": "Estudiante"}, "elementId": "class_o1s7odadm"}	2026-10-30 22:00:00.830503-04
258	12	1	Rister Yasir Arce Cuéllar	class:update	class_nn921nseu	Profesor	{"patch": {"name": "Profesor"}, "elementId": "class_nn921nseu"}	2026-10-30 22:00:00.831723-04
259	12	1	Rister Yasir Arce Cuéllar	ai:system	\N	system	{"kind": "applied", "role": "system", "text": "Rister Yasir Arce Cuéllar aplicó 3 cambios en la sala.", "authorName": "Rister Yasir Arce Cuéllar"}	2026-10-30 22:00:00.832767-04
260	12	1	Rister Yasir Arce Cuéllar	ai:user	\N	user	{"kind": "text", "role": "user", "text": "cambiame los nombres de las clases a espaniol", "authorName": "Rister Yasir Arce Cuéllar"}	2026-10-30 22:10:23.94521-04
261	12	\N	TRAZO	ai:assistant	\N	assistant	{"kind": "modify", "role": "assistant", "text": "Para Rister Yasir Arce Cuéllar: Se cambiarán los nombres de las clases a español. Las clases 'Persona', 'Estudiante' y 'Profesor' se mantendrán con sus nombres actuales, ya que ya están en español. No se realizarán cambios adicionales en atributos o métodos. Las relaciones de herencia existentes se conservarán. No se eliminarán ni agregarán clases en este cambio.", "authorName": "TRAZO"}	2026-10-30 22:10:26.780175-04
262	12	1	Rister Yasir Arce Cuéllar	class:update	class_o1s7odadm	\N	{"patch": {"position": {"x": 450, "y": 80}}, "elementId": "class_o1s7odadm"}	2026-10-30 22:11:54.966249-04
263	12	1	Rister Yasir Arce Cuéllar	class:update	class_o1s7odadm	\N	{"patch": {"position": {"x": 450, "y": 80}}, "elementId": "class_o1s7odadm"}	2026-10-30 22:11:55.669836-04
264	14	1	Rister Yasir Arce Cuéllar	class:update	class_ot468sk9y	\N	{"patch": {"position": {"x": 450, "y": 400}}, "elementId": "class_ot468sk9y"}	2026-10-30 22:12:18.72362-04
265	14	12	pepe	ai:user	\N	user	{"kind": "text", "role": "user", "text": "cambiame los nombres de las clases a espaniol", "authorName": "pepe"}	2026-10-30 22:12:48.792573-04
266	14	\N	TRAZO	ai:assistant	\N	assistant	{"kind": "modify", "role": "assistant", "text": "Para pepe: No encontré la clase «Persona».", "authorName": "TRAZO"}	2026-10-30 22:12:53.420645-04
267	14	12	pepe	ai:user	\N	user	{"kind": "text", "role": "user", "text": "revisa las clases y cambia los nombres de las clases a espaniol", "authorName": "pepe"}	2026-10-30 22:14:22.91611-04
268	14	\N	TRAZO	ai:assistant	\N	assistant	{"kind": "proposal", "role": "assistant", "text": "Para pepe: He cambiado los nombres de las clases a español. La clase 'Person' se renombrará a 'Persona', 'Student' a 'Estudiante' y 'Professor' a 'Profesor'. Además, se mantendrán las relaciones de herencia existentes. No se requieren nuevas relaciones en este cambio.", "authorName": "TRAZO"}	2026-10-30 22:14:24.977997-04
269	14	12	pepe	class:update	class_ot468sk9y	Persona	{"patch": {"name": "Persona"}, "elementId": "class_ot468sk9y"}	2026-10-30 22:14:28.085779-04
270	14	12	pepe	class:update	class_w99ssny55	Estudiante	{"patch": {"name": "Estudiante"}, "elementId": "class_w99ssny55"}	2026-10-30 22:14:28.089709-04
271	14	12	pepe	class:update	class_r1g88jii9	Profesor	{"patch": {"name": "Profesor"}, "elementId": "class_r1g88jii9"}	2026-10-30 22:14:28.093049-04
272	14	12	pepe	ai:system	\N	system	{"kind": "applied", "role": "system", "text": "pepe aplicó 3 cambios en la sala.", "authorName": "pepe"}	2026-10-30 22:14:28.095486-04
273	14	1	Rister Yasir Arce Cuéllar	class:update	class_w99ssny55	\N	{"patch": {"position": {"x": 360, "y": 60}}, "elementId": "class_w99ssny55"}	2026-10-30 22:14:44.36041-04
\.


--
-- TOC entry 3389 (class 0 OID 963373)
-- Dependencies: 208
-- Data for Name: diagram_collaborators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diagram_collaborators (id, diagram_id, user_id, first_joined_at, last_seen_at) FROM stdin;
89	13	1	2026-10-30 21:58:29.158778-04	2026-10-30 21:58:45.801386-04
92	12	11	2026-10-30 22:00:49.086254-04	2026-10-30 22:00:49.086254-04
93	12	12	2026-10-30 22:01:42.634173-04	2026-10-30 22:09:53.32007-04
15	2	5	2026-09-16 01:01:18.432987-04	2026-09-16 01:12:22.47517-04
58	12	1	2026-10-24 23:14:26.99898-04	2026-10-30 22:10:02.049913-04
16	2	1	2026-09-16 01:01:29.824865-04	2026-09-19 17:19:00.021778-04
106	14	12	2026-10-30 22:12:31.417157-04	2026-10-30 22:19:29.94141-04
31	7	1	2026-10-17 21:53:23.588615-04	2026-10-18 01:23:47.352888-04
45	8	1	2026-10-18 01:36:07.413232-04	2026-10-18 01:43:17.12693-04
47	9	1	2026-10-18 01:57:09.427452-04	2026-10-18 10:50:20.016402-04
50	10	1	2026-10-18 14:02:55.526365-04	2026-10-24 22:57:40.730903-04
55	11	1	2026-10-24 22:58:23.580465-04	2026-10-24 23:05:52.286385-04
104	14	1	2026-10-30 22:12:05.657845-04	2026-10-30 23:06:10.628785-04
\.


--
-- TOC entry 3387 (class 0 OID 963349)
-- Dependencies: 206
-- Data for Name: diagrams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diagrams (id, name, owner_id, share_token, graph_data, created_at, updated_at) FROM stdin;
10	uuuuu	1	997e1827-2a88-4df7-a57a-b44cbb3f7a09	{"cells": [{"z": 4, "id": "class_sibu30ukv", "name": "Categoria", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Categoria", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: int\\n- nombre: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 20, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": [], "umlName": "Categoria", "position": {"x": 600, "y": 590}, "attributes": ["- id: int", "- nombre: String"], "umlMethods": [], "umlAttributes": ["- id: int", "- nombre: String"], "umlStereotype": "none"}, {"z": 5, "id": "class_x9ie5hqwi", "name": "Producto", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Producto", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 100, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: int\\n- nombre: String\\n- precio: double\\n- stock: int", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 20, "stroke": "#1b4332", "transform": "translate(0,140)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": [], "umlName": "Producto", "position": {"x": 60, "y": 610}, "attributes": ["- id: int", "- nombre: String", "- precio: double", "- stock: int"], "umlMethods": [], "umlAttributes": ["- id: int", "- nombre: String", "- precio: double", "- stock: int"], "umlStereotype": "none"}, {"z": 6, "id": "class_8eoft0y4e", "name": "Person", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Person", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 120, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- name: String\\n- age: int\\n- phoneNumber: double\\n- emailAddress: String\\n- hasParkingPass: bool", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 60, "stroke": "#1b4332", "transform": "translate(0,160)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ getSeminarHistory(): list\\n+ takeExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ getSeminarHistory(): list", "+ takeExamination(): void"], "umlName": "Person", "position": {"x": 510, "y": 0}, "attributes": ["- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String", "- hasParkingPass: bool"], "umlMethods": ["+ getSeminarHistory(): list", "+ takeExamination(): void"], "umlAttributes": ["- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String", "- hasParkingPass: bool"], "umlStereotype": "none"}, {"z": 7, "id": "class_vte00fklp", "name": "Address", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Address", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 120, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- street: String\\n- city: String\\n- state: String\\n- postalCode: String\\n- country: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,160)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ validate(): bool", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ validate(): bool"], "umlName": "Address", "position": {"x": 910, "y": 150}, "attributes": ["- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"], "umlMethods": ["+ validate(): bool"], "umlAttributes": ["- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"], "umlStereotype": "none"}, {"z": 8, "id": "class_e5f9zkfsy", "name": "Student", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Student", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 40, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- studentNumber: double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 60, "stroke": "#1b4332", "transform": "translate(0,80)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ isEligibleToEnroll(Student): bool\\n+ takeExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ isEligibleToEnroll(Student): bool", "+ takeExamination(): void"], "umlName": "Student", "position": {"x": 80, "y": 280}, "attributes": ["- studentNumber: double"], "umlMethods": ["+ isEligibleToEnroll(Student): bool", "+ takeExamination(): void"], "umlAttributes": ["- studentNumber: double"], "umlStereotype": "none"}, {"z": 9, "id": "class_xkgt4qt1d", "name": "Professor", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Professor", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- listOfStudents: list\\n- salary: double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ applyExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ applyExamination(): void"], "umlName": "Professor", "position": {"x": 360, "y": 280}, "attributes": ["- listOfStudents: list", "- salary: double"], "umlMethods": ["+ applyExamination(): void"], "umlAttributes": ["- listOfStudents: list", "- salary: double"], "umlStereotype": "none"}, {"z": 10, "id": "link_wrixtnzwd", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "0..1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_8eoft0y4e"}, "target": {"id": "class_vte00fklp"}, "umlType": "association"}, {"z": 11, "id": "link_ria0h010p", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_e5f9zkfsy"}, "target": {"id": "class_8eoft0y4e"}, "umlType": "association"}, {"z": 12, "id": "link_b68cfjosb", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_xkgt4qt1d"}, "target": {"id": "class_8eoft0y4e"}, "umlType": "association"}, {"z": 13, "id": "class_xjrpl764r", "name": "Asignacion", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Asignacion", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 40, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- estado: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 20, "stroke": "#1b4332", "transform": "translate(0,80)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": [], "umlName": "Asignacion", "position": {"x": 640, "y": 280}, "attributes": ["- estado: String"], "umlMethods": [], "umlAttributes": ["- estado: String"], "umlStereotype": "none"}, {"z": 14, "id": "class_pq8zh0zvf", "name": "Estado", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Estado", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 40, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- nombre: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 20, "stroke": "#1b4332", "transform": "translate(0,80)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": [], "umlName": "Estado", "position": {"x": 920, "y": 280}, "attributes": ["- nombre: String"], "umlMethods": [], "umlAttributes": ["- nombre: String"], "umlStereotype": "none"}, {"z": 15, "id": "link_ef7bdsp7a", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "0..*", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_xjrpl764r"}, "target": {"id": "class_pq8zh0zvf"}, "umlType": "association"}]}	2026-10-18 14:02:55.490561-04	2026-10-24 22:57:51.63233-04
9	new	1	0f465a8e-2c11-49c5-a45f-e62f8104cc18	{"cells": [{"z": 1, "id": "class_qlmpfggma", "name": "Categoria", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Categoria", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Integer\\n- nombre: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 60, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ agregarProducto(Producto): void\\n+ eliminarProducto(Producto): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ agregarProducto(Producto): void", "+ eliminarProducto(Producto): void"], "umlName": "Categoria", "position": {"x": 80, "y": 80}, "attributes": ["- id: Integer", "- nombre: String"], "umlMethods": ["+ agregarProducto(Producto): void", "+ eliminarProducto(Producto): void"], "umlAttributes": ["- id: Integer", "- nombre: String"], "umlStereotype": "none"}, {"z": 2, "id": "class_os6cnh307", "name": "Producto", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Producto", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 100, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Integer\\n- nombre: String\\n- precio: Double\\n- descripcion: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 60, "stroke": "#1b4332", "transform": "translate(0,140)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ calcularDescuento(): Double\\n+ obtenerPrecioConDescuento(): Double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ calcularDescuento(): Double", "+ obtenerPrecioConDescuento(): Double"], "umlName": "Producto", "position": {"x": 420, "y": 80}, "attributes": ["- id: Integer", "- nombre: String", "- precio: Double", "- descripcion: String"], "umlMethods": ["+ calcularDescuento(): Double", "+ obtenerPrecioConDescuento(): Double"], "umlAttributes": ["- id: Integer", "- nombre: String", "- precio: Double", "- descripcion: String"], "umlStereotype": "none"}, {"z": 3, "id": "class_a7mofgm63", "name": "Factura", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Factura", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 100, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Integer\\n- fecha: Date\\n- total: Double\\n- cliente: Cliente", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 60, "stroke": "#1b4332", "transform": "translate(0,140)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ generarFactura(): void\\n+ calcularTotal(): Double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ generarFactura(): void", "+ calcularTotal(): Double"], "umlName": "Factura", "position": {"x": 790, "y": 90}, "attributes": ["- id: Integer", "- fecha: Date", "- total: Double", "- cliente: Cliente"], "umlMethods": ["+ generarFactura(): void", "+ calcularTotal(): Double"], "umlAttributes": ["- id: Integer", "- fecha: Date", "- total: Double", "- cliente: Cliente"], "umlStereotype": "none"}, {"z": 4, "id": "class_k1sj5nil8", "name": "Person", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Person", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 120, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ name: String\\n+ age: Integer\\n+ phoneNumber: Double\\n+ emailAddress: String\\n+ hasParkingPass: Boolean", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,160)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ hasParkingPass(): Boolean", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ hasParkingPass(): Boolean"], "umlName": "Person", "position": {"x": 940, "y": 380}, "attributes": ["+ name: String", "+ age: Integer", "+ phoneNumber: Double", "+ emailAddress: String", "+ hasParkingPass: Boolean"], "umlMethods": ["+ hasParkingPass(): Boolean"], "umlAttributes": ["+ name: String", "+ age: Integer", "+ phoneNumber: Double", "+ emailAddress: String", "+ hasParkingPass: Boolean"], "umlStereotype": "none"}, {"z": 5, "id": "class_j1uv6s54p", "name": "Student", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Student", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ studentNumber: Double\\n+ isEligibleToEnroll: Boolean", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 60, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ getSeminarHistory(): List\\n+ takeExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ getSeminarHistory(): List", "+ takeExamination(): void"], "umlName": "Student", "position": {"x": 100, "y": 350}, "attributes": ["+ studentNumber: Double", "+ isEligibleToEnroll: Boolean"], "umlMethods": ["+ getSeminarHistory(): List", "+ takeExamination(): void"], "umlAttributes": ["+ studentNumber: Double", "+ isEligibleToEnroll: Boolean"], "umlStereotype": "none"}, {"z": 6, "id": "class_kcfwjtpkj", "name": "Professor", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Professor", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ listOfStudents: List\\n+ salary: Double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ applyExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ applyExamination(): void"], "umlName": "Professor", "position": {"x": 150, "y": 590}, "attributes": ["+ listOfStudents: List", "+ salary: Double"], "umlMethods": ["+ applyExamination(): void"], "umlAttributes": ["+ listOfStudents: List", "+ salary: Double"], "umlStereotype": "none"}, {"z": 7, "id": "link_g9vn2ob0p", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_j1uv6s54p"}, "target": {"id": "class_k1sj5nil8"}, "umlType": "association"}, {"z": 8, "id": "link_hj461lv7m", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_kcfwjtpkj"}, "target": {"id": "class_k1sj5nil8"}, "umlType": "association"}]}	2026-10-18 01:57:09.396172-04	2026-10-18 10:56:37.548051-04
7	kkk	1	b27d9e48-cff3-4a32-b847-3a824607f7e7	{"cells": [{"z": 1, "id": "class_qbgsxvzkg", "name": "Clase", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Clase", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 20, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 20, "stroke": "#1b4332", "transform": "translate(0,60)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": [], "umlName": "Clase23", "position": {"x": 80, "y": 130}, "attributes": [], "umlMethods": [], "umlAttributes": [], "umlStereotype": "none"}, {"z": 2, "id": "class_wlpti4ps5", "name": "Clase", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Clase", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 20, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 20, "stroke": "#1b4332", "transform": "translate(0,60)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": [], "umlName": "Clase", "position": {"x": 550, "y": 90}, "attributes": [], "umlMethods": [], "umlAttributes": [], "umlStereotype": "none"}, {"z": 3, "id": "link_w5sa4nmce", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "sourceMarker": {"d": "M 10 0 L 5 -5 L 0 0 L 5 5 Z", "fill": "black", "type": "path"}}}, "source": {"id": "class_wlpti4ps5"}, "target": {"id": "class_qbgsxvzkg"}, "umlType": "composition"}, {"z": 4, "id": "class_il1fof91g", "name": "Categoria", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Categoria", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ id: string\\n+ name: string", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ save(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ save(): void"], "umlName": "Categoria", "position": {"x": 300, "y": 390}, "attributes": ["+ id: string", "+ name: string"], "umlMethods": ["+ save(): void"], "umlAttributes": ["+ id: string", "+ name: string"], "umlStereotype": "none"}, {"z": 5, "id": "class_02cukkgsh", "name": "Productos", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Productos", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 80, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ id: string\\n+ name: string\\n+ price: string", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,120)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ save(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ save(): void"], "umlName": "Productos", "position": {"x": 730, "y": 340}, "attributes": ["+ id: string", "+ name: string", "+ price: string"], "umlMethods": ["+ save(): void"], "umlAttributes": ["+ id: string", "+ name: string", "+ price: string"], "umlStereotype": "none"}, {"z": 6, "id": "link_u9coipvv7", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "0", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_il1fof91g"}, "target": {"id": "class_02cukkgsh"}, "umlType": "association"}, {"z": 7, "id": "class_4cfre80be", "name": "Person", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Person", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 100, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ name: string\\n+ age: int\\n+ phoneNumber: double\\n+ emailAddress: string", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,140)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ hasParkingPass(): bool", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ hasParkingPass(): bool"], "umlName": "Person", "position": {"x": 100, "y": 530}, "attributes": ["+ name: string", "+ age: int", "+ phoneNumber: double", "+ emailAddress: string"], "umlMethods": ["+ hasParkingPass(): bool"], "umlAttributes": ["+ name: string", "+ age: int", "+ phoneNumber: double", "+ emailAddress: string"], "umlStereotype": "none"}, {"z": 8, "id": "class_oaiz53h67", "name": "Address", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Address", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 120, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ street: string\\n+ city: string\\n+ state: string\\n+ postalCode: string\\n+ country: string", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,160)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ validate(): bool", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ validate(): bool"], "umlName": "Address", "position": {"x": 710, "y": 580}, "attributes": ["+ street: string", "+ city: string", "+ state: string", "+ postalCode: string", "+ country: string"], "umlMethods": ["+ validate(): bool"], "umlAttributes": ["+ street: string", "+ city: string", "+ state: string", "+ postalCode: string", "+ country: string"], "umlStereotype": "none"}, {"z": 9, "id": "class_jtaohtjnk", "name": "Student", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Student", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 40, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ studentNumber: double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 80, "stroke": "#1b4332", "transform": "translate(0,80)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ isEligibleToEnroll(Student): bool\\n+ getSeminarHistory(): list\\n+ takeExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ isEligibleToEnroll(Student): bool", "+ getSeminarHistory(): list", "+ takeExamination(): void"], "umlName": "Student", "position": {"x": 1100, "y": 470}, "attributes": ["+ studentNumber: double"], "umlMethods": ["+ isEligibleToEnroll(Student): bool", "+ getSeminarHistory(): list", "+ takeExamination(): void"], "umlAttributes": ["+ studentNumber: double"], "umlStereotype": "none"}, {"z": 10, "id": "class_5g9w3su4c", "name": "Professor", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Professor", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "+ listOfStudents: list\\n+ Salary: double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ applyExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ applyExamination(): void"], "umlName": "Professor", "position": {"x": 1060, "y": 260}, "attributes": ["+ listOfStudents: list", "+ Salary: double"], "umlMethods": ["+ applyExamination(): void"], "umlAttributes": ["+ listOfStudents: list", "+ Salary: double"], "umlStereotype": "none"}, {"z": 11, "id": "link_ahccjqvqe", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "source": {"id": "class_4cfre80be"}, "target": {"id": "class_oaiz53h67"}, "umlType": "association"}]}	2026-10-17 21:53:23.556864-04	2026-10-18 01:25:23.684054-04
2	pepe	1	f012ee60-2489-47e2-8541-0fafe111db40	{"cells": [{"z": 1, "id": "class_fui33bpfo", "name": "Clase", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "Clase", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,60)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "Clase34343", "position": {"x": 400, "y": 330}, "attributes": [], "umlMethods": [], "umlAttributes": [], "umlStereotype": "none"}, {"z": 2, "id": "class_sjlvqjhzj", "name": "Clase", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "Clase", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,60)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "888", "position": {"x": 30, "y": 500}, "attributes": [], "umlMethods": [], "umlAttributes": [], "umlStereotype": "none"}, {"z": 3, "id": "link_76jycyps7", "type": "standard.Link", "attrs": {"line": {"targetMarker": {"d": "M 10 -5 0 0 10 5 Z", "fill": "white", "stroke": "black"}, "strokeDasharray": "5 5"}}, "labels": [{"attrs": {"text": {"text": "1", "font-size": 12, "font-family": "Arial"}}, "position": 0.1}, {"attrs": {"text": {"text": "*", "font-size": 12, "font-family": "Arial"}}, "position": 0.9}], "source": {"id": "class_fui33bpfo"}, "target": {"id": "class_sjlvqjhzj"}, "umlType": "dependency"}, {"z": 4, "id": "class_wr7yvge88", "name": "Clase", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "Clase", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,60)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "categoria", "position": {"x": 790, "y": 410}, "attributes": [], "umlMethods": [], "umlAttributes": [], "umlStereotype": "interface"}, {"z": 5, "id": "link_kxwku8d2m", "type": "standard.Link", "attrs": {"line": {"targetMarker": {"d": "M 10 -5 0 0 10 5 Z", "fill": "white"}}}, "labels": [{"attrs": {"text": {"text": "", "font-size": 12, "font-family": "Arial"}}, "position": 0.1}, {"attrs": {"text": {"text": "", "font-size": 12, "font-family": "Arial"}}, "position": 0.9}], "source": {"id": "class_fui33bpfo"}, "target": {"id": "class_wr7yvge88"}, "umlType": "inheritance"}, {"z": 6, "id": "class_rmdtw4mbd", "name": "Clase", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "Clase", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "+ nombre:string", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,80)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "Clase", "position": {"x": 220, "y": 110}, "attributes": ["+ nombre:string"], "umlMethods": [], "umlAttributes": ["+ nombre:string"], "umlStereotype": "none"}, {"z": 7, "id": "class_hie9zit5u", "name": "categoría", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "categoría", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "+ nombre:string", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,80)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "categoría", "position": {"x": 95, "y": 297}, "attributes": ["+ nombre:string"], "umlMethods": [], "umlAttributes": ["+ nombre:string"], "umlStereotype": "none"}, {"z": 8, "id": "class_3joau2jxs", "name": "producto", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "producto", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 80, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "+ nombre:string\\n+ precio:number\\n+ fecha:string", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,120)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "producto", "position": {"x": 179, "y": 167}, "attributes": ["+ nombre:string", "+ precio:number", "+ fecha:string"], "umlMethods": [], "umlAttributes": ["+ nombre:string", "+ precio:number", "+ fecha:string"], "umlStereotype": "none"}, {"z": 9, "id": "class_2o4py2c36", "name": "venta", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "venta", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 100, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "+ nombre:string\\n+ numeroVenta:number\\n+ pago:number\\n+ fecha:string", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,140)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "venta", "position": {"x": 650, "y": 180}, "attributes": ["+ nombre:string", "+ numeroVenta:number", "+ pago:number", "+ fecha:string"], "umlMethods": [], "umlAttributes": ["+ nombre:string", "+ numeroVenta:number", "+ pago:number", "+ fecha:string"], "umlStereotype": "none"}, {"z": 10, "id": "link_ypjh7rs96", "type": "standard.Link", "attrs": {"line": {"sourceMarker": {"d": "M 10 0 L 5 -5 L 0 0 L 5 5 Z", "fill": "black", "type": "path"}}}, "labels": [{"attrs": {"text": {"text": "1", "font-size": 12, "font-family": "Arial"}}, "position": 0.1}, {"attrs": {"text": {"text": "*", "font-size": 12, "font-family": "Arial"}}, "position": 0.9}], "source": {"id": "class_2o4py2c36"}, "target": {"id": "class_3joau2jxs"}, "umlType": "composition"}, {"z": 11, "id": "class_dm1g4po9p", "name": "Clase", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "Clase", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,60)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "Clase", "position": {"x": 530, "y": 540}, "attributes": [], "umlMethods": [], "umlAttributes": [], "umlStereotype": "none"}, {"z": 12, "id": "class_cb3v13m71", "name": "Clase", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 40, "stroke": "#000000", "transform": "translate(0,0)", "stroke-width": 1}, ".uml-class-name-text": {"fill": "#000000", "text": "Clase", "font-size": 14, "font-family": "Arial"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,40)", "stroke-width": 1}, ".uml-class-attrs-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#FFFFE0", "height": 20, "stroke": "#000000", "transform": "translate(0,60)", "stroke-width": 1}, ".uml-class-methods-text": {"fill": "#000000", "text": "", "ref-x": 10, "font-family": "Arial", "text-anchor": "start"}}, "methods": [], "umlName": "Clase", "position": {"x": 90, "y": 170}, "attributes": [], "umlMethods": [], "umlAttributes": [], "umlStereotype": "none"}, {"z": 13, "id": "link_bwnhdrhau", "type": "standard.Link", "attrs": {"line": {"targetMarker": {"d": "M 10 -5 0 0 10 5 Z", "fill": "white", "stroke": "black"}, "strokeDasharray": "5 5"}}, "labels": [{"attrs": {"text": {"text": "", "font-size": 12, "font-family": "Arial"}}, "position": 0.1}, {"attrs": {"text": {"text": "", "font-size": 12, "font-family": "Arial"}}, "position": 0.9}], "source": {"id": "class_sjlvqjhzj"}, "target": {"id": "class_dm1g4po9p"}, "umlType": "dependency"}]}	2026-09-15 23:59:26.906062-04	2026-09-19 17:19:23.501092-04
8	new	1	5e0e59be-a6f7-4dc0-9a3e-222274b5dcb5	{"cells": []}	2026-10-18 01:36:07.368839-04	2026-10-18 01:55:10.783523-04
11	tt	1	d17ee3e2-4ec3-4e39-975d-d58d0f5205b9	{"cells": [{"z": 1, "id": "class_4iz9adeft", "name": "Person", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Person", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 120, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- name: String\\n- age: int\\n- phoneNumber: double\\n- emailAddress: String\\n- hasParkingPass: bool", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,160)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ livesAt(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ livesAt(): void"], "umlName": "Person", "position": {"x": 170, "y": 680}, "attributes": ["- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String", "- hasParkingPass: bool"], "umlMethods": ["+ livesAt(): void"], "umlAttributes": ["- name: String", "- age: int", "- phoneNumber: double", "- emailAddress: String", "- hasParkingPass: bool"], "umlStereotype": "none"}, {"z": 2, "id": "class_izm4ugi4o", "name": "Address", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Address", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 120, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- street: String\\n- city: String\\n- state: String\\n- postalCode: String\\n- country: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,160)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ validate(): bool", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ validate(): bool"], "umlName": "Address", "position": {"x": 360, "y": 80}, "attributes": ["- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"], "umlMethods": ["+ validate(): bool"], "umlAttributes": ["- street: String", "- city: String", "- state: String", "- postalCode: String", "- country: String"], "umlStereotype": "none"}, {"z": 3, "id": "class_d827o0r72", "name": "Student", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Student", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 40, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- studentNumber: double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 80, "stroke": "#1b4332", "transform": "translate(0,80)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ isEligibleToEnroll(Student): bool\\n+ getSeminarHistory(): list\\n+ takeExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ isEligibleToEnroll(Student): bool", "+ getSeminarHistory(): list", "+ takeExamination(): void"], "umlName": "Student", "position": {"x": 640, "y": 80}, "attributes": ["- studentNumber: double"], "umlMethods": ["+ isEligibleToEnroll(Student): bool", "+ getSeminarHistory(): list", "+ takeExamination(): void"], "umlAttributes": ["- studentNumber: double"], "umlStereotype": "none"}, {"z": 4, "id": "class_y4j3etu16", "name": "Professor", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Professor", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- listOfStudents: list\\n- salary: double", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ applyExamination(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ applyExamination(): void"], "umlName": "Professor", "position": {"x": 920, "y": 80}, "attributes": ["- listOfStudents: list", "- salary: double"], "umlMethods": ["+ applyExamination(): void"], "umlAttributes": ["- listOfStudents: list", "- salary: double"], "umlStereotype": "none"}, {"z": 5, "id": "link_lez0e6cma", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"d": "M 10 -5 0 0 10 5 Z", "fill": "#ffffff", "stroke": "#1b4332"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_d827o0r72"}, "target": {"id": "class_4iz9adeft"}, "umlType": "inheritance"}, {"z": 6, "id": "link_f33pvcja9", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"d": "M 10 -5 0 0 10 5 Z", "fill": "#ffffff", "stroke": "#1b4332"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_y4j3etu16"}, "target": {"id": "class_4iz9adeft"}, "umlType": "inheritance"}, {"z": 7, "id": "link_8nn9wjhao", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "strokeWidth": 1.75, "targetMarker": {"type": "none"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "0..1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_4iz9adeft"}, "target": {"id": "class_izm4ugi4o"}, "umlType": "association"}]}	2026-10-24 22:58:23.539808-04	2026-10-24 23:08:41.97321-04
13	iii	1	522b558a-1cf3-4075-9c29-b183f72c9329	{"cells": [{"id": "class_44fasmtzb", "name": "Person", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Person", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 140, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- nombre: String\\n- edad: Integer\\n- telefono: String\\n- correoElectronico: String\\n- tieneTarjetaDeEstacionamiento: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,180)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ viveEn(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ viveEn(): void"], "umlName": "Person", "position": {"x": 470, "y": 450}, "attributes": ["- id: Long", "- nombre: String", "- edad: Integer", "- telefono: String", "- correoElectronico: String", "- tieneTarjetaDeEstacionamiento: String"], "umlMethods": ["+ viveEn(): void"], "umlAttributes": ["- id: Long", "- nombre: String", "- edad: Integer", "- telefono: String", "- correoElectronico: String", "- tieneTarjetaDeEstacionamiento: String"], "umlStereotype": "none"}, {"id": "class_dc2p3qfwj", "name": "Student", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Student", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- numeroEstudiante: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 80, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ esElegibleParaInscribirse(estudiante: Student): Boolean\\n+ obtenerHistorialDeSeminarios(): void\\n+ presentarExamen(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ esElegibleParaInscribirse(estudiante: Student): Boolean", "+ obtenerHistorialDeSeminarios(): void", "+ presentarExamen(): void"], "umlName": "Student", "position": {"x": 360, "y": 60}, "attributes": ["- id: Long", "- numeroEstudiante: String"], "umlMethods": ["+ esElegibleParaInscribirse(estudiante: Student): Boolean", "+ obtenerHistorialDeSeminarios(): void", "+ presentarExamen(): void"], "umlAttributes": ["- id: Long", "- numeroEstudiante: String"], "umlStereotype": "none"}, {"id": "class_e64dhmrsb", "name": "Professor", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Professor", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- salario: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ aplicarExamen(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ aplicarExamen(): void"], "umlName": "Professor", "position": {"x": 880, "y": 70}, "attributes": ["- id: Long", "- salario: String"], "umlMethods": ["+ aplicarExamen(): void"], "umlAttributes": ["- id: Long", "- salario: String"], "umlStereotype": "none"}, {"id": "link_ihcj13i6d", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "targetMarker": {"d": "M 20 -10 0 0 20 10 Z", "fill": "#ffffff", "stroke": "#1b4332"}}}, "labels": [], "source": {"id": "class_44fasmtzb"}, "target": {"id": "class_dc2p3qfwj"}, "umlType": "inheritance"}, {"id": "link_syj4cbgro", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "targetMarker": {"d": "M 20 -10 0 0 20 10 Z", "fill": "#ffffff", "stroke": "#1b4332"}}}, "labels": [], "source": {"id": "class_44fasmtzb"}, "target": {"id": "class_e64dhmrsb"}, "umlType": "inheritance"}]}	2026-10-30 21:58:29.128135-04	2026-10-30 21:58:56.329054-04
12	qq	1	8ed5c067-0249-43c1-b370-b345de3d53b9	{"cells": [{"z": 1, "id": "class_q8afu60wd", "name": "Person", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Person", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 140, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- nombre: String\\n- edad: Integer\\n- telefono: String\\n- correoElectronico: String\\n- tieneTarjetaDeEstacionamiento: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,180)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ viveEn(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ viveEn(): void"], "umlName": "Persona", "position": {"x": 720, "y": 460}, "attributes": ["- id: Long", "- nombre: String", "- edad: Integer", "- telefono: String", "- correoElectronico: String", "- tieneTarjetaDeEstacionamiento: String"], "umlMethods": ["+ viveEn(): void"], "umlAttributes": ["- id: Long", "- nombre: String", "- edad: Integer", "- telefono: String", "- correoElectronico: String", "- tieneTarjetaDeEstacionamiento: String"], "umlStereotype": "none"}, {"z": 3, "id": "class_o1s7odadm", "name": "Student", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Student", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- numeroEstudiante: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 80, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ esElegibleParaInscribirse(estudiante: Student): Boolean\\n+ obtenerHistorialDeSeminarios(): void\\n+ presentarExamen(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ esElegibleParaInscribirse(estudiante: Student): Boolean", "+ obtenerHistorialDeSeminarios(): void", "+ presentarExamen(): void"], "umlName": "Estudiante", "position": {"x": 450, "y": 80}, "attributes": ["- id: Long", "- numeroEstudiante: String"], "umlMethods": ["+ esElegibleParaInscribirse(estudiante: Student): Boolean", "+ obtenerHistorialDeSeminarios(): void", "+ presentarExamen(): void"], "umlAttributes": ["- id: Long", "- numeroEstudiante: String"], "umlStereotype": "none"}, {"z": 4, "id": "class_nn921nseu", "name": "Professor", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Professor", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- salario: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ aplicarExamen(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ aplicarExamen(): void"], "umlName": "Profesor", "position": {"x": 920, "y": 80}, "attributes": ["- id: Long", "- salario: String"], "umlMethods": ["+ aplicarExamen(): void"], "umlAttributes": ["- id: Long", "- salario: String"], "umlStereotype": "none"}, {"z": 6, "id": "link_ihcj13i6d", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "targetMarker": {"d": "M 20 -10 0 0 20 10 Z", "fill": "#ffffff", "stroke": "#1b4332"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1..*", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_q8afu60wd"}, "target": {"id": "class_o1s7odadm"}, "umlType": "inheritance"}, {"z": 7, "id": "link_syj4cbgro", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "targetMarker": {"d": "M 20 -10 0 0 20 10 Z", "fill": "#ffffff", "stroke": "#1b4332"}}}, "labels": [{"attrs": {"text": {"fill": "#13211c", "text": "1", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.1}, {"attrs": {"text": {"fill": "#13211c", "text": "1..*", "font-size": 12, "font-family": "JetBrains Mono, monospace"}}, "position": 0.9}], "source": {"id": "class_q8afu60wd"}, "target": {"id": "class_nn921nseu"}, "umlType": "inheritance"}]}	2026-10-24 23:14:26.984214-04	2026-10-30 22:11:57.825414-04
14	mmm	1	e10729aa-3f6c-4297-8ded-bb7ad68dc66e	{"cells": [{"id": "class_ot468sk9y", "name": "Persona", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Persona", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 140, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- nombre: String\\n- edad: Integer\\n- telefono: String\\n- correoElectronico: String\\n- tieneTarjetaDeEstacionamiento: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,180)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ viveEn(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ viveEn(): void"], "umlName": "Persona", "position": {"x": 450, "y": 400}, "attributes": ["- id: Long", "- nombre: String", "- edad: Integer", "- telefono: String", "- correoElectronico: String", "- tieneTarjetaDeEstacionamiento: String"], "umlMethods": ["+ viveEn(): void"], "umlAttributes": ["- id: Long", "- nombre: String", "- edad: Integer", "- telefono: String", "- correoElectronico: String", "- tieneTarjetaDeEstacionamiento: String"], "umlStereotype": "none"}, {"id": "class_w99ssny55", "name": "Estudiante", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Estudiante", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- numeroEstudiante: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 80, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ esElegibleParaInscribirse(estudiante: Student): Boolean\\n+ obtenerHistorialDeSeminarios(): void\\n+ presentarExamen(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ esElegibleParaInscribirse(estudiante: Student): Boolean", "+ obtenerHistorialDeSeminarios(): void", "+ presentarExamen(): void"], "umlName": "Estudiante", "position": {"x": 360, "y": 60}, "attributes": ["- id: Long", "- numeroEstudiante: String"], "umlMethods": ["+ esElegibleParaInscribirse(estudiante: Student): Boolean", "+ obtenerHistorialDeSeminarios(): void", "+ presentarExamen(): void"], "umlAttributes": ["- id: Long", "- numeroEstudiante: String"], "umlStereotype": "none"}, {"id": "class_r1g88jii9", "name": "Profesor", "size": {"width": 250, "height": 150}, "type": "uml.Class", "angle": 0, "attrs": {".uml-class-name-rect": {"rx": 0, "ry": 0, "fill": "#1b4332", "height": 40, "stroke": "#1b4332", "transform": "translate(0,0)", "stroke-width": 1.5}, ".uml-class-name-text": {"fill": "#f4f7f5", "text": "Profesor", "font-size": 15, "font-family": "Figtree, sans-serif", "font-weight": "700"}, ".uml-class-attrs-rect": {"rx": 0, "ry": 0, "fill": "#f4f7f5", "height": 60, "stroke": "#1b4332", "transform": "translate(0,40)", "stroke-width": 1.5}, ".uml-class-attrs-text": {"fill": "#13211c", "text": "- id: Long\\n- salario: String", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}, ".uml-class-methods-rect": {"rx": 0, "ry": 0, "fill": "#ffffff", "height": 40, "stroke": "#1b4332", "transform": "translate(0,100)", "stroke-width": 1.5}, ".uml-class-methods-text": {"fill": "#13211c", "text": "+ aplicarExamen(): void", "ref-x": 12, "ref-y": 6, "font-family": "JetBrains Mono, monospace", "text-anchor": "start"}}, "methods": ["+ aplicarExamen(): void"], "umlName": "Profesor", "position": {"x": 640, "y": 60}, "attributes": ["- id: Long", "- salario: String"], "umlMethods": ["+ aplicarExamen(): void"], "umlAttributes": ["- id: Long", "- salario: String"], "umlStereotype": "none"}, {"id": "link_ihcj13i6d", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "targetMarker": {"d": "M 20 -10 0 0 20 10 Z", "fill": "#ffffff", "stroke": "#1b4332"}}}, "labels": [], "source": {"id": "class_ot468sk9y"}, "target": {"id": "class_w99ssny55"}, "umlType": "inheritance"}, {"id": "link_syj4cbgro", "type": "standard.Link", "attrs": {"line": {"stroke": "#1b4332", "targetMarker": {"d": "M 20 -10 0 0 20 10 Z", "fill": "#ffffff", "stroke": "#1b4332"}}}, "labels": [], "source": {"id": "class_ot468sk9y"}, "target": {"id": "class_r1g88jii9"}, "umlType": "inheritance"}], "revision": 0}	2026-10-30 22:12:05.6404-04	2026-10-30 23:01:03.489115-04
\.


--
-- TOC entry 3392 (class 0 OID 963418)
-- Dependencies: 211
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (sid, sess, expire) FROM stdin;
cXJtfvkUmmsWST0-HyyrqWIclVBGs2CZ	{"cookie":{"originalMaxAge":604800000,"expires":"2026-11-07T02:01:30.907Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":12,"userName":"pepe"}	2026-11-08 14:52:31
s1lIkR-fFtQ8pbZCKdd0RUqQSj8kp7Rm	{"cookie":{"originalMaxAge":604800000,"expires":"2026-11-07T02:12:15.380Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"userId":1,"userName":"Rister Yasir Arce Cuéllar"}	2026-11-08 14:52:31
\.


--
-- TOC entry 3385 (class 0 OID 963300)
-- Dependencies: 204
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password) FROM stdin;
1	Rister Yasir Arce Cuéllar	yasirarce70@gmail.com	$2b$10$0ApR0zKjY.d8PXpeG1PwquZGjnHyO6mok4/porDp5EOH3vF/Ufdnu
5	dddd	yasirarce@gmail.com	$2b$10$MCPsq9kp8RjIh4hJMzyMoOo6qAHLyh.kLKFQI.179gPG.vrlWf8nS
11	Rister Yasir Arce Cuéllar	yasirarce70+2@gmail.com	$2b$10$MeFQmXOhSyIUmF0w7CJ0veI5rwbnoFcGc4rGBkyJbamyi8q0l9y2m
12	pepe	yasirarce70+3@gmail.com	$2b$10$lM8N22u5UvkjQUUDKepC2OIBDALa2ugDpfKmoSinZdnrGwr0P0ToC
\.


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 209
-- Name: diagram_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diagram_activity_id_seq', 273, true);


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 207
-- Name: diagram_collaborators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diagram_collaborators_id_seq', 122, true);


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 205
-- Name: diagrams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diagrams_id_seq', 14, true);


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 203
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- TOC entry 3247 (class 2606 OID 963405)
-- Name: diagram_activity diagram_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_activity
    ADD CONSTRAINT diagram_activity_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 963382)
-- Name: diagram_collaborators diagram_collaborators_diagram_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_collaborators
    ADD CONSTRAINT diagram_collaborators_diagram_id_user_id_key UNIQUE (diagram_id, user_id);


--
-- TOC entry 3244 (class 2606 OID 963380)
-- Name: diagram_collaborators diagram_collaborators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_collaborators
    ADD CONSTRAINT diagram_collaborators_pkey PRIMARY KEY (id);


--
-- TOC entry 3237 (class 2606 OID 963362)
-- Name: diagrams diagrams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagrams
    ADD CONSTRAINT diagrams_pkey PRIMARY KEY (id);


--
-- TOC entry 3239 (class 2606 OID 963364)
-- Name: diagrams diagrams_share_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagrams
    ADD CONSTRAINT diagrams_share_token_key UNIQUE (share_token);


--
-- TOC entry 3252 (class 2606 OID 963425)
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- TOC entry 3233 (class 2606 OID 963307)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3235 (class 2606 OID 963305)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 1259 OID 963426)
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- TOC entry 3248 (class 1259 OID 963416)
-- Name: idx_diagram_activity_diagram_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_diagram_activity_diagram_id ON public.diagram_activity USING btree (diagram_id);


--
-- TOC entry 3249 (class 1259 OID 963417)
-- Name: idx_diagram_activity_element_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_diagram_activity_element_id ON public.diagram_activity USING btree (diagram_id, element_id);


--
-- TOC entry 3245 (class 1259 OID 963393)
-- Name: idx_diagram_collaborators_diagram_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_diagram_collaborators_diagram_id ON public.diagram_collaborators USING btree (diagram_id);


--
-- TOC entry 3240 (class 1259 OID 963370)
-- Name: idx_diagrams_owner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_diagrams_owner_id ON public.diagrams USING btree (owner_id);


--
-- TOC entry 3256 (class 2606 OID 963406)
-- Name: diagram_activity diagram_activity_diagram_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_activity
    ADD CONSTRAINT diagram_activity_diagram_id_fkey FOREIGN KEY (diagram_id) REFERENCES public.diagrams(id) ON DELETE CASCADE;


--
-- TOC entry 3257 (class 2606 OID 963411)
-- Name: diagram_activity diagram_activity_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_activity
    ADD CONSTRAINT diagram_activity_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 3254 (class 2606 OID 963383)
-- Name: diagram_collaborators diagram_collaborators_diagram_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_collaborators
    ADD CONSTRAINT diagram_collaborators_diagram_id_fkey FOREIGN KEY (diagram_id) REFERENCES public.diagrams(id) ON DELETE CASCADE;


--
-- TOC entry 3255 (class 2606 OID 963388)
-- Name: diagram_collaborators diagram_collaborators_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagram_collaborators
    ADD CONSTRAINT diagram_collaborators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3253 (class 2606 OID 963365)
-- Name: diagrams diagrams_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagrams
    ADD CONSTRAINT diagrams_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: dev
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2026-11-10 10:54:08 -04

--
-- PostgreSQL database dump complete
--

\unrestrict Jq8a2EAgxp9ToXVojWoqvjLyDrbfHdvYyXdVjV7JTjNJgQdW1uF8JVhivKhiy3v

