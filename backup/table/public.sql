--
-- PostgreSQL database dump
--


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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: tag_n_decr(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.tag_n_decr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE tag SET n = n - 1 where id=OLD.tag_id;
        RETURN NULL;
    END;
$$;


--
-- Name: tag_n_incr(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.tag_n_incr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE tag SET n = n + 1 where id=NEW.tag_id;
        RETURN NULL;
    END;
$$;


SET default_tablespace = '';

--
-- Name: license; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.license (
    id bigint NOT NULL,
    spdx character varying NOT NULL
);


--
-- Name: license_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.license_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


--
-- Name: license_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.license_id_seq OWNED BY public.license.id;


--
-- Name: mod; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mod (
    id bigint NOT NULL,
    name character varying NOT NULL,
    site_id bigint NOT NULL,
    url character varying NOT NULL,
    user_id bigint NOT NULL,
    down bigint NOT NULL,
    brief character varying NOT NULL,
    utime bigint DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL,
    ctime bigint DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL,
    license_id bigint DEFAULT 0 NOT NULL
);


--
-- Name: mod_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


--
-- Name: mod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mod_id_seq OWNED BY public.mod.id;


--
-- Name: mod_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mod_tag (
    id bigint NOT NULL,
    tag_id bigint NOT NULL,
    mod_id bigint NOT NULL
);


--
-- Name: mod_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mod_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


--
-- Name: mod_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mod_tag_id_seq OWNED BY public.mod_tag.id;


--
-- Name: site; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site (
    id bigint NOT NULL,
    host character varying NOT NULL
);


--
-- Name: site_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


--
-- Name: site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_id_seq OWNED BY public.site.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tag (
    id bigint NOT NULL,
    name character varying NOT NULL,
    n bigint DEFAULT 0 NOT NULL
);


--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: user_name; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_name (
    id bigint NOT NULL,
    name character varying NOT NULL
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_id_seq OWNED BY public.user_name.id;


--
-- Name: user_id_site_id; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_id_site_id (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    site_id bigint NOT NULL
);


--
-- Name: user_id_site_id_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_site_id_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


--
-- Name: user_id_site_id_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_id_site_id_id_seq OWNED BY public.user_id_site_id.id;


--
-- Name: license id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.license ALTER COLUMN id SET DEFAULT nextval('public.license_id_seq'::regclass);


--
-- Name: mod id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mod ALTER COLUMN id SET DEFAULT nextval('public.mod_id_seq'::regclass);


--
-- Name: mod_tag id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mod_tag ALTER COLUMN id SET DEFAULT nextval('public.mod_tag_id_seq'::regclass);


--
-- Name: site id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site ALTER COLUMN id SET DEFAULT nextval('public.site_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: user_id_site_id id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_id_site_id ALTER COLUMN id SET DEFAULT nextval('public.user_id_site_id_id_seq'::regclass);


--
-- Name: user_name id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_name ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: mod mod_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mod
    ADD CONSTRAINT mod_name UNIQUE (name);


--
-- Name: mod mod_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mod
    ADD CONSTRAINT mod_pk PRIMARY KEY (id);


--
-- Name: mod_tag mod_tag_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mod_tag
    ADD CONSTRAINT mod_tag_pk PRIMARY KEY (id);


--
-- Name: license pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.license
    ADD CONSTRAINT pk PRIMARY KEY (id);


--
-- Name: site site_host; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site
    ADD CONSTRAINT site_host UNIQUE (host);


--
-- Name: site site_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site
    ADD CONSTRAINT site_pk PRIMARY KEY (id);


--
-- Name: license spdx; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.license
    ADD CONSTRAINT spdx UNIQUE (spdx);


--
-- Name: tag tag_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_name UNIQUE (name);


--
-- Name: tag tag_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pk PRIMARY KEY (id);


--
-- Name: user_id_site_id user_id_site_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_id_site_id
    ADD CONSTRAINT user_id_site_id_pk PRIMARY KEY (id);


--
-- Name: user_id_site_id user_id_site_id_un; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_id_site_id
    ADD CONSTRAINT user_id_site_id_un UNIQUE (user_id, site_id);


--
-- Name: user_name user_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_name
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: mod_down_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mod_down_idx ON public.mod USING lsm (down HASH);


--
-- Name: mod_site_id_url; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX mod_site_id_url ON public.mod USING lsm (site_id HASH, url ASC);


--
-- Name: mod_tag_mod_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX mod_tag_mod_id_idx ON public.mod_tag USING lsm (mod_id HASH, tag_id ASC);


--
-- Name: tag_n_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tag_n_idx ON public.tag USING lsm (n DESC);


--
-- Name: user_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_name_idx ON public.user_name USING lsm (name HASH);


--
-- Name: mod_tag add; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER add AFTER INSERT ON public.mod_tag FOR EACH ROW EXECUTE PROCEDURE public.tag_n_incr('tag_id');


--
-- Name: mod_tag del; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER del AFTER DELETE ON public.mod_tag FOR EACH ROW EXECUTE PROCEDURE public.tag_n_decr('tag_id');


--
-- PostgreSQL database dump complete
--

