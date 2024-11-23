/*================================================*/
/* Datenbanken I                                  */
/* Einführungsbeispiel                            */
/* Tabellen erzeugen                              */
/*================================================*/

/*================================================*/
/* Tabelle: DEPT                                  */
/*================================================*/
CREATE TABLE dept  (
   deptno      INTEGER          NOT NULL,
   dname       VARCHAR(14)       NOT NULL,
   loc         VARCHAR(13)       NOT NULL,
   CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

/*================================================*/
/* Tabelle: EMP                                   */
/*================================================*/
CREATE TABLE emp  (
   empno       INTEGER          NOT NULL,
   ename       VARCHAR(10)       NOT NULL,
   job         VARCHAR(9)        NOT NULL,
   mgr         INTEGER,
   hiredate    DATE               NOT NULL,
   sal         NUMERIC(7,2)        NOT NULL,
   comm        NUMERIC(7,2),
   deptno      INTEGER          NOT NULL,
   CONSTRAINT pk_emp PRIMARY KEY (empno),
   CONSTRAINT fk_emp_relation__dept FOREIGN KEY (deptno)
     REFERENCES dept (deptno),
   CONSTRAINT fk_emp_relation__emp FOREIGN KEY (mgr)
     REFERENCES emp (empno)
);

/*================================================*/
/* Index: RELATION_3_FK                           */
/*================================================*/
CREATE INDEX relation_3_fk ON emp (
   deptno ASC
);

/*================================================*/
/* Index: RELATION_16_FK                          */
/*================================================*/
CREATE INDEX relation_16_fk ON emp (
   mgr ASC
);
