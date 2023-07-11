create or replace procedure create_user(
  adhaar_id in int,
  user_name in varchar(50),
  user_password in varchar(30),
  age in int,
  phone_number in char(10),
  user_sex in char(1),
  state in varchar(50),
  street in varchar(50),
  door_no in int,
  pincode in int,
  city in varchar(50)) as
begin
insert into user values (adhaar_id, user_name, user_password, age, phone_number, user_sex, state, street, door_no, pincode, city);
end;
/

create or replace procedure create_site_user (u_id in int, last_login in datetime) as
begin
insert into site_user values (u_id, last_login);
end;
/

create or replace procedure create_manager (u_id in int, rating in float, salary in int) as
begin
insert into manager values (u_id, rating, salary);
end;
/

create or replace procedure create_customer (su_id in int, reward_pts in int) as
begin
insert into customer values (su_id, reward_pts);
end;
/

create or replace procedure create_owner (c_id in int, min_rent in int) as
begin
insert into owner values (c_id, min_rent);
end;
/

create or replace procedure create_tenant (c_id in int, t_rating in float, mar_status in char(1)) as
begin
insert into tenant values (c_id, t_rating, mar_status);
end;
/

create sequence property_id_seq start with 1;

create or replace procedure create_property (
  plinth_area in float,
  total_area in float,
  no_of_floors in int,
  year_of_construction in int,
  address in varchar(50)) as
begin
insert into property values (property_id_seq.nextval, plinth_area, total_area, no_of_floors, year_of_construction, address);
end;
/

create or replace procedure create_residential (
  plinth_area in float,
  total_area in float,
  no_of_floors in int,
  year_of_construction in int,
  address in varchar(50),
  no_of_bedrooms in int ,
  residential_property_type in char(1) ,
  gym in boolean,
  parking_space in boolean,
  swimming_pool in boolean) as
n number;
begin
  n := property_id_seq.nextval;
  create_property(n, plinth_area, total_area, no_of_floors, year_of_construction, address);
  insert into residential_property values (n, no_of_bedrooms, residential_property_type, gym, parking_space, swimming_pool);
end;
/

create or replace procedure create_commercial (
  plinth_area in float,
  total_area in float,
  no_of_floors in int,
  year_of_construction in int,
  address in varchar(50),
  business_type in varchar(10),
  commercial_property_type in char(1),
  prebuild_infrastructure in varchar(50),
  nearest_distribution_centre in varchar(50),
  storage_capacity in int)
n number;
begin
  n := property_id_seq.nextval;
  create_property(n, plinth_area, total_area, no_of_floors, year_of_construction, address);
  insert into commercial_property values (n, business_type, commercial_property_type, prebuild_infrastructure, nearest_distribution_centre, storage_capacity);
end;
/