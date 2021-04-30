USE VaccineDB;

INSERT Patient VALUES
('2003721021','Mars Aries','Mars Lane 1'),
('2007959041','Thor Hammer','Mjollnir Parken 420'),
('1901201213','Diogenes Plankton','Olympensvej 3'),
('0512931519','Spongebob Squarepants', 'Godtgemt 52'),
('0808851214','Afrodite Love', 'Spurgt 12');

INSERT Location VALUES
('Copenhagen','Jagtvej 25'),
('Naksskov','Frederiksvej 12'),
('Odense','Fedgade 15'),
('Aarhus','Langtvæk 123'),
('Horsens','Dabdabvej 69');

INSERT Vaccine VALUES
('divoc',50.00),
('blast3000',22.50),
('aspera',99.50),
('covaxx',25.00);

INSERT Employee VALUES
('1','Dwight Schute','Doctor','50000'),
('2','Jim Halpert','Nurse','20000'),
('3','Michael Scott','Laborant','25000'),
('4','Pam Beasly','Surgeon','55000'),
('5','Andy Bernard','Doctor','35000');

INSERT Schedules VALUES
('1','2021-01-25','120000','190000'),
('2','2021-03-06','080000','220000'),
('3','2021-05-28','090000','150000'),
('4','2021-12-08','100000','160000'),
('5','2021-08-10','120000','220000');

INSERT Certification VALUES
('1','2020-03-22','120000','divoc','4'),
('2','2020-04-02','080000','blast3000','3'),
('3','2020-12-07','090000','aspera','2'),
('4','2020-05-03','100000','aspera','1'),
('5','2020-08-17','120000','covaxx','5');

INSERT Appointment VALUES
('1','2003721021','Copenhagen','Jagtvej 25','2021-01-25','150000'),
('2','2007959041','Naksskov','Frederiksvej 12','2021-03-06','120000'),
('3','1901201213','Odense','Fedgade 15','2021-05-28','133000'),
('4','0512931519','Aarhus','Langtvæk 123','2021-12-08','140000'),
('5','0808851214','Horsens','Dabdabvej 69','2021-08-10','151500');

INSERT Vaccination VALUES
('1','2021-01-25','153000','2003721021','aspera','1'),
('2','2021-03-06','130000','2007959041','aspera','2'),
('3','2021-05-28','140000','1901201213','blast3000','3'),
('4','2021-12-08','143000','0512931519','divoc','4'),
('5','2021-08-10','160000','0808851214','covaxx','5');

INSERT Storages VALUES
('Copenhagen','Jagtvej 25','aspera','10000'),
('Naksskov','Frederiksvej 12','aspera','50000'),
('Odense','Fedgade 15','blast3000','100000'),
('Aarhus','Langtvæk 123','divoc','5000'),
('Horsens','Dabdabvej 69','covaxx','15050');

INSERT Works VALUES
('1','1','Copenhagen','Jagtvej 25'),
('2','2','Naksskov','Frederiksvej 12'),
('3','3','Odense','Fedgade 15'),
('4','4','Aarhus','Langtvæk 123'),
('5','5','Horsens','Dabdabvej 69');

