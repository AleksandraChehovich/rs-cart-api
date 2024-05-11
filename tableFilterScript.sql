-- drop table users;

create extension if not exists "uuid-ossp";

create table if not exists users (
   id uuid not null default uuid_generate_v4() primary key,
  	name text not null,
  	password text not null,
	email text not null
);
create table if not exists carts (
   id uuid not null default uuid_generate_v4() primary key,
   user_id uuid references users(id) on delete cascade,
   created_at date not null,
   updated_at date not null,
   status text not null check (status IN ('OPEN', 'ORDERED'))
);

create table if not exists products (
	id uuid not null default uuid_generate_v4() primary key,
 	title text not null,
 	description text not null,
 	price integer not null
);

create table if not exists cart_items (
   id uuid not null default uuid_generate_v4() primary key,
   count integer not null,
   cart_id uuid references carts(id) ON DELETE CASCADE,
   product_id uuid references products(id) ON DELETE CASCADE
);

create table if not exists orders (
   id uuid not null default uuid_generate_v4() primary key,
   user_id uuid references users(id) on delete cascade,
   cart_id uuid not null references carts(id),
   payment JSON not null,
   delivery JSON not null,
   comments text,
   status text not null,
   total integer not null
);

insert into users (id, name, password, email) values ('b70cccf7-ffba-44fb-bddd-fe0fcccaa64c', 'user1', 'password1', 'email1@email.com'),
('e8045a90-3336-416c-9073-4cf38d98c8c1', 'user2', 'password2', 'email2@email.com'),
('f2c03422-9235-4d89-84af-2bd7bf4b05a9', 'user3', 'password3', 'email3@email.com');

insert into products (id, title, description, price) values ('16f253b4-41e3-40e4-8ab4-fa1b6a80cc55', 'test-title3-csv', 'test-description3-csv', 250),
('e78316f5-8c75-4adc-bf22-c5382f406724', 'test-title2-scv', 'test-description2-scv', 100),
('eb970f50-0a1e-47b8-9108-e5ecb5fefe99', 'test-title-scv', 'test-description-scv', 200),
('f36a33c1-0a7a-4281-9a97-1dd96d55ff79', 'title-scv', 'title-scv', 600);

insert into carts (id, user_id, created_at, updated_at, status) values ('7ce737ae-bf2e-462e-a9ae-83f52f7a7543', 'b70cccf7-ffba-44fb-bddd-fe0fcccaa64c', '2023-03-26 06:08:03', '2023-03-26 06:48:31', 'OPEN' ),
   ('a4fe6ac4-89a2-48a9-91a1-97899adbccb7', 'e8045a90-3336-416c-9073-4cf38d98c8c1', '2023-01-25 19:30:43', '2023-01-25 19:30:43', 'OPEN' ),
   ('9caf36a1-f7ac-4c4d-ac25-8c6cf7c9e41b', 'f2c03422-9235-4d89-84af-2bd7bf4b05a9', '2023-01-18 02:36:12', '2023-01-18 04:36:02', 'OPEN');

insert into cart_items (id, cart_id, product_id, count) values ('e9d39f9b-5f3d-4450-ba46-0132b2c4945a', '7ce737ae-bf2e-462e-a9ae-83f52f7a7543', '16f253b4-41e3-40e4-8ab4-fa1b6a80cc55', 1),
   ('8530841f-5d42-4cba-90b4-2ad2cbd378ad', 'a4fe6ac4-89a2-48a9-91a1-97899adbccb7', 'e78316f5-8c75-4adc-bf22-c5382f406724', 2),
   ('a4bc4231-32e3-4125-918e-d037d42d15e6', '9caf36a1-f7ac-4c4d-ac25-8c6cf7c9e41b', 'eb970f50-0a1e-47b8-9108-e5ecb5fefe99', 2);