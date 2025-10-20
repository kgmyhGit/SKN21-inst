/* ***********************************************
단일행 함수: 
	- 행별로 처리하는 함수. 문자/숫자/날짜/변환 함수 
	- 단일행은 select, where절에 사용가능
다중행 함수: 
	- 여러행을 묶어서 한번에 처리하는 함수 => 집계함수, 그룹함수라고 한다.
	- 다중행은 where절에는 사용할 수 없다. (sub query 이용) 
* ***********************************************/

/* ***************************************************************************************************************
# 함수 
- 문자열관련 함수
 char_length(v) - v의 글자수 반환
 concat(v1, v2[, ..]) - 값들을 합쳐 하나의 문자열로 반환
 format(숫자, 소수부 자릿수) - 정수부에 단위 구분자 "," 를 표시하고 지정한 소수부 자리까지만 문자열로 만들어 반환
 upper(v), lower(v) - v를 모두 대문자/소문자 로 변환
 insert(기준문자열, 위치, 길이, 삽입문자열): 위치기준으로 변경. 기준문자열의 위치(1부터 시작)에서부터 길이까지 지우고 삽입문자열을 넣는다.
 replace(기준문자열, 원래문자열, 바꿀문자열): 문자열기준으로 변경. 기준문자열의 원래문자열을 바꿀문자열로 바꾼다.
 left(기준문자열, 길이), right(기준문자열, 길이): 기준문자열에서 왼쪽(left), 오른쪽(right)의 길이만큼의 문자열을 반환한다.
 substring(기준문자열, 시작위치, 길이): 기준문자열에서 시작위치부터 길이 개수의 글자 만큼 잘라서 반환한다. 길이를 생략하면 마지막까지 잘라낸다.
 substring_index(기준문자열, 구분자, 개수): 기준문자열을 구분자를 기준으로 나눈 뒤 개수만큼 반환. 개수: 양수 – 앞에서 부터 개수,  음수 – 뒤에서 부터 개수만큼 반환
 ltrim(문자열), rtrim(문자열), trim(문자열): 문자열에서 왼쪽(ltrim), 오른쪽(rtrim), 양쪽(trim)의 공백을 제거한다. 중간공백은 유지
 trim(방향  제거할문자열  from 기준문자열): 기준문자열에서 방향에 있는 제거할문자열을 제거한다.
								   방향: both (앞,뒤), leading (앞), trailing (뒤)
 lpad(기준문자열, 길이, 채울문자열), rpad(기준문자열, 길이, 채울문자열): 기준문자열을 길이만큼 늘린 뒤 남는 길이만큼 채울문자열로 왼쪽(lpad), 오른쪽(rpad)에 채운다. 기준문자열 글자수가 길이보다 많을 경우 나머지는 자른다.
*************************************************************************************************************** */
use testdb;

select char_length('aaabbbcc');
select char_length(trim('  a   ')) "처리결과";

-- EMP 테이블에서 직원의 이름(emp_name)을 모두 대문자, 소문자, 이름 글자수를 조회
select emp_name,
	   upper(emp_name) "대문자 이름",
       lower(emp_name) "소문자 이름",
	   char_length(emp_name) "이름 글자수"
from   emp;

-- 직원 이름(emp_name) 의 자릿수를 15자리로 맞추고 15자가 안되는 이름의 경우  공백을 앞에 붙여 조회. 
select  lpad(emp_name, 15, ' ') "emp_name",
	    rpad(emp_name, 15, ' ') "emp_name2",
        lpad(emp_name, 5, ' ') "emp_name3",   -- 5글자 이상인 것은 짤라낸다.
	    char_length(lpad(emp_name, 15, ' '))
from emp;
    
--  EMP 테이블에서 이름(emp_name)이 10글자 이상인 직원들의 이름(emp_name)과 이름의 글자수 조회
select  emp_name, char_length(emp_name) "글자수"
from    emp
where   char_length(emp_name) >= 10;

-- format
select format(salary, 1) as "salary"
from emp;

/* **************************************************************************
- 숫자관련 함수
 abs(값): 절대값 반환
 round(값, 자릿수): 자릿수이하에서 반올림 (양수 - 실수부, 음수 - 정수부, 기본값: 0-0이하에서 반올림이므로 정수로 반올림)
 truncate(값, 자릿수): 자릿수이하에서 절삭-버림(자릿수: 양수 - 실수부, 음수 - 정수부, 기본값: 0)
 ceil(값): 값보다 큰 정수중 가장 작은 정수. 소숫점 이하 올린다. 
 floor(값): 값보다 작은 정수중 가장 작은 정수. 소숫점 이하를 버린다. 내림
 sign(값): 숫자 n의 부호를 정수로 반환(1-양수, 0, -1-음수)
 mod(n1, n2): n1 % n2

************************************************************************** */

