-- 問1
-- 国名を全て抽出してください。
SELECT name FROM countries;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。
SELECT * FROM countries WHERE continent = 'Europe';

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。
SELECT * FROM countries WHERE continent NOT IN ('Europe')

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。
SELECT * FROM countries WHERE population >= 100000

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。
SELECT * FROM countries WHERE life_expectancy BETWEEN 56 AND 76;


-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。
SELECT * FROM cities WHERE country_code='NLB' OR country_code = 'ALB' OR country_code = 'DZA'

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。
SELECT * FROM countries WHERE indep_year IS NULL 

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。
SELECT * FROM countries WHERE indep_year IS NOT NULL

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。
SELECT * FROM countries WHERE name LIKE '%ia'

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。
SELECT * FROM countries WHERE name LIKE '%st%'

-- 問11
-- 名前が「an」で始まる国を抽出してください。
SELECT * FROM countries WHERE name LIKE 'an%'

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
SELECT * FROM countries
WHERE (indep_year < 1990 OR population > 100000) AND surface_area >= 1000000;


-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。
SELECT * FROM countries
WHERE (code = 'DZA' OR code = 'ALB') AND indep_year < 1990;

-- 問14
-- 全ての地方をグループ化せずに表示してください。
SELECT DISTINCT region FROM countries

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」
SELECT CONCAT(name, 'の人口は', FORMAT(population, 0), '人です') AS output FROM countries;


-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT name, life_expectancy 
FROM countries 
WHERE life_expectancy IS NOT NULL 
ORDER BY life_expectancy ASC;


-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT name, life_expectancy 
FROM countries 
WHERE life_expectancy IS NOT NULL 
ORDER BY life_expectancy DESC;


-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。
SELECT name, life_expectancy, indep_year 
FROM countries 
WHERE life_expectancy IS NOT NULL 
ORDER BY life_expectancy DESC, indep_year DESC;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。
SELECT LEFT(code, 1) AS code_initial, name 
FROM countries;


-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。
SELECT name, LENGTH(name) AS name_length 
FROM countries 
ORDER BY name_length DESC;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)
SELECT region, AVG(life_expectancy) AS avg_life_expectancy, AVG(population) AS avg_population
FROM countries
GROUP BY region;


-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)
SELECT region, MAX(life_expectancy) AS max_life_expectancy, MAX(population) AS avg_population
FROM countries
GROUP BY region;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください
SELECT MIN(surface_area) AS min_surface_area
FROM countries
WHERE continent = 'Asia';

-- 問24
-- アジア大陸の表面積の合計を表示してください。
SELECT SUM(surface_area) AS total_surface_area
FROM countries
WHERE continent = 'Asia';
-- 問25
-- 全ての国と言語を表示してください。
SELECT c1.name , c2.language
FROM countries AS c1
JOIN countrylanguages AS c2
ON c1.code = c2.country_code

-- 問26
-- 全ての国と言語と市区町村を表示してください。
SELECT c1.name, c3.name AS 市区町村名, c2.language
FROM countries AS c1
JOIN cities AS c3 ON c1.code = c3.country_code
JOIN countrylanguages AS c2 ON c1.code = c2.country_code

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。
SELECT cb.name, ct.name
FROM celebrities AS cb
LEFT JOIN countries AS ct 
ON cb.country_code = ct.code


-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。
SELECT cb.name, ct.name, cl.language 
FROM celebrities AS cb
LEFT JOIN countries AS ct 
ON cb.country_code = ct.code
JOIN countrylanguages AS cl
ON cb.country_code = cl.country_code
WHERE cl.is_official = 'T';

-- 問29
-- 全ての有名人の名前と国名をテーブル結合せずに出力してください。
SELECT cb.name, ct.name
FROM celebrities AS cb
LEFT JOIN countries AS ct
ON cb.country_code = ct.code;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
SELECT ce.country_code, MAX(ce.age) AS max_age, MIN(ce.age) AS min_age
FROM celebrities AS ce
WHERE ce.country_code IN ('GRC', 'USA')
GROUP BY ce.country_code
HAVING MAX(ce.age) >= 50 AND MIN(ce.age) <= 30;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。
SELECT '1981' AS 誕生日, COUNT(*) AS 人数
FROM celebrities
WHERE birth >= '1981-01-01' AND birth <= '1981-12-31'
UNION ALL
SELECT '1991' AS 誕生日, COUNT(*) AS 人数
FROM celebrities
WHERE birth >= '1991-01-01' AND birth <= '1991-12-31';


-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
SELECT ct.name AS 国名, AVG(cb.age) AS 平均年齢
FROM countries AS ct
JOIN celebrities AS cb 
ON ct.code = cb.country_code
GROUP BY ct.name
ORDER BY 平均年齢 DESC;















