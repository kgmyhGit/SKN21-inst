/* *************************************
SELECT 기본 구문 - 연산자, 컬럼 별칭

  select 컬럼명, 컬럼명 [, .....]  　=> 조회할 컬럼 지정. *: 모든 컬럼
  from   테이블명                  => 조회할 테이블 지정.

- 컬럼명 [as 별칭] => 테이블에서 컬럼명의 값들을 조회한 뒤 그 결과를 별칭으로 지정한 컬럼반환한다. 별칭에 컬럼명으로 못 사용하는 문자(공백,특수문자들)를 쓸 경우 " "로 감싼다. 
- distinct 컬럼명 => 중복된 결과를 제거한다.

참고: 
- Sql은 대소문자 구분 안함.
- sql문 실행: control+enter
*************************************** */
-- EMP 테이블의 모든 컬럼의 모든 항목을 조회 (전직원 정보 조회).
select * from testdb.emp;

use testdb;
select * from emp;

-- EMP 테이블의 직원 ID(emp_id), 직원 이름(emp_name), 업무(job) 컬럼의 값을 조회.
select emp_id, 		
       emp_name, 
       job
from   emp;

-- EMP 테이블의 업무(job) 어떤 값들로 구성되었는지 조회. - 동일한 값은 하나씩만 조회되도록 처리.
select distinct job from emp;
select distinct job, emp_name from emp;
select distinct job, dept_name from emp;


-- EMP 테이블에서 emp_id는 직원ID, emp_name은 직원이름, hire_date는 입사일, salary는 급여, dept_name은 소속부서 별칭으로 조회결과를 출력 한다.
select emp_id as 직원ID ,  # emp_id 컬럼의 조회결과를 직원ID 컬럼으로 보여줘.
       upper(emp_name) as 직원이름,
       hire_date as 입사일,
       salary as 급여,
       dept_name as 소속부서
from   emp;

-- as 생략가능
select emp_id,
       upper(emp_name) "emp_name",
       hire_date "입사일",
       salary "급여",
       dept_name  "소속 부서" -- 별칭을 " " 로 감싼다.
from   emp;

/* **************************************
연산자 
- 산술 연산자 
	- +, -, *, /, %, mod, div (몫 연산)
- 여러개 값을 합쳐 문자열로 반환
	- concat(값, 값, ...)
- 피연산자가 null인 경우 결과는 null
- 연산은 그 컬럼의 모든 값들에 일률적으로 적용된다.
- 같은 컬럼을 여러번 조회할 수 있다.
************************************** */

select salary, salary * 12, salary * 6, salary * salary * 120 from emp;

-- EMP 테이블에서 직원의 이름(emp_name), 급여(salary), 급여(salary)을 연봉으로 조회. (곱하기 12)
select emp_name, salary, salary * 12 "연봉"
from emp;

-- EMP 테이블의 직원의 이름(emp_name), 급여(salary)를 조회하는데 급여 앞에 '$'를 붙여서 조회한다.
select  emp_name, concat('$', salary, '원') from emp;

-- EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션_PCT(comm_pct), 급여에 커미션_PCT를 곱한 값을 조회.
select emp_name,
       salary,
       comm_pct,
       salary * comm_pct "커미션"
from   emp;       

/* *************************************
where 절을 이용한 행 선택 

주의 : mysql은 비교시 대소문자를 가리지 않는다.
      ex) select * from emp where emp_name = 'steven'; Steven 조회된다.
     대소문자 구별해서 비교하게 하려면 컬럼명 앞에 BINARY를 붙인다.
	  ex) where BINARY emp_name = 'Steven' and BINARY job_id='aD_PRES';
************************************* */

-- select * from emp where binary emp_name = 'steven';

-- EMP 테이블에서 직원_ID(emp_id)가 110인 직원의 이름(emp_name)과 부서명(dept_name)을 조회
select emp_name, dept_name from emp where emp_id = 110;
 
-- EMP 테이블에서 'Sales' 부서에 속하지 않은 직원들의 ID(emp_id), 이름(emp_name),  부서명(dept_name)을 조회.
select emp_id, emp_name, dept_name
from   emp
-- where  dept_name != 'Sales';
where  dept_name <> 'Sales';

-- EMP 테이블에서 급여(salary)가 $10,000를 초과인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select emp_id, emp_name, salary
from   emp
where  salary > 10000;
 
-- EMP 테이블에서 커미션비율(comm_pct)이 0.2~0.3 사이인 직원의 ID(emp_id), 이름(emp_name), 커미션비율(comm_pct)을 조회.
select  emp_id, emp_name, comm_pct
from    emp
-- where   comm_pct between 0.2 and 0.3;
where   comm_pct not between 0.2 and 0.3;

-- EMP 테이블에서 업무(job)가 'IT_PROG' 거나 'ST_MAN' 인 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회.
select  emp_id, emp_name, job
from 	emp
where   job not in ('IT_PROG', 'ST_MAN');
-- where   job in ('IT_PROG', 'ST_MAN');
-- where   job = 'IT_PROG' or job = 'ST_MAN';

-- EMP 테이블에서 직원 이름(emp_name)이 S로 시작하는 직원의  ID(emp_id), 이름(emp_name)을 조회.
# % 글자수와 문자가 뭐가 오든 상관없다.
select emp_id, emp_name
from   emp
where  emp_name not like 'S%';
-- where  emp_name like 'S%';  -- ~로 시작하는
-- where  emp_name like '%en'; -- ~ 로 끝나는
-- where emp_name like '%are%'; -- ~ 를 포함한
                             -- 'K%abc' -- K로 시작하고 abc로 끝나는.

