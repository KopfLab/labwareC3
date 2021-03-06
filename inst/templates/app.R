source('credentials.R')
message('INFO: Connection to database... ', appendLF = FALSE)
pool <- pool::dbPool(drv = RPostgreSQL::PostgreSQL(), host = db_host, dbname = db_name, user = db_user, password = db_pwd)
message('successful.')
shiny::onStop(function() { pool::poolClose(pool) })
lablogger::ll_run_gui(
  group_id = group_id, # from credentials
  access_token = access_token, # from credentials
  pool = pool, # from credentials
  timezone = timezone, # from credentials
  app_pwd = app_pwd, # from credentials
  app_title = group_id, # change to customize application title
  app_color = "red" # for options, see skin in ?shinydashboard::dashboardPage
)
