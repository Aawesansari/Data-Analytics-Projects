CREATE TABLE layoffs2
LIKE layoffs;

SELECT * 
FROM layoffs2;

INSERT layoffs2
SELECT *
FROM layoffs;

-- DELETING DUPLICATES-- 
SELECT *,
ROW_NUMBER()OVER(
PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs2;

WITH dupl AS
(
SELECT *,
ROW_NUMBER()OVER(
PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs2
)
SELECT *
FROM dupl 
WHERE row_num> 1
;

SELECT * 
FROM layoffs2;

CREATE TABLE `layoffs3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs3;

INSERT INTO layoffs3
SELECT *,
ROW_NUMBER()OVER(
PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs2;

DELETE 
FROM layoffs3
WHERE row_num>1;

SELECT *
FROM layoffs3
WHERE row_num>1;
