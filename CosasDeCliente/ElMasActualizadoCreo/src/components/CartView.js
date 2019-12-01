class CartView extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        catalog: {},
        listCart: {},
        cartFetched: false,
        catalogFetched: false
      }
    }
  
    fetchListCart(cartId, component) {
      getLocalAsJson(`listCart?cartId=${cartId}`)
        .then(function(response){
          return response.json()
        })
        .then(function(json) {
          if (json.errorCode === 0) {
            component.setState({listCart: json.list, catalog: component.state.catalog, cartFetched: true}); 
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

    handleCheckOut() {
      const { router, clientId, cartId } = this.props
      router.navigate("/checkOut", { clientId: clientId, cartId: cartId })
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
            component.setState({listCart: component.state.listCart, catalog: json.catalog,
                                cartFetched: component.state.cartFetched, catalogFetched: true}); 
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
  
      return (
        <div>
       <List component="nav" aria-label="substrings">
        {
          this.state.cartFetched && this.state.catalogFetched && this.state.catalog && this.state.listCart && Object.keys(this.state.listCart).map((key, ix) => {
            return (
              <ListItem
                key={ix}
                >
                <IconButton 
                  edge="start"
                  color="default"
                  onClick={() => router.navigate('/info', { bookSelected: key, catalog: this.state.catalog })}
                  >
                  <Icon>info_two_tones</Icon>
                </IconButton>

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
      { Object.keys(this.state.listCart).length !== 0 &&
      <Button
        color="primary"
        onClick={() => this.handleCheckOut()}>
        Check out
        <Icon>local_mall</Icon>
          </Button>
      }
      { Object.keys(this.state.listCart).length === 0 &&
        <div>
        <Typography component="h1" gutterBottom>
        No ha añadido ningún libro todavía.
        </Typography>
        <Button
        color="primary"
        onClick={() => router.navigate("/catalog", {clientId: clientId, cartId: cartId})}>
        Seguir comprando
        <Icon>shopping_basket_outlined</Icon>
          </Button>
        </div>
      }
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