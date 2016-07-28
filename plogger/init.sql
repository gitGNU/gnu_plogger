-- Plogger - Time tracking software
-- Copyright (C) 2010 Romel Raul Sandoval Palomo
--
-- This program is free software; you can redistribute it and/or    
-- modify it under the terms of the GNU General Public License as   
-- published by the Free Software Foundation; either version 3 of   
-- the License, or (at your option) any later version.              
--                                                                  
-- This program is distributed in the hope that it will be useful,  
-- but WITHOUT ANY WARRANTY; without even the implied warranty of   
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the    
-- GNU General Public License for more details.                     
--                                                                  
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, contact:
--
-- Free Software Foundation           Voice:  +1-617-542-5942
-- 59 Temple Place - Suite 330        Fax:    +1-617-542-2652
-- Boston, MA  02111-1307,  USA       gnu@gnu.org
------------------------------------------------------------------------------

-- Semicolon below was added to facilitate delimited text reading from scheme.
-- ;

create table projects (
       id integer primary key, 
       project varchar(32) unique
);

create table tasks (
       id integer primary key,
       description varchar(200),
       progress decimal(3,2) default 0.0,
       project_id integer,
       foreign key(project_id) references projects(id)
);

create table tag_groups (
       id integer primary key, 
       tag_group varchar(32) unique
);

create table tags (
       id integer primary key,
       tag varchar(32) unique,
       tag_group_id integer,
       foreign key(tag_group_id) references tag_groups(id)
);

create table task_has_tags (
       task_id integer,
       tag_id integer,
       foreign key(task_id) references tasks(id),
       foreign key(tag_id) references tags(id)
);

create table remote_systems (
       id integer primary key,
       "name" varchar(32),
       url varchar(255)
);

create table remote_task_ids (
       id varchar(32) primary key,
       task_id integer,
       remote_system_id integer not null,
       foreign key(task_id) references tasks(id),
       foreign key(remote_system_id) references remote_systems(id)_
);

create table units (
       id integer primary key,
       singular varchar(32) unique,
       plural varchar(36) unique
);

create table task_has_units (
       task_id integer not null,
       unit_id integer not null,
       quantity integer,
       foreign key (task_id) references tasks(id),
       foreign key (unit_id) references units(id),
);

create table activities (
       id integer primary key,
       start_time timestamp default current_timestamp,
       end_time timestamp,
       comment varchar(1024),
       task_id integer,
       foreign key(task_id) references tasks(id),
);
