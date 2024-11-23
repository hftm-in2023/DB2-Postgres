/* SQLINES DEMO *** ==============================*/
/* SQLINES DEMO ***                               */
/* SQLINES DEMO *** iel                            */
/* SQLINES DEMO ***                               */
/* SQLINES DEMO *** ==============================*/

-- SQLINES DEMO ***  using a Pluggable Database (PDB).
alter session set container=xepdb1;

/* SQLINES DEMO *** ==============================*/
/* SQLINES DEMO ***                               */
/* SQLINES DEMO *** ==============================*/
-- SQLINES FOR EVALUATION USE ONLY (14 DAYS)
CREATE TABLE scott.dept  (
   deptno      SMALLINT          NOT NULL,
   dname       VARCHAR(14)       NOT NULL,
   loc         VARCHAR(13)       NOT NULL,
   CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

/* SQLINES DEMO *** ==============================*/
/* SQLINES DEMO ***                               */
/* SQLINES DEMO *** ==============================*/
CREATE TABLE scott.emp  (
   empno       SMALLINT          NOT NULL,
   ename       VARCHAR(10)       NOT NULL,
   job         VARCHAR(9)        NOT NULL,
   mgr         SMALLINT,
   hiredate    TIMESTAMP(0)               NOT NULL,
   sal         DECIMAL(7,2)        NOT NULL,
   comm        DECIMAL(7,2),
   deptno      SMALLINT          NOT NULL,
   CONSTRAINT pk_emp PRIMARY KEY (empno),
   CONSTRAINT fk_emp_relation__dept FOREIGN KEY (deptno)
     REFERENCES scott.dept (deptno),
   CONSTRAINT fk_emp_relation__emp FOREIGN KEY (mgr)
     REFERENCES scott.emp (empno)
);

/* SQLINES DEMO *** ==============================*/
/* SQLINES DEMO *** _FK                           */
/* SQLINES DEMO *** ==============================*/
CREATE INDEX relation_3_fk ON scott.emp (
   deptno ASC
);

/* SQLINES DEMO *** ==============================*/
/* SQLINES DEMO *** 6_FK                          */
/* SQLINES DEMO *** ==============================*/
CREATE INDEX relation_16_fk ON scott.emp (
   mgr ASC
);