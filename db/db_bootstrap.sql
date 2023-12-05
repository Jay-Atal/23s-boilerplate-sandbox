-- This file is to bootstrap a database for the CS3200 project.

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create
database cool_db;

-- Via the Docker Compose file, a special user called webapp will
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on cool_db.* to
'webapp'@'%';
flush
privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use cool_db;

/* -- Put your DDL
CREATE TABLE fav_colors (
  name VARCHAR(20),
  color VARCHAR(10)
);

-- Add sample data. 
INSERT INTO fav_colors
  (name, color)
VALUES
  ('dev', 'blue'),
  ('pro', 'yellow'),
  ('junior', 'red'); */

create table Moderator
(
    ModeratorID INT primary key not null,
    Email       VARCHAR(50)     not null,
    Name        VARCHAR(50)     not null,
    Role        VARCHAR(50)     not null
);



create table Student
(
    StudentID INT primary key,
    Name      VARCHAR(50),
    Email     VARCHAR(50),
    Major     VARCHAR(23),
    GradeYear VARCHAR(11),
    NumCoops  INT
);


create table User_Interaction
(
    ModeratorID   INT,
    StudentID     INT,
    InteractionID INT primary key,
    UserTimestamp DATETIME,
    Content       VARCHAR(150),
    Status        tinyint(1) NOT NULL,

    CONSTRAINT fk_01 FOREIGN KEY (ModeratorID)
        REFERENCES Moderator (ModeratorID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_02 FOREIGN KEY (StudentID)
        REFERENCES Student (StudentID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


create table Guidelines
(
    ModeratorID INT not null,
    GuidelineID INT primary key not null ,
    Content     VARCHAR(300) not null ,
    UpdateDate  DATETIME not null,

    CONSTRAINT fk_03 FOREIGN KEY (ModeratorID)
        REFERENCES Moderator (ModeratorID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Analytics
(
    AnalyticsID INT primary key,
    EngagementScore Int not null,
    TrendType VARCHAR(150),
    ModeratorID INT,
    Data VARCHAR(150),
    CONSTRAINT fk_04 FOREIGN KEY (ModeratorID)
        REFERENCES Moderator (ModeratorID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Notification
(
    ReceiverID int,
    NotificationID int,
    Type varchar(50),
    NotificationTimestamp DATETIME,
    SeenStatus tinyint(1),
    CONSTRAINT fk_05 FOREIGN KEY (ReceiverID)
        REFERENCES Student (StudentID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Company_Page
(
    CompanyPageID int primary key,
    Name varchar(150) not null,
    OverallRating int not null,
    AreHiring tinyint(1) NOT NULL,
    ProgramLength varchar(150)
);

CREATE TABLE Job_Openings
(
    CompanyPageID int not null ,
    JobID int not null primary key,
    Name varchar(150) not null ,
    RoleDescription varchar(150) not null ,
    Difficulty varchar(150) not null ,
    GradeYearRequirement varchar(150),
    CONSTRAINT fk_06 FOREIGN KEY (CompanyPageID)
        REFERENCES Company_Page (CompanyPageID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Student_Job_Search
(
    JobID int,
    StudentID int,
    CONSTRAINT fk_07 FOREIGN KEY (JobID)
        REFERENCES Job_Openings (JobID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_08 FOREIGN KEY (StudentID)
        REFERENCES Student (StudentID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

create table Reviews
(
    CompanyPageID int not null,
    JobID int not null,
    StudentID int not null,
    ReviewID int primary key not null,
    Comment varchar(150) not null,
    DifficultyRating int not null,
    FirstOrSecondCoop varchar(10) not null,

    CONSTRAINT fk_09 FOREIGN KEY (CompanyPageID)
        REFERENCES Company_Page (CompanyPageID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

        CONSTRAINT fk_010 FOREIGN KEY (JobID)
        REFERENCES Job_Openings (JobID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

        CONSTRAINT fk_11 FOREIGN KEY (StudentID)
        REFERENCES Student (StudentID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

create table Company_Representative
(
    CompanyPageID int,
    CompanyRepID int primary key,
    Name varchar(150),
    Email varchar(150),
    CONSTRAINT fk_12 FOREIGN KEY (CompanyPageID)
        REFERENCES Company_Page (CompanyPageID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Dispute
(
     ReviewID int,
     ModeratorID int,
     DisputeID int primary key,
     ResolutionStatus varchar(15),
     ResolutionDate DATETIME,
     CONSTRAINT fk_13 FOREIGN KEY (ReviewID)
         REFERENCES Reviews (ReviewID)
         ON UPDATE CASCADE
         ON DELETE CASCADE,
     CONSTRAINT fk_14 FOREIGN KEY (ModeratorID)
         REFERENCES Moderator (ModeratorID)
         ON UPDATE CASCADE
         ON DELETE CASCADE
);

CREATE TABLE Review_Response
(
    CompanyRepID int,
    ReviewID int,
    ResponseID int,
    ResponseContent varchar(150),
    ResponseDate DATETIME,
    CONSTRAINT fk_15 FOREIGN KEY (CompanyRepID)
        REFERENCES Company_Representative (CompanyRepID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_16 FOREIGN KEY (ReviewID)
        REFERENCES Reviews (ReviewID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Company_Content
(
    CompanyRepID int not null ,
    ContentID int primary key not null ,
    ContentType varchar(50) not null ,
    ContentData varchar(150) not null ,
    PostDate DATETIME not null ,

    CONSTRAINT fk_17 FOREIGN KEY (CompanyRepID)
        REFERENCES Company_Representative (CompanyRepID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Compensation_Data
(
     PositionType varchar(150) not null ,
     AverageSalary varchar(150) not null ,
     FilterCriteria varchar(150) not null ,
     CompanyPageID int primary key not null

);

insert into Moderator (ModeratorID, Email, Name, Role) values (1, 'jdunlap0@sciencedaily.com', 'Jeri Dunlap', 'Analyst');
insert into Moderator (ModeratorID, Email, Name, Role) values (2, 'htugwell1@unblog.fr', 'Helenka Tugwell', 'Analyst');
insert into Moderator (ModeratorID, Email, Name, Role) values (3, 'abispo2@mail.ru', 'Aylmar Bispo', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (4, 'tcaine3@photobucket.com', 'Tiertza Caine', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (5, 'jdoucette4@yellowbook.com', 'Joby Doucette', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (6, 'wtow5@netvibes.com', 'Weston Tow', 'Analyst');
insert into Moderator (ModeratorID, Email, Name, Role) values (7, 'dbeeho6@nydailynews.com', 'Darby Beeho', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (8, 'ofacchini7@pbs.org', 'Orella Facchini', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (9, 'fskitral8@opera.com', 'Florinda Skitral', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (10, 'lmacmanus9@themeforest.net', 'Lizzy MacManus', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (11, 'oarklea@usda.gov', 'Orlan Arkle', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (12, 'lgullamb@tuttocitta.it', 'Letta Gullam', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (13, 'vchaplainc@google.es', 'Vincenz Chaplain', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (14, 'rlongthornd@netlog.com', 'Roxie Longthorn', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (15, 'sfawberte@economist.com', 'Sande Fawbert', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (16, 'imccauleyf@netlog.com', 'Ingrim McCauley', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (17, 'ggaucheg@free.fr', 'Gay Gauche', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (18, 'khambatchh@ustream.tv', 'Keven Hambatch', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (19, 'hrippingi@intel.com', 'Hayes Ripping', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (20, 'lbaguleyj@joomla.org', 'Linet Baguley', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (21, 'sburnsellk@nasa.gov', 'Shandeigh Burnsell', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (22, 'dhainsworthl@salon.com', 'Donielle Hainsworth', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (23, 'cfreirem@dailymail.co.uk', 'Chrystal Freire', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (24, 'wpenticostn@cbc.ca', 'Walden Penticost', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (25, 'ldabelso@goo.gl', 'Lisbeth Dabels', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (26, 'jseadonp@answers.com', 'Jessa Seadon', 'Analyst');
insert into Moderator (ModeratorID, Email, Name, Role) values (27, 'dparfittq@house.gov', 'Dorrie Parfitt', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (28, 'babraminor@theglobeandmail.com', 'Bernadene Abramino', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (29, 'kfolans@mozilla.com', 'Kerry Folan', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (30, 'gdrehert@nbcnews.com', 'Gloria Dreher', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (31, 'kblacktinu@wsj.com', 'Katleen Blacktin', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (32, 'lloffelv@deviantart.com', 'Ly Loffel', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (33, 'gfrangellow@cdc.gov', 'Gardy Frangello', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (34, 'xthirstx@ustream.tv', 'Ximenes Thirst', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (35, 'eduffriey@google.com.hk', 'Eileen Duffrie', 'Analyst');
insert into Moderator (ModeratorID, Email, Name, Role) values (36, 'dfiguresz@macromedia.com', 'Dora Figures', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (37, 'ncastanares10@t.co', 'Noel Castanares', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (38, 'clewsley11@ustream.tv', 'Craggie Lewsley', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (39, 'hportlock12@reverbnation.com', 'Hadrian Portlock', 'Analyst');
insert into Moderator (ModeratorID, Email, Name, Role) values (40, 'nbroomhall13@instagram.com', 'Nealy Broomhall', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (41, 'mgeorge14@cpanel.net', 'Marcille George', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (42, 'kbeadnell15@wiley.com', 'Kenny Beadnell', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (43, 'dbrusin16@ow.ly', 'Dodi Brusin', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (44, 'xmockes17@cafepress.com', 'Xylia Mockes', 'Administrator');
insert into Moderator (ModeratorID, Email, Name, Role) values (45, 'ssomerville18@netscape.com', 'Stace Somerville', 'Moderator');
insert into Moderator (ModeratorID, Email, Name, Role) values (46, 'ckeri19@i2i.jp', 'Clarice Keri', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (47, 'rkeirle1a@alibaba.com', 'Rosabel Keirle', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (48, 'akeeble1b@digg.com', 'Annabel Keeble', 'Enforcer');
insert into Moderator (ModeratorID, Email, Name, Role) values (49, 'cyarnell1c@friendfeed.com', 'Carmine Yarnell', 'Supervisor');
insert into Moderator (ModeratorID, Email, Name, Role) values (50, 'rshoard1d@godaddy.com', 'Roseanna Shoard', 'Supervisor');

insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (1, 'Jackie Dunkirk', 'jdunkirk0@linkedin.com', 'English Literature', 'Fifth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (2, 'Aviva Brickham', 'abrickham1@google.es', 'Psychology', 'Second year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (3, 'Cristobal Wedderburn', 'cwedderburn2@creativecommons.org', 'Political Science', 'Second year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (4, 'Kelila Tendahl', 'ktendahl3@newsvine.com', 'Nursing', 'Third year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (5, 'Sandra Woodcraft', 'swoodcraft4@intel.com', 'Business Administration', 'First year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (6, 'Devi Costello', 'dcostello5@globo.com', 'Biology', 'Third year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (7, 'Humfried Emma', 'hemma6@yellowpages.com', 'Education', 'Second year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (8, 'Orlan Birkett', 'obirkett7@typepad.com', 'Education', 'Fifth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (9, 'Vina Delouch', 'vdelouch8@quantcast.com', 'Psychology', 'Fourth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (10, 'Osmond O''Cassidy', 'oocassidy9@chronoengine.com', 'Biology', 'Third year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (11, 'Vivienne Sharvell', 'vsharvella@cbc.ca', 'Psychology', 'Fifth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (12, 'Russell Counter', 'rcounterb@blog.com', 'Communications', 'Fifth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (13, 'Bern Anthonsen', 'banthonsenc@lulu.com', 'Political Science', 'Fourth year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (14, 'Rea Andriulis', 'randriulisd@slideshare.net', 'Nursing', 'Fifth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (15, 'Lauritz Wevell', 'lwevelle@hibu.com', 'Communications', 'Fifth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (16, 'Pedro Seagood', 'pseagoodf@sciencedaily.com', 'Political Science', 'Fourth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (17, 'Toby Steddall', 'tsteddallg@google.co.jp', 'Psychology', 'First year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (18, 'Roseline Colleymore', 'rcolleymoreh@craigslist.org', 'Communications', 'Third year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (19, 'Karlotte Aldus', 'kaldusi@dagondesign.com', 'English Literature', 'Fifth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (20, 'Rodi Hobben', 'rhobbenj@dot.gov', 'Engineering', 'Third year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (21, 'Kennith Oager', 'koagerk@miibeian.gov.cn', 'Biology', 'Fifth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (22, 'Garland Allabush', 'gallabushl@studiopress.com', 'Nursing', 'Second year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (23, 'Winona Prestie', 'wprestiem@ibm.com', 'Communications', 'First year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (24, 'Jenda Paolicchi', 'jpaolicchin@adobe.com', 'Political Science', 'Fifth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (25, 'Adelaida Lorens', 'alorenso@canalblog.com', 'Education', 'Fifth year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (26, 'Web Escot', 'wescotp@histats.com', 'English Literature', 'First year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (27, 'Ileana Yeandel', 'iyeandelq@google.com.au', 'Computer Science', 'Second year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (28, 'Karilynn Sterre', 'ksterrer@craigslist.org', 'Nursing', 'Third year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (29, 'Tiffani Turpey', 'tturpeys@nyu.edu', 'Engineering', 'First year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (30, 'Birch Seery', 'bseeryt@wunderground.com', 'Engineering', 'Second year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (31, 'Prinz Berrecloth', 'pberreclothu@vkontakte.ru', 'Business Administration', 'Fifth year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (32, 'Jamaal Vannar', 'jvannarv@cisco.com', 'English Literature', 'Fourth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (33, 'Win Grattage', 'wgrattagew@amazon.com', 'Nursing', 'First year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (34, 'Beatrix Mussalli', 'bmussallix@hostgator.com', 'Engineering', 'Fifth year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (35, 'Edan Lowman', 'elowmany@dot.gov', 'Computer Science', 'Fourth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (36, 'Ruprecht Loyndon', 'rloyndonz@dropbox.com', 'Psychology', 'Third year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (37, 'Tomasine Wignall', 'twignall10@nydailynews.com', 'Political Science', 'Third year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (38, 'Tommi Sausman', 'tsausman11@ovh.net', 'English Literature', 'Fifth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (39, 'Ashlan Hamshaw', 'ahamshaw12@domainmarket.com', 'Biology', 'Fifth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (40, 'Doloritas Duplain', 'dduplain13@go.com', 'Communications', 'Third year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (41, 'Gerik Braine', 'gbraine14@princeton.edu', 'Computer Science', 'Fourth year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (42, 'Estel Deverill', 'edeverill15@reddit.com', 'English Literature', 'First year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (43, 'Birdie Jeavons', 'bjeavons16@e-recht24.de', 'English Literature', 'Fifth year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (44, 'Yanaton McCulloch', 'ymcculloch17@soup.io', 'Education', 'Third year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (45, 'Zola Duker', 'zduker18@tinypic.com', 'Biology', 'Fifth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (46, 'Patti Hiseman', 'phiseman19@amazon.com', 'Biology', 'Fourth year', 3);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (47, 'Richmond Kerin', 'rkerin1a@toplist.cz', 'Education', 'Second year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (48, 'Marlene Handrock', 'mhandrock1b@baidu.com', 'Business Administration', 'Second year', 2);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (49, 'Corrianne Poyntz', 'cpoyntz1c@youku.com', 'Engineering', 'Third year', 1);
insert into Student (Studentid, Name, Email, Major, GradeYear, NumCoops) values (50, 'Conant McNae', 'cmcnae1d@techcrunch.com', 'Biology', 'First year', 3);

insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (45, 18, 1, '2023-06-20 14:15:12', 'causing delays in communication.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (16, 36, 2, '2023-07-10 03:25:24', 'an error popped up stating that the recipient''s username was invalid', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (26, 15, 3, '2023-05-12 11:50:40', 'an error message appeared stating that some required fields were left blank', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (22, 44, 4, '2023-10-06 11:42:53', 'an error message appeared stating that the transaction could not be processed.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (8, 11, 5, '2023-07-12 18:03:46', 'the user encountered a technical glitch in the chat feature. Messages were not being delivered in real-time', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (41, 13, 6, '2022-12-15 16:01:54', 'The user noticed a bug in the video player. When trying to play a video', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (32, 9, 7, '2023-08-27 07:00:30', 'the user encountered a technical glitch in the chat feature. Messages were not being delivered in real-time', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (40, 12, 8, '2023-10-15 19:53:27', 'A user reported a bug in the messaging feature. When trying to send a message', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (3, 9, 9, '2023-01-17 20:11:40', 'an error message appeared stating that the file format was not supported.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (47, 9, 10, '2022-11-27 01:19:01', 'A user reported a bug in the notification system. They were not receiving any email notifications for new messages or updates', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (19, 47, 11, '2023-06-20 17:58:00', 'even though the pages existed.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (2, 3, 12, '2023-06-23 13:21:20', 'causing delays in communication.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (29, 43, 13, '2023-11-05 13:21:05', 'While navigating through the website', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (2, 16, 14, '2023-10-11 04:58:48', 'causing delays in communication.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (21, 39, 15, '2023-01-29 02:21:07', 'the user encountered a technical glitch in the chat feature. Messages were not being delivered in real-time', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (31, 22, 16, '2023-09-09 23:28:54', 'even though the pages existed.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (8, 9, 17, '2023-06-14 09:45:51', 'it would freeze after a few seconds and then crash the entire browser.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (26, 45, 18, '2023-08-30 21:47:51', 'The user noticed a bug in the video player. When trying to play a video', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (9, 8, 19, '2023-02-11 01:12:01', 'even though they were filled correctly.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (14, 17, 20, '2023-11-13 09:17:41', 'an error message appeared stating that the file format was not supported.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (24, 46, 21, '2023-01-29 19:41:56', 'an error message appeared stating that the transaction could not be processed.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (9, 16, 22, '2023-11-08 18:18:34', 'even though the settings were correctly configured.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (8, 30, 23, '2023-10-14 15:08:51', 'The user noticed a bug in the video player. When trying to play a video', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (46, 2, 24, '2023-10-27 22:32:43', 'While navigating through the website', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (37, 18, 25, '2023-05-12 06:17:44', 'an error message appeared stating that the transaction could not be processed.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (26, 12, 26, '2023-02-20 08:56:32', 'even though it was correct.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (14, 24, 27, '2023-09-10 02:39:11', 'an error message appeared stating that some required fields were left blank', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (30, 21, 28, '2023-07-17 21:15:51', 'The user experienced a technical issue while accessing certain pages on the website. They would receive a ''404 Page Not Found'' error', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (33, 24, 29, '2023-10-13 07:04:42', 'the user encountered a bug in the search functionality. No results were displayed even when searching for valid keywords.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (42, 4, 30, '2023-08-12 05:15:04', 'A user reported a bug in the messaging feature. When trying to send a message', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (35, 40, 31, '2023-07-29 14:26:14', 'an error message appeared stating that the transaction could not be processed.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (13, 5, 32, '2023-09-15 18:52:51', 'an error message appeared stating that the file format was not supported.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (49, 34, 33, '2023-03-15 00:41:41', 'even though they were filled correctly.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (1, 14, 34, '2022-12-13 22:07:48', 'The user noticed a bug in the video player. When trying to play a video', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (30, 35, 35, '2023-03-29 09:31:53', 'an error message appeared stating that the file format was not supported.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (29, 4, 36, '2023-08-01 14:47:00', 'causing delays in communication.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (1, 10, 37, '2023-02-08 02:49:50', 'A user reported a technical bug in the payment process. After entering the credit card details and clicking ''Submit''', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (4, 9, 38, '2023-10-08 03:30:14', 'the user encountered a bug in the search functionality. No results were displayed even when searching for valid keywords.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (35, 1, 39, '2023-08-24 13:40:17', 'an error message appeared stating that some required fields were left blank', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (16, 1, 40, '2023-11-04 11:36:01', 'even though they were filled correctly.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (36, 13, 41, '2023-07-18 02:51:11', 'even though the settings were correctly configured.', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (49, 45, 42, '2023-11-07 15:54:30', 'even though the settings were correctly configured.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (42, 20, 43, '2023-01-01 10:37:29', 'even though the settings were correctly configured.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (32, 31, 44, '2022-12-09 14:58:14', 'While navigating through the website', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (6, 34, 45, '2023-05-27 22:58:14', 'causing delays in communication.', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (40, 12, 46, '2023-10-17 04:10:26', 'The user encountered a technical bug while trying to upload an image. After selecting the file', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (37, 49, 47, '2023-01-15 11:52:10', 'an error popped up stating that the recipient''s username was invalid', 0);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (33, 18, 48, '2022-12-08 17:29:20', 'A user reported a bug in the messaging feature. When trying to send a message', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (23, 19, 49, '2023-09-04 16:59:12', 'The user experienced a technical issue while filling out a form. After submitting the form', 1);
insert into User_Interaction (ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status) values (46, 26, 50, '2023-02-05 00:51:00', 'even though it was correct.', 1);

insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (27, 1, 'Ut enim ad minim veniam', '2023-10-29 12:16:34');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (18, 2, 'Lorem ipsum dolor sit amet', '2023-04-04 04:07:50');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (22, 3, 'Ut enim ad minim veniam', '2023-03-02 09:58:29');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (18, 4, 'Consectetur adipiscing elit', '2022-12-17 03:10:45');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (17, 5, 'Ut enim ad minim veniam', '2022-12-05 08:40:55');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (10, 6, 'Ut enim ad minim veniam', '2023-01-07 06:35:16');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (16, 7, 'Consectetur adipiscing elit', '2023-01-06 05:58:06');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (1, 8, 'Lorem ipsum dolor sit amet', '2023-01-28 22:01:32');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (42, 9, 'Ut enim ad minim veniam', '2022-11-28 10:24:30');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (8, 10, 'Sed do eiusmod tempor incididunt', '2023-08-24 01:56:59');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (19, 11, 'Lorem ipsum dolor sit amet', '2023-09-09 21:30:23');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (27, 12, 'Ut labore et dolore magna aliqua', '2023-04-07 07:43:37');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (31, 13, 'Ut labore et dolore magna aliqua', '2022-12-03 02:36:21');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (18, 14, 'Sed do eiusmod tempor incididunt', '2023-04-26 12:29:09');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (44, 15, 'Consectetur adipiscing elit', '2023-05-04 06:36:41');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (3, 16, 'Ut enim ad minim veniam', '2023-03-11 22:29:13');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (11, 17, 'Ut labore et dolore magna aliqua', '2023-08-03 20:27:16');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (29, 18, 'Consectetur adipiscing elit', '2022-12-10 08:36:36');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (34, 19, 'Ut enim ad minim veniam', '2023-04-25 23:19:24');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (28, 20, 'Lorem ipsum dolor sit amet', '2023-11-19 04:15:55');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (15, 21, 'Ut enim ad minim veniam', '2023-10-09 22:12:22');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (9, 22, 'Sed do eiusmod tempor incididunt', '2023-02-23 09:32:33');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (8, 23, 'Sed do eiusmod tempor incididunt', '2022-12-17 04:46:57');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (44, 24, 'Lorem ipsum dolor sit amet', '2023-06-29 13:41:34');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (35, 25, 'Consectetur adipiscing elit', '2023-09-09 19:36:37');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (10, 26, 'Sed do eiusmod tempor incididunt', '2023-02-28 17:06:45');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (43, 27, 'Ut enim ad minim veniam', '2022-12-28 06:53:32');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (47, 28, 'Ut enim ad minim veniam', '2023-01-06 03:57:21');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (24, 29, 'Consectetur adipiscing elit', '2023-02-13 07:21:17');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (33, 30, 'Lorem ipsum dolor sit amet', '2023-08-04 11:56:29');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (26, 31, 'Ut enim ad minim veniam', '2023-03-26 05:18:42');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (18, 32, 'Consectetur adipiscing elit', '2023-04-27 02:12:20');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (33, 33, 'Sed do eiusmod tempor incididunt', '2022-12-07 12:34:42');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (19, 34, 'Lorem ipsum dolor sit amet', '2023-01-30 05:58:51');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (37, 35, 'Lorem ipsum dolor sit amet', '2023-07-11 23:05:56');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (4, 36, 'Sed do eiusmod tempor incididunt', '2023-01-06 08:42:14');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (42, 37, 'Ut enim ad minim veniam', '2023-10-17 20:17:02');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (47, 38, 'Ut labore et dolore magna aliqua', '2023-04-04 16:07:56');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (47, 39, 'Ut labore et dolore magna aliqua', '2023-09-21 20:13:59');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (37, 40, 'Consectetur adipiscing elit', '2023-09-03 03:32:52');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (30, 41, 'Ut labore et dolore magna aliqua', '2023-07-16 03:43:27');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (5, 42, 'Lorem ipsum dolor sit amet', '2023-10-08 13:38:00');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (30, 43, 'Lorem ipsum dolor sit amet', '2023-01-05 18:28:06');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (38, 44, 'Ut labore et dolore magna aliqua', '2023-08-30 23:04:22');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (14, 45, 'Consectetur adipiscing elit', '2023-06-15 10:42:18');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (25, 46, 'Sed do eiusmod tempor incididunt', '2023-04-10 12:34:10');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (35, 47, 'Consectetur adipiscing elit', '2023-02-01 05:55:32');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (17, 48, 'Ut labore et dolore magna aliqua', '2023-11-12 20:43:42');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (40, 49, 'Sed do eiusmod tempor incididunt', '2023-11-25 08:34:02');
insert into Guidelines (ModeratorID, GuidelineID, Content, UpdateDate) values (48, 50, 'Ut enim ad minim veniam', '2023-01-09 21:56:05');

insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (1, 34, 'Upward', 46, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (2, 80, 'Upward', 48, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (3, 13, 'Upward', 2, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (4, 19, 'Upward', 30, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (5, 61, 'Fluctuating', 38, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (6, 97, 'Upward', 8, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (7, 56, 'Stable', 14, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (8, 90, 'Downward', 44, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (9, 41, 'Stable', 24, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (10, 99, 'Upward', 8, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (11, 34, 'Downward', 36, 'Machine learning');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (12, 12, 'Fluctuating', 48, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (13, 95, 'Upward', 33, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (14, 29, 'Downward', 17, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (15, 46, 'Downward', 23, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (16, 91, 'Upward', 28, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (17, 15, 'Fluctuating', 47, 'Machine learning');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (18, 25, 'Downward', 6, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (19, 43, 'Fluctuating', 49, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (20, 62, 'Upward', 22, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (21, 9, 'Fluctuating', 3, 'Machine learning');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (22, 96, 'Stable', 44, 'Machine learning');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (23, 85, 'Upward', 33, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (24, 48, 'Fluctuating', 45, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (25, 25, 'Upward', 4, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (26, 84, 'Stable', 4, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (27, 63, 'Upward', 10, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (28, 89, 'Upward', 12, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (29, 44, 'Upward', 19, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (30, 45, 'Upward', 47, 'Machine learning');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (31, 56, 'Downward', 28, 'Data visualization');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (32, 88, 'Stable', 2, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (33, 55, 'Fluctuating', 42, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (34, 35, 'Stable', 47, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (35, 96, 'Stable', 13, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (36, 72, 'Upward', 22, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (37, 12, 'Stable', 43, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (38, 95, 'Stable', 37, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (39, 75, 'Fluctuating', 5, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (40, 87, 'Downward', 2, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (41, 37, 'Stable', 35, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (42, 37, 'Fluctuating', 43, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (43, 70, 'Fluctuating', 34, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (44, 7, 'Downward', 44, 'Natural language processing');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (45, 13, 'Fluctuating', 49, 'Machine learning');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (46, 29, 'Downward', 13, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (47, 23, 'Downward', 11, 'Machine learning');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (48, 95, 'Fluctuating', 50, 'Statistical modeling');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (49, 32, 'Stable', 43, 'Data analysis');
insert into Analytics (AnalyticsID, EngagementScore, TrendType, ModeratorID, Data) values (50, 88, 'Stable', 5, 'Natural language processing');

insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (45, 1, 'New message', '2023-04-28 07:38:07', 51);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (9, 2, 'New message', '2023-08-24 04:37:27', 75);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (43, 3, 'Reminder', '2023-04-04 17:47:17', 32);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (33, 4, 'Alert', '2023-03-09 23:59:15', 99);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (31, 5, 'Update', '2023-06-29 21:21:17', 51);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (38, 6, 'Alert', '2023-05-22 02:31:41', 46);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (17, 7, 'Reminder', '2023-06-03 00:34:57', 39);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (14, 8, 'New message', '2023-04-11 07:15:54', 83);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (9, 9, 'New message', '2023-11-16 08:23:08', 77);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (32, 10, 'New message', '2023-02-01 21:48:56', 58);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (47, 11, 'New message', '2023-09-08 10:22:06', 50);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (4, 12, 'Alert', '2023-09-10 17:03:13', 27);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (34, 13, 'Update', '2023-07-20 18:16:30', 63);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (41, 14, 'New message', '2023-02-09 05:49:47', 87);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (14, 15, 'Reminder', '2023-01-28 22:26:30', 20);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (24, 16, 'Alert', '2023-07-20 00:05:28', 38);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (32, 17, 'Update', '2023-10-06 07:48:18', 6);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (5, 18, 'Update', '2023-09-08 18:21:27', 43);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (36, 19, 'Reminder', '2023-03-10 22:51:30', 41);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (9, 20, 'Reminder', '2023-05-22 04:15:41', 12);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (17, 21, 'Alert', '2023-11-01 14:13:51', 72);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (34, 22, 'Reminder', '2023-07-06 03:14:15', 12);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (49, 23, 'Alert', '2023-09-03 09:52:14', 23);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (7, 24, 'Update', '2023-07-13 20:18:59', 69);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (14, 25, 'New message', '2023-09-11 07:25:27', 66);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (33, 26, 'Update', '2022-12-22 05:58:11', 58);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (48, 27, 'Notification', '2023-04-16 18:35:39', 48);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (43, 28, 'Notification', '2023-08-22 14:02:21', 38);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (1, 29, 'Reminder', '2022-12-17 03:52:38', 100);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (50, 30, 'Notification', '2023-03-27 22:01:11', 77);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (24, 31, 'Update', '2023-06-07 17:58:25', 23);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (44, 32, 'New message', '2023-06-25 07:27:00', 54);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (18, 33, 'Notification', '2023-07-14 20:48:50', 88);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (23, 34, 'New message', '2023-07-13 05:26:50', 91);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (46, 35, 'Update', '2023-08-11 07:26:21', 42);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (27, 36, 'New message', '2023-03-15 21:51:34', 72);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (44, 37, 'Alert', '2023-07-03 22:29:07', 25);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (26, 38, 'New message', '2022-12-08 02:56:31', 98);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (15, 39, 'Alert', '2023-06-08 18:52:33', 100);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (21, 40, 'Notification', '2023-02-04 03:38:07', 92);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (33, 41, 'Notification', '2023-06-06 23:33:50', 17);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (25, 42, 'Alert', '2023-09-05 18:46:34', 68);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (31, 43, 'Alert', '2023-09-14 23:08:05', 63);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (1, 44, 'Reminder', '2023-11-25 11:28:11', 5);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (19, 45, 'Notification', '2023-08-18 10:49:43', 18);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (8, 46, 'New message', '2023-07-12 10:50:21', 26);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (9, 47, 'Reminder', '2023-04-26 20:25:48', 75);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (5, 48, 'Alert', '2023-07-15 05:30:31', 12);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (34, 49, 'Reminder', '2023-01-30 02:35:25', 85);
insert into Notification (ReceiverID, NotificationID, Type, NotificationTimestamp, SeenStatus) values (19, 50, 'New message', '2023-07-04 12:30:01', 61);

insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (1, 'Skivee', 2, 0, '2 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (2, 'Skyndu', 3, 1, '6 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (3, 'Blogtags', 4, 1, '2 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (4, 'Mita', 1, 1, '6 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (5, 'Youfeed', 1, 0, '0 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (6, 'Quaxo', 5, 1, '6 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (7, 'Midel', 2, 1, '0 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (8, 'Wikido', 1, 1, '1 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (9, 'Nlounge', 2, 1, '5 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (10, 'Fivechat', 4, 1, '8 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (11, 'Quamba', 5, 1, '6 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (12, 'Topicshots', 3, 1, '8 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (13, 'Yata', 4, 1, '8 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (14, 'Twitterwire', 3, 0, '4 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (15, 'Buzzdog', 5, 0, '2 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (16, 'Meeveo', 2, 1, '6 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (17, 'Zooxo', 2, 0, '7 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (18, 'Divape', 5, 1, '9 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (19, 'Rhyzio', 5, 1, '6 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (20, 'Yodo', 5, 1, '4 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (21, 'Gigaclub', 5, 1, '9 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (22, 'Brightdog', 3, 1, '1 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (23, 'Skipfire', 3, 0, '5 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (24, 'Innotype', 1, 0, '5 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (25, 'Eazzy', 4, 1, '2 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (26, 'Leexo', 3, 0, '6 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (27, 'Livefish', 1, 0, '5 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (28, 'Katz', 5, 0, '5 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (29, 'Eire', 2, 1, '6 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (30, 'Dynabox', 5, 1, '4 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (31, 'Reallinks', 1, 0, '7 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (32, 'Zoombeat', 5, 1, '3 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (33, 'Zazio', 4, 1, '4 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (34, 'Meetz', 1, 1, '1 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (35, 'Photojam', 4, 1, '3 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (36, 'Blognation', 2, 0, '4 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (37, 'Kwideo', 1, 0, '9 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (38, 'Oozz', 4, 0, '8 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (39, 'Jabbercube', 5, 1, '9 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (40, 'Yakidoo', 3, 1, '5 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (41, 'Bubblebox', 2, 0, '3 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (42, 'Buzzster', 2, 1, '0 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (43, 'Dazzlesphere', 1, 0, '1 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (44, 'Skaboo', 5, 0, '1 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (45, 'Voomm', 3, 1, '1 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (46, 'Flipstorm', 4, 1, '7 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (47, 'LiveZ', 1, 1, '1 days');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (48, 'Oloo', 5, 0, '4 months');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (49, 'Flashpoint', 2, 0, '5 weeks');
insert into Company_Page (CompanyPageID, Name, OverallRating, AreHiring, ProgramLength) values (50, 'Zava', 1, 1, '2 days');

insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (41, 1, 'Errol Pagel', 'Sales Representative', 'intermediate', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (24, 2, 'Brendan Crutchley', 'Sales Representative', 'challenging', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (7, 3, 'Rodrick Atkyns', 'Financial Analyst', 'easy', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (5, 4, 'Eulalie Mellenby', 'Financial Analyst', 'novice', 'fourth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (42, 5, 'Ludvig Glaves', 'Content Writer', 'novice', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (16, 6, 'Rhody Osmint', 'Financial Analyst', 'beginner', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (38, 7, 'Krishna Belchamber', 'Content Writer', 'expert', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (13, 8, 'Codie Rillatt', 'HR Coordinator', 'expert', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (19, 9, 'Gonzales Worcester', 'Financial Analyst', 'medium', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (30, 10, 'George Quarles', 'Marketing Specialist', 'advanced', 'fifth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (42, 11, 'Donna Breward', 'Project Manager', 'intermediate', 'fourth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (25, 12, 'Dita Ginley', 'Data Analyst', 'advanced', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (8, 13, 'Dulcea McHenry', 'Data Analyst', 'challenging', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (9, 14, 'Shawnee Thewles', 'Software Engineer', 'easy', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (8, 15, 'Marlee Cowlishaw', 'Sales Representative', 'medium', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (41, 16, 'Angelle Wraighte', 'Data Analyst', 'expert', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (6, 17, 'Estrella Noah', 'Software Engineer', 'advanced', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (5, 18, 'Waylin Ivanin', 'Customer Support Agent', 'intermediate', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (50, 19, 'Clo Cannicott', 'Marketing Specialist', 'easy', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (42, 20, 'Edsel McFade', 'Sales Representative', 'advanced', 'fourth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (23, 21, 'Graham Kieff', 'Content Writer', 'advanced', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (29, 22, 'Ruby Flaherty', 'Content Writer', 'easy', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (8, 23, 'Jackquelin Renshell', 'Sales Representative', 'novice', 'fifth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (34, 24, 'Stewart Clericoates', 'Customer Support Agent', 'challenging', 'fifth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (13, 25, 'Hanan Laslett', 'Graphic Designer', 'novice', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (8, 26, 'Quint Boultwood', 'Software Engineer', 'beginner', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (11, 27, 'Olav Pavel', 'Marketing Specialist', 'novice', 'fifth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (34, 28, 'Philippa Bycraft', 'Financial Analyst', 'novice', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (48, 29, 'Darrell Poole', 'Marketing Specialist', 'medium', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (2, 30, 'Donnie Manna', 'Marketing Specialist', 'novice', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (10, 31, 'Loree Edmand', 'Graphic Designer', 'expert', 'fourth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (17, 32, 'Luciano Cathrae', 'Financial Analyst', 'easy', 'fourth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (9, 33, 'Kriste Fominov', 'Sales Representative', 'medium', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (4, 34, 'Marlyn Le Fleming', 'Project Manager', 'novice', 'fourth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (13, 35, 'Renelle Bridgnell', 'Customer Support Agent', 'novice', 'fifth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (28, 36, 'Owen Dunridge', 'Project Manager', 'hard', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (21, 37, 'Rriocard Atherley', 'Content Writer', 'novice', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (48, 38, 'Ashleigh Kienzle', 'Financial Analyst', 'challenging', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (11, 39, 'Karalynn Esgate', 'Marketing Specialist', 'expert', 'third year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (4, 40, 'Freida O''Shirine', 'Financial Analyst', 'novice', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (30, 41, 'Pru Abrehart', 'HR Coordinator', 'expert', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (40, 42, 'Corliss Tarling', 'Marketing Specialist', 'pro', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (42, 43, 'Lucio Moxted', 'HR Coordinator', 'easy', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (37, 44, 'Brandyn Oulett', 'Data Analyst', 'novice', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (49, 45, 'Hector Maccree', 'Marketing Specialist', 'novice', 'fifth year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (21, 46, 'Alicea Balaison', 'Software Engineer', 'hard', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (35, 47, 'Elie Heinreich', 'Customer Support Agent', 'medium', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (28, 48, 'Rena Dornan', 'Graphic Designer', 'beginner', 'second year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (12, 49, 'Amalie Petz', 'Graphic Designer', 'pro', 'first year');
insert into Job_Openings (CompanyPageID, JobID, Name, RoleDescription, Difficulty, GradeYearRequirement) values (12, 50, 'Winna Junes', 'HR Coordinator', 'pro', 'first year');

insert into Student_Job_Search (JobID, StudentID) values (38, 49);
insert into Student_Job_Search (JobID, StudentID) values (4, 40);
insert into Student_Job_Search (JobID, StudentID) values (38, 13);
insert into Student_Job_Search (JobID, StudentID) values (36, 17);
insert into Student_Job_Search (JobID, StudentID) values (36, 33);
insert into Student_Job_Search (JobID, StudentID) values (25, 3);
insert into Student_Job_Search (JobID, StudentID) values (32, 16);
insert into Student_Job_Search (JobID, StudentID) values (34, 46);
insert into Student_Job_Search (JobID, StudentID) values (34, 13);
insert into Student_Job_Search (JobID, StudentID) values (7, 34);
insert into Student_Job_Search (JobID, StudentID) values (43, 14);
insert into Student_Job_Search (JobID, StudentID) values (35, 10);
insert into Student_Job_Search (JobID, StudentID) values (36, 41);
insert into Student_Job_Search (JobID, StudentID) values (3, 21);
insert into Student_Job_Search (JobID, StudentID) values (17, 50);
insert into Student_Job_Search (JobID, StudentID) values (4, 28);
insert into Student_Job_Search (JobID, StudentID) values (37, 45);
insert into Student_Job_Search (JobID, StudentID) values (16, 30);
insert into Student_Job_Search (JobID, StudentID) values (40, 16);
insert into Student_Job_Search (JobID, StudentID) values (29, 30);
insert into Student_Job_Search (JobID, StudentID) values (7, 37);
insert into Student_Job_Search (JobID, StudentID) values (25, 25);
insert into Student_Job_Search (JobID, StudentID) values (28, 22);
insert into Student_Job_Search (JobID, StudentID) values (16, 44);
insert into Student_Job_Search (JobID, StudentID) values (5, 11);
insert into Student_Job_Search (JobID, StudentID) values (35, 11);
insert into Student_Job_Search (JobID, StudentID) values (5, 11);
insert into Student_Job_Search (JobID, StudentID) values (46, 27);
insert into Student_Job_Search (JobID, StudentID) values (16, 43);
insert into Student_Job_Search (JobID, StudentID) values (7, 30);
insert into Student_Job_Search (JobID, StudentID) values (41, 15);
insert into Student_Job_Search (JobID, StudentID) values (45, 18);
insert into Student_Job_Search (JobID, StudentID) values (29, 2);
insert into Student_Job_Search (JobID, StudentID) values (16, 4);
insert into Student_Job_Search (JobID, StudentID) values (30, 25);
insert into Student_Job_Search (JobID, StudentID) values (25, 8);
insert into Student_Job_Search (JobID, StudentID) values (42, 48);
insert into Student_Job_Search (JobID, StudentID) values (32, 30);
insert into Student_Job_Search (JobID, StudentID) values (11, 45);
insert into Student_Job_Search (JobID, StudentID) values (15, 3);
insert into Student_Job_Search (JobID, StudentID) values (37, 50);
insert into Student_Job_Search (JobID, StudentID) values (32, 18);
insert into Student_Job_Search (JobID, StudentID) values (11, 44);
insert into Student_Job_Search (JobID, StudentID) values (23, 43);
insert into Student_Job_Search (JobID, StudentID) values (28, 44);
insert into Student_Job_Search (JobID, StudentID) values (20, 40);
insert into Student_Job_Search (JobID, StudentID) values (15, 37);
insert into Student_Job_Search (JobID, StudentID) values (27, 48);
insert into Student_Job_Search (JobID, StudentID) values (39, 38);
insert into Student_Job_Search (JobID, StudentID) values (35, 48);

insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (19, 13, 23, 1, 'The management team was effective in providing guidance and support.', 51, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (29, 14, 31, 2, 'The management team was effective in providing guidance and support.', 100, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (33, 49, 17, 3, 'I had the chance to work on challenging and interesting projects.', 49, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (1, 12, 19, 4, 'I enjoyed collaborating with my colleagues on various projects.', 54, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (50, 11, 42, 5, 'The workload was manageable and allowed for a good work-life balance.', 84, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (34, 37, 8, 6, 'I felt valued and recognized for my contributions.', 18, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (13, 28, 33, 7, 'I appreciated the opportunities for professional growth and development.', 53, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (22, 30, 48, 8, 'I received constructive feedback that helped me improve my skills.', 82, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (4, 34, 35, 9, 'I had the chance to work on challenging and interesting projects.', 44, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (28, 46, 9, 10, 'The company culture fostered creativity and innovation.', 41, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (9, 28, 25, 11, 'I enjoyed collaborating with my colleagues on various projects.', 13, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (37, 18, 35, 12, 'The company culture fostered creativity and innovation.', 74, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (23, 35, 37, 13, 'The communication within the team was clear and efficient.', 91, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (12, 16, 18, 14, 'The management team was effective in providing guidance and support.', 58, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (32, 6, 19, 15, 'I received constructive feedback that helped me improve my skills.', 80, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (10, 3, 17, 16, 'The work environment was positive and supportive.', 42, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (35, 23, 37, 17, 'Working at the company was a great experience.', 8, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (19, 41, 21, 18, 'The workload was manageable and allowed for a good work-life balance.', 22, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (36, 8, 25, 19, 'The communication within the team was clear and efficient.', 49, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (28, 30, 11, 20, 'I appreciated the opportunities for professional growth and development.', 98, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (43, 20, 13, 21, 'I appreciated the opportunities for professional growth and development.', 80, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (6, 27, 10, 22, 'I had the chance to work on challenging and interesting projects.', 66, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (12, 6, 16, 23, 'I had the chance to work on challenging and interesting projects.', 17, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (42, 30, 40, 24, 'The workload was manageable and allowed for a good work-life balance.', 86, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (45, 8, 9, 25, 'The management team was effective in providing guidance and support.', 49, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (49, 27, 50, 26, 'The communication within the team was clear and efficient.', 17, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (38, 16, 50, 27, 'I appreciated the opportunities for professional growth and development.', 45, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (38, 40, 10, 28, 'I had the chance to work on challenging and interesting projects.', 70, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (15, 47, 11, 29, 'I appreciated the opportunities for professional growth and development.', 57, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (1, 14, 50, 30, 'The management team was effective in providing guidance and support.', 52, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (32, 9, 25, 31, 'I felt valued and recognized for my contributions.', 24, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (44, 37, 28, 32, 'I enjoyed collaborating with my colleagues on various projects.', 94, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (11, 10, 9, 33, 'The workload was manageable and allowed for a good work-life balance.', 70, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (41, 14, 13, 34, 'I received constructive feedback that helped me improve my skills.', 28, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (3, 9, 25, 35, 'I had the chance to work on challenging and interesting projects.', 6, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (44, 18, 32, 36, 'I had the chance to work on challenging and interesting projects.', 48, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (35, 18, 5, 37, 'The communication within the team was clear and efficient.', 82, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (34, 7, 47, 38, 'I received constructive feedback that helped me improve my skills.', 29, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (48, 22, 5, 39, 'I received constructive feedback that helped me improve my skills.', 71, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (4, 26, 46, 40, 'The work environment was positive and supportive.', 32, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (9, 47, 12, 41, 'The communication within the team was clear and efficient.', 63, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (34, 7, 45, 42, 'The communication within the team was clear and efficient.', 68, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (10, 6, 3, 43, 'I enjoyed collaborating with my colleagues on various projects.', 43, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (27, 27, 20, 44, 'I felt valued and recognized for my contributions.', 73, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (39, 16, 9, 45, 'I enjoyed collaborating with my colleagues on various projects.', 60, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (45, 28, 46, 46, 'I appreciated the opportunities for professional growth and development.', 70, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (43, 16, 35, 47, 'I had the chance to work on challenging and interesting projects.', 18, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (31, 31, 32, 48, 'The company culture fostered creativity and innovation.', 61, 'first');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (6, 12, 29, 49, 'The work environment was positive and supportive.', 81, 'second');
insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values (32, 2, 36, 50, 'I enjoyed collaborating with my colleagues on various projects.', 38, 'second');

insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (32, 1, 'Caz Coldridge', 'ccoldridge0@cam.ac.uk');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (41, 2, 'Hestia McWhin', 'hmcwhin1@tmall.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (11, 3, 'Redford Cutress', 'rcutress2@reddit.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (4, 4, 'Henrie Playden', 'hplayden3@omniture.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (2, 5, 'Murial Tapin', 'mtapin4@amazonaws.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (16, 6, 'Stephen Sharper', 'ssharper5@ameblo.jp');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (22, 7, 'Celinka Ruslin', 'cruslin6@wp.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (26, 8, 'Bran Linke', 'blinke7@chronoengine.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (26, 9, 'Fianna Cahillane', 'fcahillane8@about.me');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (25, 10, 'Doe Carpmile', 'dcarpmile9@oaic.gov.au');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (33, 11, 'Ranna Blackett', 'rblacketta@edublogs.org');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (44, 12, 'Hieronymus Pendlenton', 'hpendlentonb@ustream.tv');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (15, 13, 'Arney Plewright', 'aplewrightc@sun.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (12, 14, 'Dora Torbeck', 'dtorbeckd@ustream.tv');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (34, 15, 'Esme Cuff', 'ecuffe@globo.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (43, 16, 'Ester Kester', 'ekesterf@about.me');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (1, 17, 'Johnette Halleybone', 'jhalleyboneg@mac.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (16, 18, 'Kaleena Northall', 'knorthallh@geocities.jp');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (49, 19, 'Lannie Connichie', 'lconnichiei@thetimes.co.uk');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (39, 20, 'Willy Cecely', 'wcecelyj@imdb.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (33, 21, 'Nikola Bickerstaff', 'nbickerstaffk@buzzfeed.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (16, 22, 'Matthiew Kitchingman', 'mkitchingmanl@archive.org');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (48, 23, 'Petunia Sandaver', 'psandaverm@bandcamp.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (15, 24, 'Hendrika Walder', 'hwaldern@yahoo.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (39, 25, 'Gayel Haps', 'ghapso@ed.gov');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (31, 26, 'Yehudit Kulis', 'ykulisp@theglobeandmail.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (31, 27, 'Sterne Wiltshier', 'swiltshierq@tinyurl.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (11, 28, 'Shawn Blogg', 'sbloggr@unc.edu');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (7, 29, 'Durward Coleiro', 'dcoleiros@state.tx.us');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (17, 30, 'Holly Carnier', 'hcarniert@who.int');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (29, 31, 'Bradan Weathey', 'bweatheyu@icq.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (34, 32, 'Coop Burnup', 'cburnupv@devhub.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (34, 33, 'Hermine Romer', 'hromerw@wp.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (36, 34, 'Brennan Roskelley', 'broskelleyx@amazon.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (34, 35, 'Ulric Biskupiak', 'ubiskupiaky@seesaa.net');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (10, 36, 'Matthias Amaya', 'mamayaz@hp.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (38, 37, 'Beltran McGaffey', 'bmcgaffey10@archive.org');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (18, 38, 'Alfy Brookzie', 'abrookzie11@indiatimes.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (16, 39, 'Skip Canti', 'scanti12@sohu.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (6, 40, 'Kaile Malley', 'kmalley13@comsenz.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (48, 41, 'Lorrin Giraudou', 'lgiraudou14@multiply.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (11, 42, 'Consalve MacKonochie', 'cmackonochie15@surveymonkey.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (19, 43, 'Arabella Woof', 'awoof16@ameblo.jp');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (21, 44, 'Vikki Filipczynski', 'vfilipczynski17@disqus.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (19, 45, 'Oswald Dewberry', 'odewberry18@yahoo.co.jp');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (19, 46, 'Donetta Dubois', 'ddubois19@house.gov');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (13, 47, 'Tracey Furmedge', 'tfurmedge1a@archive.org');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (28, 48, 'Dorine Benaine', 'dbenaine1b@scribd.com');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (40, 49, 'Noreen Fitzjohn', 'nfitzjohn1c@senate.gov');
insert into Company_Representative (CompanyPageID, CompanyRepID, Name, Email) values (1, 50, 'Nady MacAlpyne', 'nmacalpyne1d@newyorker.com');

insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (44, 11, 1, 'Approved', '2023-01-27 22:09:53');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (42, 45, 2, 'Approved', '2023-06-24 16:10:07');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (24, 17, 3, 'Pending', '2023-01-07 00:28:12');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (41, 10, 4, 'Denied', '2022-11-28 21:17:50');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (37, 3, 5, 'Denied', '2023-11-14 08:25:03');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (10, 32, 6, 'Approved', '2022-12-11 21:03:41');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (50, 1, 7, 'Pending', '2023-02-19 00:34:57');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (14, 25, 8, 'Denied', '2023-11-07 01:40:11');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (12, 9, 9, 'Denied', '2023-09-10 15:48:04');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (36, 31, 10, 'Denied', '2023-07-10 14:06:58');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (44, 36, 11, 'Approved', '2023-06-22 19:56:21');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (4, 23, 12, 'Approved', '2023-02-20 12:49:35');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (23, 26, 13, 'Pending', '2023-06-21 21:29:09');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (5, 33, 14, 'Approved', '2023-07-02 03:35:21');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (1, 15, 15, 'Denied', '2023-08-20 19:41:05');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (28, 47, 16, 'Denied', '2023-07-03 02:57:19');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (28, 10, 17, 'Pending', '2023-11-21 09:54:56');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (20, 49, 18, 'Pending', '2023-04-12 04:52:15');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (42, 26, 19, 'Approved', '2023-10-09 05:02:48');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (41, 43, 20, 'Approved', '2023-02-07 21:17:23');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (34, 36, 21, 'Approved', '2022-12-31 03:52:55');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (28, 20, 22, 'Pending', '2023-11-06 09:13:14');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (47, 50, 23, 'Pending', '2023-06-07 12:55:35');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (10, 28, 24, 'Denied', '2023-10-06 09:38:31');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (23, 32, 25, 'Pending', '2023-07-24 08:23:50');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (34, 40, 26, 'Approved', '2023-09-28 09:47:35');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (34, 14, 27, 'Approved', '2023-01-25 15:50:32');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (33, 11, 28, 'Denied', '2023-11-11 15:59:13');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (34, 18, 29, 'Approved', '2023-07-10 11:18:13');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (28, 4, 30, 'Pending', '2023-09-30 00:22:35');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (37, 41, 31, 'Denied', '2023-10-25 07:01:01');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (9, 33, 32, 'Approved', '2023-01-18 22:12:05');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (8, 5, 33, 'Denied', '2023-02-21 03:51:21');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (24, 43, 34, 'Approved', '2023-09-24 20:26:35');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (11, 38, 35, 'Denied', '2023-03-29 13:51:41');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (6, 7, 36, 'Pending', '2023-11-03 08:43:51');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (36, 32, 37, 'Pending', '2022-12-06 00:01:02');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (5, 50, 38, 'Approved', '2022-12-19 17:50:53');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (20, 24, 39, 'Approved', '2023-10-26 12:31:57');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (50, 35, 40, 'Pending', '2023-02-03 16:10:53');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (14, 31, 41, 'Pending', '2023-06-22 05:51:13');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (30, 5, 42, 'Pending', '2022-12-17 17:28:39');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (43, 47, 43, 'Approved', '2023-10-04 07:11:07');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (41, 49, 44, 'Pending', '2023-09-05 00:44:55');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (23, 24, 45, 'Approved', '2023-11-08 22:13:28');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (41, 18, 46, 'Denied', '2022-12-06 19:17:29');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (24, 43, 47, 'Denied', '2023-07-14 23:08:26');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (30, 28, 48, 'Approved', '2023-06-27 00:22:45');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (31, 36, 49, 'Pending', '2023-05-26 19:32:43');
insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values (15, 47, 50, 'Pending', '2023-06-18 08:50:14');

insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (46, 49, 1, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-01-30 17:18:20');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (10, 28, 2, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-09-29 13:17:59');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (7, 8, 3, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-04-15 12:26:03');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (39, 6, 4, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-04-01 23:09:30');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (16, 43, 5, 'Thank you for reaching out to us. We appreciate your feedback.', '2023-08-06 14:34:24');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (36, 50, 6, 'We value your business and will do our best to assist you.', '2023-01-14 14:03:54');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (18, 18, 7, 'Thank you for reaching out to us. We appreciate your feedback.', '2023-05-10 05:01:52');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (50, 25, 8, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-02-07 20:36:37');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (16, 41, 9, 'We value your business and will do our best to assist you.', '2023-08-29 08:28:13');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (10, 6, 10, 'We value your business and will do our best to assist you.', '2023-07-02 23:34:56');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (39, 27, 11, 'Please let us know if there''s anything else we can help you with.', '2023-10-16 00:11:42');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (46, 20, 12, 'Please let us know if there''s anything else we can help you with.', '2023-02-14 22:42:39');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (7, 37, 13, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-08-09 23:51:30');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (15, 9, 14, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-08-20 08:35:03');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (13, 40, 15, 'Thank you for reaching out to us. We appreciate your feedback.', '2023-06-14 18:07:25');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (11, 30, 16, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-09-22 17:15:00');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (34, 31, 17, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-08-14 16:59:03');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (41, 2, 18, 'Thank you for reaching out to us. We appreciate your feedback.', '2022-12-30 00:35:35');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (2, 36, 19, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-04-20 13:30:45');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (34, 11, 20, 'We value your business and will do our best to assist you.', '2023-04-15 22:48:57');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (50, 35, 21, 'We value your business and will do our best to assist you.', '2023-04-14 20:47:41');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (16, 10, 22, 'We value your business and will do our best to assist you.', '2023-04-01 02:40:05');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (16, 32, 23, 'We value your business and will do our best to assist you.', '2023-07-30 11:21:31');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (23, 13, 24, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-01-23 19:41:11');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (41, 28, 25, 'Thank you for reaching out to us. We appreciate your feedback.', '2022-12-25 03:13:59');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (15, 15, 26, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2022-12-21 17:59:24');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (36, 20, 27, 'We value your business and will do our best to assist you.', '2022-12-05 14:59:05');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (31, 11, 28, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-07-10 15:31:22');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (46, 40, 29, 'Please let us know if there''s anything else we can help you with.', '2023-02-04 05:03:57');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (1, 3, 30, 'Please let us know if there''s anything else we can help you with.', '2023-02-06 20:56:36');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (21, 29, 31, 'We value your business and will do our best to assist you.', '2023-04-25 05:43:20');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (23, 43, 32, 'Thank you for reaching out to us. We appreciate your feedback.', '2022-12-31 21:42:03');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (25, 45, 33, 'Thank you for reaching out to us. We appreciate your feedback.', '2023-11-12 06:39:09');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (2, 42, 34, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-03-09 08:33:28');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (49, 47, 35, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-09-03 20:27:54');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (32, 43, 36, 'Thank you for reaching out to us. We appreciate your feedback.', '2023-03-02 17:49:02');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (46, 29, 37, 'Thank you for reaching out to us. We appreciate your feedback.', '2023-04-10 14:31:10');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (26, 42, 38, 'Please let us know if there''s anything else we can help you with.', '2023-07-07 03:29:19');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (20, 3, 39, 'Please let us know if there''s anything else we can help you with.', '2023-05-29 00:30:29');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (10, 45, 40, 'Thank you for reaching out to us. We appreciate your feedback.', '2023-09-17 16:24:18');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (33, 22, 41, 'Please let us know if there''s anything else we can help you with.', '2023-08-22 21:54:28');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (38, 4, 42, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-05-03 13:18:53');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (13, 39, 43, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-11-25 21:48:23');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (49, 35, 44, 'We apologize for any inconvenience caused. We are working to resolve the issue.', '2023-01-12 11:15:36');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (21, 9, 45, 'Thank you for reaching out to us. We appreciate your feedback.', '2023-04-23 02:00:28');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (19, 26, 46, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-02-04 14:55:17');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (20, 36, 47, 'We value your business and will do our best to assist you.', '2023-07-30 07:47:30');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (35, 33, 48, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-01-14 01:44:47');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (14, 46, 49, 'Your satisfaction is our top priority. We will address your concerns promptly.', '2023-09-26 04:13:57');
insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values (8, 6, 50, 'We value your business and will do our best to assist you.', '2023-11-19 22:11:07');

insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (16, 1, 'text/plain', 'entertainment', '2022-12-25 16:08:24');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (5, 2, 'application/xml', 'food', '2023-03-30 11:04:35');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (7, 3, 'image/png', 'business', '2023-06-22 14:35:21');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (36, 4, 'application/json', 'music', '2023-06-11 17:54:07');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (38, 5, 'image/jpeg', 'education', '2023-08-27 14:52:57');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (21, 6, 'image/png', 'business', '2023-07-13 10:10:38');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (48, 7, 'audio/mpeg', 'health', '2023-06-17 02:18:41');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (49, 8, 'application/pdf', 'business', '2022-12-20 17:19:16');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (26, 9, 'text/html', 'food', '2023-09-21 11:59:21');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (13, 10, 'audio/mpeg', 'music', '2023-04-17 13:09:39');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (37, 11, 'text/html', 'health', '2023-01-13 08:53:52');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (22, 12, 'application/pdf', 'food', '2023-07-03 12:18:46');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (47, 13, 'video/mp4', 'sports', '2023-09-23 07:44:12');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (41, 14, 'text/plain', 'education', '2023-05-28 15:06:54');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (13, 15, 'video/mp4', 'business', '2023-09-12 20:38:46');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (13, 16, 'text/html', 'technology', '2023-04-10 03:45:07');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (14, 17, 'application/xml', 'education', '2023-11-01 08:40:55');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (14, 18, 'text/plain', 'travel', '2023-02-02 11:39:54');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (16, 19, 'image/png', 'fashion', '2023-08-20 20:09:14');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (3, 20, 'application/json', 'fashion', '2023-08-09 19:22:13');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (4, 21, 'video/mp4', 'food', '2022-12-10 20:24:12');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (20, 22, 'audio/wav', 'business', '2023-11-17 21:32:59');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (26, 23, 'audio/wav', 'sports', '2023-04-01 08:19:04');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (28, 24, 'video/mp4', 'food', '2023-07-07 14:09:10');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (23, 25, 'image/png', 'sports', '2023-07-14 02:02:38');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (45, 26, 'audio/wav', 'technology', '2023-02-19 05:07:23');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (18, 27, 'audio/wav', 'education', '2022-12-05 05:59:25');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (48, 28, 'image/jpeg', 'sports', '2023-03-23 04:43:13');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (13, 29, 'audio/wav', 'travel', '2023-05-15 05:28:11');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (20, 30, 'image/png', 'food', '2023-10-29 14:31:04');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (12, 31, 'audio/wav', 'health', '2023-07-03 02:41:12');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (3, 32, 'text/plain', 'music', '2023-02-13 10:03:04');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (47, 33, 'text/plain', 'education', '2022-12-13 11:11:23');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (19, 34, 'video/mp4', 'entertainment', '2023-07-20 12:45:48');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (31, 35, 'application/xml', 'education', '2023-08-29 14:44:00');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (27, 36, 'application/xml', 'technology', '2022-12-14 08:50:52');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (35, 37, 'audio/mpeg', 'music', '2023-08-26 14:41:32');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (23, 38, 'image/jpeg', 'sports', '2023-10-14 13:32:26');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (47, 39, 'audio/mpeg', 'business', '2022-12-06 09:49:28');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (13, 40, 'image/png', 'fashion', '2023-04-07 12:34:27');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (24, 41, 'audio/mpeg', 'fashion', '2023-10-07 22:49:25');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (37, 42, 'text/plain', 'business', '2023-07-08 03:06:51');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (10, 43, 'audio/mpeg', 'sports', '2023-09-11 13:16:16');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (3, 44, 'application/pdf', 'health', '2023-04-07 10:45:33');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (32, 45, 'video/mp4', 'education', '2023-09-18 19:20:41');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (34, 46, 'text/plain', 'business', '2022-12-08 15:08:55');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (26, 47, 'text/html', 'education', '2023-09-05 15:58:11');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (29, 48, 'image/png', 'technology', '2023-11-21 02:00:41');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (45, 49, 'application/pdf', 'business', '2023-06-28 03:26:22');
insert into Company_Content (CompanyRepID, ContentID, ContentType, ContentData, PostDate) values (12, 50, 'application/pdf', 'fashion', '2023-08-02 04:05:06');

insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Financial Analyst', 140000, 'Marketing', 1);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Software Engineer', 100000, 'Part-time', 2);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Customer Service Representative', 130000, 'Internship', 3);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Product Manager', 140000, 'Sales', 4);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Human Resources Coordinator', 70000, 'Finance', 5);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Sales Representative', 140000, 'Customer service', 6);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Operations Manager', 60000, 'Entry level', 7);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Software Engineer', 70000, 'Sales', 8);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Product Manager', 130000, 'Sales', 9);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Financial Analyst', 80000, 'Full-time', 10);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Software Engineer', 50000, 'Internship', 11);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Marketing Specialist', 100000, 'Sales', 12);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Software Engineer', 140000, 'Software development', 13);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Financial Analyst', 70000, 'Software development', 14);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Financial Analyst', 80000, 'Marketing', 15);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Operations Manager', 90000, 'Sales', 16);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Marketing Specialist', 80000, 'Full-time', 17);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Customer Service Representative', 90000, 'Remote', 18);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Sales Representative', 60000, 'Finance', 19);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Sales Representative', 50000, 'Full-time', 20);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Sales Representative', 140000, 'Entry level', 21);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Graphic Designer', 50000, 'Full-time', 22);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Financial Analyst', 130000, 'Finance', 23);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Sales Representative', 90000, 'Part-time', 24);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Human Resources Coordinator', 110000, 'Part-time', 25);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Marketing Specialist', 70000, 'Customer service', 26);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Human Resources Coordinator', 140000, 'Software development', 27);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Product Manager', 50000, 'Entry level', 28);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Data Analyst', 100000, 'Full-time', 29);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Graphic Designer', 60000, 'Part-time', 30);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Marketing Specialist', 50000, 'Full-time', 31);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Financial Analyst', 70000, 'Part-time', 32);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Financial Analyst', 50000, 'Marketing', 33);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Data Analyst', 70000, 'Customer service', 34);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Data Analyst', 90000, 'Customer service', 35);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Human Resources Coordinator', 70000, 'Remote', 36);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Operations Manager', 130000, 'Finance', 37);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Financial Analyst', 50000, 'Customer service', 38);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Customer Service Representative', 70000, 'Marketing', 39);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Data Analyst', 140000, 'Marketing', 40);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Sales Representative', 130000, 'Part-time', 41);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Sales Representative', 140000, 'Internship', 42);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Product Manager', 110000, 'Part-time', 43);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Marketing Specialist', 130000, 'Internship', 44);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Operations Manager', 90000, 'Marketing', 45);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Human Resources Coordinator', 130000, 'Sales', 46);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Operations Manager', 70000, 'Customer service', 47);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Marketing Specialist', 140000, 'Internship', 48);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Marketing Specialist', 90000, 'Software development', 49);
insert into Compensation_Data (PositionType, AverageSalary, FilterCriteria, CompanypageID) values ('Human Resources Coordinator', 100000, 'Part-time', 50);