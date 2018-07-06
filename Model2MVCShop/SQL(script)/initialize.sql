
DROP TABLE notice; 
DROP TABLE cart;
DROP TABLE transaction;
DROP TABLE product;
DROP TABLE users;
DROP TABLE reply;

DROP SEQUENCE seq_product_prod_no;
DROP SEQUENCE seq_transaction_tran_no;
DROP SEQUENCE seq_cart_cart_no;
DROP SEQUENCE seq_notice_notice_no; 
DROP SEQUENCE seq_reply_reply_no; 
DROP SEQUENCE seq_park_parkNo;

CREATE SEQUENCE seq_product_prod_no	 	INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_transaction_tran_no	 INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_cart_cart_no   INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_notice_notice_no INCREMENT BY 1 START WITH 10000; 
CREATE SEQUENCE seq_reply_reply_no INCREMENT BY 1 START WITH 10000; 

CREATE TABLE users ( 
	user_id 			VARCHAR2(20)		NOT NULL,
	user_name 	VARCHAR2(50)		NOT NULL,
	password 		VARCHAR2(10)		NOT NULL,
	role 				VARCHAR2(5) 		DEFAULT 'user',
	ssn 					VARCHAR2(13),
	cell_phone	 VARCHAR2(14),
	addr 				VARCHAR2(100),
	email 				VARCHAR2(50),
	reg_date 		DATE,
	lat                    VARCHAR2(30),
	lng                   VARCHAR2(30),
	PRIMARY KEY(user_id)
);


CREATE TABLE product ( 
	prod_no 					NUMBER 				NOT NULL,
	prod_name 				VARCHAR2(100) 	NOT NULL,
	prod_detail 				VARCHAR2(200),
	manufacture_day	    VARCHAR2(8),
	price 							NUMBER(10),
	image_file 					VARCHAR2(100),
	reg_date 					DATE,
	prod_quantity         NUMBER 				NOT NULL,
	PRIMARY KEY(prod_no)
);

CREATE TABLE transaction ( 
	tran_no 						NUMBER 			NOT NULL,
	prod_no 					NUMBER(16)		NOT NULL REFERENCES product(prod_no),
	buyer_id 					VARCHAR2(20)	NOT NULL REFERENCES users(user_id),
	payment_option		 CHAR(3),
	receiver_name 		 VARCHAR2(20),
	receiver_phone		 VARCHAR2(14),
	demailaddr 				 VARCHAR2(100),
	dlvy_request 			 VARCHAR2(100),
	tran_status_code	 CHAR(3),
	order_data 				 DATE,
	dlvy_date 				 DATE,
	purchase_quantity 			NUMBER 		  NOT NULL,
	purchase_price 		NUMBER 				NOT NULL,
	purchase_cancel 	VARCHAR2(5) 	NOT NULL,
	star				   			    NUMBER,
	review 			            VARCHAR2(100),
	lat                               VARCHAR2(30),
	lng                              VARCHAR2(30),
	PRIMARY KEY(tran_no)
);


CREATE TABLE cart (
	cart_no 					 NUMBER 			 NOT NULL,
	prod_no 				 NUMBER(16)		 NOT NULL REFERENCES product(prod_no),
	buyer_id     			 VARCHAR2(20)	 NOT NULL REFERENCES users(user_id),
	cart_price				 NUMBER              DEFAULT 0,
	cart_prodQuantity	 NUMBER			  NOT NULL,
	reg_date				 DATE,
	prod_name            VARCHAR2(100) 	NOT NULL,
	prod_price          NUMBER(20)   NOT NULL,
	sumPrice				 NUMBER,
	cartCancel 			VARCHAR2(5) 	DEFAULT '0', 
	PRIMARY KEY(cart_no)
);

CREATE TABLE notice( 
 notice_no number NOT NULL, 
 notice_id VARCHAR2(50) NOT NULL REFERENCES users(user_id), 
 notice_title VARCHAR2(200) NOT NULL, 
 notice_detail VARCHAR2(500), 
 reg_date DATE, 
 notice_hits number,
 fileName VARCHAR2(50),
 PRIMARY KEY(notice_no) 
);

CREATE TABLE reply(
 reply_no number NOT NULL,
 notice_no number DEFAULT 0 REFERENCES notice(notice_no),
 reply_id varchar2(50) NOT NULL,
 reply_detail varchar2(500) NOT NULL,
 reg_date DATE,
 update_date DATE,
 PRIMARY KEY (reply_no)
);

INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) 
VALUES ( 'admin', 'admin', '1234', 'admin', NULL, NULL, '서울시 서초구', 'admin@mvc.com',to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS')); 

INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) 
VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, NULL, 'manager@mvc.com', to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));          

INSERT INTO users 
VALUES ( 'user01', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, sysdate,'37.494541','127.02758300000005'); 

INSERT INTO users 
VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, sysdate,'37.4949056', '127.02743899999996'); 

