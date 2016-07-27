-- Plogger - Time tracking software
-- Copyright (C) 2010 Romel Raúl Sandoval-Palomo
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
       title varchar(32) unique
);

create table phases (
       id integer primary key, 
       title varchar(32) unique
);

create table task_types (
       id integer primary key,
       title varchar(32) unique
);

create table tasks (
       id integer primary key,
       title varchar(32),
       progress decimal(3,2) default 0.0,
       type_id integer,
       project_id integer,
       foreign key(type_id) references task_types(id),
       foreign key(project_id) references projects(id)
);

create table activities (
       id integer primary key,
       start_time timestamp default current_timestamp,
       end_time timestamp,
       comment varchar(1024),
       task_id integer,
       phase_id integer,
       foreign key(task_id) references tasks(id),
       foreign key(phase_id) references phases(id)
);

create table interruptions(
       id integer primary key,
       start_time timestamp default current_timestamp,
       end_time timestamp,
       comment varchar(1024),
       activity_id integer,
       foreign key(activity_id) references activities(id)
);
