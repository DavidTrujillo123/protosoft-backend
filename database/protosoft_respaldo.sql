--
-- PostgreSQL database dump
--

-- Dumped from database version 11.18
-- Dumped by pg_dump version 15.3

-- Started on 2023-07-18 19:35:22

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

--
-- TOC entry 8 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: azure_superuser
--

-- *not* creating schema, since initdb creates it


-- ALTER SCHEMA public OWNER TO azure_superuser;

--
-- TOC entry 229 (class 1255 OID 17449)
-- Name: generar_regid(); Type: FUNCTION; Schema: public; Owner: utnAdmin
--

CREATE FUNCTION public.generar_regid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	regid character varying;
BEGIN
	regid = CONCAT('R-',UPPER(new.regreino),(SELECT COUNT(*) FROM registros) + 1);
 	new.regid = regid;
	RAISE NOTICE '%', new.regid;
  RETURN NEW;
END;
$$;


-- ALTER FUNCTION public.generar_regid() OWNER TO "utnAdmin";

--
-- TOC entry 216 (class 1255 OID 17371)
-- Name: generar_usuid(); Type: FUNCTION; Schema: public; Owner: utnAdmin
--

CREATE FUNCTION public.generar_usuid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	usuid character varying;
BEGIN
	usuid = CONCAT(UPPER(new.rolid),'-',(SELECT COUNT(*) FROM usuarios) + 1);
 	new.usuid = usuid;
	RAISE NOTICE '%', new.usuid;
  RETURN NEW;
END;
$$;


-- ALTER FUNCTION public.generar_usuid() OWNER TO "utnAdmin";

