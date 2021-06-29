# Scraping Delitos

Este código permite obtener un objeto tipo `sf` con los delitos localizados. La solicitud se hace por región y por año.

## Inicio de sesión

Los datos tienen acceso restringido. Para hacer uso de este código hay que iniciar sesión en la página (https://siedt.spd.gov.cl/). Luego de esto hay que seguír los siguientes pasos para obtener el `id` de la sesión.

1. Hacemos click en el candado al lado de la dirección URL.

![](Readme_img/home.png)
![](Readme_img/1.png)
2. Seleccionamos "Cookies"
![](Readme_img/2.png)
3. Nos ubicamos en "siedt.spd.gov.cl" > "Cookies" > "ci_session"
![](Readme_img/3.png)
4. El valor en `Content` es nuestro identificador.

## El código `main.R` muestra un ejemplo del uso de la función `delitosReg` donde el identificador es un parámetro.
