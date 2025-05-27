--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2025-05-23 15:38:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4885 (class 1262 OID 16767)
-- Name: connexus_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE connexus_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE connexus_db OWNER TO postgres;

\connect connexus_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16769)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id_cliente integer NOT NULL,
    nome character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    telefone character varying(20),
    data_nascimento date,
    data_cadastro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(10) DEFAULT 'ativo'::character varying
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16768)
-- Name: clientes_id_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_cliente_seq OWNER TO postgres;

--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 215
-- Name: clientes_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_cliente_seq OWNED BY public.clientes.id_cliente;


--
-- TOC entry 218 (class 1259 OID 16782)
-- Name: enderecos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enderecos (
    id_endereco integer NOT NULL,
    id_cliente integer,
    logradouro character varying(255),
    numero character varying(20),
    bairro character varying(100),
    cidade character varying(100),
    estado character varying(100),
    cep character varying(10)
);


ALTER TABLE public.enderecos OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16781)
-- Name: enderecos_id_endereco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enderecos_id_endereco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enderecos_id_endereco_seq OWNER TO postgres;

--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 217
-- Name: enderecos_id_endereco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enderecos_id_endereco_seq OWNED BY public.enderecos.id_endereco;


--
-- TOC entry 220 (class 1259 OID 16796)
-- Name: historico_interacoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historico_interacoes (
    id_interacao integer NOT NULL,
    id_cliente integer,
    data_interacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    tipo_interacao character varying(50),
    detalhes text,
    id_usuario integer
);


ALTER TABLE public.historico_interacoes OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16795)
-- Name: historico_interacoes_id_interacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historico_interacoes_id_interacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historico_interacoes_id_interacao_seq OWNER TO postgres;

--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 219
-- Name: historico_interacoes_id_interacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historico_interacoes_id_interacao_seq OWNED BY public.historico_interacoes.id_interacao;


--
-- TOC entry 222 (class 1259 OID 16811)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nome character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    tipo_usuario character varying(20) DEFAULT 'colaborador'::character varying,
    username character varying(255),
    nivel_acesso integer DEFAULT 1
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16810)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 4703 (class 2604 OID 16772)
-- Name: clientes id_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id_cliente SET DEFAULT nextval('public.clientes_id_cliente_seq'::regclass);


--
-- TOC entry 4706 (class 2604 OID 16785)
-- Name: enderecos id_endereco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enderecos ALTER COLUMN id_endereco SET DEFAULT nextval('public.enderecos_id_endereco_seq'::regclass);


--
-- TOC entry 4707 (class 2604 OID 16799)
-- Name: historico_interacoes id_interacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_interacoes ALTER COLUMN id_interacao SET DEFAULT nextval('public.historico_interacoes_id_interacao_seq'::regclass);


--
-- TOC entry 4709 (class 2604 OID 16814)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 4873 (class 0 OID 16769)
-- Dependencies: 216
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id_cliente, nome, email, telefone, data_nascimento, data_cadastro, status) FROM stdin;
1	João Silva	joao.silva@example.com	123456789	1990-05-15	2025-05-22 07:59:24.779426	ativo
\.


--
-- TOC entry 4875 (class 0 OID 16782)
-- Dependencies: 218
-- Data for Name: enderecos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enderecos (id_endereco, id_cliente, logradouro, numero, bairro, cidade, estado, cep) FROM stdin;
1	1	Rua A	123	Centro	Natividade	TO	77300000
\.


--
-- TOC entry 4877 (class 0 OID 16796)
-- Dependencies: 220
-- Data for Name: historico_interacoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historico_interacoes (id_interacao, id_cliente, data_interacao, tipo_interacao, detalhes, id_usuario) FROM stdin;
\.


--
-- TOC entry 4879 (class 0 OID 16811)
-- Dependencies: 222
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, nome, email, senha, data_criacao, tipo_usuario, username, nivel_acesso) FROM stdin;
5	João Gabriel	joaogabriil896@gmail.com	$2b$10$dhY1pVX.OlOv8slJoy7nueFBxSi2MRBEX2xBbLV/n/5E.UK88QOUe	2025-05-23 13:57:26.792035	colaborador	joao gabriel	2
2	Administrador	admin@connexus.com	$2b$10$A0tRyMcOPvtn92.PCMqRwuFaJiHpB1nAh/Gvkj76tVJTLXvN.JSkG	2025-05-22 10:43:33.852987	Admin	admin2	3
\.


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 215
-- Name: clientes_id_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_cliente_seq', 1, true);


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 217
-- Name: enderecos_id_endereco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enderecos_id_endereco_seq', 1, true);


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 219
-- Name: historico_interacoes_id_interacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_interacoes_id_interacao_seq', 1, false);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 5, true);


--
-- TOC entry 4714 (class 2606 OID 16780)
-- Name: clientes clientes_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_email_key UNIQUE (email);


--
-- TOC entry 4716 (class 2606 OID 16778)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 4718 (class 2606 OID 16789)
-- Name: enderecos enderecos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enderecos
    ADD CONSTRAINT enderecos_pkey PRIMARY KEY (id_endereco);


--
-- TOC entry 4720 (class 2606 OID 16804)
-- Name: historico_interacoes historico_interacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_interacoes
    ADD CONSTRAINT historico_interacoes_pkey PRIMARY KEY (id_interacao);


--
-- TOC entry 4722 (class 2606 OID 16822)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4724 (class 2606 OID 16820)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4726 (class 2606 OID 16825)
-- Name: usuarios usuarios_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);


--
-- TOC entry 4727 (class 2606 OID 16790)
-- Name: enderecos enderecos_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enderecos
    ADD CONSTRAINT enderecos_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 4728 (class 2606 OID 16805)
-- Name: historico_interacoes historico_interacoes_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_interacoes
    ADD CONSTRAINT historico_interacoes_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 4885
-- Name: DATABASE connexus_db; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE connexus_db TO admin2004;


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE clientes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.clientes TO admin2004;


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE enderecos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.enderecos TO admin2004;


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE historico_interacoes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.historico_interacoes TO admin2004;


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE usuarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.usuarios TO admin2004;


-- Completed on 2025-05-23 15:38:01

--
-- PostgreSQL database dump complete
--

