drop table if exists accounts;
drop table if exists Price_Audits;
drop table if exists price;

CREATE TABLE IF NOT EXISTS accounts (
    id int generated by default as identity,
    name varchar(100) not null,
    balance dec(15,2) not null,
    primary key(id)
);
CREATE TABLE IF NOT EXISTS Price_Audits (
   book_id INT NOT NULL,
    entry_date text NOT NULL
);

create TABLE IF NOT EXISTS price(
	id INT not null,
	price integer not null 
);

create or replace procedure transfer(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;$$



CREATE OR REPLACE FUNCTION Func_Test ()
RETURNS integer AS $test$
declare
test integer;
BEGIN
SELECT count (1) into test FROM public.accounts;
RETURN test;
END;
$test$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION auditfunc() RETURNS TRIGGER AS $my_table$
   BEGIN
      INSERT INTO Price_Audits(book_id, entry_date) VALUES (new.ID, current_timestamp);
      RETURN NEW;
   END;
$my_table$ LANGUAGE plpgsql;

CREATE TRIGGER price_trigger AFTER INSERT ON Price
FOR EACH ROW EXECUTE PROCEDURE auditfunc();


INSERT INTO Price 
VALUES (3, 400);

insert into accounts(name,balance)
values('Bob',10000);

insert into accounts(name,balance)
values('Alice',10000);

