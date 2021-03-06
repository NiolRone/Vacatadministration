BEGIN TRANSACTION;
DROP TABLE IF EXISTS "enseignants";
CREATE TABLE IF NOT EXISTS "enseignants" (
	"id_enseignant"	INTEGER,
	"nom"	VARCHAR(50) NOT NULL,
	"prenom"	VARCHAR(50) NOT NULL,
	"email"	VARCHAR(100) NOT NULL UNIQUE,
	"tel"	VARCHAR(10),
	"login"	VARCHAR(8),
	PRIMARY KEY("id_enseignant" AUTOINCREMENT),
	FOREIGN KEY("login") REFERENCES "comptes"("login")
);
DROP TABLE IF EXISTS "contrats";
CREATE TABLE IF NOT EXISTS "contrats" (
	"id_contrat"	INTEGER,
	"date_deb"	DATE UNIQUE,
	"date_fin"	DATE CHECK(DATE("date_deb") < DATE("date_fin")) UNIQUE,
	"id_vacataire"	INTEGER UNIQUE,
	"id_referent"	INTEGER UNIQUE,
	PRIMARY KEY("id_contrat" AUTOINCREMENT),
	FOREIGN KEY("id_vacataire") REFERENCES "vacataires"("id_vacataire"),
	FOREIGN KEY("id_referent") REFERENCES "enseignants"("id_enseignant")
);
DROP TABLE IF EXISTS "interventions";
CREATE TABLE IF NOT EXISTS "interventions" (
	"id_contrat"	INTEGER,
	"code_module"	VARCHAR(20),
	"nbre_heures"	FLOAT,
	FOREIGN KEY("code_module") REFERENCES "modules"("code_module"),
	FOREIGN KEY("id_contrat") REFERENCES "contrats"("id_contrat")
);
DROP TABLE IF EXISTS "modules";
CREATE TABLE IF NOT EXISTS "modules" (
	"code_module"	VARCHAR(20) NOT NULL,
	"intitule"	VARCHAR(20) NOT NULL,
	"abbr"	VARCHAR(150),
	PRIMARY KEY("code_module")
);
DROP TABLE IF EXISTS "vacataires";
CREATE TABLE IF NOT EXISTS "vacataires" (
	"id_vacataire"	INTEGER,
	"nom"	VARCHAR(50) NOT NULL,
	"prenom"	VARCHAR(50) NOT NULL,
	"email"	VARCHAR(100) NOT NULL UNIQUE,
	"tel"	VARCHAR(10),
	"statut"	VARCHAR(100) NOT NULL,
	"employeur"	VARCHAR(200),
	"login"	VARCHAR(8),
	"recrutable"	BOOLEAN,
	PRIMARY KEY("id_vacataire" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "comptes";
CREATE TABLE IF NOT EXISTS "comptes" (
	"login"	VARCHAR(8),
	"mdp"	VARCHAR(128),
	"role"	VARCHAR(15) NOT NULL,
	PRIMARY KEY("login")
);
INSERT INTO "enseignants" VALUES (1,'Cordier','Emmanuelle','emmanuelle.cordier@univ-grenoble-alpes.fr','651608809','cordiere');
INSERT INTO "enseignants" VALUES (2,'Nicolas','Luce','luce.nicolas@univ-grenoble-alpes.fr','409021336','nicolasl');
INSERT INTO "enseignants" VALUES (3,'Le Laurent','Lucas','lucas.le-laurent@univ-grenoble-alpes.fr','715397101','lelaurel');
INSERT INTO "contrats" VALUES (1,'2021-11-01','2022-04-20',1,1);
INSERT INTO "contrats" VALUES (2,'2022-01-26','2022-06-07',2,2);
INSERT INTO "contrats" VALUES (3,'2021-09-17','2021-11-19',3,3);
INSERT INTO "modules" VALUES ('R1.01','Initiation aux r??seaux informatiques',NULL);
INSERT INTO "modules" VALUES ('R1.02','Principes et architecture des r??seaux',NULL);
INSERT INTO "modules" VALUES ('R1.03','R??seaux locaux et ??quipements actifs',NULL);
INSERT INTO "modules" VALUES ('SAE1.01','Se sensibiliser ?? l''hygi??ne informatique et ?? la cybers??curit??',NULL);
INSERT INTO "modules" VALUES ('SAE1.02','S''initier aux r??seaux informatiques',NULL);
INSERT INTO "modules" VALUES ('R1.04','Fondamentaux des syst??mes ??lectroniques',NULL);
INSERT INTO "modules" VALUES ('R1.05','Supports de transmission pour les r??seaux',NULL);
INSERT INTO "modules" VALUES ('R1.06','Architecture des syst??mes num??riques et informatiques',NULL);
INSERT INTO "modules" VALUES ('SAE1.03','D??couvrir un dispositif de transmission',NULL);
INSERT INTO "modules" VALUES ('R1.07','Fondamentaux de la programmation','Python1');
INSERT INTO "modules" VALUES ('R1.08','Bases des syst??mes d''exploitation','Shell');
INSERT INTO "modules" VALUES ('R1.09','Introduction aux technologies Web','DevWeb');
INSERT INTO "modules" VALUES ('SAE1.04','Se pr??senter sur Internet',NULL);
INSERT INTO "modules" VALUES ('SAE1.05','Traiter des donn??es',NULL);
INSERT INTO "modules" VALUES ('R1.10','Anglais technique 1','Anglais');
INSERT INTO "modules" VALUES ('R1.11','Expression-Culture-Communication Professionnelles : Introduction ?? la communication et au savoir-??tre professionnels','ExprComm');
INSERT INTO "modules" VALUES ('R1.12','Projet Personnel et Professionnel','PPP');
INSERT INTO "modules" VALUES ('R1.13','Math??matiques du signal','MathSignal');
INSERT INTO "modules" VALUES ('R1.14','Math??matiques des transmissions','MathTrans');
INSERT INTO "modules" VALUES ('R1.15','Gestion de projet 1 : Ma??triser les bases de l''organisation du travail','GestProj');
INSERT INTO "modules" VALUES ('SAE1.PORTFOLIO','Portfolio','Portfolio');
INSERT INTO "modules" VALUES ('R2.01','Technologies de l''Internet',NULL);
INSERT INTO "modules" VALUES ('R2.02','Administration syst??me et fondamentaux de la virtualisation',NULL);
INSERT INTO "modules" VALUES ('R2.03','Bases des services r??seaux',NULL);
INSERT INTO "modules" VALUES ('SAE2.01','Construire un r??seau informatique pour une petite structure',NULL);
INSERT INTO "modules" VALUES ('R2.04','Initiation ?? la t??l??phonie d''entreprise',NULL);
INSERT INTO "modules" VALUES ('R2.05','Signaux et Syst??mes pour les transmissions',NULL);
INSERT INTO "modules" VALUES ('R2.06','Num??risation de l''information',NULL);
INSERT INTO "modules" VALUES ('SAE2.02','Mesurer et caract??riser un signal ou un syst??me',NULL);
INSERT INTO "modules" VALUES ('R2.07','Sources de donn??es',NULL);
INSERT INTO "modules" VALUES ('R2.08','Analyse et traitement de donn??es structur??es',NULL);
INSERT INTO "modules" VALUES ('R2.09','Initiation au d??veloppement Web',NULL);
INSERT INTO "modules" VALUES ('SAE2.03','Mettre en place une solution informatique pour l''entreprise',NULL);
INSERT INTO "modules" VALUES ('R2.10','Anglais technique 2',NULL);
INSERT INTO "modules" VALUES ('R2.11','Expression-Culture-Communication Professionnelles : Renforcement des techniques de communication',NULL);
INSERT INTO "modules" VALUES ('R2.12','Projet Personnel et Professionnel',NULL);
INSERT INTO "modules" VALUES ('R2.13','Math??matiques des syst??mes num??riques',NULL);
INSERT INTO "modules" VALUES ('R2.14','Analyse math??matique des signaux',NULL);
INSERT INTO "modules" VALUES ('SAE2.04','Projet int??gratif',NULL);
INSERT INTO "modules" VALUES ('SAE2.PORTFOLIO','Portfolio',NULL);
INSERT INTO "modules" VALUES ('R3.01','R??seaux de Campus','ResCampus');
INSERT INTO "modules" VALUES ('R3.02','R??seaux op??rateurs','ResOp');
INSERT INTO "modules" VALUES ('R3.03','Services r??seaux avanc??s','ServRes');
INSERT INTO "modules" VALUES ('R3.04','Services d''annuaire','Annuaires');
INSERT INTO "modules" VALUES ('R3.05','Cha??nes de transmissions num??riques','TransNum');
INSERT INTO "modules" VALUES ('R3.06','Fibres optiques et propagation','FO');
INSERT INTO "modules" VALUES ('R3.07','R??seaux d''acc??s','ResAcces');
INSERT INTO "modules" VALUES ('R3.08','Consolidation de la programmation','POO');
INSERT INTO "modules" VALUES ('R3.09','Programmation ??v??nementielle','ProgEvenementiel');
INSERT INTO "modules" VALUES ('R3.10','Gestion d''un syst??me de bases de donn??es','ConfigBDD');
INSERT INTO "modules" VALUES ('R3.11','Anglais professionnel 1','Anglais');
INSERT INTO "modules" VALUES ('R3.12','Expression-Culture-Communication professionnelles : Savoir collaborer','ExprComm');
INSERT INTO "modules" VALUES ('R3.13','PPP','PPP');
INSERT INTO "modules" VALUES ('R3.14','Math??matiques : Analyse de Fourier','MathFourier');
INSERT INTO "modules" VALUES ('R3.15','Gestion de projets 2 : Utiliser les m??thodes de gestion de projet','GestProj');
INSERT INTO "modules" VALUES ('R3.Cyber.16','Fondamentaux de la CyberS??curit?? et Introduction au pentesting','Pentesting');
INSERT INTO "modules" VALUES ('R3.DevCloud.16','Eco-syst??me Cloud','EcoCloud');
INSERT INTO "modules" VALUES ('R3.DevCloud.17','Virtualisation avanc??e','Virtu');
INSERT INTO "modules" VALUES ('SAE3.01','Etude et mise en oeuvre d''un syst??me de transmission',NULL);
INSERT INTO "modules" VALUES ('SAE3.02','Applications communicantes (client-serveur)',NULL);
INSERT INTO "modules" VALUES ('SAE3.PORTFOLIO','Portfolio','Portfolio');
INSERT INTO "modules" VALUES ('SAE3.03','Concevoir un r??seau informatique multi-sites',NULL);
INSERT INTO "modules" VALUES ('SAE3.Cyber.04','D??couvrir le pentesting',NULL);
INSERT INTO "modules" VALUES ('SAE.DevCloud.04','Mettre en place une infrastructure virtualis??e',NULL);
INSERT INTO "modules" VALUES ('R4.01','Infrastructure de s??curit??','InfraSec');
INSERT INTO "modules" VALUES ('R4.02','Transmissions avanc??es',NULL);
INSERT INTO "modules" VALUES ('R4.03','Physique des t??l??coms','Antennes');
INSERT INTO "modules" VALUES ('R4.04','R??seaux cellulaires','ResCel');
INSERT INTO "modules" VALUES ('R4.05','Automatisation des t??ches d''administration','Scripting');
INSERT INTO "modules" VALUES ('R4.06','Anglais professionnel','Anglais');
INSERT INTO "modules" VALUES ('R4.07','ECCP : communiquer pour mettre en valeur ses comp??tences','ExprCom');
INSERT INTO "modules" VALUES ('R4.Cyber.09','S??curit?? des ??seaux LAN','LANSecure');
INSERT INTO "modules" VALUES ('R4.Cyber.10','Cryptographique','Crypto');
INSERT INTO "modules" VALUES ('R4.Cyber.11','S??curisation de services r??seaux','ServSecure');
INSERT INTO "modules" VALUES ('R4.DevCloud.09','Fondamentaux de la conteneurisation','Docker');
INSERT INTO "modules" VALUES ('R4.DevCloud.10','D??veloppement de microservices','Microservice');
INSERT INTO "modules" VALUES ('SAE4.PORTFOLIO','Portfolio','Portfolio');
INSERT INTO "modules" VALUES ('SAE4.STAGE','Stage','Stage');
INSERT INTO "modules" VALUES ('SAE4.Cyber.01','S??curiser un syst??me d''information',NULL);
INSERT INTO "modules" VALUES ('SAE4.DevCloud.01','D??velopper et d??ployer un microservice dans un environnement virtualis??',NULL);
INSERT INTO "modules" VALUES ('R5.01','Wifi Avanc??','Wifi');
INSERT INTO "modules" VALUES ('R5.02','Supervision des r??seaux','Supervision');
INSERT INTO "modules" VALUES ('R5.03','Ing??nierie de syst??mes t??l??coms','SysTel');
INSERT INTO "modules" VALUES ('R5.04','Cycle de vie d''un projet informatique','ProjInf');
INSERT INTO "modules" VALUES ('R5.05','Anglais : Insertion professionnelle 1','Anglais');
INSERT INTO "modules" VALUES ('R5.08','Gestion de projets : Mener un projet professionnel','GestProj');
INSERT INTO "modules" VALUES ('R5.Cyber.09','Architectures s??curis??es','ArchiSecure');
INSERT INTO "modules" VALUES ('R5.Cyber.10','Audits de s??curit??','Audit');
INSERT INTO "modules" VALUES ('R5.Cyber.11','Supervision de la s??curit??','Supervision2');
INSERT INTO "modules" VALUES ('R5.Cyber.13','Analyse de s??curit?? par scripting','Scapy');
INSERT INTO "modules" VALUES ('R5.DevCloud.09','Outils et m??thodes du DevOps','DevOps');
INSERT INTO "modules" VALUES ('R5.DevCloud.10','Infrastructures containeuris??es','InfraConteneurs');
INSERT INTO "modules" VALUES ('R5.DevCloud.11','Programmer son infrastructure','ProgInfra');
INSERT INTO "modules" VALUES ('SAE5.01','Concevoir r??aliser et pr??senter une solution technique - application ?? la t??l??com',NULL);
INSERT INTO "modules" VALUES ('SAE5.02','Piloter un projet informatique',NULL);
INSERT INTO "modules" VALUES ('SAE5.PORTFOLIO','Portfolio','Portfolio');
INSERT INTO "modules" VALUES ('SAE5.Cyber.03','Assurer la s??curisation et la supervision avanc??es d''un syst??me d''information',NULL);
INSERT INTO "modules" VALUES ('SAE5.DevCloud.03','Orchestrer la conteneurisation d''une application',NULL);
INSERT INTO "modules" VALUES ('R6.01','Anglais : Insertion professionnelle 2','Anglais');
INSERT INTO "modules" VALUES ('R6.02','Expression-Culture-Communication professionnelles : Communiquer en tant que futur cadre interm??diaire','ExprCom');
INSERT INTO "modules" VALUES ('R6.03','Connaissance de l''entreprise','Droit');
INSERT INTO "modules" VALUES ('R6.Cyber.04','R??ponse ?? incidents','Incident');
INSERT INTO "modules" VALUES ('R5.DevCloud.12','Solutions Cloud','Cloud');
INSERT INTO "modules" VALUES ('SAE6.PORTFOLIO','Portfolio','Portfolio');
INSERT INTO "modules" VALUES ('SAE6.STAGE','Stage','Stage');
INSERT INTO "modules" VALUES ('SAE6.Cyber.01','R??agir face ?? une cyber attaque','CyberAttaque');
INSERT INTO "modules" VALUES ('SAE6.DevCloud.01','G??rer le pipeline d''une application orient??e Cloud','Pipeline');
INSERT INTO "vacataires" VALUES (1,'Rossi','Thomas','thomas.rossi@gmail.com','705257567','Salari?? public','UGA','rossitho',1);
INSERT INTO "vacataires" VALUES (2,'Guillet','Jos??phine','josephine.guillet@hotmail.fr','978598105','Collaborateur b??n??vole',NULL,'guilletj',1);
INSERT INTO "vacataires" VALUES (3,'Arnaud','Lucy','lucy.arnaud@yahoo.com','415603300','Collaborateur b??n??vole',NULL,'arnaudlu',1);
INSERT INTO "vacataires" VALUES (4,'Didier','Maggie','maggie.didier@orange.fr','458825449','ASI',NULL,NULL,0);
INSERT INTO "vacataires" VALUES (5,'Guyot-Gaillard','Marc','marc.guyot-gaillard@univ-grenoble-alpes.fr','623657373','ITRF','IUT1-GEII','guyotgam',0);
INSERT INTO "comptes" VALUES ('rossitho','$2b$12$aVJdS1pfz6n1MSiYot.7J.BbTnzVp9UcU4vI91QfFvxaOu5Q.hDgi','vacataire');
INSERT INTO "comptes" VALUES ('guilletj','$2b$12$dp8xvk6Iw53bt0Vja2oZvu.g8mwvlfmCZkzlpeUk2aOBsl3SikmgK','vacataire');
INSERT INTO "comptes" VALUES ('arnaudlu','$2b$12$jtKpoPs6gC4FMnhbogHx5.le5MfeZI1DKS.x/8QbOsUMPVh/rT0EK','vacataire');
INSERT INTO "comptes" VALUES ('cordiere','$2b$12$HT0bR6Cu2fvemWY1K.HJbeiUecjXXjxwhuBpPMJUGatrY4Ous1kgW','enseignant');
INSERT INTO "comptes" VALUES ('nicolasl','$2b$12$xe1qWHPzQFRgLNuI2ZUd1u.lewmPHghPQpwtzQKdEx2XHQJkxlFVy','enseignant');
INSERT INTO "comptes" VALUES ('lelaurel','$2b$12$b4W9akqffRtSwKCzo1xYyOt.yfuEHn/pPyKOCKT38vLwbNPdkqf.a','enseignant');
COMMIT;