-- EMP 테이블에서 직원 이름(emp_name)의 세 번째 문자가 “e”인 모든 사원의 이름을 조회
# `_` : 한 글자
select emp_name from emp
where  emp_name like '___e%';

-- EMP 테이블에서 직원의 이름에 '%' 가 들어가는 직원의 ID(emp_id), 직원이름(emp_name) 조회
--    %나 _ 를 검색하는 값으로 사용할 경우. 
select emp_id, emp_name from emp
where  emp_name like '%&%%' escape '&'; -- escape '특수문자'   특수문자뒤에 %나 _ 는 조회할 값임을 표시.(like의 패턴문자가 아니라)

-- EMP 테이블에서 부서명(dept_name)이 null인 직원의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.
select emp_id, emp_name, dept_name
from   emp
where  dept_name is null;

-- EMP 테이블에서 커미션이 있는(comm_pct가 null이 아닌)  직원들을 모든 컬럼값들을 조회
select * from emp
where  comm_pct is not null;


-- select year(hire_date) from emp;
-- EMP 테이블에서 2004년에 입사한 직원들의 ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회.
-- 참고: date/datatime에서 년도만 추출 함수: year(컬럼명)
select emp_id, emp_name, hire_date
from   emp
where  year(hire_date) = 2004;
-- where  hire_date between '2004-01-01' and '2004-12-31';
-- where  hire_date > '2004-05-31'; 2004-05-31 이후 입사한 직원조회 

-- EMP 테이블에서 연봉(salary * 12) 이 200,000 이상인 직원들의 모든 정보를 조회.
select * from emp
where salary * 12 > 200000;

/* ******************************************
 WHERE 조건이 여러개인 경우 AND 나 OR 로 조건들을 묶어준다.
 
 AND: 두 조건이 모두 True인 행만 조회
 OR: 두 조건 중 하나 이상이 True인 행을 조회
 
 연산 우선순위: AND > OR
 	where 조건1 and 조건2 or 조건3
	  1. 조건 1 and 조건2
	  2. 1결과 or 조건3
 
 or를 먼저 하려면 where 조건1 and (조건2 or 조건3)
 *******************************************/
-- EMP 테이블에서 'SA_REP' 업무를 담당하는 직원들 중 급여(salary)가 $9,000인 직원의 직원들을 조회.
select * from emp
where  job = 'SA_REP' and  salary = 9000;

-- EMP 테이블에서 업무(job)가 'FI_ACCOUNT' 거나 급여(salary)가 $8,000 이상인 직원들을 조회.
select * from emp
where job = 'FI_ACCOUNT' or salary >= 8000;

-- EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 부서(dept_name)가 'Shipping' 이고 2005년 이후 입사한  직원들을 조회.
select * from emp
where job like '%MAN%' 
and   dept_name = 'Shipping' 
and   hire_date >= '2005-01-01'; -- year(hire_date) >= 2005

-- EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 'Marketing' 이나 'Sales' 부서에 소속된 직원들의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)를 조회. 
select emp_id, emp_name, job, dept_name
from   emp
where  job like '%MAN%'
 and   dept_name in ('Marketing', 'Sales');

select emp_id, emp_name, job, dept_name
from   emp
where  job like '%MAN%'
and    (dept_name = 'Marketing'
or     dept_name = 'Sales');

-- and -> or
-- (job like '%MAN%' and    dept_name = 'Marketing') or dept_name = 'Sales'

/* *******************************************************************
order by를 이용한 정렬
- order by절은 select문의 마지막 구문으로 온다.
- order by 정렬기준컬럼 정렬방식 [, ...]
    - 정렬기준컬럼 지정 단위: 컬럼이름, 컬럼의순번(select절의 선언 순서)
     `select salary, hire_date from emp` 에서 salary 컬럼을 기준으로 정렬할 경우 `order by salary` 또는 `order by 1` 로 작성할 수있다.
	 
    - 정렬방식
        - ASC : 오름차순(ascending), 기본방식(생략가능)
        - DESC : 내림차순(descending)
		
문자열 오름차순 : 숫자 -> 대문자 -> 소문자 -> 한글 (유니코드 순서)
Date 오름차순 : 과거 -> 미래
null은 오름차순일 때 가장 먼저 나온다.

ex)
order by salary asc, emp_id desc
- salary로 전체 정렬을 하고 salary가 같은 행은 emp_id로 정렬.
******************************************************************* */

--  직원들의 전체 정보를 직원 ID(emp_id)가 큰 순서대로 정렬해 조회
select * from emp
order by emp_id desc;

--  직원들의 id(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 
--  업무(job) 순서대로 (A -> Z) 조회하고 업무(job)가 같은 직원들은 급여(salary)가 높은 순서대로 2차 정렬해서 조회.
select emp_name, job, salary
from   emp
-- order by job asc, salary desc;
order by 2 asc, 3 desc;

-- 급여(salary)가 $5,000을 넘는 직원의 ID(emp_id), 이름(emp_name), 급여(salary)를 급여가 높은 순서부터 조회
select emp_id, emp_name, salary
from  emp
where  salary > 5000
-- order by salary desc;
order by 3 desc;









