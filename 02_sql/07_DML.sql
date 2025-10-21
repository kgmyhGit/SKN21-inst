-- edit > preferences > SQL Editor > Safe update (맨아래) 체크박스 해제

use hr_join;

select * from emp;
/* *********************************************************************
UPDATE : 테이블의 컬럼의 값을 수정
UPDATE 테이블명
SET    변경할 컬럼 = 변경할 값  [, 변경할 컬럼 = 변경할 값]
[WHERE 제약조건]

 - UPDATE: 변경할 테이블 지정
 - SET: 변경할 컬럼과 값을 지정
 - WHERE: 변경할 행을 선택. 
************************************************************************ */

-- 직원 ID가 200인 직원의 급여를 5000으로 변경
select * from emp where emp_id = 200;

update emp
set    salary = 5000
where  emp_id = 200;

-- 직원 ID가 200인 직원의 급여를 10% 인상한 값으로 변경.
update emp
set    salary = salary * 1.1
where  emp_id = 200;

-- 부서 ID가 100인 직원의 커미션 비율을 0.2로 salary는 3000 인상한 값으로 변경.
select * from emp where dept_id = 100;

update emp
set    comm_pct = 0.2,
       salary = salary + 3000
where  dept_id = 100;       

-- 부서 ID가 100인 직원의 커미션 비율을 null 로 변경.
update emp
set   comm_pct = null
where dept_id = 100;


/* *********************************************************************
DELETE : 테이블의 행을 삭제
구문 
 - DELETE FROM 테이블명 [WHERE 제약조건]
   - WHERE: 삭제할 행을 선택
************************************************************************ */

-- 부서테이블에서 부서_ID가 200인 부서 삭제
select * from dept where dept_id = 200;

delete from dept where dept_id = 200;

-- 부서 ID가 없는 직원들을 삭제
select * from emp where dept_id is null;

delete from emp where dept_id is null;

-- 담당 업무(emp.job_id)가 'SA_MAN'이고 급여(emp.salary) 가 12000 미만인 직원들을 삭제.
select * from emp where job_id = 'SA_MAN' and salary <= 12000;

delete from emp where job_id = 'SA_MAN' and salary <= 12000;

-- comm_pct 가 null이고 job_id 가 IT_PROG인 직원들을 삭제
select * from emp where comm_pct is null and job_id = 'IT_PROG';

delete from emp where comm_pct is null and job_id = 'IT_PROG';



