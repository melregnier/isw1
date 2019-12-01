class PurchasesView extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        catalog: {},
        catalogFetched: false,
        purchases: {},
        purchasesFetched: false
      }
    }
  
    fetchPurchases(clientId, password) {
      let component = this

      getLocalAsJson(`listPurchases?clientId=${clientId}&password=${password}`)
        .then(function(response){
          return response.json()
        })
        .then(function(json) {
          if (json.errorCode === 0) {
            component.setState({purchasesFetched: true, purchases: json.purchases}); 
          }
          if (json.errorCode === 1) {
            {alert('Hubo un error recuperando sus datos');}
          }
        })
        .catch(function (error) {
          console.log('Looks like there was a problem: \n', error);
        });
    }
  
    componentDidMount(){
      let component = this;
      const { clientId, password } = this.props
  
      getLocalAsJson('catalog')
        .then(function(response){
          return response.json()
        })
        .then(function(json) {
          if (json.errorCode === 0) {
            component.setState({catalog: json.catalog, catalogFetched: true,
                                purchases: component.state.purchases, purchasesFetched: component.state.purchasesFetched}); 
          }
          if (json.errorCode === 1) {
            {alert('No se puede acceder al catálogo en este momento');}
          }
        })
        .catch(function (error) {
          console.log('Looks like there was a problem: \n', error);
        });
      this.fetchPurchases(clientId, password)
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
       <List component="nav" aria-label="productos">
        { this.state.catalogFetched && this.state.purchasesFetched && Object.keys(this.state.purchases.booksPurchased).map((key, ix) => {
            return (
              <ListItem
                key={ix}
                >
                <ListItemText primary={this.state.catalog[key].title}
                              secondary={`ISBN ${key}`} />
                {this.state.purchases.booksPurchased[key]}
              </ListItem>
            )
          })
        }
      </List>
      Total: ${this.state.purchases.total}
      </div>
      )
    }
  }
