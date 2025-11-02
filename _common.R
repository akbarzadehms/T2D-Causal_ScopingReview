
# ---- shared setup for all chapters ----
# کتابخانه‌ها
suppressPackageStartupMessages({
  library(knitr)
  library(dplyr)
  library(readr)
  library(ggplot2)
  library(yaml)
})

# تنظیمات knitr (اگر دیتای شما زیاد تغییر می‌کند، کش را خاموش نگه دارید)
knitr::opts_chunk$set(
  echo = TRUE,
  message = FALSE,
  warning = FALSE,
  cache = FALSE
)

# خواندن پارامترها: از ENV (اولویت) یا فایل params.yml
param_file <- if (file.exists("params.yml")) "params.yml" else NULL
cfg <- list()

# از ENV اگر تنظیم شده باشد
env_input <- Sys.getenv("INPUT_DATA", unset = NA)
env_title <- Sys.getenv("BOOK_TITLE", unset = NA)
env_author <- Sys.getenv("BOOK_AUTHOR", unset = NA)
env_seed <- Sys.getenv("BOOK_SEED", unset = NA)

if (!is.na(env_input)) cfg$input_data <- env_input
if (!is.na(env_title)) cfg$title <- env_title
if (!is.na(env_author)) cfg$author <- env_author
if (!is.na(env_seed)) cfg$seed <- as.integer(env_seed)

# اگر هنوز چیزی خالی است از فایل yaml پر کن
if (!is.null(param_file)) {
  y <- yaml::read_yaml(param_file)
  for (nm in names(y)) if (is.null(cfg[[nm]])) cfg[[nm]] <- y[[nm]]
}

# پیش‌فرض‌ها
if (is.null(cfg$input_data)) cfg$input_data <- "data/example.csv"
if (is.null(cfg$title)) cfg$title <- "Dynamic Book Example"
if (is.null(cfg$author)) cfg$author <- "Author"
if (is.null(cfg$seed)) cfg$seed <- 1234

# در دسترس همهٔ فصل‌ها
set.seed(cfg$seed)
options(book_cfg = cfg)







