#question 1. 
select customer_name as 'Customer Name', customer_segment as 'Customer Segment' from superstore.cust_dimen;


# question 2. 
select * from superstore.cust_dimen order by Cust_id desc;


# question 3. 
select order_id, order_date from superstore.orders_dimen where order_priority = 'HIGH';


# question 4. 
select sum(sales) as total_sales, avg(sales) as avg_sales from superstore.market_fact;


# question 5.
select max(sales), min(sales) from superstore.market_fact;


# question 6. 
select region, count(cust_id) as no_of_customers from superstore.cust_dimen group by region order by count(cust_id);


# question 7. 
select region, count(cust_id) as no_of_customers from superstore.cust_dimen group by region order by count(cust_id) desc limit 1;


# question 8.
select c.Customer_Name as 'Customer Name', sum(m.order_quantity) as no_of_tables_purchased from superstore.market_fact as m join superstore.cust_dimen as c on m.cust_id = c.cust_id 
join superstore.prod_dimen as p on m.prod_id = p.prod_id
where c.region = 'Atlantic' and p.Product_Sub_Category = 'Tables'
group by c.customer_name
order by sum(m.order_quantity) desc;


# question 9. 
select customer_name, count(cust_id) as 'no of small business owner' from superstore.cust_dimen 
where region = 'Ontario' and customer_segment = 'small business' 
group by customer_name;


# question 10. 
select prod_id, sum(order_quantity) as no_of_products_sold from superstore.market_fact group by prod_id order by sum(order_quantity) desc;


# question 11. 
select prod_id, product_sub_category from superstore.prod_dimen where product_category = 'furniture' or product_category = 'technology';


# question 12. 
select p.product_category as product_category, round(sum(m.profit),2) as profits from superstore.market_fact as m 
join superstore.prod_dimen as p on m.prod_id = p.prod_id 
group by p.product_category
order by sum(m.profit) desc;


# question 13. 
select p.product_category as product_category, p.product_sub_category as sub_category, round(sum(m.profit),2) as profits from superstore.market_fact as m
join superstore.prod_dimen as p on m.prod_id = p.prod_id
group by p.product_sub_category
order by p.product_category;


# question 14. 
select o.order_date, m.order_quantity, m.sales from superstore.market_fact as m join superstore.orders_dimen as o on m.ord_id = o.ord_id order by o.order_date;


# question 15. 
select customer_name from superstore.cust_dimen where instr(customer_name, 'r') = 2 and instr(customer_name, 'd') = 4;


# question 16. 
select m.cust_id as cust_id, m.sales as sales, c.customer_name as customer_name, c.region as region from superstore.market_fact as m
join superstore.cust_dimen as c on m.cust_id = c.cust_id
where m.sales between 1000 and 5000;


# question 17. 
select * from(select sales, dense_rank() over(order by sales desc) as r from superstore.market_fact) sub where r = 3;


# question 18. 
select c.region as region, count(m.ship_id) as no_of_shipments, round(sum(m.profit),2) as profit from superstore.market_fact as m
join superstore.cust_dimen as c on m.cust_id = c.cust_id 
join superstore.prod_dimen as p on m.prod_id = p.prod_id
where 	product_sub_category = (select p.product_sub_category 
								from superstore.market_fact as m
									join superstore.prod_dimen as p on m.prod_id = p.prod_id
                                    group by product_sub_category
                                    order by sum(m.profit)
                                    limit 1)
group by c.region
order by sum(m.profit);