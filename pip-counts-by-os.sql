SELECT
  DATE(timestamp) AS date,
  details.system.name AS os,
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
       file.project = "numpy" OR
       file.project = "tensorflow" OR
       file.project = "torch" OR
       file.project = "Keras" OR
       file.project = "scikit-learn" OR
       file.project = "scipy")
  AND details.installer.name = "pip"
GROUP BY project, version, date, os
ORDER BY project, version, date, os
