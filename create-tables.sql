create table if not exists user (
	adhaar_id int primary key,
    user_name varchar(50),
    user_password varchar(30),
    age int,
    phone_number char(10),
    user_sex char(1),
    state varchar(50),
    street varchar(50),
    door_no int,
    pincode int,
    city varchar(50)
);

create table if not exists superuser (
	super_user_id int primary key,
    supervision_duration_start_mins int, -- Duration in minutes 
    foreign key (super_user_id) references user(adhaar_id)
);

create table if not exists site_user (
	site_user_id int primary key,
    last_login datetime,
    foreign key (site_user_id) references user(adhaar_id)
); 

create table if not exists manager (
	manager_id int primary key,
    rating float,
    salary int,
    foreign key (manager_id) references site_user(site_user_id)
);

create table if not exists customer (
	customer_id int primary key,
    reward_points int,
    foreign key (customer_id) references site_user(site_user_id)
);

create table if not exists owner (
	owner_id int primary key,
    min_expected_rent int,
    foreign key (owner_id) references customer(customer_id)
);

create table if not exists tenant (
	tenant_id int primary key,
    tenant_rating float,
    marital_status char(1),
    foreign key (tenant_id) references customer(customer_id)
);

-- create table if not exists currently_rented (
-- 	tenant_id int primary key,
--     agency_commission int,
--     yearly_hike float,
--     exp_duration_start date,
--     exp_duration_end date,
--     rent_per_month int,
--     foreign key (tenant_id) references tenant(tenant_id)
-- );

create table if not exists property (
    pid int primary key,
    plinth_area float,
    total_area float,
    no_of_floors int,
    year_of_construction int,
    address varchar(50)
);

create table if not exists residential_property (
    residential_id int primary key,
    no_of_bedrooms int not null,
    residential_property_type char(1) not null,
    gym boolean,
    parking_space boolean,
    swimming_pool boolean
);

create table if not exists commercial_property (
    commercial_id int primary key,
    business_type varchar(10),
    commercial_property_type char(1) not null,
    prebuild_infrastructure varchar(50),
    nearest_distribution_centre varchar(50),
    storage_capacity int
);

create table if not exists owned_by (
	owner_id int,
    property_id int,
    foreign key (owner_id) references owner(owner_id),
    foreign key (property_id) references property(pid)
);

create table if not exists action_history (
	user_id int,
    action_timestamp int,
    action_performed varchar(30),
    primary key (user_id, action_timestamp),
    foreign key (user_id) references user(adhaar_id)
);

create table if not exists previously_rented (
    property_id int,
    tenant_id int,
    duration_start_date date,
    duration_end_date date,
    rent_per_month int,
    yearly_hike float,
    foreign key (property_id) references property(pid),
    foreign key (tenant_id) references tenant(tenant_id)
);

alter table previously_rented add constraint previously_rented_pk primary key (property_id, tenant_id);

create table if not exists currently_rented (
    tenant_id int primary key,
    property_id int,
    exp_duration_start_date date,
    exp_duration_end_date date,
    rent_per_month int,
    yearly_hike float,
    agency_commission float,
    foreign key (property_id) references property(pid),
    foreign key (tenant_id) references tenant(tenant_id)
);