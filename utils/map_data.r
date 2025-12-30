map_drug_data <- function(data.raw) {

  age.dict <- c(
    '-0.95197' = '18 - 24',
    '-0.07854' = '25 - 34',
    '0.49788' = '35 - 44',
    '1.09449' = '45 - 54',
    '1.82213' = '55 - 64',
    '2.59171' = '65+'
  )

  gender.dict <- c(
    '0.48246' = 'Female',
    '-0.48246' = 'Male'
  )

  education.dict <- c(
    '-2.43591' = 'Left School Before 16 years',
    '-1.73790' = 'Left School at 16 years',
    '-1.43719' = 'Left School at 17 years',
    '-1.22751' = 'Left School at 18 years',
    '-0.61113' = 'Some College, No Certificate Or Degree',
    '-0.05921' = 'Professional Certificate / Diploma',
    '0.45468' = 'University Degree',
    '1.16365' = 'Masters Degree',
    '1.98437' = 'Doctorate Degree'
  )

  country.dict <- c(
    '-0.09765' = 'Australia',
    '0.24923' = 'Canada',
    '-0.46841' = 'New Zealand',
    '-0.28519' = 'Other',
    '0.21128' = 'Republic of Ireland',
    '0.96082' = 'UK',
    '-0.57009' = 'USA'
  )

  ethnicity.dict <- c(
    '-0.50212' = 'Asian',
    '-1.10702' = 'Black',
    '1.90725' = 'Mixed-Black/Asian',
    '0.12600' = 'Mixed-White/Asian',
    '-0.22166' = 'Mixed-White/Black',
    '0.11440' = 'Other',
    '-0.31685' = 'White'
  )

  usage.dict <- c(
    'CL0' = 'Never Used',
    'CL1' = 'Used over a Decade Ago',
    'CL2' = 'Used in Last Decade',
    'CL3' = 'Used in Last Year',
    'CL4' = 'Used in Last Month',
    'CL5' = 'Used in Last Week',
    'CL6' = 'Used in Last Day'
  )

  dict.list <- list(
    Age = age.dict,
    Gender = gender.dict,
    Education = education.dict,
    Country = country.dict,
    Ethnicity = ethnicity.dict
  )

  substance.cols <- c(
    'Alcohol', 'Amphet', 'Amyl', 'Benzos', 'Caff', 'Cannabis',
    'Choc', 'Coke', 'Crack', 'Ecstasy', 'Heroin', 'Ketamine',
    'Legalh', 'LSD', 'Meth', 'Mushrooms', 'Nicotine', 'Semer', 'VSA'
  )

  data.mapped <- data.raw

  data.mapped[names(dict.list)] <- lapply(
    names(dict.list),
    function(col) dict.list[[col]][as.character(data.raw[[col]])]
  )

  data.mapped[substance.cols] <- lapply(
    data.raw[substance.cols],
    function(col) usage.dict[as.character(col)]
  )

  return(data.mapped)
}
