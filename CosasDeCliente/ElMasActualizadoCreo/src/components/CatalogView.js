class CatalogView extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      catalog: {},
      listCart: {}
    }
  }

  fetchListCart(cartId, component) {
    getLocalAsJson(`listCart?cartId=${cartId}`)
      .then(function(response){
        return response.json()
      })
      .then(function(json) {
        if (json.errorCode === 0) {
          component.setState({listCart: json.list, catalog: component.state.catalog}); 
        }
        if (json.errorCode === 1) {
          {alert('Hubo un error recuperando sus datos');}
        }
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  handleAdd(isbn){
    const { cartId } = this.props
    let component = this
    getLocalAsJson(`addToCart?cartId=${cartId}&bookIsbn=${isbn}&bookQuantity=1`)
      .then(function (response) {
        
        return response.json()
      })
      .then(function (json) {
          // si en json.error_code es 0 -> voy al catalogo (actualizando cartId y clientId), 
          // si es 1 ->  mensaje de error {alert('Datos Inválidos');}
        if (json.errorCode === 0) {
          component.fetchListCart(cartId, component)
        }
        if (json.errorCode === 1) {
          {alert('Hubo un error añadiendo su libro. Intente nuevamente.');}
        }
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  handleRemove(isbn){
    const { cartId } = this.props
    let component = this
    getLocalAsJson(`removeBook?cartId=${cartId}&bookIsbn=${isbn}`)
      .then(function (response) {
        
        return response.json()
      })
      .then(function (json) {
          // si en json.error_code es 0 -> voy al catalogo (actualizando cartId y clientId), 
          // si es 1 ->  mensaje de error {alert('Datos Inválidos');}
        if (json.errorCode === 0) {
          component.fetchListCart(cartId, component)
        }
        if (json.errorCode === 1) {
          {alert('Hubo un error quitando su libro. Intente nuevamente.');}
        }
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  componentDidMount(){
    let component = this;
    const { cartId } = this.props

    getLocalAsJson('catalog')
      .then(function(response){
        return response.json()
      })
      .then(function(json) {
        if (json.errorCode === 0) {
          component.setState({listCart: component.state.listCart, catalog: json.catalog}); 
        }
        if (json.errorCode === 1) {
          {alert('No se puede acceder al catálogo en este momento');}
        }
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
    this.fetchListCart(cartId, component)
  }

  render() {
    const {
      router,
      clientId,
      cartId,
      classes
    } = this.props

    //const classes = useStyles();
    console.log(this.state.listCart[1])

    console.log("listcart")

    return (
      <div>
     <List component="nav" aria-label="substrings">
      {
        this.state.catalog && Object.keys(this.state.catalog).map((key, ix) => {
          return (
            <ListItem
              button
              key={ix}
              //onClick={() => router.navigate('/details', { selectedSubstring: this.state.catalog.catalog[key] })}
              >
              <ListItemText primary={this.state.catalog[key].title}
                            secondary={`ISBN ${key} Precio unitario: ${this.state.catalog[key].price}`} />
              <IconButton 
                edge="start"
                color="default"
                onClick={() => this.handleRemove(key)}
                >
                <Icon>remove_circle_outline_rounded</Icon>
              </IconButton>
              {(this.state.listCart && this.state.listCart[key]) || 0 }
              <IconButton
                edge="start"
                color="primary"
                onClick={() => this.handleAdd(key)}
                >
                <Icon>add_circle_outline_rounded</Icon>
              </IconButton>
            </ListItem>
          )
        })
      }
    </List>
    </div>
    )
  }
}
/*
// Add style
const SubstringsView = withStyles(styles, {
  withTheme: true
})(SubstringsComponent)
*/