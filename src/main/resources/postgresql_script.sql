-- DB 초기화 시 테이블 drop

DROP TABLE IF EXISTS public.bank_statement;
DROP TABLE IF EXISTS public.currency;
DROP TABLE IF EXISTS public."instance";
DROP TABLE IF EXISTS public."member";
DROP TABLE IF EXISTS public.trade;
DROP TABLE IF EXISTS public."order";
DROP TABLE IF EXISTS public.wallet;
DROP type IF EXISTS role cascade;
DROP type IF EXISTS yn cascade;
DROP type IF EXISTS order_type cascade;
DROP type IF EXISTS transaction_type cascade;

-- DB 생성

--CREATE TYPE role AS ENUM ('ADMIN', 'NORMAL');
--CREATE TYPE yn AS ENUM ('Y', 'N');
--CREATE TYPE order_type AS ENUM ('BUY', 'SELL');
--CREATE TYPE transaction_type AS ENUM ('DEPOSIT', 'WITHDRAW');

CREATE TABLE bank_statement (
                               transaction_id bigserial NOT NULL,
                               transaction_date timestamptz NOT NULL,
                               member_id varchar(100) NOT NULL,
                               transaction_type varchar(10) NOT NULL,
                               krw int8 NOT NULL,
                               status varchar(10) NOT NULL,
                               upt_date timestamptz NOT NULL,
                               CONSTRAINT bank_statement_pk PRIMARY KEY (transaction_id)
);

COMMENT ON COLUMN public.bank_statement.transaction_id IS '입출금 거래 아이디';
COMMENT ON COLUMN public.bank_statement.transaction_date IS '입출금 거래 시간';
COMMENT ON COLUMN public.bank_statement.member_id IS '회원 아이디';
COMMENT ON COLUMN public.bank_statement.transaction_type IS '입출금 구분';
COMMENT ON COLUMN public.bank_statement.krw IS '원화';
COMMENT ON COLUMN public.bank_statement.status IS '상태';
COMMENT ON COLUMN public.bank_statement.upt_date IS '수정시간';

CREATE TABLE currency (
                          currency varchar(100) NOT NULL,
                          current_price int8 NOT NULL,
                          previous_price int8 NOT NULL,
                          transaction_price int8 NOT NULL,
                          CONSTRAINT currency_pkey PRIMARY KEY (currency)
);


COMMENT ON COLUMN public.currency.currency IS '화폐명';
COMMENT ON COLUMN public.currency.current_price IS '현재가';
COMMENT ON COLUMN public.currency.previous_price IS '전일가';
COMMENT ON COLUMN public.currency.transaction_price IS '거래대금';


CREATE TABLE "instance" (
                            "date" timestamptz NOT NULL,
                            system_id varchar(100) NOT NULL,
                            status varchar(10) NOT NULL,
                            CONSTRAINT instance_pkey PRIMARY KEY (date)
);

COMMENT ON COLUMN public."instance"."date" IS '시스템 확인 날짜';
COMMENT ON COLUMN public."instance".system_id IS '시스템 아이디';
COMMENT ON COLUMN public."instance".status IS '시스템 상태';


CREATE TABLE "member" (
                          member_id varchar(100) NOT NULL,
                          "role" varchar(10) NOT NULL,
                          use_yn varchar(1) NOT NULL,
                          reg_date timestamptz NOT NULL,
                          upt_date timestamptz NOT NULL,
                          "password" varchar(100) NOT NULL,
                          CONSTRAINT member_pkey PRIMARY KEY (member_id)
);
CREATE INDEX member_password_idx ON public.member USING btree (password);

COMMENT ON COLUMN public."member".member_id IS '회원 아이디';
COMMENT ON COLUMN public."member"."password" IS '비밀번호';
COMMENT ON COLUMN public."member"."role" IS '역할';
COMMENT ON COLUMN public."member".use_yn IS '사용여부';
COMMENT ON COLUMN public."member".reg_date IS '가입시간';
COMMENT ON COLUMN public."member".upt_date IS '수정시간';


CREATE TABLE trade (
                       trade_id bigserial NOT NULL,
                       trade_date timestamptz NOT NULL,
                       buy_order_id int8 NOT NULL,
                       sell_order_id int8 NOT NULL,
                       quantity int8 NOT NULL,
                       CONSTRAINT trade_pkey PRIMARY KEY (trade_id)
);

COMMENT ON COLUMN public.trade.trade_id IS '거래 아이디';
COMMENT ON COLUMN public.trade.trade_date IS '거래 시간';
COMMENT ON COLUMN public.trade.buy_order_id IS '구매 주문 아이디';
COMMENT ON COLUMN public.trade.sell_order_id IS '판매 주문 아이디';
COMMENT ON COLUMN public.trade.quantity IS '거래량';

CREATE TABLE "order" (
                         order_id bigserial NOT NULL,
                         order_date timestamptz NOT NULL,
                         order_member varchar(100) NOT NULL,
                         currency varchar(100) NOT NULL,
                         order_type varchar(4) NOT NULL,
                         price int8 NOT NULL,
                         quantity int8 NOT NULL,
                         stock int8 NOT NULL,
                         status varchar(4) NOT NULL,
                         upt_date timestamptz NOT NULL,
                         CONSTRAINT order_pkey PRIMARY KEY (order_id)
);


COMMENT ON COLUMN public.order.order_id IS '아이디';
COMMENT ON COLUMN public.order.order_date IS '주문 시간';
COMMENT ON COLUMN public.order.order_member IS '주문자 아이디';
COMMENT ON COLUMN public.order.currency IS '화폐 종류';
COMMENT ON COLUMN public.order.order_type IS '주문 종류';
COMMENT ON COLUMN public.order.price IS '주문지정금액';
COMMENT ON COLUMN public.order.quantity IS '주문량';
COMMENT ON COLUMN public.order.stock IS '미체결량';
COMMENT ON COLUMN public.order.status IS '상태';
COMMENT ON COLUMN public.order.upt_date IS '수정시간';


CREATE TABLE wallet (
                        member_id varchar(100) NOT NULL,
                        currency varchar(100) NOT NULL,
                        quantity int8 NOT NULL,
                        average_price int8 NOT NULL,
                        CONSTRAINT wallet_pk PRIMARY KEY (member_id, currency)
);

COMMENT ON COLUMN public.wallet.member_id IS '회원 아이디';
COMMENT ON COLUMN public.wallet.currency IS '화폐 종류';
COMMENT ON COLUMN public.wallet.quantity IS '보유량';
COMMENT ON COLUMN public.wallet.average_price IS '매수 평균가';