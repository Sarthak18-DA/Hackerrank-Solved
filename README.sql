# Hackerrank-Solved
Here I Update questions solved on HackerRank &amp; LeetCode

https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true

SELECT 
  CASE 
    WHEN G.Grade < 8 THEN 'NULL'
    ELSE S.Name
  END AS Name,
  G.Grade,
  S.Marks
FROM Students S
JOIN Grades G ON S.Marks BETWEEN G.Min_Mark AND G.Max_Mark
ORDER BY 
  G.Grade DESC,
  CASE 
    WHEN G.Grade < 8 THEN S.Marks
    ELSE S.Name
  END ASC;



SELECT 
    H.hacker_id, 
    H.name
FROM Hackers H
JOIN (
    SELECT 
        S.hacker_id,
        COUNT(DISTINCT S.challenge_id) AS full_score_count
    FROM Submissions S
    JOIN Challenges C ON S.challenge_id = C.challenge_id
    JOIN Difficulty D ON C.difficulty_level = D.difficulty_level
    WHERE S.score = D.score
    GROUP BY S.hacker_id
    HAVING COUNT(DISTINCT S.challenge_id) > 1
) AS FS ON H.hacker_id = FS.hacker_id
ORDER BY FS.full_score_count DESC, H.hacker_id ASC;



https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true


SELECT W.id, WP.age, W.coins_needed, W.power
FROM Wands W
JOIN Wands_Property WP ON W.code = WP.code
WHERE WP.is_evil = 0
  AND W.coins_needed = (
    SELECT MIN(W2.coins_needed)
    FROM Wands W2
    JOIN Wands_Property WP2 ON W2.code = WP2.code
    WHERE WP2.is_evil = 0
      AND W2.power = W.power
      AND WP2.age = WP.age
  )
ORDER BY W.power DESC, WP.age DESC;


https://www.hackerrank.com/challenges/challenges/problem?isFullScreen=true


WITH ChallengeCounts AS (
    SELECT 
        H.hacker_id,
        H.name,
        COUNT(C.challenge_id) AS total_challenges
    FROM Hackers H
    JOIN Challenges C ON H.hacker_id = C.hacker_id
    GROUP BY H.hacker_id, H.name
),
ChallengeGroups AS (
    SELECT 
        total_challenges,
        COUNT(*) AS freq
    FROM ChallengeCounts
    GROUP BY total_challenges
),
MaxCount AS (
    SELECT MAX(total_challenges) AS max_challenges FROM ChallengeCounts
)

SELECT 
    CC.hacker_id, 
    CC.name, 
    CC.total_challenges
FROM ChallengeCounts CC
JOIN ChallengeGroups CG ON CC.total_challenges = CG.total_challenges
JOIN MaxCount M ON 1=1
WHERE 
    CC.total_challenges = M.max_challenges
    OR CG.freq = 1
ORDER BY CC.total_challenges DESC, CC.hacker_id ASC;
