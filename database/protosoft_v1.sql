/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     05/05/2024 14:06:15                          */
/*==============================================================*/


-- drop index RELATIONSHIP_6_FK;

-- drop index CLASES_PK;

-- drop table CLASES;

-- drop index RELATIONSHIP_10_FK;

-- drop index ESPECIES_PK;

-- drop table ESPECIES;

-- drop index RELATIONSHIP_8_FK;

-- drop index FAMILIAS_PK;

-- drop table FAMILIAS;

-- drop index RELATIONSHIP_5_FK;

-- drop index FILOS_PK;

-- drop table FILOS;

-- drop index RELATIONSHIP_9_FK;

-- drop index GENEROS_PK;

-- drop table GENEROS;

-- drop index RELATIONSHIP_7_FK;

-- drop index ORDENES_PK;

-- drop table ORDENES;

-- drop index RELATIONSHIP_1_FK;

-- drop index PREGUNTAS_RECUPERACION_PK;

-- drop table PREGUNTAS_RECUPERACION;

-- drop index RELATIONSHIP_4_FK;

-- drop index REGISTROIMG_PK;

-- drop table REGISTROIMG;

-- drop index RELATIONSHIP_3_FK;

-- drop index REGISTROS_PK;

-- drop table REGISTROS;

-- drop index REINOS_PK;

-- drop table REINOS;

-- drop index ROL_PK;

-- drop table ROL;

-- drop index RELATIONSHIP_2_FK;

-- drop index USUARIOS_PK;

-- drop table USUARIOS;

/*==============================================================*/
/* Table: CLASES                                                */
/*==============================================================*/
create table CLASES (
   CLAID                VARCHAR(10)          not null,
   FILID                VARCHAR(10)          not null,
   CALNOMBRE            VARCHAR(256)         not null,
   constraint PK_CLASES primary key (CLAID)
);