INSERT INTO users 
VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, sysdate, '37.49794199999999','127.02762099999995'); 

INSERT INTO users 
VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, sysdate,'37.4980981','127.02935019999995' ); 

INSERT INTO users 
VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, sysdate,'37.5615076', '126.97505330000001'); 

INSERT INTO users 
VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, sysdate, '37.57593689999999', '126.97681569999997'); 

INSERT INTO users 
VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, sysdate); 

INSERT INTO users 
VALUES ( 'user11', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users 
VALUES ( 'user12', 'SCOTT', '1212', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users 
VALUES ( 'user13', 'SCOTT', '1313', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users 
VALUES ( 'user14', 'SCOTT', '1414', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users 
VALUES ( 'user15', 'SCOTT', '1515', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users 
VALUES ( 'user16', 'SCOTT', '1616', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users 
VALUES ( 'user17', 'SCOTT', '1717', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users 
VALUES ( 'user18', 'SCOTT', '1818', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users 
VALUES ( 'user19', 'SCOTT', '1919', 'user', NULL, NULL, NULL, NULL, sysdate);
           
           
insert into product values (seq_product_prod_no.nextval,'vaio vgn FS70B','소니 바이오 노트북 신동품','20120514',2000000, 'AHlbAAAAtBqyWAAA.jpg',to_date('2012/12/14 11:27:27', 'YYYY/MM/DD HH24:MI:SS'),1000);
insert into product values (seq_product_prod_no.nextval,'자전거','자전거 좋아요~','20120514',10000, 'AHlbAAAAvetFNwAA.jpg',to_date('2012/11/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'),904);
insert into product values (seq_product_prod_no.nextval,'보르도','최고 디자인 신품','20120201',1170000, 'AHlbAAAAvewfegAB.jpg',to_date('2012/10/14 10:49:39', 'YYYY/MM/DD HH24:MI:SS'),245);
insert into product values (seq_product_prod_no.nextval,'보드세트','한시즌 밖에 안썼습니다. 눈물을 머금고 내놓음 ㅠ.ㅠ','20120217', 200000, 'AHlbAAAAve1WwgAC.jpg',to_date('2012/11/14 10:50:58', 'YYYY/MM/DD HH24:MI:SS'),455);
insert into product values (seq_product_prod_no.nextval,'인라인','좋아욥','20120819', 20000, 'AHlbAAAAve37LwAD.jpg',to_date('2012/11/14 10:51:40', 'YYYY/MM/DD HH24:MI:SS'),1254);
insert into product values (seq_product_prod_no.nextval,'삼성센스 2G','sens 메모리 2Giga','20121121',800000, 'AHlbAAAAtBqyWAAA.jpg',to_date('2012/11/14 18:46:58', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'연꽃','정원을 가꿔보세요','20121022',232300, 'AHlbAAAAtDPSiQAA.jpg',to_date('2012/11/15 17:39:01', 'YYYY/MM/DD HH24:MI:SS'),52);
insert into product values (seq_product_prod_no.nextval,'삼성센스','노트북','20120212',600000, 'AHlbAAAAug1vsgAA.jpg',to_date('2012/11/12 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),60);

insert into notice values (seq_notice_notice_no.nextval,'admin','할인이벤트 실시!!','모든 고객님들에게 20% 할인의 찬스를...',to_date('2012/12/14 11:27:27', 'YYYY/MM/DD HH24:MI:SS'),1); 
insert into notice values (seq_notice_notice_no.nextval,'admin','개설!여러분들 성원 감사드립니다ㅠ','모든 고객님들에게 20% 할인의 찬스를...',to_date('2012/12/14 11:27:27', 'YYYY/MM/DD HH24:MI:SS'),2);
insert into notice values (seq_notice_notice_no.nextval,'admin','오늘 01:00부터 06:00까지 홈페이지 점검이 있을 예정입니다. 불편을 드려서 죄송합니다 ㅠㅅㅠ','서버점검 및 총 비즈니스로직 점검이 있을 예정입니다!',to_date('2012/12/14 11:27:27', 'YYYY/MM/DD HH24:MI:SS'),3);  

commit; 



//== Page 처리을 위한 SQL 구성연습

SELECT user_id , user_name , email
FROM users
ORDER BY user_id

currentPage =2
pageSize = 3   
4 ~ 6

SELECT inner_table. * ,  ROWNUM AS row_seq
FROM (	SELECT user_id , user_name , email
				FROM users
				ORDER BY user_id ) inner_table
WHERE ROWNUM <=6;	
//==>           currentPage * paseSize


SELECT * 
FROM (	SELECT inner_table. * ,  ROWNUM AS row_seq
				FROM (	SELECT user_id , user_name , email
								FROM users
								ORDER BY user_id ) inner_table
				WHERE ROWNUM <=6 )
WHERE row_seq BETWEEN 4 AND 6;

//==> (currentPage-1) * paseSize+1           currentPage * paseSize