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


CREATE OR REPLACE FUNCTION public.insert_registros(
        p_usuid character varying, 
        p_regestado boolean, 
        p_regnombre_cientifico character varying, 
        p_regnombre_vulgar character varying, 
        p_regespecie character varying, 
        p_reggenero character varying,
        p_regfamilia character varying, 
        p_regorden character varying, 
        p_regclase character varying, 
        p_regfilo character varying, 
        p_regreino character varying, 
        p_regdescripcion character varying, 
        p_reghabitat character varying, 
        p_img character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  new_regid character varying;
BEGIN
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

CREATE FUNCTION public.insert_usuarios(p_rolid character varying, p_usucorreo character varying, p_usucontrasenia character varying, p_usunombre character varying, p_usuapellido character varying, p_usuestado boolean, p_usuimagen character varying, p_usutelefono character varying, p_preg1 character varying, p_respt1 character varying, p_preg2 character varying, p_respt2 character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  new_usuid character varying;
BEGIN
	INSERT INTO usuarios (rolid, usucorreo, usucontrasenia, 
						  usunombre, usuapellido, usuestado, 
						  usuimagen, usutelefono)
    VALUES (p_rolid, p_usucorreo, p_usucontrasenia, 
				p_usunombre, p_usuapellido, 
				p_usuestado, p_usuimagen, p_usutelefono)
	RETURNING usuid INTO new_usuid;
	INSERT INTO public.preguntas_recuperacion(
            usuid, pregunta, respuesta)
                VALUES (new_usuid, p_preg1, p_respt1);

	INSERT INTO public.preguntas_recuperacion(
            usuid, pregunta, respuesta)
                VALUES (new_usuid, p_preg2, p_respt2);
END;
$$;


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

CREATE TABLE public.clases (
    claid character varying(10) NOT NULL,
    filid character varying(10) NOT NULL,
    clanombre character varying(256) NOT NULL
);


CREATE TABLE public.especies (
    espid character varying(10) NOT NULL,
    genid character varying(10) NOT NULL,
    espnombre character varying(256) NOT NULL
);


CREATE TABLE public.familias (
    famid character varying(10) NOT NULL,
    ordid character varying(10) NOT NULL,
    famnombre character varying(256) NOT NULL
);


CREATE TABLE public.filos (
    filid character varying(10) NOT NULL,
    reiid character varying(10) NOT NULL,
    filnombre character varying(256) NOT NULL
);


CREATE TABLE public.generos (
    genid character varying(10) NOT NULL,
    famid character varying(10) NOT NULL,
    gennombre character varying(256) NOT NULL
);


CREATE TABLE public.ordenes (
    ordid character varying(10) NOT NULL,
    claid character varying(10) NOT NULL,
    ordnombre character varying(256) NOT NULL
);


CREATE TABLE public.preguntas_recuperacion (
    usuid character varying(20) NOT NULL,
    pregunta text NOT NULL,
    respuesta text NOT NULL
);


CREATE TABLE public.registroimg (
    imgruta character varying(256) NOT NULL,
    regid character varying(20) NOT NULL
);


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


CREATE TABLE public.reinos (
    reiid character varying(10) NOT NULL,
    reinombre character varying(256) NOT NULL
);



CREATE TABLE public.rol (
    rolid character varying(3) NOT NULL,
    rolnombre character varying(15) NOT NULL
);


ALTER TABLE ONLY public.clases
    ADD CONSTRAINT pk_clases PRIMARY KEY (claid);

ALTER TABLE ONLY public.especies
    ADD CONSTRAINT pk_especies PRIMARY KEY (espid);

ALTER TABLE ONLY public.familias
    ADD CONSTRAINT pk_familias PRIMARY KEY (famid);

ALTER TABLE ONLY public.filos
    ADD CONSTRAINT pk_filos PRIMARY KEY (filid);


--
-- TOC entry 4172 (class 2606 OID 17263)
-- Name: generos pk_generos; Type: CONSTRAINT; Schema: public; Owner: utnAdmin
--

ALTER TABLE ONLY public.generos
    ADD CONSTRAINT pk_generos PRIMARY KEY (genid);

ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT pk_ordenes PRIMARY KEY (ordid);


ALTER TABLE ONLY public.registroimg
    ADD CONSTRAINT pk_registroimg PRIMARY KEY (imgruta);

ALTER TABLE ONLY public.registros
    ADD CONSTRAINT pk_registros PRIMARY KEY (regid);


ALTER TABLE ONLY public.reinos
    ADD CONSTRAINT pk_reinos PRIMARY KEY (reiid);


ALTER TABLE ONLY public.rol
    ADD CONSTRAINT pk_rol PRIMARY KEY (rolid);


ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (usuid);

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usucorreo_key UNIQUE (usucorreo);

CREATE INDEX clases_ordenes_fk ON public.ordenes USING btree (claid);


CREATE UNIQUE INDEX clases_pk ON public.clases USING btree (claid);



CREATE INDEX especies_generos_fk ON public.especies USING btree (genid);


CREATE UNIQUE INDEX especies_pk ON public.especies USING btree (espid);


CREATE INDEX familias_generos_fk ON public.generos USING btree (famid);


CREATE UNIQUE INDEX familias_pk ON public.familias USING btree (famid);



CREATE INDEX filos_clases_fk ON public.clases USING btree (filid);



CREATE UNIQUE INDEX filos_pk ON public.filos USING btree (filid);



CREATE UNIQUE INDEX generos_pk ON public.generos USING btree (genid);



CREATE INDEX ordenes_familias_fk ON public.familias USING btree (ordid);




CREATE UNIQUE INDEX ordenes_pk ON public.ordenes USING btree (ordid);



CREATE INDEX preguntas_usuario_fk ON public.preguntas_recuperacion USING btree (usuid);



CREATE INDEX registro_registroimg_fk ON public.registroimg USING btree (regid);



CREATE UNIQUE INDEX registroimg_pk ON public.registroimg USING btree (imgruta);



CREATE UNIQUE INDEX registros_pk ON public.registros USING btree (regid);



CREATE INDEX reinos_filos_fk ON public.filos USING btree (reiid);




CREATE UNIQUE INDEX reinos_pk ON public.reinos USING btree (reiid);



CREATE UNIQUE INDEX rol_pk ON public.rol USING btree (rolid);


CREATE INDEX roles_usuarios_fk ON public.usuarios USING btree (rolid);



CREATE INDEX usuario_registro_fk ON public.registros USING btree (usuid);




CREATE UNIQUE INDEX usuarios_pk ON public.usuarios USING btree (usuid);




CREATE TRIGGER trigger_generar_regid BEFORE INSERT ON public.registros FOR EACH ROW EXECUTE PROCEDURE public.generar_regid();


CREATE TRIGGER trigger_generar_usuid BEFORE INSERT ON public.usuarios FOR EACH ROW EXECUTE PROCEDURE public.generar_usuid();




ALTER TABLE ONLY public.clases
    ADD CONSTRAINT fk_clases_filos_cla_filos FOREIGN KEY (filid) REFERENCES public.filos(filid) ON UPDATE CASCADE ON DELETE RESTRICT;




ALTER TABLE ONLY public.especies
    ADD CONSTRAINT fk_especies_especies__generos FOREIGN KEY (genid) REFERENCES public.generos(genid) ON UPDATE CASCADE ON DELETE RESTRICT;




ALTER TABLE ONLY public.familias
    ADD CONSTRAINT fk_familias_ordenes_f_ordenes FOREIGN KEY (ordid) REFERENCES public.ordenes(ordid) ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY public.filos
    ADD CONSTRAINT fk_filos_reinos_fi_reinos FOREIGN KEY (reiid) REFERENCES public.reinos(reiid) ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY public.generos
    ADD CONSTRAINT fk_generos_familias__familias FOREIGN KEY (famid) REFERENCES public.familias(famid) ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY public.ordenes
    ADD CONSTRAINT fk_ordenes_clases_or_clases FOREIGN KEY (claid) REFERENCES public.clases(claid) ON UPDATE CASCADE ON DELETE RESTRICT;




ALTER TABLE ONLY public.preguntas_recuperacion
    ADD CONSTRAINT fk_pregunta_preguntas_usuarios FOREIGN KEY (usuid) REFERENCES public.usuarios(usuid) ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY public.registroimg
    ADD CONSTRAINT fk_registro_registro__registro FOREIGN KEY (regid) REFERENCES public.registros(regid) ON UPDATE CASCADE ON DELETE RESTRICT;




ALTER TABLE ONLY public.registros
    ADD CONSTRAINT fk_registro_usuario_r_usuarios FOREIGN KEY (usuid) REFERENCES public.usuarios(usuid) ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuarios_roles_usu_rol FOREIGN KEY (rolid) REFERENCES public.rol(rolid) ON UPDATE CASCADE ON DELETE RESTRICT;



REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


