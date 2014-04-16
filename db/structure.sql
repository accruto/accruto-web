--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE addresses (
    id integer NOT NULL,
    street character varying(255),
    city character varying(255),
    postcode integer,
    state character varying(255),
    latitude double precision,
    longitude double precision,
    addressable_id integer,
    addressable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- Name: bounties; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bounties (
    id integer NOT NULL,
    name character varying(255),
    value double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bounties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bounties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bounties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bounties_id_seq OWNED BY bounties.id;


--
-- Name: candidate_search_beta_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE candidate_search_beta_users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: candidate_search_beta_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE candidate_search_beta_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: candidate_search_beta_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE candidate_search_beta_users_id_seq OWNED BY candidate_search_beta_users.id;


--
-- Name: candidates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE candidates (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    phone character varying(255),
    status character varying(255),
    job_title character varying(255),
    address_id integer,
    visa character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    minimum_annual_salary integer,
    user_id integer,
    profile_photo character varying(255),
    desired_job_title hstore,
    summary text,
    state character varying(255) DEFAULT 'unpublished'::character varying,
    start_interviewing_at timestamp without time zone,
    published_at timestamp without time zone
);


--
-- Name: candidates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE candidates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: candidates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE candidates_id_seq OWNED BY candidates.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE companies (
    id integer NOT NULL,
    name character varying(255),
    phone character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    logo_url character varying(255)
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: contact_forms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contact_forms (
    id integer NOT NULL,
    full_name character varying(255),
    email character varying(255),
    about character varying(255),
    message character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: contact_forms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contact_forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contact_forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contact_forms_id_seq OWNED BY contact_forms.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: educations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE educations (
    id integer NOT NULL,
    institution character varying(255),
    qualification character varying(255),
    qualification_type character varying(255),
    graduated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    candidate_id integer,
    qualification_major character varying(255),
    start_at timestamp without time zone
);


--
-- Name: educations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE educations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: educations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE educations_id_seq OWNED BY educations.id;


--
-- Name: experiences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE experiences (
    id integer NOT NULL,
    company character varying(255),
    job_title character varying(255),
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    current boolean,
    candidate_id integer,
    description text
);


--
-- Name: experiences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE experiences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: experiences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE experiences_id_seq OWNED BY experiences.id;


--
-- Name: favourites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE favourites (
    id integer NOT NULL,
    user_id integer,
    job_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: favourites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE favourites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favourites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE favourites_id_seq OWNED BY favourites.id;


--
-- Name: invites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE invites (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    message text,
    user_id integer,
    status character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invites_id_seq OWNED BY invites.id;


--
-- Name: job_applications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE job_applications (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    resume character varying(255),
    user_id integer,
    job_id integer,
    accepted_terms boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cover_letter text
);


--
-- Name: job_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_applications_id_seq OWNED BY job_applications.id;


--
-- Name: job_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE job_categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    external_category_id integer,
    slug character varying(255),
    external_category_ids text
);


--
-- Name: job_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_categories_id_seq OWNED BY job_categories.id;


--
-- Name: job_subcategories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE job_subcategories (
    id integer NOT NULL,
    name character varying(255),
    job_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    external_subcategory_id integer,
    slug character varying(255),
    external_subcategory_ids text
);


--
-- Name: job_subcategories_candidates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE job_subcategories_candidates (
    id integer NOT NULL,
    candidate_id integer,
    job_subcategory_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: job_subcategories_candidates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_subcategories_candidates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_subcategories_candidates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_subcategories_candidates_id_seq OWNED BY job_subcategories_candidates.id;


--
-- Name: job_subcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_subcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_subcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_subcategories_id_seq OWNED BY job_subcategories.id;


--
-- Name: job_subcategories_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE job_subcategories_jobs (
    id integer NOT NULL,
    job_subcategory_id integer,
    job_id integer
);


--
-- Name: job_subcategories_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_subcategories_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_subcategories_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_subcategories_jobs_id_seq OWNED BY job_subcategories_jobs.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE jobs (
    id integer NOT NULL,
    title character varying(255),
    address_id integer,
    posted_at timestamp without time zone,
    expires_at timestamp without time zone,
    job_type character varying(255),
    company_id integer,
    external_job_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text,
    source character varying(255),
    slug character varying(255),
    external_apply_url character varying(255),
    tsv tsvector
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE jobs_id_seq OWNED BY jobs.id;


--
-- Name: migration_tracks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE migration_tracks (
    id integer NOT NULL,
    last_data_time character varying(255),
    email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: migration_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE migration_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migration_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE migration_tracks_id_seq OWNED BY migration_tracks.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_id integer,
    searchable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE preferences (
    id integer NOT NULL,
    user_id integer,
    email_frequency character varying(255) DEFAULT 'Daily'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    next_alert_date date
);


--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE preferences_id_seq OWNED BY preferences.id;


--
-- Name: recent_searches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE recent_searches (
    id integer NOT NULL,
    job_title character varying(255),
    address character varying(255),
    days character varying(255),
    sort character varying(255),
    category character varying(255),
    user_id integer,
    search_at timestamp without time zone,
    source text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    subscribed boolean DEFAULT false,
    search_results text
);


--
-- Name: recent_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE recent_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recent_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE recent_searches_id_seq OWNED BY recent_searches.id;


--
-- Name: referral_sites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE referral_sites (
    id integer NOT NULL,
    name character varying(255),
    token character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: referral_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE referral_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referral_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE referral_sites_id_seq OWNED BY referral_sites.id;


--
-- Name: resumes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resumes (
    id integer NOT NULL,
    candidate_id integer,
    courses text,
    awards text,
    skills text,
    objective text,
    summary text,
    other character varying(255),
    citizenship character varying(255),
    affiliations text,
    professional text,
    interests text,
    referees text,
    updated_at_linkme timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: resumes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resumes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resumes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE resumes_id_seq OWNED BY resumes.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: shortlists; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE shortlists (
    id integer NOT NULL,
    user_id integer,
    candidate_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: shortlists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE shortlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shortlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE shortlists_id_seq OWNED BY shortlists.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(128),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: trade_qualifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trade_qualifications (
    id integer NOT NULL,
    name character varying(255),
    attained_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    candidate_id integer
);


--
-- Name: trade_qualifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE trade_qualifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trade_qualifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE trade_qualifications_id_seq OWNED BY trade_qualifications.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean,
    authentication_token character varying(255),
    provider character varying(255),
    uid character varying(255),
    linkedin_token character varying(255),
    linkedin_secret character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bounties ALTER COLUMN id SET DEFAULT nextval('bounties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY candidate_search_beta_users ALTER COLUMN id SET DEFAULT nextval('candidate_search_beta_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY candidates ALTER COLUMN id SET DEFAULT nextval('candidates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contact_forms ALTER COLUMN id SET DEFAULT nextval('contact_forms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY educations ALTER COLUMN id SET DEFAULT nextval('educations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY experiences ALTER COLUMN id SET DEFAULT nextval('experiences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY favourites ALTER COLUMN id SET DEFAULT nextval('favourites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY invites ALTER COLUMN id SET DEFAULT nextval('invites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_applications ALTER COLUMN id SET DEFAULT nextval('job_applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_categories ALTER COLUMN id SET DEFAULT nextval('job_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_subcategories ALTER COLUMN id SET DEFAULT nextval('job_subcategories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_subcategories_candidates ALTER COLUMN id SET DEFAULT nextval('job_subcategories_candidates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_subcategories_jobs ALTER COLUMN id SET DEFAULT nextval('job_subcategories_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY jobs ALTER COLUMN id SET DEFAULT nextval('jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY migration_tracks ALTER COLUMN id SET DEFAULT nextval('migration_tracks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY preferences ALTER COLUMN id SET DEFAULT nextval('preferences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY recent_searches ALTER COLUMN id SET DEFAULT nextval('recent_searches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY referral_sites ALTER COLUMN id SET DEFAULT nextval('referral_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY resumes ALTER COLUMN id SET DEFAULT nextval('resumes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY shortlists ALTER COLUMN id SET DEFAULT nextval('shortlists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY trade_qualifications ALTER COLUMN id SET DEFAULT nextval('trade_qualifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: bounties_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bounties
    ADD CONSTRAINT bounties_pkey PRIMARY KEY (id);


--
-- Name: candidate_search_beta_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY candidate_search_beta_users
    ADD CONSTRAINT candidate_search_beta_users_pkey PRIMARY KEY (id);


--
-- Name: candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY candidates
    ADD CONSTRAINT candidates_pkey PRIMARY KEY (id);


--
-- Name: companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: contact_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contact_forms
    ADD CONSTRAINT contact_forms_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: educations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY educations
    ADD CONSTRAINT educations_pkey PRIMARY KEY (id);


--
-- Name: experiences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY experiences
    ADD CONSTRAINT experiences_pkey PRIMARY KEY (id);


--
-- Name: favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY (id);


--
-- Name: invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY invites
    ADD CONSTRAINT invites_pkey PRIMARY KEY (id);


--
-- Name: job_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY job_applications
    ADD CONSTRAINT job_applications_pkey PRIMARY KEY (id);


--
-- Name: job_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY job_categories
    ADD CONSTRAINT job_categories_pkey PRIMARY KEY (id);


--
-- Name: job_subcategories_candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY job_subcategories_candidates
    ADD CONSTRAINT job_subcategories_candidates_pkey PRIMARY KEY (id);


--
-- Name: job_subcategories_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY job_subcategories_jobs
    ADD CONSTRAINT job_subcategories_jobs_pkey PRIMARY KEY (id);


--
-- Name: job_subcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY job_subcategories
    ADD CONSTRAINT job_subcategories_pkey PRIMARY KEY (id);


--
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migration_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY migration_tracks
    ADD CONSTRAINT migration_tracks_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (id);


--
-- Name: recent_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY recent_searches
    ADD CONSTRAINT recent_searches_pkey PRIMARY KEY (id);


--
-- Name: referral_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY referral_sites
    ADD CONSTRAINT referral_sites_pkey PRIMARY KEY (id);


--
-- Name: resumes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resumes
    ADD CONSTRAINT resumes_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: shortlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY shortlists
    ADD CONSTRAINT shortlists_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: trade_qualifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trade_qualifications
    ADD CONSTRAINT trade_qualifications_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: address_city; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX address_city ON addresses USING gin (to_tsvector('simple'::regconfig, (city)::text));


--
-- Name: address_state; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX address_state ON addresses USING gin (to_tsvector('simple'::regconfig, (state)::text));


--
-- Name: address_street; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX address_street ON addresses USING gin (to_tsvector('simple'::regconfig, (street)::text));


--
-- Name: addresses_city; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX addresses_city ON addresses USING gin (to_tsvector('english'::regconfig, (city)::text));


--
-- Name: addresses_state; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX addresses_state ON addresses USING gin (to_tsvector('english'::regconfig, (state)::text));


--
-- Name: addresses_street; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX addresses_street ON addresses USING gin (to_tsvector('english'::regconfig, (street)::text));


--
-- Name: candidates_desired_job_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX candidates_desired_job_title ON candidates USING gin (desired_job_title);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_job_categories_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_job_categories_on_slug ON job_categories USING btree (slug);


--
-- Name: index_job_subcategories_candidates_on_candidate_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_job_subcategories_candidates_on_candidate_id ON job_subcategories_candidates USING btree (candidate_id);


--
-- Name: index_job_subcategories_candidates_on_job_subcategory_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_job_subcategories_candidates_on_job_subcategory_id ON job_subcategories_candidates USING btree (job_subcategory_id);


--
-- Name: index_job_subcategories_jobs_on_job_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_job_subcategories_jobs_on_job_id ON job_subcategories_jobs USING btree (job_id);


--
-- Name: index_job_subcategories_jobs_on_job_subcategory_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_job_subcategories_jobs_on_job_subcategory_id ON job_subcategories_jobs USING btree (job_subcategory_id);


--
-- Name: index_job_subcategories_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_job_subcategories_on_slug ON job_subcategories USING btree (slug);


--
-- Name: index_jobs_on_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_jobs_on_address_id ON jobs USING btree (address_id);


--
-- Name: index_jobs_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_jobs_on_company_id ON jobs USING btree (company_id);


--
-- Name: index_jobs_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_jobs_on_slug ON jobs USING btree (slug);


--
-- Name: index_recent_searches_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_recent_searches_on_user_id ON recent_searches USING btree (user_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: job_subcategories_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX job_subcategories_name ON job_subcategories USING gin (to_tsvector('english'::regconfig, (name)::text));


--
-- Name: jobs_description; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX jobs_description ON jobs USING gin (to_tsvector('english'::regconfig, description));


--
-- Name: jobs_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX jobs_title ON jobs USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: tsvectorupdate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON jobs FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('tsv', 'pg_catalog.english', 'title', 'description');


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130725054250');

INSERT INTO schema_migrations (version) VALUES ('20130725072015');

INSERT INTO schema_migrations (version) VALUES ('20130726053237');

INSERT INTO schema_migrations (version) VALUES ('20130726054115');

INSERT INTO schema_migrations (version) VALUES ('20130729015726');

INSERT INTO schema_migrations (version) VALUES ('20130729015755');

INSERT INTO schema_migrations (version) VALUES ('20130729021702');

INSERT INTO schema_migrations (version) VALUES ('20130730072030');

INSERT INTO schema_migrations (version) VALUES ('20130730075746');

INSERT INTO schema_migrations (version) VALUES ('20130801000247');

INSERT INTO schema_migrations (version) VALUES ('20130801012023');

INSERT INTO schema_migrations (version) VALUES ('20130801055205');

INSERT INTO schema_migrations (version) VALUES ('20130805042117');

INSERT INTO schema_migrations (version) VALUES ('20130806060106');

INSERT INTO schema_migrations (version) VALUES ('20130806061727');

INSERT INTO schema_migrations (version) VALUES ('20130808013415');

INSERT INTO schema_migrations (version) VALUES ('20130808013436');

INSERT INTO schema_migrations (version) VALUES ('20130812012143');

INSERT INTO schema_migrations (version) VALUES ('20130812012853');

INSERT INTO schema_migrations (version) VALUES ('20130813184913');

INSERT INTO schema_migrations (version) VALUES ('20130814234953');

INSERT INTO schema_migrations (version) VALUES ('20130817004316');

INSERT INTO schema_migrations (version) VALUES ('20130817154613');

INSERT INTO schema_migrations (version) VALUES ('20130817214007');

INSERT INTO schema_migrations (version) VALUES ('20130820065102');

INSERT INTO schema_migrations (version) VALUES ('20130820145500');

INSERT INTO schema_migrations (version) VALUES ('20130821054545');

INSERT INTO schema_migrations (version) VALUES ('20130821203933');

INSERT INTO schema_migrations (version) VALUES ('20130824165351');

INSERT INTO schema_migrations (version) VALUES ('20130826044920');

INSERT INTO schema_migrations (version) VALUES ('20130827015131');

INSERT INTO schema_migrations (version) VALUES ('20130827015520');

INSERT INTO schema_migrations (version) VALUES ('20130827072058');

INSERT INTO schema_migrations (version) VALUES ('20130830045542');

INSERT INTO schema_migrations (version) VALUES ('20130831104406');

INSERT INTO schema_migrations (version) VALUES ('20130831120034');

INSERT INTO schema_migrations (version) VALUES ('20130901024502');

INSERT INTO schema_migrations (version) VALUES ('20130901040950');

INSERT INTO schema_migrations (version) VALUES ('20130916010308');

INSERT INTO schema_migrations (version) VALUES ('20130918053025');

INSERT INTO schema_migrations (version) VALUES ('20130918061409');

INSERT INTO schema_migrations (version) VALUES ('20130925032510');

INSERT INTO schema_migrations (version) VALUES ('20130925034531');

INSERT INTO schema_migrations (version) VALUES ('20130926060517');

INSERT INTO schema_migrations (version) VALUES ('20130927054409');

INSERT INTO schema_migrations (version) VALUES ('20130929001747');

INSERT INTO schema_migrations (version) VALUES ('20130929002304');

INSERT INTO schema_migrations (version) VALUES ('20130929002928');

INSERT INTO schema_migrations (version) VALUES ('20130930070808');

INSERT INTO schema_migrations (version) VALUES ('20131002005453');

INSERT INTO schema_migrations (version) VALUES ('20131002012731');

INSERT INTO schema_migrations (version) VALUES ('20131002042018');

INSERT INTO schema_migrations (version) VALUES ('20131002042934');

INSERT INTO schema_migrations (version) VALUES ('20131002043714');

INSERT INTO schema_migrations (version) VALUES ('20131002043807');

INSERT INTO schema_migrations (version) VALUES ('20131002044556');

INSERT INTO schema_migrations (version) VALUES ('20131002050833');

INSERT INTO schema_migrations (version) VALUES ('20131002060906');

INSERT INTO schema_migrations (version) VALUES ('20131002061854');

INSERT INTO schema_migrations (version) VALUES ('20131002063548');

INSERT INTO schema_migrations (version) VALUES ('20131002064229');

INSERT INTO schema_migrations (version) VALUES ('20131003162941');

INSERT INTO schema_migrations (version) VALUES ('20131003201606');

INSERT INTO schema_migrations (version) VALUES ('20131004065549');

INSERT INTO schema_migrations (version) VALUES ('20131006070837');

INSERT INTO schema_migrations (version) VALUES ('20131006093339');

INSERT INTO schema_migrations (version) VALUES ('20131008042909');

INSERT INTO schema_migrations (version) VALUES ('20131008085037');

INSERT INTO schema_migrations (version) VALUES ('20131010005856');

INSERT INTO schema_migrations (version) VALUES ('20131013154301');

INSERT INTO schema_migrations (version) VALUES ('20131014033429');

INSERT INTO schema_migrations (version) VALUES ('20131016145859');

INSERT INTO schema_migrations (version) VALUES ('20131018034945');

INSERT INTO schema_migrations (version) VALUES ('20131127222156');

INSERT INTO schema_migrations (version) VALUES ('20140416195725');