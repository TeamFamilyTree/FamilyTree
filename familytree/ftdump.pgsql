--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: app_marriage; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE app_marriage (
    id integer NOT NULL,
    husband_id integer NOT NULL,
    wife_id integer NOT NULL,
    tree_id integer NOT NULL
);


ALTER TABLE app_marriage OWNER TO treeadmin;

--
-- Name: app_marriage_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE app_marriage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_marriage_id_seq OWNER TO treeadmin;

--
-- Name: app_marriage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE app_marriage_id_seq OWNED BY app_marriage.id;


--
-- Name: app_person; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE app_person (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50),
    prefix character varying(50),
    gender character varying(1) NOT NULL,
    alive boolean NOT NULL,
    married boolean NOT NULL,
    is_branch boolean NOT NULL,
    tree_id integer NOT NULL,
    father_id integer,
    mother_id integer,
    is_root boolean NOT NULL,
    is_paternal_desc boolean NOT NULL,
    birth_year character varying(4),
    death_year character varying(4),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE app_person OWNER TO treeadmin;

--
-- Name: app_person_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE app_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_person_id_seq OWNER TO treeadmin;

--
-- Name: app_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE app_person_id_seq OWNED BY app_person.id;


--
-- Name: app_tree; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE app_tree (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    passcode character varying(100) NOT NULL
);


ALTER TABLE app_tree OWNER TO treeadmin;

--
-- Name: app_tree_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE app_tree_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_tree_id_seq OWNER TO treeadmin;

--
-- Name: app_tree_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE app_tree_id_seq OWNED BY app_tree.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO treeadmin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO treeadmin;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO treeadmin;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO treeadmin;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO treeadmin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO treeadmin;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO treeadmin;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO treeadmin;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO treeadmin;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO treeadmin;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO treeadmin;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO treeadmin;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO treeadmin;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO treeadmin;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO treeadmin;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO treeadmin;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO treeadmin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: treeadmin
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO treeadmin;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: treeadmin
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: treeadmin
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO treeadmin;

--
-- Name: app_marriage id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_marriage ALTER COLUMN id SET DEFAULT nextval('app_marriage_id_seq'::regclass);


--
-- Name: app_person id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_person ALTER COLUMN id SET DEFAULT nextval('app_person_id_seq'::regclass);


