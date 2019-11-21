function CreateCartView(props) {
  const { router } = props
  const classes = useStyles();
  const [values, setValues] = React.useState({
    user: '',
    password: ''
  });
  const handleChange = prop => event => {
    setValues({ ...values, [prop]: event.target.value });
  };
  const handleSend = values => {
    const user = values.user
    getLocalAsJson(`createCart?clientId=${user}&password=${values.password}`)
      .then(function (response) {
        
        return response.json()
      })
      .then(function (json) {
        console.log('llego')
          // si en json.error_code es 0 -> voy al catalogo (actualizando cartId y clientId), 
          // si es 1 ->  mensaje de error {alert('Datos Inválidos');}
        if (json.errorCode === 0) {
          router.navigate("/catalog", { clientId: user, cartId: json.cartId })
        }
        if (json.errorCode === 1) {
          {alert('Datos Inválidos');}
        }
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  return (
    <div>
      <Typography component="h1" gutterBottom>
          Ingrese su usuario y contraseña para crear un carrito.
          </Typography>
      <FormControl fullWidth className={classes.textField} variant="outlined">
        <InputLabel htmlFor="outlined-adornment-amount">Usuario</InputLabel>
        <OutlinedInput
          id="outlined-adornment-amount"
          value={values.user}
          onChange={handleChange('user')}
          labelWidth={60}
        />
      </FormControl>

      <FormControl fullWidth className={classes.textField} variant="outlined">
        <InputLabel htmlFor="outlined-adornment-amount">Contraseña</InputLabel>
        <OutlinedInput
          type="password"
          id="outlined-adornment-amount"
          value={values.password}
          onChange={handleChange('password')}
          labelWidth={90}
        />
      </FormControl>

      <Button
        color="primary"
        onClick={() => handleSend(values)}>
        Crear carrito
          </Button>
    </div>
  )
}



