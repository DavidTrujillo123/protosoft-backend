-- Para la tabla "rol"
INSERT INTO public.rol (rolid, rolnombre) VALUES ('INV', 'INVESTIGADOR');
INSERT INTO public.rol (rolid, rolnombre) VALUES ('DIG', 'DIGITADOR');

-- Para la tabla "usuarios"
INSERT INTO public.usuarios (usuid, rolid, usucorreo, usucontrasenia, usunombre, usuapellido, usuestado, usuimagen, usutelefono) VALUES ('INV-1', 'INV', 'david@utn.edu.ec', '12345', 'DAVID', 'SMITH', 't', NULL, '988631231');
INSERT INTO public.usuarios (usuid, rolid, usucorreo, usucontrasenia, usunombre, usuapellido, usuestado, usuimagen, usutelefono) VALUES ('INV-2', 'INV', 'betsy@utn.edu.ec', 'betsy', 'Betsy', 'Montenegro', 't', NULL, '981991239');

INSERT INTO public.preguntas_recuperacion (usuid, pregunta, respuesta) VALUES ('INV-1', 'Mi juego favorito', 'psp');
INSERT INTO public.preguntas_recuperacion (usuid, pregunta, respuesta) VALUES ('INV-1', 'Nombre de mi mascota', 'tomas');
INSERT INTO public.preguntas_recuperacion (usuid, pregunta, respuesta) VALUES ('INV-2', 'Color favorito', 'Azul');
INSERT INTO public.preguntas_recuperacion (usuid, pregunta, respuesta) VALUES ('INV-2', 'Como se llama tu gato', 'Panda');


INSERT INTO public.reinos (reiid, reinombre) VALUES ('PROT', 'Protista');

INSERT INTO public.filos (filid, reiid, filnombre) VALUES ('FIL-AM1', 'PROT', 'Amoebozoa');
INSERT INTO public.filos (filid, reiid, filnombre) VALUES ('FIL-AP2', 'PROT', 'Apicomplexa');
INSERT INTO public.filos (filid, reiid, filnombre) VALUES ('FIL-CI3', 'PROT', 'Ciliophora');
INSERT INTO public.filos (filid, reiid, filnombre) VALUES ('FIL-DI4', 'PROT', 'Dinoflagellata');
INSERT INTO public.filos (filid, reiid, filnombre) VALUES ('FIL-EU5', 'PROT', 'Euglenozoa');


INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-TU1', 'FIL-AM1', 'Tubulinea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-DI2', 'FIL-AM1', 'Discosea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-CO3', 'FIL-AM1', 'Conosa');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-AR4', 'FIL-AM1', 'Archamoebae');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-EV5', 'FIL-AM1', 'Evosea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-CO6', 'FIL-AP2', 'Conoidasida');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-AC7', 'FIL-AP2', 'Aconoidasida');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-HA8', 'FIL-AP2', 'Haemospororida');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-PI9', 'FIL-AP2', 'Piroplasmida');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-CO10', 'FIL-AP2', 'Coccidia');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-OL11', 'FIL-CI3', 'Oligohymenophorea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-SP12', 'FIL-CI3', 'Spirotrichea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-LI13', 'FIL-CI3', 'Litostomatea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-PH14', 'FIL-CI3', 'Phyllopharyngea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-HA15', 'FIL-CI3', 'Haptoria');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-DI16', 'FIL-DI4', 'Dinophyceae');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-NO17', 'FIL-DI4', 'Noctiluciphyceae');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-PO18', 'FIL-DI4', 'Polykrikoida');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-BL19', 'FIL-DI4', 'Blastodiniphyceae');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-EL20', 'FIL-DI4', 'Ellobiopsida');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-EU21', 'FIL-EU5', 'Euglenoidea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-KI22', 'FIL-EU5', 'Kinetoplastea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-DI23', 'FIL-EU5', 'Diplonemea');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-PR24', 'FIL-EU5', 'Prokinetoplastina');
INSERT INTO public.clases (claid, filid, clanombre) VALUES ('CLA-SY25', 'FIL-EU5', 'Symbiontida');


INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-TU1', 'CLA-TU1', 'Tubulinida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-EN2', 'CLA-TU1', 'Entamoebida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-LE3', 'CLA-TU1', 'Leptomyxida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-PE4', 'CLA-TU1', 'Pelobiontida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-HI5', 'CLA-TU1', 'Himatismenida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-AC6', 'CLA-DI2', 'Acrasida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-EC7', 'CLA-DI2', 'Echinamoebida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-VA8', 'CLA-DI2', 'Variosea');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-MY9', 'CLA-DI2', 'Mycetozoa');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-TH10', 'CLA-DI2', 'Thecamoebida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-CO11', 'CLA-CO6', 'Coccidiorida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-PI12', 'CLA-CO6', 'Piroplasmorida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-EU13', 'CLA-CO6', 'Eucoccidiorida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-GR14', 'CLA-CO6', 'Gregarinorida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-HA15', 'CLA-CO6', 'Haemospororida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-PE16', 'CLA-OL11', 'Peritrichida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-HY17', 'CLA-OL11', 'Hymenostomatida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-SC18', 'CLA-OL11', 'Scuticociliatida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-OL19', 'CLA-OL11', 'Oligotrichida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-ST20', 'CLA-OL11', 'Stichotrichida');
INSERT INTO public.ordenes (ordid, claid, ordnombre) VALUES ('ORD-SY21', 'CLA-SY25', 'Symbiontida');


INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-AM1', 'ORD-TU1', 'Amoebidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-HA2', 'ORD-TU1', 'Hartmannellidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-VA3', 'ORD-TU1', 'Vahlkampfiidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-TH4', 'ORD-TU1', 'Thecamoebidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-PE5', 'ORD-TU1', 'Pelobiontidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-EI6', 'ORD-CO11', 'Eimeriidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-CY7', 'ORD-CO11', 'Cryptosporidiidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-SA8', 'ORD-CO11', 'Sarcocystidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-GO9', 'ORD-CO11', 'Goussartiidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-IS10', 'ORD-CO11', 'Isosporidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-VO11', 'ORD-PE16', 'Vorticellidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-ZO12', 'ORD-PE16', 'Zoothamniidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-EP13', 'ORD-PE16', 'Epistylididae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-CA14', 'ORD-PE16', 'Carchesiidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-SC15', 'ORD-PE16', 'Scyphidiidae');
INSERT INTO public.familias (famid, ordid, famnombre) VALUES ('FAM-SY16', 'ORD-SY21', 'Symbiontidae');


INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-AM1', 'FAM-AM1', 'Amoeba');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-CH2', 'FAM-AM1', 'Chaos');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-HA3', 'FAM-AM1', 'Hartmannella');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-PL4', 'FAM-AM1', 'Platyamoeba');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-ST5', 'FAM-AM1', 'Sterkiella');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-EI6', 'FAM-EI6', 'Eimeria');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-IS7', 'FAM-EI6', 'Isospora');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-CY8', 'FAM-EI6', 'Cyclospora');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-CR9', 'FAM-EI6', 'Cryptosporidium');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-TO10', 'FAM-EI6', 'Toxoplasma');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-VO11', 'FAM-VO11', 'Vorticella');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-ZO12', 'FAM-VO11', 'Zoothamnium');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-EP13', 'FAM-VO11', 'Epistylis');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-CA14', 'FAM-VO11', 'Carchesium');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-SC15', 'FAM-VO11', 'Scyphidia');
INSERT INTO public.generos (genid, famid, gennombre) VALUES ('GEN-SY16', 'FAM-SY16', 'Symbion');

INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-PR1', 'GEN-AM1', 'proteus');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-DU2', 'GEN-AM1', 'dubia');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-VE3', 'GEN-AM1', 'verrucosa');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-PR4', 'GEN-AM1', 'proteus');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-TE5', 'GEN-AM1', 'terricola');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-TE6', 'GEN-EI6', 'tenella');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-AC7', 'GEN-EI6', 'acervulina');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-MA8', 'GEN-EI6', 'maxima');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-NE9', 'GEN-EI6', 'necatrix');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-BR10', 'GEN-EI6', 'brunetti');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-MI11', 'GEN-VO11', 'microstoma');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-CO12', 'GEN-VO11', 'convallaria');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-CA13', 'GEN-VO11', 'campanula');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-NE14', 'GEN-VO11', 'nebulifera');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-PA15', 'GEN-VO11', 'patula');
INSERT INTO public.especies (espid, genid, espnombre) VALUES ('ESP-PA16', 'GEN-SY16', 'pandora');

INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA1', 'INV-1', 't', 'Eimeria tenella', 'Eimeria', 'ESP-TE6', 'GEN-EI6', 'FAM-EI6', 'ORD-CO11', 'CLA-CO6', 'FIL-AP2', 'Protista', 'Eimeria teniella es un protozoo parásito que infecta las células del epitelio cecal de los pollos.​ Destruye las células epiteliales intestinales.', 'Se localiza en el ciego de las aves de corral, a las que afecta con una coccidiosis hemorrágica, que destruye las células epiteliales intestinales.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA2', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA3', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Ameba de vida libre y de gran tamaño que vive en ambientes de agua dulce.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA4', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es una gran especie de ameba estrechamente relacionada con otro género de amebas gigantes, Chaos, este protozoo usa extensiones llamadas pseudópodos para moverse y comer organismos unicelulares más pequeños.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA5', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA6', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA7', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA8', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA9', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA10', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA11', 'INV-2', 't', 'Amoeba proteus', 'Chaos diffluens', 'ESP-PR1', 'GEN-AM1', 'FAM-AM1', 'ORD-TU1', 'CLA-TU1', 'FIL-AM1', 'Protista', 'Es un protozoo caracterizado por su forma cambiante, puesto que carece de pared celular, y por su movimiento ameboide a base de seudópodos, que también usa para capturar alimentos a través del proceso llamado fagocitosis.', 'Las especies de este género viven libres en agua o en tierra.');
INSERT INTO public.registros (regid, usuid, regestado, regnombre_cientifico, regnombre_vulgar, regespecie, reggenero, regfamilia, regorden, regclase, regfilo, regreino, regdescripcion, reghabitat) VALUES ('R-PROTISTA12', 'INV-2', 't', 'Eimeria maxima', 'Eimeria', 'ESP-MA8', 'GEN-EI6', 'FAM-EI6', 'ORD-CO11', 'CLA-CO6', 'FIL-AP2', 'Protista', 'Eimeria, es un género de parásito coccidio, perteneciente a la familia Eimeriidae, coexisten en una multitud de aves y mamíferos domésticos.', 'Eimeria maxima coloniza preferentemente la parte media del intestino delgado, pero en los casos graves, las lesiones pueden cubrir todo el intestino delgado. La cavidad del intestino puede contener mucosa naranja y sangre, y en infecciones graves, la mucosa se puede ver seriamente dañada');

INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689651475/mp3y85ml6ubdwziuwobo.webp', 'R-PROTISTA1');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689652256/e7hhybjowjvzfw5ndx4y.jpg', 'R-PROTISTA2');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689688378/jvodqh4nijjdzrz7rrbh.jpg', 'R-PROTISTA3');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689689216/vdgm6kgicwncihbjvkza.jpg', 'R-PROTISTA4');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689691109/hjhl0dlnkygereekdjko.jpg', 'R-PROTISTA5');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689695219/jgoh5y6py3tzyfonjsij.jpg', 'R-PROTISTA6');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689695783/hili8exlnv6jbebspkw8.jpg', 'R-PROTISTA7');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689696005/qhtsyeximhxcpajxerzc.jpg', 'R-PROTISTA8');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689696156/telqrtd0dkhfbupa5eko.jpg', 'R-PROTISTA9');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689698160/zn0pvmpcx8qhvc8gppnj.jpg', 'R-PROTISTA10');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689698277/jqnanukmmzjszxlxvfv1.jpg', 'R-PROTISTA11');
INSERT INTO public.registroimg (imgruta, regid) VALUES ('https://res.cloudinary.com/dqhmyjlbv/image/upload/v1689719984/biqygs3c0mqusvtg5gte.jpg', 'R-PROTISTA12');
