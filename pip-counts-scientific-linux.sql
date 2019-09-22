SELECT
  DATE(timestamp) AS date,
  CASE WHEN country_code = "CH" THEN "CH" WHEN country_code = "US" THEN "US" ELSE "other" END AS country,
  file.project AS project,
  REGEXP_REPLACE(file.version, "\\.[0123456789]{1,}$", "") AS version,
  COUNT(*) AS count
FROM `the-psf.pypi.downloads*`
WHERE
  _TABLE_SUFFIX BETWEEN '20160101' AND '20190922'
  AND (file.project = "uproot" OR
       file.project = "awkward" OR
       file.project = "iminuit" OR
       file.project = "matplotlib" OR
       file.project = "pandas" OR
       file.project = "numpy")
  AND details.distro.name LIKE "%Scientific%" AND details.installer.name = "pip"
GROUP BY project, version, date, country
ORDER BY project, version, date, country
