function CheckOutView(props) {
    const { router } = props
    const classes = useStyles();
    const [values, setValues] = React.useState({
      ccn: '',
      cco: '',
      cced: ''
    });
  
    const handleChange = prop => event => {
      setValues({ ...values, [prop]: event.target.value });
    };

    const handleSend = values => {
      const ccn = values.ccn
      const cco = values.cco
      const cced = values.cced
      const { cartId } = props
      getLocalAsJson(`checkOutCart?cartId=${cartId}&ccn=${ccn}&cco=${cco}&cced=${cced}`)
        .then(function (response) {
          return response.json()
        })
        .then(function (json) {
            // si en json.error_code es 0 -> voy al catalogo (actualizando cartId y clientId), 
            // si es 1 ->  mensaje de error {alert('Datos Inválidos');}
          if (json.errorCode === 0) {
            router.navigate("/ticket", { cartId: '', ticket: json.ticket })
          }
          if (json.errorCode === 1) {
            {alert(json.message);}
          }
        })
        .catch(function (error) {
          console.log('Looks like there was a problem: \n', error);
        });
    }
  
    return (
      <div>
        <Typography component="h1" gutterBottom>
            Ingrese los datos de su tarjeta para continuar.
            </Typography>
        <FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">Número de tarjeta de crédito </InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={values.ccn}
            onChange={handleChange('ccn')}
            labelWidth={205}
          />
        </FormControl>
  
        <FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">Nombre del titular a cargo</InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={values.cco}
            onChange={handleChange('cco')}
            labelWidth={190}
          />
        </FormControl>

        <FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">Fecha de expiración</InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            placeholder="mmyyyy"
            value={values.cced}
            onChange={handleChange('cced')}
            labelWidth={145}
          />
        </FormControl>
  
        <Button
          color="primary"
          onClick={() => handleSend(values)}>
          Continuar
          <Icon>payment</Icon>
            </Button>
      </div>
    )
  }