WITH top_industries AS (SELECT
	COUNT(*) AS num_uni,
	i.industry
FROM dates
INNER JOIN industries AS i
USING(company_id)
WHERE EXTRACT(year FROM date_joined) IN ('2019', '2020', '2021')
GROUP BY i.industry
ORDER BY num_uni DESC
LIMIT 3
)

SELECT
	i.industry,
	EXTRACT(year FROM date_joined) AS year,
	COUNT(*) AS num_unicorns,
	ROUND(AVG(f.valuation)/1000000000, 2) AS average_valuation_billions
FROM dates
INNER JOIN industries AS i
USING(company_id)
INNER JOIN funding AS f
USING(company_id)
WHERE EXTRACT(year FROM date_joined) IN ('2019', '2020', '2021') AND i.industry IN (SELECT industry FROM top_industries)
GROUP BY year, i.industry
ORDER BY year DESC, COUNT(*) DESC