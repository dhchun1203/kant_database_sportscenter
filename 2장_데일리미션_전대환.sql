-- 1번
SELECT
    member_id AS 회원번호,
    name AS 이름,
    birth_year AS 출생연도,
    region AS 거주지역,
    phone AS 전화번호
FROM
    members
WHERE
    (birth_year BETWEEN 1970 and 1989)
    AND (email IS NULL)
ORDER BY
    출생연도,
    회원번호;

-- 2번
SELECT
    region AS 거주지역,
    CASE
        WHEN gender = 'F' THEN '여'
        WHEN gender = 'M' THEN '남'
    END AS 성별,
    COUNT(*) AS 회원수,
    ROUND(AVG(birth_year),0) AS 평균출생연도
FROM
    members
GROUP BY
    region,
    gender
HAVING
    COUNT(*) >= 5
ORDER BY
    region,
    gender;

-- 3번
SELECT 
    m.name AS 회원명, 
    m.phone AS 전화번호, 
    c.course_name AS 강좌명, 
    e.enroll_month AS 수강월
FROM enrollments e
LEFT JOIN members m ON (m.member_id = e.member_id)
LEFT JOIN courses c ON (e.course_id = c.course_id)
WHERE e.enroll_month = '2026-10' AND e.status = '취소'
ORDER BY 회원명;

-- 4번

SELECT
    s.sport_name AS 종목,
    e.enroll_month AS 수강월,
    COUNT(*) AS 수강인원,
    SUM(e.pay_amount) AS 매출
FROM sports s
LEFT JOIN courses c ON (c.sport_id = s.sport_id)
LEFT JOIN enrollments e ON (e.course_id = c.course_id AND e.status <> '취소')
-- WHERE e.status <> '취소'
GROUP BY s.sport_id, e.enroll_month
HAVING SUM(e.pay_amount) >= 1000000
ORDER BY s.sport_name COLLATE "ko-x-icu", 수강월;
-- 5번

SELECT 
    i.name AS 강사명,
    s.sport_name AS 종목,
    COUNT(DISTINCT c.course_id) AS 담당강좌수,
    COUNT(e.course_id) AS 이번달신청
FROM instructors i
LEFT JOIN courses c ON (c.instructor_id = i.instructor_id)
LEFT JOIN sports s ON (s.sport_id = c.sport_id)
LEFT JOIN enrollments e ON (e.course_id = c.course_id AND e.enroll_month = '2026-11')
GROUP BY i.instructor_id, s.sport_id
ORDER BY 이번달신청 DESC, 강사명;


