-- Prodcut Table  

CREATE TABLE products (
  
  id int not null  auto_increment, 
  p_name varchar(400) not null,
  p_price integer not null,
  primary key(id)
);


INSERT INTO products (p_name, p_price) values
    ("iphone", 20000),
    ("camera", 30000),
    ("laptop", 50000),
    ("cricket_bat", 200),
    ("cricket_ball", 50),
    ("headphones", 500),
    ("earphones", 522);


CREATE TABLE stocks (
  
  p_id int not null, 
  p_quantity integer not null,
  p_added_date date,
  foreign key(p_id) references products(id)
);


INSERT INTO stocks (p_id, p_quantity, p_added_date) values
    (1, 3, now()),
    (2, 4, now()),
    (3, 5, now()),
    (4, 333, now()),
    (5, 2222, now()),
    (6, 53, now()),
    (7, 10000, now());
    
    
    
CREATE TABLE sales (
  sales_p_name varchar(1000) not null,
  sales_p_id int not null, 
  sales_p_quantity integer not null,
  sales_p_total_price integer not null,
  foreign key(sales_p_id) references products(id)
);


delimiter $$

create procedure product_value_updation(product_name_from_frontend varchar(10000), q_of_product integer)

begin 

declare product_id_of_frontend integer;
declare product_price float;
declare product_quantity_of_frontend integer;


select id, p_price into product_id_of_frontend, product_price from products where p_name = product_name_from_frontend; 
select p_quantity into product_quantity_of_frontend from stocks where product_id_of_frontend = p_id;

if product_quantity_of_frontend >= q_of_product then 
    update stocks set p_quantity = (p_quantity - 1) where p_id = product_id_of_frontend; 
    insert into sales (sales_p_name, sales_p_id, sales_p_quantity, sales_p_total_price) 
    values (
    
      product_name_from_frontend,
      product_id_of_frontend,
      q_of_product,
      q_of_product * product_price
    );

else 
  select "Number of stock is not available";
  
end if;


end$$

call product_value_updation("iphone", 1);
call product_value_updation("cricket_ball", 1);

select * from sales;
















