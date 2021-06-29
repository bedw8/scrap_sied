require(httr)
library(jsonlite)
library(dplyr)
library(sf)

delitosReg  <- function(nreg,año,id){

  cookies <- c(
    'ci_session' = as.character(id)
    )

  data <- list(
    `metodo` = 'filter',
    `forma` = 'filter',
    `region` = as.character(nreg),
    `provincia` = '-1',
    `comuna` = '-1',
    `barrio` = '-1',
    `categoria` = '-1',
    `new_categoria` = '-1',
    `new_subcategoria` = '-1',
    `anio` = as.character(año),
    `mes` = '-1'
  )

  res <- httr::POST(url = 'https://siedt.spd.gov.cl/index.php/main/find_points', httr::set_cookies(.cookies = cookies), body = data)

  if (res$status_code != 200){
    print(paste("Código de estado:",res$status_code))
  }
  else{
    df <- fromJSON(content(res, 'text'))$resulset

    if (df %>% length() == 0){
      print('No hay resultados')
    }
    else{
      df <- as.data.frame(df) %>% select(-c(categoria,subcategoria)) %>% arrange(fecha,hora) %>% st_as_sf(coords = c("x","y"), crs = 4326)

    }
  }
 return(df)
}