--
-- TOC entry 231 (class 1255 OID 17448)
-- Name: insert_registros(character varying, boolean, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: utnAdmin
--

CREATE FUNCTION public.insert_registros(p_usuid character varying, p_regestado boolean, p_regnombre_cientifico character varying, p_regnombre_vulgar character varying, p_regespecie character varying, p_reggenero character varying, p_regfamilia character varying, p_regorden character varying, p_regclase character varying, p_regfilo character varying, p_regreino character varying, p_regdescripcion character varying, p_reghabitat character varying, p_img character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  new_regid character varying;
BEGIN
	-- Insert en registros
	INSERT INTO public.registros(
    	usuid, regestado, regnombre_cientifico, 
    	regnombre_vulgar, regespecie, reggenero, regfamilia, 
    	regorden, regclase, regfilo, regreino, 
    	regdescripcion, reghabitat)
  	VALUES (
    	p_usuid, p_regestado, p_regnombre_cientifico, 
    	p_regnombre_vulgar, p_regespecie, p_reggenero, p_regfamilia, 
    	p_regorden, p_regclase, p_regfilo, p_regreino, 
    	p_regdescripcion, p_reghabitat)
		RETURNING regid INTO new_regid;

	INSERT INTO public.registroimg 
		values (p_img, new_regid);
END;
$$;


-- ALTER FUNCTION public.insert_registros(p_usuid character varying, p_regestado boolean, p_regnombre_cientifico character varying, p_regnombre_vulgar character varying, p_regespecie character varying, p_reggenero character varying, p_regfamilia character varying, p_regorden character varying, p_regclase character varying, p_regfilo character varying, p_regreino character varying, p_regdescripcion character varying, p_reghabitat character varying, p_img character varying) OWNER TO "utnAdmin";

--
-- TOC entry 230 (class 1255 OID 17453)
-- Name: insert_usuarios(character varying, character varying, character varying, character varying, character varying, boolean, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: utnAdmin
--

CREATE FUNCTION public.insert_usuarios(p_rolid character varying, p_usucorreo character varying, p_usucontrasenia character varying, p_usunombre character varying, p_usuapellido character varying, p_usuestado boolean, p_usuimagen character varying, p_usutelefono character varying, p_preg1 character varying, p_respt1 character varying, p_preg2 character varying, p_respt2 character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  new_usuid character varying;
BEGIN
	-- Insert en usuarios
	INSERT INTO usuarios (rolid, usucorreo, usucontrasenia, 
						  usunombre, usuapellido, usuestado, 
						  usuimagen, usutelefono)
    VALUES (p_rolid, p_usucorreo, p_usucontrasenia, 
				p_usunombre, p_usuapellido, 
				p_usuestado, p_usuimagen, p_usutelefono)
	RETURNING usuid INTO new_usuid;
				
	--Insert en preguntas de recuperacion
	INSERT INTO public.preguntas_recuperacion(
            usuid, pregunta, respuesta)
                VALUES (new_usuid, p_preg1, p_respt1);

	INSERT INTO public.preguntas_recuperacion(
            usuid, pregunta, respuesta)
                VALUES (new_usuid, p_preg2, p_respt2);
END;
$$;


-- ALTER FUNCTION public.insert_usuarios(p_rolid character varying, p_usucorreo character varying, p_usucontrasenia character varying, p_usunombre character varying, p_usuapellido character varying, p_usuestado boolean, p_usuimagen character varying, p_usutelefono character varying, p_preg1 character varying, p_respt1 character varying, p_preg2 character varying, p_respt2 character varying) OWNER TO "utnAdmin";

--
-- TOC entry 232 (class 1255 OID 17463)
-- Name: registrosdeusuario(character varying); Type: FUNCTION; Schema: public; Owner: utnAdmin
--

CREATE FUNCTION public.registrosdeusuario(p_usuario_id character varying) RETURNS TABLE(registro_id character varying, usuario_id character varying, estado_registro boolean, nombre_cientifico character varying, nombre_vulgar character varying, especie character varying, genero character varying, familia character varying, orden character varying, clase character varying, filo character varying, reino character varying, descripcion text, habitat text, ruta_imagen character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        r.regid AS registro_id, 
        r.usuid AS usuario_id, 
        r.regestado AS estado_registro, 
        r.regnombre_cientifico AS nombre_cientifico, 
        r.regnombre_vulgar AS nombre_vulgar,
        r.regespecie AS especie, 
        r.reggenero AS genero, 
        r.regfamilia AS familia, 
        r.regorden AS orden, 
        r.regclase AS clase,
        r.regfilo AS filo, 
        r.regreino AS reino, 
        r.regdescripcion AS descripcion, 
        r.reghabitat AS habitat, 
        ri.imgruta AS ruta_imagen
    FROM registros r
    LEFT JOIN registroimg ri ON r.regid = ri.regid
    WHERE r.usuid = p_usuario_id;
END;
$$;


-- ALTER FUNCTION public.registrosdeusuario(p_usuario_id character varying) OWNER TO "utnAdmin";

-- SET default_tablespace = '';

--
-- TOC entry 200 (class 1259 OID 17231)
-- Name: clases; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.clases (
    claid character varying(10) NOT NULL,
    filid character varying(10) NOT NULL,
    clanombre character varying(256) NOT NULL
);


-- ALTER TABLE public.clases OWNER TO "utnAdmin";

--
-- TOC entry 201 (class 1259 OID 17238)
-- Name: especies; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.especies (
    espid character varying(10) NOT NULL,
    genid character varying(10) NOT NULL,
    espnombre character varying(256) NOT NULL
);


-- ALTER TABLE public.especies OWNER TO "utnAdmin";

--
-- TOC entry 202 (class 1259 OID 17245)
-- Name: familias; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.familias (
    famid character varying(10) NOT NULL,
    ordid character varying(10) NOT NULL,
    famnombre character varying(256) NOT NULL
);


-- ALTER TABLE public.familias OWNER TO "utnAdmin";

--
-- TOC entry 203 (class 1259 OID 17252)
-- Name: filos; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.filos (
    filid character varying(10) NOT NULL,
    reiid character varying(10) NOT NULL,
    filnombre character varying(256) NOT NULL
);


-- ALTER TABLE public.filos OWNER TO "utnAdmin";

--
-- TOC entry 204 (class 1259 OID 17259)
-- Name: generos; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.generos (
    genid character varying(10) NOT NULL,
    famid character varying(10) NOT NULL,
    gennombre character varying(256) NOT NULL
);


-- ALTER TABLE public.generos OWNER TO "utnAdmin";

--
-- TOC entry 205 (class 1259 OID 17266)
-- Name: ordenes; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.ordenes (
    ordid character varying(10) NOT NULL,
    claid character varying(10) NOT NULL,
    ordnombre character varying(256) NOT NULL
);


-- ALTER TABLE public.ordenes OWNER TO "utnAdmin";

--
-- TOC entry 206 (class 1259 OID 17273)
-- Name: preguntas_recuperacion; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.preguntas_recuperacion (
    usuid character varying(20) NOT NULL,
    pregunta text NOT NULL,
    respuesta text NOT NULL
);


-- ALTER TABLE public.preguntas_recuperacion OWNER TO "utnAdmin";

--
-- TOC entry 207 (class 1259 OID 17280)
-- Name: registroimg; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.registroimg (
    imgruta character varying(256) NOT NULL,
    regid character varying(20) NOT NULL
);


-- ALTER TABLE public.registroimg OWNER TO "utnAdmin";

--
-- TOC entry 208 (class 1259 OID 17287)
-- Name: registros; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.registros (
    regid character varying(20) NOT NULL,
    usuid character varying(20) NOT NULL,
    regestado boolean NOT NULL,
    regnombre_cientifico character varying(256) NOT NULL,
    regnombre_vulgar character varying(256) NOT NULL,
    regespecie character varying(256) NOT NULL,
    reggenero character varying(256) NOT NULL,
    regfamilia character varying(256) NOT NULL,
    regorden character varying(256) NOT NULL,
    regclase character varying(256) NOT NULL,
    regfilo character varying(256) NOT NULL,
    regreino character varying(256) NOT NULL,
    regdescripcion text,
    reghabitat text
);


-- ALTER TABLE public.registros OWNER TO "utnAdmin";

--
-- TOC entry 211 (class 1259 OID 17309)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.usuarios (
    usuid character varying(20) NOT NULL,
    rolid character varying(3) NOT NULL,
    usucorreo character varying(256) NOT NULL,
    usucontrasenia character varying(256) NOT NULL,
    usunombre character varying(40) NOT NULL,
    usuapellido character varying(40) NOT NULL,
    usuestado boolean NOT NULL,
    usuimagen character varying(256),
    usutelefono character varying(10)
);


-- ALTER TABLE public.usuarios OWNER TO "utnAdmin";

--
-- TOC entry 212 (class 1259 OID 17495)
-- Name: registros_de_usuario; Type: VIEW; Schema: public; Owner: utnAdmin
--

CREATE VIEW public.registros_de_usuario AS
 SELECT r.regid AS registro_id,
    r.usuid AS usuario_id,
    concat(usu.usunombre, ' ', usu.usuapellido) AS usunombre,
    r.regestado AS estado_registro,
    r.regnombre_cientifico AS nombre_cientifico,
    r.regnombre_vulgar AS nombre_vulgar,
    esp.espnombre AS especie,
    gen.gennombre AS genero,
    fam.famnombre AS familia,
    ord.ordnombre AS orden,
    cla.clanombre AS clase,
    fil.filnombre AS filo,
    r.regreino AS reino,
    r.regdescripcion AS descripcion,
    r.reghabitat AS habitat,
    ri.imgruta AS ruta_imagen
   FROM ((((((((public.registros r
     LEFT JOIN public.registroimg ri ON (((r.regid)::text = (ri.regid)::text)))
     LEFT JOIN public.especies esp ON (((r.regespecie)::text = (esp.espid)::text)))
     LEFT JOIN public.generos gen ON (((r.reggenero)::text = (gen.genid)::text)))
     LEFT JOIN public.familias fam ON (((r.regfamilia)::text = (fam.famid)::text)))
     LEFT JOIN public.ordenes ord ON (((r.regorden)::text = (ord.ordid)::text)))
     LEFT JOIN public.clases cla ON (((r.regclase)::text = (cla.claid)::text)))
     LEFT JOIN public.filos fil ON (((r.regfilo)::text = (fil.filid)::text)))
     LEFT JOIN public.usuarios usu ON (((r.usuid)::text = (usu.usuid)::text)));


-- ALTER TABLE public.registros_de_usuario OWNER TO "utnAdmin";

--
-- TOC entry 209 (class 1259 OID 17297)
-- Name: reinos; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.reinos (
    reiid character varying(10) NOT NULL,
    reinombre character varying(256) NOT NULL
);


-- ALTER TABLE public.reinos OWNER TO "utnAdmin";

--
-- TOC entry 210 (class 1259 OID 17303)
-- Name: rol; Type: TABLE; Schema: public; Owner: utnAdmin
--

CREATE TABLE public.rol (
    rolid character varying(3) NOT NULL,
    rolnombre character varying(15) NOT NULL
);


-- ALTER TABLE public.rol OWNER TO "utnAdmin";

--
-- TOC entry 4334 (class 0 OID 17231)
-- Dependencies: 200
-- Data for Name: clases; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.clases (claid, filid, clanombre) FROM stdin;
CLA-TU1	FIL-AM1	Tubulinea
CLA-DI2	FIL-AM1	Discosea
CLA-CO3	FIL-AM1	Conosa
CLA-AR4	FIL-AM1	Archamoebae
CLA-EV5	FIL-AM1	Evosea
CLA-CO6	FIL-AP2	Conoidasida
CLA-AC7	FIL-AP2	Aconoidasida
CLA-HA8	FIL-AP2	Haemospororida
CLA-PI9	FIL-AP2	Piroplasmida
CLA-CO10	FIL-AP2	Coccidia
CLA-OL11	FIL-CI3	Oligohymenophorea
CLA-SP12	FIL-CI3	Spirotrichea
CLA-LI13	FIL-CI3	Litostomatea
CLA-PH14	FIL-CI3	Phyllopharyngea
CLA-HA15	FIL-CI3	Haptoria
CLA-DI16	FIL-DI4	Dinophyceae
CLA-NO17	FIL-DI4	Noctiluciphyceae
CLA-PO18	FIL-DI4	Polykrikoida
CLA-BL19	FIL-DI4	Blastodiniphyceae
CLA-EL20	FIL-DI4	Ellobiopsida
CLA-EU21	FIL-EU5	Euglenoidea
CLA-KI22	FIL-EU5	Kinetoplastea
CLA-DI23	FIL-EU5	Diplonemea
CLA-PR24	FIL-EU5	Prokinetoplastina
CLA-SY25	FIL-EU5	Symbiontida
\.


--
-- TOC entry 4335 (class 0 OID 17238)
-- Dependencies: 201
-- Data for Name: especies; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.especies (espid, genid, espnombre) FROM stdin;
ESP-PR1	GEN-AM1	proteus
ESP-DU2	GEN-AM1	dubia
ESP-VE3	GEN-AM1	verrucosa
ESP-PR4	GEN-AM1	proteus
ESP-TE5	GEN-AM1	terricola
ESP-TE6	GEN-EI6	tenella
ESP-AC7	GEN-EI6	acervulina
ESP-MA8	GEN-EI6	maxima
ESP-NE9	GEN-EI6	necatrix
ESP-BR10	GEN-EI6	brunetti
ESP-MI11	GEN-VO11	microstoma
ESP-CO12	GEN-VO11	convallaria
ESP-CA13	GEN-VO11	campanula
ESP-NE14	GEN-VO11	nebulifera
ESP-PA15	GEN-VO11	patula
ESP-PA16	GEN-SY16	pandora
\.


--
-- TOC entry 4336 (class 0 OID 17245)
-- Dependencies: 202
-- Data for Name: familias; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.familias (famid, ordid, famnombre) FROM stdin;
FAM-AM1	ORD-TU1	Amoebidae
FAM-HA2	ORD-TU1	Hartmannellidae
FAM-VA3	ORD-TU1	Vahlkampfiidae
FAM-TH4	ORD-TU1	Thecamoebidae
FAM-PE5	ORD-TU1	Pelobiontidae
FAM-EI6	ORD-CO11	Eimeriidae
FAM-CY7	ORD-CO11	Cryptosporidiidae
FAM-SA8	ORD-CO11	Sarcocystidae
FAM-GO9	ORD-CO11	Goussartiidae
FAM-IS10	ORD-CO11	Isosporidae
FAM-VO11	ORD-PE16	Vorticellidae
FAM-ZO12	ORD-PE16	Zoothamniidae
FAM-EP13	ORD-PE16	Epistylididae
FAM-CA14	ORD-PE16	Carchesiidae
FAM-SC15	ORD-PE16	Scyphidiidae
FAM-SY16	ORD-SY21	Symbiontidae
\.


--
-- TOC entry 4337 (class 0 OID 17252)
-- Dependencies: 203
-- Data for Name: filos; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.filos (filid, reiid, filnombre) FROM stdin;
FIL-AM1	PROT	Amoebozoa
FIL-AP2	PROT	Apicomplexa
FIL-CI3	PROT	Ciliophora
FIL-DI4	PROT	Dinoflagellata
FIL-EU5	PROT	Euglenozoa
\.


--
-- TOC entry 4338 (class 0 OID 17259)
-- Dependencies: 204
-- Data for Name: generos; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.generos (genid, famid, gennombre) FROM stdin;
GEN-AM1	FAM-AM1	Amoeba
GEN-CH2	FAM-AM1	Chaos
GEN-HA3	FAM-AM1	Hartmannella
GEN-PL4	FAM-AM1	Platyamoeba
GEN-ST5	FAM-AM1	Sterkiella
GEN-EI6	FAM-EI6	Eimeria
GEN-IS7	FAM-EI6	Isospora
GEN-CY8	FAM-EI6	Cyclospora
GEN-CR9	FAM-EI6	Cryptosporidium
GEN-TO10	FAM-EI6	Toxoplasma
GEN-VO11	FAM-VO11	Vorticella
GEN-ZO12	FAM-VO11	Zoothamnium
GEN-EP13	FAM-VO11	Epistylis
GEN-CA14	FAM-VO11	Carchesium
GEN-SC15	FAM-VO11	Scyphidia
GEN-SY16	FAM-SY16	Symbion
\.


--
-- TOC entry 4339 (class 0 OID 17266)
-- Dependencies: 205
-- Data for Name: ordenes; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.ordenes (ordid, claid, ordnombre) FROM stdin;
ORD-TU1	CLA-TU1	Tubulinida
ORD-EN2	CLA-TU1	Entamoebida
ORD-LE3	CLA-TU1	Leptomyxida
ORD-PE4	CLA-TU1	Pelobiontida
ORD-HI5	CLA-TU1	Himatismenida
ORD-AC6	CLA-DI2	Acrasida
ORD-EC7	CLA-DI2	Echinamoebida
ORD-VA8	CLA-DI2	Variosea
ORD-MY9	CLA-DI2	Mycetozoa
ORD-TH10	CLA-DI2	Thecamoebida
ORD-CO11	CLA-CO6	Coccidiorida
ORD-PI12	CLA-CO6	Piroplasmorida
ORD-EU13	CLA-CO6	Eucoccidiorida
ORD-GR14	CLA-CO6	Gregarinorida
ORD-HA15	CLA-CO6	Haemospororida
ORD-PE16	CLA-OL11	Peritrichida
ORD-HY17	CLA-OL11	Hymenostomatida
ORD-SC18	CLA-OL11	Scuticociliatida
ORD-OL19	CLA-OL11	Oligotrichida
ORD-ST20	CLA-OL11	Stichotrichida
ORD-SY21	CLA-SY25	Symbiontida
\.


--
-- TOC entry 4340 (class 0 OID 17273)
-- Dependencies: 206
-- Data for Name: preguntas_recuperacion; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.preguntas_recuperacion (usuid, pregunta, respuesta) FROM stdin;
INV-1	Mi juego favorito	psp
INV-1	Nombre de mi mascota	tomas
INV-2	Color favorito 	Azul
INV-2	Como se llama tu gato	Panda
\.


--
-- TOC entry 4341 (class 0 OID 17280)
-- Dependencies: 207
-- Data for Name: registroimg; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.registroimg (imgruta, regid) FROM stdin;
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689651475/mp3y85ml6ubdwziuwobo.webp	R-PROTISTA1
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689652256/e7hhybjowjvzfw5ndx4y.jpg	R-PROTISTA2
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689688378/jvodqh4nijjdzrz7rrbh.jpg	R-PROTISTA3
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689689216/vdgm6kgicwncihbjvkza.jpg	R-PROTISTA4
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689691109/hjhl0dlnkygereekdjko.jpg	R-PROTISTA5
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689695219/jgoh5y6py3tzyfonjsij.jpg	R-PROTISTA6
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689695783/hili8exlnv6jbebspkw8.jpg	R-PROTISTA7
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689696005/qhtsyeximhxcpajxerzc.jpg	R-PROTISTA8
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689696156/telqrtd0dkhfbupa5eko.jpg	R-PROTISTA9
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689698160/zn0pvmpcx8qhvc8gppnj.jpg	R-PROTISTA10
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689698277/jqnanukmmzjszxlxvfv1.jpg	R-PROTISTA11
https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689719984/biqygs3c0mqusvtg5gte.jpg	R-PROTISTA12
\.


--
-- TOC entry 4342 (class 0 OID 17287)
-- Dependencies: 208
-- Data for Name: registros; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) FROM stdin;
R-PROTISTA1	INV-1	t	Eimeria tenella	Eimeria	ESP-TE6	GEN-EI6	FAM-EI6	ORD-CO11	CLA-CO6	FIL-AP2	Protista	Eimeria teniella es un protozoo parásito que infecta las células del epitelio cecal de los pollos.​ Destruye las células epiteliales intestinales.	Se localiza en el ciego de las aves de corral, a las que afecta con una coccidiosis hemorrágica, que destruye las células epiteliales intestinales.
R-PROTISTA2	INV-2	t	Amoeba proteus	Chaos diffluens	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA3	INV-2	t	Amoeba proteus	Chaos diffluens	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Ameba de vida libre y de gran tamaño que vive en ambientes de agua dulce.
R-PROTISTA4	INV-2	t	Amoeba proteus	Chaos diffluens	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es una gran especie de ameba estrechamente relacionada con otro género de amebas gigantes, Chaos, este protozoo usa extensiones llamadas pseudópodos para moverse y comer organismos unicelulares más pequeños.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA5	INV-2	t	Amoeba proteus	Chaos diffluens 	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA6	INV-2	t	Amoeba proteus	Chaos diffluens	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA7	INV-2	t	Amoeba proteus	Chaos diffluens	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA8	INV-2	t	Amoeba proteus	Chaos diffluens	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA9	INV-2	t	Amoeba proteus	Chaos diffluens	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA10	INV-2	t	Amoeba proteus	Chaos diffluens 	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA11	INV-2	t	Amoeba proteus	Chaos diffluens	ESP-PR1	GEN-AM1	FAM-AM1	ORD-TU1	CLA-TU1	FIL-AM1	Protista	Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.	Las especies de este género viven libres en agua o en tierra.
R-PROTISTA12	INV-2	t	Eimeria maxima	Eimeria	ESP-MA8	GEN-EI6	FAM-EI6	ORD-CO11	CLA-CO6	FIL-AP2	Protista	Eimeria, es un género de parásito coccidio, perteneciente a la familia Eimeriidae, coexisten en una multitud de aves y mamíferos domésticos.	Eimeria maxima coloniza preferentemente la parte media del intestino delgado, pero en los casos graves, las lesiones pueden cubrir todo el intestino delgado. La cavidad del intestino puede contener mucosa naranja y sangre, y en infecciones graves, la mucosa se puede ver seriamente dañada
\.


--
-- TOC entry 4343 (class 0 OID 17297)
-- Dependencies: 209
-- Data for Name: reinos; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.reinos (reiid, reinombre) FROM stdin;
PROT	Protista
\.


--
-- TOC entry 4344 (class 0 OID 17303)
-- Dependencies: 210
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.rol (rolid, rolnombre) FROM stdin;
INV	INVESTIGADOR
DIG	DIGITADOR
\.


--
-- TOC entry 4345 (class 0 OID 17309)
-- Dependencies: 211
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: utnAdmin
--

COPY public.usuarios (usuid, rolid, usucorreo, usucontrasenia, usunombre, usuapellido, usuestado, usuimagen, usutelefono) FROM stdin;
INV-1	INV	datrujillom@utn.edu.ec	12345	DAVID ALEXANDER	TRUJILLO MONTENGRO	t	\N	988635514
INV-2	INV	betsy@utn.edu.ec	betsy	Betsy	Montenegro	t	\N	981998458
\.


--
-- TOC entry 4156 (class 2606 OID 17235)
-- Name: clases pk_clases; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.clases
    ADD CONSTRAINT pk_clases PRIMARY KEY (claid);


--
-- TOC entry 4160 (class 2606 OID 17242)
-- Name: especies pk_especies; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.especies
    ADD CONSTRAINT pk_especies PRIMARY KEY (espid);


--
-- TOC entry 4164 (class 2606 OID 17249)
-- Name: familias pk_familias; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.familias
    ADD CONSTRAINT pk_familias PRIMARY KEY (famid);


--
-- TOC entry 4167 (class 2606 OID 17256)
-- Name: filos pk_filos; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.filos
    ADD CONSTRAINT pk_filos PRIMARY KEY (filid);


--
-- TOC entry 4172 (class 2606 OID 17263)
-- Name: generos pk_generos; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.generos
    ADD CONSTRAINT pk_generos PRIMARY KEY (genid);


--
-- TOC entry 4176 (class 2606 OID 17270)
-- Name: ordenes pk_ordenes; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT pk_ordenes PRIMARY KEY (ordid);


--
-- TOC entry 4179 (class 2606 OID 17284)
-- Name: registroimg pk_registroimg; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.registroimg
    ADD CONSTRAINT pk_registroimg PRIMARY KEY (imgruta);


--
-- TOC entry 4183 (class 2606 OID 17393)
-- Name: registros pk_registros; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.registros
    ADD CONSTRAINT pk_registros PRIMARY KEY (regid);


--
-- TOC entry 4187 (class 2606 OID 17301)
-- Name: reinos pk_reinos; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.reinos
    ADD CONSTRAINT pk_reinos PRIMARY KEY (reiid);


--
-- TOC entry 4190 (class 2606 OID 17307)
-- Name: rol pk_rol; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT pk_rol PRIMARY KEY (rolid);


--
-- TOC entry 4193 (class 2606 OID 17413)
-- Name: usuarios pk_usuarios; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (usuid);


--
-- TOC entry 4197 (class 2606 OID 17318)
-- Name: usuarios usuarios_usucorreo_key; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usucorreo_key UNIQUE (usucorreo);


--
-- TOC entry 4173 (class 1259 OID 17272)
-- Name: clases_ordenes_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX clases_ordenes_fk ON public.ordenes USING btree (claid);


--
-- TOC entry 4153 (class 1259 OID 17236)
-- Name: clases_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX clases_pk ON public.clases USING btree (claid);


--
-- TOC entry 4157 (class 1259 OID 17244)
-- Name: especies_generos_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX especies_generos_fk ON public.especies USING btree (genid);


--
-- TOC entry 4158 (class 1259 OID 17243)
-- Name: especies_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX especies_pk ON public.especies USING btree (espid);


--
-- TOC entry 4169 (class 1259 OID 17265)
-- Name: familias_generos_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX familias_generos_fk ON public.generos USING btree (famid);


--
-- TOC entry 4161 (class 1259 OID 17250)
-- Name: familias_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX familias_pk ON public.familias USING btree (famid);


--
-- TOC entry 4154 (class 1259 OID 17237)
-- Name: filos_clases_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX filos_clases_fk ON public.clases USING btree (filid);


--
-- TOC entry 4165 (class 1259 OID 17257)
-- Name: filos_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX filos_pk ON public.filos USING btree (filid);


--
-- TOC entry 4170 (class 1259 OID 17264)
-- Name: generos_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX generos_pk ON public.generos USING btree (genid);


--
-- TOC entry 4162 (class 1259 OID 17251)
-- Name: ordenes_familias_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX ordenes_familias_fk ON public.familias USING btree (ordid);


--
-- TOC entry 4174 (class 1259 OID 17271)
-- Name: ordenes_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX ordenes_pk ON public.ordenes USING btree (ordid);


--
-- TOC entry 4177 (class 1259 OID 17425)
-- Name: preguntas_usuario_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX preguntas_usuario_fk ON public.preguntas_recuperacion USING btree (usuid);


--
-- TOC entry 4180 (class 1259 OID 17406)
-- Name: registro_registroimg_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX registro_registroimg_fk ON public.registroimg USING btree (regid);


--
-- TOC entry 4181 (class 1259 OID 17285)
-- Name: registroimg_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX registroimg_pk ON public.registroimg USING btree (imgruta);


--
-- TOC entry 4184 (class 1259 OID 17394)
-- Name: registros_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX registros_pk ON public.registros USING btree (regid);


--
-- TOC entry 4168 (class 1259 OID 17258)
-- Name: reinos_filos_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX reinos_filos_fk ON public.filos USING btree (reiid);


--
-- TOC entry 4188 (class 1259 OID 17302)
-- Name: reinos_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX reinos_pk ON public.reinos USING btree (reiid);


--
-- TOC entry 4191 (class 1259 OID 17308)
-- Name: rol_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX rol_pk ON public.rol USING btree (rolid);


--
-- TOC entry 4194 (class 1259 OID 17320)
-- Name: roles_usuarios_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX roles_usuarios_fk ON public.usuarios USING btree (rolid);


--
-- TOC entry 4185 (class 1259 OID 17431)
-- Name: usuario_registro_fk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE INDEX usuario_registro_fk ON public.registros USING btree (usuid);


--
-- TOC entry 4195 (class 1259 OID 17414)
-- Name: usuarios_pk; Type: INDEX; Schema: public; Owner: utnAdmin
--

CREATE UNIQUE INDEX usuarios_pk ON public.usuarios USING btree (usuid);


--
-- TOC entry 4208 (class 2620 OID 17451)
-- Name: registros trigger_generar_regid; Type: TRIGGER; Schema: public; Owner: utnAdmin
--

CREATE TRIGGER trigger_generar_regid BEFORE INSERT ON public.registros FOR EACH ROW EXECUTE PROCEDURE public.generar_regid();


--
-- TOC entry 4209 (class 2620 OID 17372)
-- Name: usuarios trigger_generar_usuid; Type: TRIGGER; Schema: public; Owner: utnAdmin
--

CREATE TRIGGER trigger_generar_usuid BEFORE INSERT ON public.usuarios FOR EACH ROW EXECUTE PROCEDURE public.generar_usuid();


--
-- TOC entry 4198 (class 2606 OID 17321)
-- Name: clases fk_clases_filos_cla_filos; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.clases
    ADD CONSTRAINT fk_clases_filos_cla_filos FOREIGN KEY (filid) REFERENCES public.filos(filid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4199 (class 2606 OID 17326)
-- Name: especies fk_especies_especies__generos; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.especies
    ADD CONSTRAINT fk_especies_especies__generos FOREIGN KEY (genid) REFERENCES public.generos(genid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4200 (class 2606 OID 17331)
-- Name: familias fk_familias_ordenes_f_ordenes; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.familias
    ADD CONSTRAINT fk_familias_ordenes_f_ordenes FOREIGN KEY (ordid) REFERENCES public.ordenes(ordid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4201 (class 2606 OID 17336)
-- Name: filos fk_filos_reinos_fi_reinos; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.filos
    ADD CONSTRAINT fk_filos_reinos_fi_reinos FOREIGN KEY (reiid) REFERENCES public.reinos(reiid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4202 (class 2606 OID 17341)
-- Name: generos fk_generos_familias__familias; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.generos
    ADD CONSTRAINT fk_generos_familias__familias FOREIGN KEY (famid) REFERENCES public.familias(famid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4203 (class 2606 OID 17346)
-- Name: ordenes fk_ordenes_clases_or_clases; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT fk_ordenes_clases_or_clases FOREIGN KEY (claid) REFERENCES public.clases(claid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4204 (class 2606 OID 17426)
-- Name: preguntas_recuperacion fk_pregunta_preguntas_usuarios; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.preguntas_recuperacion
    ADD CONSTRAINT fk_pregunta_preguntas_usuarios FOREIGN KEY (usuid) REFERENCES public.usuarios(usuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4205 (class 2606 OID 17407)
-- Name: registroimg fk_registro_registro__registro; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.registroimg
    ADD CONSTRAINT fk_registro_registro__registro FOREIGN KEY (regid) REFERENCES public.registros(regid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4206 (class 2606 OID 17432)
-- Name: registros fk_registro_usuario_r_usuarios; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.registros
    ADD CONSTRAINT fk_registro_usuario_r_usuarios FOREIGN KEY (usuid) REFERENCES public.usuarios(usuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4207 (class 2606 OID 17366)
-- Name: usuarios fk_usuarios_roles_usu_rol; Type: FK CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuarios_roles_usu_rol FOREIGN KEY (rolid) REFERENCES public.rol(rolid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4351 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: azure_superuser
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-07-18 19:35:35

--
-- PostgreSQL database dump complete
--

