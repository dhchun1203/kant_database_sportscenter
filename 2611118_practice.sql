-- 챌린지 1. 행 거르기 + 정렬
-- courses에서 level이 '중급' 또는 '상급'이면서 fee가 70000 이상인 행을 찾아줘. course_name, level, fee를 보여주고, fee가 큰 순으로 정렬해.
-- → 결과: 5행, 맨 위는 헬스 PT 그룹반
select
    course_name,
    level,
    fee
from
    courses
where
    level in ('중급', '상급')
    and fee >= 70000
order by
    fee desc;

-- 챌린지 2. 그룹별 집계
-- courses를 sport_id별로 묶어서, 그룹마다 행 수와 fee의 평균을 구해줘. 평균은 소수 둘째 자리까지만 보여주고, sport_id 순으로 정렬해.
-- → 결과: 4행, sport_id 1은 5개
select
    sport_id,
    count(*),
    round(avg(fee), 2)
from
    courses
group by
    sport_id
order by
    sport_id;

-- 챌린지 3. WHERE + GROUP BY + HAVING
-- enrollments에서 enroll_month가 '2026-10'이고 status가 '취소'가 아닌 행만 골라줘. 그걸 course_id별로 세서 5건 이상인 그룹만 남기고, 건수가 많은 순으로 정렬해.
-- → 결과: 5행, 맨 위는 course_id 13
select
    course_id,
    count(course_id) as 건수
from
    enrollments
where
    enroll_month = '2026-10'
    and status <> '취소'
group by
    course_id
having
    count(*) >= 5
order by
    건수 desc;

-- 챌린지 4. JOIN
-- lockers와 members를 member_id로 이어서, locker_no와 회원의 name을 보여줘. locker_no 순으로 정렬해.
-- → 결과: 18행, locker_no 101은 김하늘
select
    l.locker_no,
    m.name
from
    members m
    inner join lockers l ON (l.member_id = m.member_id)
order by
    locker_no;

-- 챌린지 5. 서브쿼리
-- members에서 birth_year가 전체 birth_year 평균보다 큰 행이 몇 개인지 세줘.
-- → 결과: 29
select
    count(*)
from
    members
where
    birth_year > (
        select
            avg(birth_year)
        from
            members
    );

-- 챌린지 6. JOIN + GROUP BY
-- instructors와 courses를 instructor_id로 이어서, 강사의 name과 그 강사가 맡은 강좌 수를 보여줘. 맡은 강좌가 없는 강사도 0으로 나와야 해. 강좌 수가 많은 순으로 정렬해.
-- → 결과: 8행, 맨 아래는 차예린 0
select
    i.name as 강사이름,
    count(c.course_id) as 맡은강좌수
from
    instructors i
    left join courses c ON (c.instructor_id = i.instructor_id)
group by
    i.instructor_id
order by
    맡은강좌수 desc;

-- 챌린지 7. WHERE + GROUP BY + HAVING (SUM)
-- enrollments에서 status가 '수료'인 행만 골라서, member_id별로 pay_amount 합계를 구해줘. 합계가 300000 이상인 그룹만 남기고, 합계가 큰 순으로 정렬해.
-- → 결과: 6행, 맨 위는 member_id 21
select
    member_id,
    sum(pay_amount) as 합계
from
    enrollments
where
    status = '수료'
group by
    member_id
having
    sum(pay_amount) >= 300000
order by
    합계 desc;

-- 챌린지 8. 서브쿼리
-- courses에서 fee가 가장 비싼 강좌의 course_name과 fee를 보여줘. 금액을 직접 적지 말고 서브쿼리로 구해야 해.
-- → 결과: 1행, 헬스 PT 그룹반
select
    course_name,
    fee
from
    courses
where
    fee = (
        select
            max(fee)
        from
            courses
    );