select round(12345.12345,  2); # 자리 2 이하에서 반올림
select round(12345.12345, -2); # 자리 -2 이하에서 반올림
select round(12345.12345);     # 자리 0 이하에서 반올림(정수)

# x  x  x  x  x.xxxxx
# -4-3 -2 -1  0 12345

-- EMP 테이블에서 각 직원에 대해 직원ID(emp_id), 이름(emp_name), 급여(salary) 그리고 15% 인상된 급여(salary)를 조회하는 질의를 작성하시오.
-- (단, 15% 인상된 급여는 올림해서 정수로 표시하고, 별칭을 "SAL_RAISE"로 지정.)
SELECT emp_id,
	   emp_name,
       salary,
       ceil(salary * 1.15) "SAL_RAISE", -- 정수로 올림 
       floor(salary * 1.15) "SAL_DOWN" -- 정수로 내림 
from   emp;

-- 위의 SQL문에서 인상 급여(sal_raise)와 급여(salary) 간의 차액을 추가로 조회 
-- (직원ID(emp_id), 이름(emp_name), 15% 인상급여, 인상된 급여와 기존 급여(salary)와 차액)
SELECT emp_id,
	   emp_name,
       salary,
       ceil(salary * 1.15) "SAL_RAISE",
       ceil(salary * 1.15) - salary "차액"
from   emp;       

--  EMP 테이블에서 커미션이 있는 직원들의 직원_ID(emp_id), 이름(emp_name), 커미션비율(comm_pct), 커미션비율(comm_pct)을 8% 인상한 결과를 조회.
-- (단 커미션을 8% 인상한 결과는 소숫점 2자리 이하에서 반올림하고 별칭은 comm_raise로 지정)
select emp_id,
	   emp_name,
       comm_pct,
       comm_pct * 1.08,
       round(comm_pct * 1.08, 2) as "반올림",
       truncate(comm_pct * 1.08, 2) as "내림"
from emp
where comm_pct is not null
order by comm_pct; -- order by 3

/* ***************************************************************************************************************
- 날짜관련 함수
 
 now(): 현재 datetime
 curdate(): 현재 date
 curtime(): 현재 time
 
 year(날짜), month(날짜), day(날짜): 날짜 또는 일시의 년, 월, 일 을 반환한다.
 hour(시간), minute(시간), second(시간), microsecond(시간): 시간 또는 일시의 시, 분, 초, 마이크로초를 반환한다.
 date(), time(): datetime 에서 날짜(date), 시간(time)만 추출한다.
 
 날짜 연산
 adddate/subdate(DATETIME/DATE/TIME,  INTERVAL 값  단위)
 	- 날짜에서 특정 일시만큼 더하고(add) 빼는(sub) 함수.
    - 단위: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER(분기-3개월), YEAR
 
 datediff(날짜1, 날짜2): 날짜1 – 날짜2한 일수를 반환
 timediff(시간1, 시간2): 시간1-시간2 한 시간을 계산해서 반환 (뺀 결과를 시:분:초 로 반환)
 timestampdiff(계산할대상단위, 시작일시, 끝일시) - 계산대상 단위에 맞춰 계산한 기간을 반환. 끝일시 - 시작일시
 
 dayofweek(날짜): 날짜의 요일을 정수로 반환 (1: 일요일 ~ 7: 토요일)

 date_format(일시, 형식문자열): 일시를 원하는 형식의 문자열로 반환
*************************************************************************************************************** */
-- 실행시점의 일/시를 조회 함수
select now();
select curdate();
select curtime();

-- 날짜 타입에서 년 월 일 조회
select year(now()) "년도",
       month(curdate()) "월",
       day(curdate()) "일"
;
select date(now());
select time(now());

-- 시간 타입에서 시 분 초 조회
select hour(now()) "시간",
       minute(curtime()) "분",
       second(curtime()) "초";


select * from emp
-- where year(hire_date) = 2005;
where month(hire_date) = 10;


-- 특정 기간 만큼 전,후의 일시를 조회

select subdate(curdate(), interval 10 month),
       curdate(),
       adddate(curdate(), interval 10 month)
;
select adddate(now(), interval 3 week) "3주후",
	   adddate(now(), interval 10 hour) "10시간 후";

