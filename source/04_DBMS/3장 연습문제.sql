--<총 연습문제>
-- Part1
  --1. 모든 사원에 대한 이름, 부서번호, 부서명을 출력하는 SELECT 문장을 작성하여라.
SELECT ENAME, E.DEPTNO, DNAME 
    FROM EMP E, DEPT D 
    WHERE E.DEPTNO = D.DEPTNO;

  --2. NEW YORK에서 근무하고 있는 사원에 대하여 이름, 업무, 급여, 부서명을 출력하시오
SELECT ENAME, JOB, SAL, DNAME 
    FROM EMP E, DEPT D 
    WHERE E.DEPTNO=D.DEPTNO AND LOC = 'NEW YORK';
    
  --3. 보너스를 받는 사원에 대하여 이름, 부서명, 위치를 출력하시오
SELECT ENAME, COMM, DNAME, LOC 
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND COMM > 0;
    
  --4. 이름 중 L자가 있는 사원에 대하여 이름, 업무, 부서명, 위치를 출력하시오
SELECT ENAME, JOB, DNAME, LOC 
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND ENAME LIKE '%L%';
    
  --5. 사번, 사원명, 부서코드, 부서명을 검색하시오 사원명기준으로 오름차순정열하시오
SELECT EMPNO, ENAME, D.DEPTNO, DNAME
  FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
  ORDER BY ENAME;
  
  --6. 사번, 사원명, 급여, 부서명을 검색하시오
    -- 단, 급여가 2000이상인 사원에 대하여 급여를 기준으로 내림차순으로 정열하시오
SELECT EMPNO, ENAME, SAL, DNAME
  FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO AND SAL >= 2000
  ORDER BY SAL DESC;
  
  --7. 사번, 사원명, 업무, 급여, 부서명을 검색하시오. 단 업무가 MANAGER이며 급여가 2500이상인
    -- 사원에 대하여 사번을 기준으로 오름차순으로 정열하시오
SELECT EMPNO, ENAME, JOB, SAL, DNAME
  FROM EMP E, DEPT D
  WHERE E.DEPTNO=D.DEPTNO AND JOB = 'MANAGER' AND SAL >= 2500
  ORDER BY EMPNO;
  
  --8. 사번, 사원명, 업무, 급여, 등급을 검색하시오. 단, 급여기준 내림차순으로 정렬하시오
SELECT EMPNO, ENAME, JOB, SAL, GRADE
  FROM EMP, SALGRADE
  WHERE SAL BETWEEN LOSAL AND HISAL
  ORDER BY SAL DESC;

-- Part2
    --1. 이름, 직속상사명을 출력하시오
SELECT E1.ENAME, E2.ENAME MANAGER
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO;
    
    --2. 이름, 급여, 업무, 직속상사명을 출력하시오
SELECT E1.ENAME, E1.SAL, E1.JOB, E2.ENAME MANAGER
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO;
    
    --3. 이름, 급여, 업무, 직속상사명 상사가 없는 직원까지 전체 직원 다 출력하시오
        -- 단, 상사가 없을 시 '없음'으로 출력하시오
SELECT E1.ENAME, E1.SAL, E1.JOB, NVL(E2.ENAME, '없음') MANAGER
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO(+);
    
    --4. 이름, 급여, 부서명, 직속상사명을 출력하시오
SELECT E1.ENAME, E1.SAL, DNAME, E2.ENAME MANAGER
    FROM EMP E1, EMP E2, DEPT D
    WHERE E1.MGR = E2.EMPNO AND E1.DEPTNO = D.DEPTNO;
    
    --5. 상사가 없는 직원과 상사가 있는 직원 모두에 대해 이름, 급여, 부서코드, 부서명, 근무지, 직속상사명을 출력하시오
        -- 단, 직속상사가 없을 경우 직속상사명에는 ‘없음’으로 출력하시오
SELECT E1.ENAME, E1.SAL, E1.DEPTNO, DNAME, LOC, NVL(E2.ENAME, '없음') MANAGER
    FROM EMP E1, EMP E2, DEPT D
    WHERE E1.MGR = E2.EMPNO(+) AND E1.DEPTNO = D.DEPTNO;
    
    --6. 급여가 2000이상인 사람의 이름, 급여, 등급, 부서명, 직속상사명을 출력하시오
 SELECT E1.ENAME, E1.SAL, GRADE, DNAME, E2.ENAME MANAGER
    FROM EMP E1, EMP E2, DEPT D, SALGRADE
    WHERE E1.MGR = E2.EMPNO AND E1.DEPTNO = D.DEPTNO 
        AND E1.SAL BETWEEN LOSAL AND HISAL AND E1.SAL >= 2000;
    
    --7. 이름, 급여, 등급, 부서명, 직속상사명을 출력하시오
        -- 직속상사가 없는 직원까지 전체직원 부서명 순 정렬하시오
SELECT E1.ENAME, E1.SAL, GRADE, DNAME, NVL(E2.ENAME, NULL) MANAGER
    FROM EMP E1, EMP E2, DEPT D, SALGRADE
    WHERE E1.MGR = E2.EMPNO(+) AND E1.DEPTNO = D.DEPTNO
        AND E1.SAL BETWEEN LOSAL AND HISAL
    ORDER BY DNAME;
    
    --8. 이름, 급여, 등급, 부서명, 연봉, 직속상사명을 출력하시오
        -- 연봉 = (급여 + comm) * 12으로 계산하시오
SELECT E1.ENAME, E1.SAL, GRADE, (E1.SAL + NVL(E1.COMM, 0)) * 12 ANNUALSAL, DNAME, E2.ENAME MANAGER
    FROM EMP E1, EMP E2, DEPT D, SALGRADE
    WHERE E1.MGR = E2.EMPNO AND E1.DEPTNO = D.DEPTNO 
        AND E1.SAL BETWEEN LOSAL AND HISAL;
    
    --9. 8번을 부서명 순 부서가 같으면 급여가 큰 순 정렬
SELECT E1.ENAME, E1.SAL, GRADE, (E1.SAL + NVL(E1.COMM, 0)) * 12 ANNUALSAL, DNAME, E2.ENAME MANAGER
    FROM EMP E1, EMP E2, DEPT D, SALGRADE
    WHERE E1.MGR = E2.EMPNO AND E1.DEPTNO = D.DEPTNO 
        AND E1.SAL BETWEEN LOSAL AND HISAL
    ORDER BY DNAME, SAL DESC;
    
    --10. 사원테이블에서 사원명, 사원의 상사를 검색하시오(상사가 없는 직원까지 전체)
SELECT E1.ENAME, E2.ENAME MANAGER
  FROM EMP E1, EMP E2
  WHERE E1.MGR = E2.EMPNO(+);
  
    --11. 사원명, 상사명, 상사의 상사명을 검색하시오(self join)
SELECT E1.ENAME WORKER, E2.ENAME MANAGER, E3.ENAME TOPMANAGER
  FROM EMP E1, EMP E2, EMP E3
  WHERE E1.MGR = E2.EMPNO AND E2.MGR = E3.EMPNO;   
  
    --12. 위의 결과에서 상위 상사가 없는 모든 직원의 이름도 출력되도록 수정하시오(outer join)
SELECT E1.ENAME WORKER, E2.ENAME MANAGER, E3.ENAME TOPMANAGER
  FROM EMP E1, EMP E2, EMP E3
  WHERE E1.MGR = E2.EMPNO(+) AND E2.MGR = E3.EMPNO(+);  