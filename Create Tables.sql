create table IMDb_Movie
	(imdb_title_id		varchar(15),
	 title		varchar(500),
	 year		numeric(4,0),
	 duration	numeric,
	 director	varchar(500),
	 writer		varchar(500),
	 production_company		varchar(500),
	 actors		varchar(500),
	 description	varchar(500),
	 metascore	numeric,
	 primary key (imdb_title_id)
	);

create table Genre
	(imdb_title_id		varchar(15),
	 genre				varchar(500),
	 primary key (imdb_title_id, genre),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);
	
create table Language
	(imdb_title_id		varchar(15),
	 language			varchar(500),
	 primary key (imdb_title_id, language),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);

create table Country
	(imdb_title_id		varchar(15),
	 country			varchar(500),
	 primary key (imdb_title_id, country),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);

create table Original_Title
	(imdb_title_id		varchar(15),
	 original_title		varchar(500),
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);
	
create table Publish_Date
	(imdb_title_id		varchar(15),
	 date_published		varchar(500),
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);
	
create table Vote
	(imdb_title_id		varchar(15),
	 avg_vote		numeric,
	 votes			numeric,
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);

create table Financial_Statement
	(imdb_title_id		varchar(15),
	 budget				varchar(20),
	 usa_gross_income			varchar(20),
	 worldwide_gross_income		varchar(20),
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);

create table Reviews
	(imdb_title_id		varchar(15),
	 reviews_from_users		numeric,
	 reviews_from_critics			numeric,
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);

create table Cast_Information
	(imdb_name_id		varchar(15),
	 name		varchar(500),
	 height			numeric,
	 bio		text,
	 primary key (imdb_name_id)
	);
	
create table Cast_Birth_Name
	(imdb_name_id		varchar(15),
	 birth_name		varchar(500),
	 primary key (imdb_name_id),
	 foreign key (imdb_name_id) references Cast_Information (imdb_name_id)
	);
	
create table Cast_Birth_and_Death_Detail
	(imdb_name_id		varchar(15),
	 birth_details		varchar(500),
	 date_of_birth		varchar(500),
	 place_of_birth		varchar(500),
	 death_details		varchar(500),
	 date_of_death		varchar(500),
	 place_of_death		varchar(500),
	 reason_of_death	varchar(500),
	 primary key (imdb_name_id),
	 foreign key (imdb_name_id) references Cast_Information (imdb_name_id)
	);

create table Cast_Spouses_Detail
	(imdb_name_id		varchar(15),
	 spouses_string		text,
	 spouses			varchar(550),
	 divorces			varchar(500),
	 spouses_with_children		varchar(50),
	 children		varchar(50),
	 primary key (imdb_name_id),
	 foreign key (imdb_name_id) references Cast_Information (imdb_name_id)
	);

create table Title_Principals
	(imdb_title_id		varchar(15),
	 imdb_name_id		varchar(500),
	 ordering			numeric,
	 category			varchar(500),
	 job				varchar(500),
	 characters			varchar(500),
	 primary key (imdb_title_id, imdb_name_id,ordering),
	 foreign key (imdb_name_id) references Cast_Information (imdb_name_id),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);

create table Vote_Overall
	(imdb_title_id		varchar(15),
	 weighted_average_vote		numeric,
	 total_votes		numeric,
	 mean_vote			numeric,
	 median_vote		numeric,
	 top1000_voters_rating		numeric,
	 top1000_voters_votes		numeric,
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references IMDb_Movie (imdb_title_id)
	);

create table Vote_All_Rating
	(imdb_title_id		varchar(15),
	 votes_10		numeric,
	 votes_9		numeric,
	 votes_8		numeric,
	 votes_7		numeric,
	 votes_6		numeric,
	 votes_5		numeric,
	 votes_4		numeric,
	 votes_3		numeric,
	 votes_2		numeric,
	 votes_1		numeric,
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references Vote_Overall (imdb_title_id)
	);

create table Vote_All_Gender
	(imdb_title_id		varchar(15),
	 allgenders_0age_avg_vote		numeric,
	 allgenders_0age_votes			numeric,
	 allgenders_18age_avg_vote		numeric,
	 allgenders_18age_votes			numeric,
	 allgenders_30age_avg_vote		numeric,
	 allgenders_30age_votes			numeric,
	 allgenders_45age_avg_vote		numeric,
	 allgenders_45age_votes			numeric,
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references Vote_Overall (imdb_title_id)
	);

create table Vote_Male
	(imdb_title_id		varchar(15),
	 males_allages_avg_vote		numeric,
	 males_allages_votes		numeric,
	 males_0age_avg_vote		numeric,
	 males_0age_votes			numeric,
	 males_18age_avg_vote		numeric,
	 males_18age_votes			numeric,
	 males_30age_avg_vote		numeric,
	 males_30age_votes			numeric,
	 males_45age_avg_vote		numeric,
	 males_45age_votes			numeric,
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references Vote_Overall (imdb_title_id)
	);

create table Vote_Female
	(imdb_title_id		varchar(15),
	 females_allages_avg_vote		numeric,
	 females_allages_votes			numeric,
	 females_0age_avg_vote			numeric,
	 females_0age_votes			numeric,
	 females_18age_avg_vote		numeric,
	 females_18age_votes			numeric,
	 females_30age_avg_vote		numeric,
	 females_30age_votes			numeric,
	 females_45age_avg_vote		numeric,
	 females_45age_votes			numeric,
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references Vote_Overall (imdb_title_id)
	);

create table Vote_Region
	(imdb_title_id		varchar(15),
	 us_voters_rating		numeric,
	 us_voters_votes			numeric,
	 non_us_voters_rating			numeric,
	 non_us_voters_votes			numeric,
	 primary key (imdb_title_id),
	 foreign key (imdb_title_id) references Vote_Overall (imdb_title_id)
	);




drop table Original_Title;
drop table Genre;
drop table Language;
drop table Country;
drop table Publish_Date;
drop table Vote;
drop table Financial_Statement;
drop table Reviews;
drop table Vote_All_Rating;
drop table Vote_All_Gender;
drop table Vote_Male;
drop table Vote_Female;
drop table Vote_Region;
drop table Vote_Overall;
drop table Cast_Birth_Name;
drop table Cast_Birth_and_Death_Detail;
drop table Cast_Spouses_Detail;
drop table Title_Principals;
drop table Cast_Information;
drop table IMDb_Movie;