-- 날짜/시간의 차이 계산
select datediff(curdate(), '2024-10-10'); -- 2025-10-20 - 2025-10-10 
select timediff(curtime(), '10:10:20');
select timestampdiff(month, '2024-10-10', now());
select timestampdiff(hour, '2024-10-10', now());

-- EMP 테이블에서 부서이름(dept_name)이 'IT'인 직원들의 '입사일(hire_date)로 부터 10일전', 입사일, '입사일로 부터 10일 후' 의 날짜를 조회. 
select subdate(hire_date, interval 10 day) "입사 10일 전 날짜",
	   hire_date,
       adddate(hire_date, interval 10 day) "입사 10일 후 날짜"
from  emp
where  dept_name = 'IT';

-- ID(emp_id)가 200인 직원의 이름(emp_name), 입사일(hire_date)를 조회. 입사일은 yyyy년 mm월 dd일 형식으로 출력.
select emp_name,
       date_format(hire_date, '%Y년 %m월 %d일')
from emp
where emp_id = 200;

select date_format(now(), '%Y년 %m월 %d일 %H시 %i분 %s초');

--  각 직원의 이름(emp_name), 근무 개월수 (입사일에서 현재까지의 달 수)를 계산하여 조회. 근무개월수 내림차순으로 정렬.
select  emp_name,
		timestampdiff(month, hire_date, curdate()) "근무 개월수"
from   emp
order by 2 desc;


/* *************************************************************************************
함수 - 조건 처리함수
ifnull (기준컬럼(값), 기본값): 기준컬럼(값)이 NULL값이면 기본값을 출력하고 NULL이 아니면 기준컬럼 값을 출력
if (조건수식, 참, 거짓): 조건수식이 True이면 참을 False이면 거짓을 출력한다.
************************************************************************************* */
select ifnull(null, '없음');

-- EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)을 조회. 부서가 없는 경우 '배치 전'을 출력.
select emp_id, emp_name, job, ifnull(dept_name, '----배치 전') "dept_name"
from   emp;
-- where  dept_name is null;

-- EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션 (salary * comm_pct)을 조회. 커미션이 없는 직원은 0을 출력.
select  emp_id,
		emp_name,
        salary,
        ifnull(salary * comm_pct, 0) "커미션"
from   emp;


/* *************************************
CASE 문
case문 동등비교
case 컬럼 when 비교값 then 출력값
		 [when 비교값 then 출력값]
		 [else 출력값]
		 end
              
case문 조건문
case when 조건 then 출력값
       [when 조건 then 출력값]
       [else 출력값]
       end

************************************* */

-- EMP테이블에서 급여와 급여의 등급을 조회하는데 급여 등급은 10000이상이면 '1등급', 10000미만이면 '2등급' 으로 나오도록 조회
select salary,
       case when salary >= 10000 then '1등급' 
            else '2등급' end "급여 등급"
from emp;

-- 20000이상 , 20000 ~ 10000, 10000 미만
select salary,
       case when salary >= 20000 then '1등급' 
            when salary < 10000 then '3등급'
            else '2등급' 
	   end "급여 등급"
from emp;



-- EMP 테이블에서 업무(job)이 'AD_PRES'거나 'FI_ACCOUNT'거나 'PU_CLERK'인 직원들의 ID(emp_id), 이름(emp_name), 업무(job)을 조회.  
-- 업무(job)가 'AD_PRES'는 '대표', 'FI_ACCOUNT'는 '회계', 'PU_CLERK'의 경우 '구매'가 출력되도록 조회
select  emp_id, 
		emp_name, 
        job,
        case job when 'AD_PRES' then '대표' 
				 when 'FI_ACCOUNT' then '회계'
                 when 'PU_CLERK' then '구매'
                 else job  -- 출력값에 column명을 작성->원래 (그 행의)값을 출력
		end "job"
from    emp
where   job in ('AD_PRES', 'FI_ACCOUNT', 'PU_CLERK', 'IT_PROG');

-- EMP 테이블에서 부서이름(dept_name)과 급여 인상분을 조회.
-- 급여 인상분은 부서이름이 'IT' 이면 급여(salary)에 10%를 'Shipping' 이면 급여(salary)의 20%를 'Finance'이면 30%를 나머지는 0을 출력

select  dept_name,
		salary,
        case dept_name when 'IT' then salary * 0.1
				       when 'Shipping' then salary * 0.2
                       when 'Finance' then salary * 0.3
                       else 0 
		end "급여 인상분"
from    emp;        








