-- PostgreSQL equivalent of the given Oracle SQL

-- Containers (PDB) are an Oracle-specific concept. In PostgreSQL, there is no equivalent needed.

-- PostgreSQL does not support session-based NLS_DATE_FORMAT like Oracle. Instead, use the appropriate date format within the query.

-- Inserting data into the "dept" table
INSERT INTO scott.dept (deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO scott.dept (deptno, dname, loc) VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO scott.dept (deptno, dname, loc) VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO scott.dept (deptno, dname, loc) VALUES (40, 'OPERATIONS', 'BOSTON');

-- Inserting data into the "emp" table
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7369, 'SMITH', 'CLERK', '1980-12-17', 800, NULL, 20);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7499, 'ALLEN', 'SALESMAN', '1981-02-20', 1600, 300, 30);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7521, 'WARD', 'SALESMAN', '1981-02-22', 1250, 500, 30);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7566, 'JONES', 'MANAGER', '1981-04-02', 2975, NULL, 20);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7654, 'MARTIN', 'SALESMAN', '1981-09-28', 1250, 1400, 30);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7698, 'BLAKE', 'MANAGER', '1981-05-01', 2850, NULL, 30);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7782, 'CLARK', 'MANAGER', '1981-06-09', 2450, NULL, 10);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7788, 'SCOTT', 'ANALYST', '1982-12-09', 3000, NULL, 20);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7839, 'KING', 'PRESIDENT', '1981-11-17', 5000, NULL, 10);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7844, 'TURNER', 'SALESMAN', '1981-09-08', 1500, 0, 30);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7876, 'ADAMS', 'CLERK', '1983-01-12', 1100, NULL, 20);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7900, 'JAMES', 'CLERK', '1981-12-03', 950, NULL, 30);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7902, 'FORD', 'ANALYST', '1981-12-03', 3000, NULL, 20);
INSERT INTO scott.emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES (7934, 'MILLER', 'CLERK', '1982-01-23', 1300, NULL, 10);

-- Updating "mgr" column in the "emp" table to establish employee hierarchy
UPDATE scott.emp SET mgr = 7902 WHERE empno = 7369;
UPDATE scott.emp SET mgr = 7698 WHERE empno = 7499;
UPDATE scott.emp SET mgr = 7698 WHERE empno = 7521;
UPDATE scott.emp SET mgr = 7839 WHERE empno = 7566;
UPDATE scott.emp SET mgr = 7698 WHERE empno = 7654;
UPDATE scott.emp SET mgr = 7839 WHERE empno = 7698;
UPDATE scott.emp SET mgr = 7839 WHERE empno = 7782;
UPDATE scott.emp SET mgr = 7566 WHERE empno = 7788;
UPDATE scott.emp SET mgr = 7698 WHERE empno = 7844;
UPDATE scott.emp SET mgr = 7788 WHERE empno = 7876;
UPDATE scott.emp SET mgr = 7698 WHERE empno = 7900;
UPDATE scott.emp SET mgr = 7566 WHERE empno = 7902;
UPDATE scott.emp SET mgr = 7782 WHERE empno = 7934;

-- Commit the transaction
COMMIT;