/*==============================================================*/
/* Index: CLASES_PK                                             */
/*==============================================================*/
create unique index CLASES_PK on CLASES (
CLAID
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_6_FK on CLASES (
FILID
);

/*==============================================================*/
/* Table: ESPECIES                                              */
/*==============================================================*/
create table ESPECIES (
   ESPID                VARCHAR(10)          not null,
   GENID                VARCHAR(10)          not null,
   ESPNOMBRE            VARCHAR(256)         not null,
   constraint PK_ESPECIES primary key (ESPID)
);

/*==============================================================*/
/* Index: ESPECIES_PK                                           */
/*==============================================================*/
create unique index ESPECIES_PK on ESPECIES (
ESPID
);

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_10_FK on ESPECIES (
GENID
);

/*==============================================================*/
/* Table: FAMILIAS                                              */
/*==============================================================*/
create table FAMILIAS (
   FAMID                VARCHAR(10)          not null,
   ORDID                VARCHAR(10)          not null,
   FAMNOMBRE            VARCHAR(256)         not null,
   constraint PK_FAMILIAS primary key (FAMID)
);

/*==============================================================*/
/* Index: FAMILIAS_PK                                           */
/*==============================================================*/
create unique index FAMILIAS_PK on FAMILIAS (
FAMID
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_8_FK on FAMILIAS (
ORDID
);

/*==============================================================*/
/* Table: FILOS                                                 */
/*==============================================================*/
create table FILOS (
   FILID                VARCHAR(10)          not null,
   REIID                VARCHAR(10)          not null,
   FILNOMBRE            VARCHAR(256)         not null,
   constraint PK_FILOS primary key (FILID)
);

/*==============================================================*/
/* Index: FILOS_PK                                              */
/*==============================================================*/
create unique index FILOS_PK on FILOS (
FILID
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_5_FK on FILOS (
REIID
);

/*==============================================================*/
/* Table: GENEROS                                               */
/*==============================================================*/
create table GENEROS (
   GENID                VARCHAR(10)          not null,
   FAMID                VARCHAR(10)          not null,
   GENNOMBRE            VARCHAR(256)         not null,
   constraint PK_GENEROS primary key (GENID)
);

/*==============================================================*/
/* Index: GENEROS_PK                                            */
/*==============================================================*/
create unique index GENEROS_PK on GENEROS (
GENID
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_9_FK on GENEROS (
FAMID
);

/*==============================================================*/
/* Table: ORDENES                                               */
/*==============================================================*/
create table ORDENES (
   ORDID                VARCHAR(10)          not null,
   CLAID                VARCHAR(10)          not null,
   ORDNOMBRE            VARCHAR(256)         not null,
   constraint PK_ORDENES primary key (ORDID)
);

/*==============================================================*/
/* Index: ORDENES_PK                                            */
/*==============================================================*/
create unique index ORDENES_PK on ORDENES (
ORDID
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_7_FK on ORDENES (
CLAID
);

/*==============================================================*/
/* Table: PREGUNTAS_RECUPERACION                                */
/*==============================================================*/
create table PREGUNTAS_RECUPERACION (
   PR_REC               SERIAL               not null,
   USUID                VARCHAR(5)           not null,
   PREGUNTA             TEXT                 not null,
   RESPUESTA            TEXT                 not null,
   constraint PK_PREGUNTAS_RECUPERACION primary key (PR_REC)
);

/*==============================================================*/
/* Index: PREGUNTAS_RECUPERACION_PK                             */
/*==============================================================*/
create unique index PREGUNTAS_RECUPERACION_PK on PREGUNTAS_RECUPERACION (
PR_REC
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_1_FK on PREGUNTAS_RECUPERACION (
USUID
);

/*==============================================================*/
/* Table: REGISTROIMG                                           */
/*==============================================================*/
create table REGISTROIMG (
   IMGID                SERIAL               not null,
   REGID                VARCHAR(10)          null,
   IMGRUTA              TEXT                 not null,
   constraint PK_REGISTROIMG primary key (IMGID)
);

/*==============================================================*/
/* Index: REGISTROIMG_PK                                        */
/*==============================================================*/
create unique index REGISTROIMG_PK on REGISTROIMG (
IMGID
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_4_FK on REGISTROIMG (
REGID
);

/*==============================================================*/
/* Table: REGISTROS                                             */
/*==============================================================*/
create table REGISTROS (
   REGID                VARCHAR(10)          not null,
   USUID                VARCHAR(5)           not null,
   REGESTADO            BOOL                 not null,
   REGNOMBRE_CIENTIFICO VARCHAR(256)         not null,
   REGNOMBRE_VULGAR     VARCHAR(256)         not null,
   REGESPECIE           VARCHAR(256)         not null,
   REGGENERO            VARCHAR(256)         not null,
   REGFAMILIA           VARCHAR(256)         not null,
   REGORDEN             VARCHAR(256)         not null,
   REGCLASE             VARCHAR(256)         not null,
   REGFILO              VARCHAR(256)         not null,
   REGREINO             VARCHAR(256)         not null,
   REGDESCRIPCION       TEXT                 not null,
   REGHABITAT           TEXT                 not null,
   constraint PK_REGISTROS primary key (REGID)
);

/*==============================================================*/
/* Index: REGISTROS_PK                                          */
/*==============================================================*/
create unique index REGISTROS_PK on REGISTROS (
REGID
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_3_FK on REGISTROS (
USUID
);

/*==============================================================*/
/* Table: REINOS                                                */
/*==============================================================*/
create table REINOS (
   REIID                VARCHAR(10)          not null,
   REINOMBRE            VARCHAR(256)         not null,
   constraint PK_REINOS primary key (REIID)
);

/*==============================================================*/
/* Index: REINOS_PK                                             */
/*==============================================================*/
create unique index REINOS_PK on REINOS (
REIID
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   ROLID                VARCHAR(3)           not null,
   ROLNOMBRE            VARCHAR(15)          not null,
   constraint PK_ROL primary key (ROLID)
);

/*==============================================================*/
/* Index: ROL_PK                                                */
/*==============================================================*/
create unique index ROL_PK on ROL (
ROLID
);

/*==============================================================*/
/* Table: USUARIOS                                              */
/*==============================================================*/
create table USUARIOS (
   USUID                VARCHAR(5)           not null,
   ROLID                VARCHAR(3)           not null,
   USUCORREO            VARCHAR(256)         not null,
   USUCONTRASENIA       VARCHAR(256)         not null,
   USUNOMBRE            VARCHAR(40)          not null,
   USUAPELLIDO          VARCHAR(40)          not null,
   USU_ESTADO           BOOL                 not null,
   USUIMAGEN            TEXT                 not null,
   USUTELEFONO          VARCHAR(10)          not null,
   constraint PK_USUARIOS primary key (USUID)
);

/*==============================================================*/
/* Index: USUARIOS_PK                                           */
/*==============================================================*/
create unique index USUARIOS_PK on USUARIOS (
USUID
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_2_FK on USUARIOS (
ROLID
);

alter table CLASES
   add constraint FK_CLASES_RELATIONS_FILOS foreign key (FILID)
      references FILOS (FILID)
      on delete restrict on update restrict;

alter table ESPECIES
   add constraint FK_ESPECIES_RELATIONS_GENEROS foreign key (GENID)
      references GENEROS (GENID)
      on delete restrict on update restrict;

alter table FAMILIAS
   add constraint FK_FAMILIAS_RELATIONS_ORDENES foreign key (ORDID)
      references ORDENES (ORDID)
      on delete restrict on update restrict;

alter table FILOS
   add constraint FK_FILOS_RELATIONS_REINOS foreign key (REIID)
      references REINOS (REIID)
      on delete restrict on update restrict;

alter table GENEROS
   add constraint FK_GENEROS_RELATIONS_FAMILIAS foreign key (FAMID)
      references FAMILIAS (FAMID)
      on delete restrict on update restrict;

alter table ORDENES
   add constraint FK_ORDENES_RELATIONS_CLASES foreign key (CLAID)
      references CLASES (CLAID)
      on delete restrict on update restrict;

alter table PREGUNTAS_RECUPERACION
   add constraint FK_PREGUNTA_RELATIONS_USUARIOS foreign key (USUID)
      references USUARIOS (USUID)
      on delete restrict on update restrict;

alter table REGISTROIMG
   add constraint FK_REGISTRO_RELATIONS_REGISTRO foreign key (REGID)
      references REGISTROS (REGID)
      on delete restrict on update restrict;

alter table REGISTROS
   add constraint FK_REGISTRO_RELATIONS_USUARIOS foreign key (USUID)
      references USUARIOS (USUID)
      on delete restrict on update restrict;

alter table USUARIOS
   add constraint FK_USUARIOS_RELATIONS_ROL foreign key (ROLID)
      references ROL (ROLID)
      on delete restrict on update restrict;

