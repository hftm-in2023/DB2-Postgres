-- Create employees table schema: employees.sql

CREATE TABLE EMP (
    empno INTEGER PRIMARY KEY,
    ename VARCHAR(50) NOT NULL,
    job VARCHAR(50) NOT NULL,
    mgr INTEGER,
    hiredate TIMESTAMP NOT NULL,
    sal DECIMAL(10, 2) NOT NULL,
    comm DECIMAL(10, 2),
    deptno INTEGER NOT NULL,
    eaccount VARCHAR(50) NOT NULL,
    FOREIGN KEY (deptno) REFERENCES DEPT(deptno),
    FOREIGN KEY (mgr) REFERENCES EMP(empno)
);
