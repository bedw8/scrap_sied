require(httr)
library(jsonlite)
library(dplyr)
library(sf)
library(stringr)

delitosReg  <- function(nreg,year,id){

  dir.create(file.path('results'), showWarnings = FALSE)

  cookies <- c(
    'ci_session' = as.character(id)
    )

  data <- list(
    `metodo` = 'filter',
    `forma` = 'filter',
    `poligono` = '',
    `region` = as.character(nreg),
    `provincia` = '-1',
    `comuna` = '-1',
    `barrio` = '-1',
    `categoria` = '-1',
    `delito[]` = '-1',
    `anio` = as.character(year),
    `mes` = '-1'
  )

  res <- httr::POST(url = 'https://siedt.spd.gov.cl/index.php/app/find_points', httr::set_cookies(.cookies = cookies), body = data, encode = 'form')

  if (res$status_code != 200){
    print(paste("Código de estado:",res$status_code))
  }
  else{
    df <- fromJSON(content(res, 'text'))

    if (df %>% length() == 0){
      print('No hay resultados')
    }
    else{
      for (data in df %>% names){
        if (!str_detect(data,'(table|clock)')) {
          print(data)

          if (c('x','y') %in% (df[[data]] %>% names) %>% prod()){
            df[[data]] %>%
              arrange(fecha,hora) %>%
              st_as_sf(coords = c("x","y"), crs = 4326) %>%
              write_sf(paste0('results/',data,'_R',nreg,'_',year,'.gpkg'))
          }
          else{
            df[[data]] %>% write.csv(paste0('results/',data,'_R',nreg,'_',year,'.csv'),row.names = FALSE)
          }
        }
      }
    }
  }
 return(df)
}

