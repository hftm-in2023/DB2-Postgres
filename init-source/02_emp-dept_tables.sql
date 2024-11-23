-- Creating the "dept" table
CREATE TABLE scott.dept (
   deptno      SMALLINT          NOT NULL,
   dname       VARCHAR(14)       NOT NULL,
   loc         VARCHAR(13)       NOT NULL,
   CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

-- Creating the "emp" table with foreign keys
CREATE TABLE scott.emp (
   empno       SMALLINT          NOT NULL,
   ename       VARCHAR(10)       NOT NULL,
   job         VARCHAR(9)        NOT NULL,
   mgr         SMALLINT,
   hiredate    TIMESTAMP               NOT NULL,
   sal         NUMERIC(7,2)           NOT NULL,
   comm        NUMERIC(7,2),
   deptno      SMALLINT          NOT NULL,
   CONSTRAINT pk_emp PRIMARY KEY (empno),
   CONSTRAINT fk_emp_dept FOREIGN KEY (deptno)
     REFERENCES scott.dept (deptno),
   CONSTRAINT fk_emp_mgr FOREIGN KEY (mgr)
     REFERENCES scott.emp (empno)
);

-- Creating indexes on foreign key columns for better performance
CREATE INDEX idx_emp_deptno ON scott.emp (deptno);
CREATE INDEX idx_emp_mgr ON scott.emp (mgr);