--
-- Name: app_tree id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_tree ALTER COLUMN id SET DEFAULT nextval('app_tree_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Data for Name: app_marriage; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY app_marriage (id, husband_id, wife_id, tree_id) FROM stdin;
8	1	2	1
1	14	5	1
2	15	6	1
4	8	11	1
14	4	17	1
15	19	18	1
16	15	22	1
17	24	25	14
18	24	28	14
19	30	27	14
\.


--
-- Name: app_marriage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('app_marriage_id_seq', 19, true);


--
-- Data for Name: app_person; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY app_person (id, first_name, last_name, prefix, gender, alive, married, is_branch, tree_id, father_id, mother_id, is_root, is_paternal_desc, birth_year, death_year, created_at, updated_at) FROM stdin;
60	G2 DA	\N	\N	f	f	f	f	3	54	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
55	G2 AA	\N	\N	m	t	f	f	3	51	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
8	محمود	\N	\N	m	f	f	f	1	15	6	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
50	root	\N	\N	m	f	f	f	3	\N	\N	t	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
51	G1 A	\N	\N	m	f	f	f	3	50	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
52	G1 B	\N	\N	m	f	f	f	3	50	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
53	G1 C	\N	\N	m	f	f	f	3	50	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
54	G1 D	\N	\N	m	f	f	f	3	50	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
56	G2 AB	\N	\N	m	f	f	f	3	51	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
57	G2 BA	\N	\N	m	f	f	f	3	52	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
58	G2 BB	\N	\N	m	f	f	f	3	52	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
59	G2 CA	\N	\N	m	f	f	f	3	53	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
61	G3 AAA	\N	\N	m	f	f	f	3	55	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
62	G3 ABA	\N	\N	m	f	f	f	3	56	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
1	عبد الله	lastname	\N	m	f	t	t	1	\N	\N	t	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
10	حصة	\N	\N	f	f	t	f	1	\N	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
11	هند	\N	\N	f	f	t	f	1	\N	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
9	فيصل	\N	\N	m	f	t	f	1	7	10	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
12	عائشة	\N	\N	f	f	t	f	1	\N	\N	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
13	سامي	\N	\N	m	f	f	f	1	8	11	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
4	عبد اللطيف	المبارك	الشيخ	m	t	t	f	1	1	2	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
18	سارة	العبدالله	\N	f	t	t	f	1	4	17	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
5	نجلاء	الفلاني	\N	f	f	t	f	1	\N	\N	f	f	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
20	فاطمة	\N		f	t	f	f	1	14	5	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
16	خالد	\N		m	t	f	f	1	1	2	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
7	لمياء	\N	\N	f	t	f	f	1	14	5	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
14	وسيم	\N	\N	m	f	t	f	1	1	2	f	t	\N	1300	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
21	مبارك	\N	الشيخ	m	f	f	f	13	\N	\N	t	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
19	نوفل	الفلاني	\N	m	f	t	f	1	\N	\N	f	f	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
2	نورة	الفلاني	\N	f	f	t	f	1	\N	\N	f	f	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
22	عائشة	الفلاني	\N	f	t	t	f	1	\N	\N	f	f	\N	\N	2018-08-25 23:28:13.294732+01	2018-08-25 23:28:13.294773+01
15	فهد	\N	\N	m	t	t	f	1	1	2	f	t	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 23:28:13.307163+01
23	عبير	\N	\N	f	f	f	f	1	15	6	f	t	\N	\N	2018-08-25 23:30:43.084158+01	2018-08-25 23:30:43.084184+01
17	نوف	الفلاني	\N	f	f	t	f	1	\N	\N	f	f	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
6	لما	\N	\N	f	f	t	f	1	\N	\N	f	f	\N	\N	2018-08-25 18:03:49.242261+01	2018-08-25 18:03:49.283064+01
25	فاطمة	الفلاني	\N	f	f	t	f	14	\N	\N	f	f	\N	\N	2018-08-26 17:21:47.880323+01	2018-08-26 17:21:47.880387+01
26	سالم	\N	\N	m	f	f	f	14	24	25	f	t	\N	\N	2018-08-26 17:22:16.803384+01	2018-08-26 17:22:16.803553+01
28	عائشة	الفلاني	\N	f	t	t	f	14	\N	\N	f	f	\N	\N	2018-08-26 17:24:51.006105+01	2018-08-26 17:24:51.006162+01
24	سليمان	\N	\N	m	f	t	f	14	\N	\N	t	t	\N	\N	2018-08-26 17:07:19.984315+01	2018-08-26 17:24:51.012732+01
29	عامر	\N	\N	m	f	f	f	14	24	28	f	t	\N	\N	2018-08-26 17:25:33.798321+01	2018-08-26 17:25:33.798377+01
30	فهد	الفلاني	\N	m	f	t	f	14	\N	\N	f	f	\N	\N	2018-08-26 17:26:24.28336+01	2018-08-26 17:26:24.283385+01
27	صفية	\N	\N	f	f	t	f	14	24	25	f	t	\N	\N	2018-08-26 17:24:17.046046+01	2018-08-26 17:26:24.287077+01
31	صقر	الفلاني	\N	m	f	f	f	14	30	27	f	f	\N	\N	2018-08-26 17:26:46.330279+01	2018-08-26 17:26:46.330313+01
33	هند	الفلاني	\N	f	f	f	f	14	30	27	f	f	\N	\N	2018-08-26 21:58:31.163665+01	2018-08-26 21:58:31.163707+01
34	hash test	\N	\N	m	f	f	f	15	\N	\N	t	t	\N	\N	2018-08-28 22:02:04.377532+01	2018-08-28 22:02:04.377563+01
\.


--
-- Name: app_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('app_person_id_seq', 34, true);


--
-- Data for Name: app_tree; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY app_tree (id, name, passcode) FROM stdin;
3	test3	pbkdf2_sha256$100000$LovOb0iuCKPh$VAsAZ99XDSVxkzCUNwfIlPHAALPJqN/LA6qkqdHwrWQ=
1	العبدالله	pbkdf2_sha256$100000$LovOb0iuCKPh$VAsAZ99XDSVxkzCUNwfIlPHAALPJqN/LA6qkqdHwrWQ=
13	المبارك	pbkdf2_sha256$100000$LovOb0iuCKPh$VAsAZ99XDSVxkzCUNwfIlPHAALPJqN/LA6qkqdHwrWQ=
15	hash test	pbkdf2_sha256$100000$LovOb0iuCKPh$VAsAZ99XDSVxkzCUNwfIlPHAALPJqN/LA6qkqdHwrWQ=
14	السليماني	pbkdf2_sha256$100000$LovOb0iuCKPh$VAsAZ99XDSVxkzCUNwfIlPHAALPJqN/LA6qkqdHwrWQ=
\.


--
-- Name: app_tree_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('app_tree_id_seq', 15, true);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add tree	7	add_tree
20	Can change tree	7	change_tree
21	Can delete tree	7	delete_tree
22	Can add person	8	add_person
23	Can change person	8	change_person
24	Can delete person	8	delete_person
25	Can add marriage	9	add_marriage
26	Can change marriage	9	change_marriage
27	Can delete marriage	9	delete_marriage
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('auth_permission_id_seq', 27, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$100000$pjjNceGdmF6F$8kcA23ewal/ifcMLu8ohy0sqJDTUzm42bUxD+UzlaP4=	2018-08-27 15:50:43.945268+01	t	admin			admin@admin.admin	t	t	2018-08-27 15:50:34.505203+01
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	app	tree
8	app	person
9	app	marriage
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('django_content_type_id_seq', 9, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-03-16 09:53:15.626844+00
2	auth	0001_initial	2018-03-16 09:53:21.740685+00
3	admin	0001_initial	2018-03-16 09:53:23.92043+00
4	admin	0002_logentry_remove_auto_add	2018-03-16 09:53:24.843432+00
5	contenttypes	0002_remove_content_type_name	2018-03-16 09:53:26.482017+00
6	auth	0002_alter_permission_name_max_length	2018-03-16 09:53:28.119694+00
7	auth	0003_alter_user_email_max_length	2018-03-16 09:53:29.759145+00
8	auth	0004_alter_user_username_opts	2018-03-16 09:53:30.782228+00
9	auth	0005_alter_user_last_login_null	2018-03-16 09:53:32.420807+00
10	auth	0006_require_contenttypes_0002	2018-03-16 09:53:33.138438+00
11	auth	0007_alter_validators_add_error_messages	2018-03-16 09:53:34.133514+00
12	auth	0008_alter_user_username_max_length	2018-03-16 09:53:36.414242+00
13	auth	0009_alter_user_last_name_max_length	2018-03-16 09:53:37.540511+00
14	sessions	0001_initial	2018-03-16 09:53:39.588426+00
15	app	0001_initial	2018-03-22 11:18:59.82215+00
16	app	0002_auto_20180322_1915	2018-03-22 16:17:23.101797+00
17	app	0003_auto_20180322_1921	2018-03-22 16:22:14.69932+00
18	app	0004_auto_20180405_1304	2018-04-05 11:04:54.036727+01
19	app	0005_auto_20180405_1312	2018-04-05 11:12:30.065348+01
20	app	0006_marriage_tree	2018-04-09 11:55:02.114633+01
21	app	0007_auto_20180417_2017	2018-04-18 13:48:17.019798+01
22	app	0008_person_is_root	2018-04-18 17:47:57.242909+01
23	app	0009_auto_20180419_1248	2018-04-19 10:48:07.452813+01
24	app	0010_auto_20180419_1539	2018-04-19 13:40:08.580016+01
25	app	0011_auto_20180420_1431	2018-04-20 12:31:44.775179+01
26	app	0012_auto_20180420_1446	2018-04-20 12:46:55.272292+01
27	app	0013_person_is_paternal_desc	2018-08-06 11:44:00.559949+01
28	app	0014_auto_20180816_1654	2018-08-16 14:55:01.955203+01
29	app	0015_auto_20180816_1835	2018-08-16 16:35:24.149663+01
30	app	0016_auto_20180825_1716	2018-08-25 15:17:06.853152+01
31	app	0017_auto_20180825_2003	2018-08-25 18:03:49.293394+01
32	app	0018_tree_passcode	2018-08-27 22:53:35.263025+01
33	app	0019_auto_20180829_0001	2018-08-28 22:01:41.906959+01
34	app	0020_auto_20180829_0001	2018-08-28 22:01:59.108986+01
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: treeadmin
--

SELECT pg_catalog.setval('django_migrations_id_seq', 34, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: treeadmin
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
3zefvqp2pmj3py66hdsxpdd1n1gliisy	ZmYwZGNiZjhlYThjNTkyYmI4YzFlYjA3YzY1ODc1NzAzNjJjMjllMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlNWFmZTY1MTczMjMwZmI4ODc5ZDE5MzY2MWJiODU0NzI1ZDE4ZTIzIiwidHJlZV9pZCI6M30=	2018-09-10 23:22:11.723341+01
uu4qy4jrj45heo0cy4gb8btthfy0p3an	NGY1OGYyNTAzMzA4NzI0MzhkNzZjNjVjNDBhMTllMTk5YWI0Y2Q2Njp7InRyZWVfaWQiOjE1fQ==	2018-09-11 22:10:25.978217+01
wcomrhrnhhrgskkcz2yeymfg4gawsan3	NDc5ODk3ZmUyZjc3ZDQ5ZWExNjE2NzJlOGY1NzM5ZDc0YzU0MjlhMDp7InRyZWVfaWQiOjEsInRyZWVfbmFtZSI6Ilx1MDYyN1x1MDY0NFx1MDYzOVx1MDYyOFx1MDYyZlx1MDYyN1x1MDY0NFx1MDY0NFx1MDY0NyJ9	2018-09-11 23:59:59.155572+01
4n1arquw4at9t9dtamresu481q46x2lo	NDc5ODk3ZmUyZjc3ZDQ5ZWExNjE2NzJlOGY1NzM5ZDc0YzU0MjlhMDp7InRyZWVfaWQiOjEsInRyZWVfbmFtZSI6Ilx1MDYyN1x1MDY0NFx1MDYzOVx1MDYyOFx1MDYyZlx1MDYyN1x1MDY0NFx1MDY0NFx1MDY0NyJ9	2018-09-12 00:14:19.178181+01
4cx0cfr0ylxs3cuc837cji1g4sigdoa2	NDc5ODk3ZmUyZjc3ZDQ5ZWExNjE2NzJlOGY1NzM5ZDc0YzU0MjlhMDp7InRyZWVfaWQiOjEsInRyZWVfbmFtZSI6Ilx1MDYyN1x1MDY0NFx1MDYzOVx1MDYyOFx1MDYyZlx1MDYyN1x1MDY0NFx1MDY0NFx1MDY0NyJ9	2018-09-12 00:15:12.658544+01
no8jx51hh4fa0htmaqikduxzcpkbkqs9	NDc5ODk3ZmUyZjc3ZDQ5ZWExNjE2NzJlOGY1NzM5ZDc0YzU0MjlhMDp7InRyZWVfaWQiOjEsInRyZWVfbmFtZSI6Ilx1MDYyN1x1MDY0NFx1MDYzOVx1MDYyOFx1MDYyZlx1MDYyN1x1MDY0NFx1MDY0NFx1MDY0NyJ9	2018-09-12 00:21:15.17212+01
s0nnffx3188b7wptmi8fq8kucw2bzugs	NDc5ODk3ZmUyZjc3ZDQ5ZWExNjE2NzJlOGY1NzM5ZDc0YzU0MjlhMDp7InRyZWVfaWQiOjEsInRyZWVfbmFtZSI6Ilx1MDYyN1x1MDY0NFx1MDYzOVx1MDYyOFx1MDYyZlx1MDYyN1x1MDY0NFx1MDY0NFx1MDY0NyJ9	2018-09-12 16:12:46.012828+01
\.


--
-- Name: app_marriage app_marriage_husband_id_wife_id_2e1008dd_uniq; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_marriage
    ADD CONSTRAINT app_marriage_husband_id_wife_id_2e1008dd_uniq UNIQUE (husband_id, wife_id);


--
-- Name: app_marriage app_marriage_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_marriage
    ADD CONSTRAINT app_marriage_pkey PRIMARY KEY (id);


--
-- Name: app_person app_person_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_person
    ADD CONSTRAINT app_person_pkey PRIMARY KEY (id);


--
-- Name: app_tree app_tree_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_tree
    ADD CONSTRAINT app_tree_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: app_marriage_husband_id_9a5049fb; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX app_marriage_husband_id_9a5049fb ON app_marriage USING btree (husband_id);


--
-- Name: app_marriage_tree_id_bb0b6800; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX app_marriage_tree_id_bb0b6800 ON app_marriage USING btree (tree_id);


--
-- Name: app_marriage_wife_id_047ef360; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX app_marriage_wife_id_047ef360 ON app_marriage USING btree (wife_id);


--
-- Name: app_person_father_id_2e124a87; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX app_person_father_id_2e124a87 ON app_person USING btree (father_id);


--
-- Name: app_person_mother_id_4cbfe546; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX app_person_mother_id_4cbfe546 ON app_person USING btree (mother_id);


--
-- Name: app_person_tree_id_id_03de75a7; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX app_person_tree_id_id_03de75a7 ON app_person USING btree (tree_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_user_groups_group_id_97559544 ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX django_session_expire_date_a5c62663 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: treeadmin
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: app_marriage app_marriage_husband_id_9a5049fb_fk_app_person_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_marriage
    ADD CONSTRAINT app_marriage_husband_id_9a5049fb_fk_app_person_id FOREIGN KEY (husband_id) REFERENCES app_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_marriage app_marriage_tree_id_bb0b6800_fk_app_tree_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_marriage
    ADD CONSTRAINT app_marriage_tree_id_bb0b6800_fk_app_tree_id FOREIGN KEY (tree_id) REFERENCES app_tree(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_marriage app_marriage_wife_id_047ef360_fk_app_person_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_marriage
    ADD CONSTRAINT app_marriage_wife_id_047ef360_fk_app_person_id FOREIGN KEY (wife_id) REFERENCES app_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_person app_person_father_id_2e124a87_fk_app_person_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_person
    ADD CONSTRAINT app_person_father_id_2e124a87_fk_app_person_id FOREIGN KEY (father_id) REFERENCES app_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_person app_person_mother_id_4cbfe546_fk_app_person_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_person
    ADD CONSTRAINT app_person_mother_id_4cbfe546_fk_app_person_id FOREIGN KEY (mother_id) REFERENCES app_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_person app_person_tree_id_0c8c7839_fk_app_tree_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY app_person
    ADD CONSTRAINT app_person_tree_id_0c8c7839_fk_app_tree_id FOREIGN KEY (tree_id) REFERENCES app_tree(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk; Type: FK CONSTRAINT; Schema: public; Owner: treeadmin
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

