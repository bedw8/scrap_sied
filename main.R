source('delitosReg.R')

###### Guardamos ID ######
id <- '123456...' # Remplazar por el id ci_session. leer Readme

###### Obtenemos objeto geométrico con los delitos
df <- delitosReg(nreg = 15, año = 2021, id = id)
