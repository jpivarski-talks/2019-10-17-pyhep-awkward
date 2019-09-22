SELECT
  DATE(timestamp) AS date,
  CASE WHEN country_code = "CH" THEN "CH" WHEN country_code = "US" THEN "US" ELSE "other" END AS country,
  COUNT(*) AS count
FROM `the-psf.pypi.downloads*`
WHERE
  _TABLE_SUFFIX BETWEEN '20160101' AND '20190922'
  AND details.distro.name LIKE "%Scientific%" AND details.installer.name = "pip"
GROUP BY date, country
ORDER BY date, country
