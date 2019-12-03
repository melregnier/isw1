class TicketView extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        ticket: props.ticket,
        catalog: {},
        catalogFetched: false
      }
    } 
  
    componentDidMount() {
      let component = this;
      let badRequest = false
      console.log("didmount")
  
      getLocalAsJson('catalog')
        .then(function(response){
          if (response.status === 400) {
            badRequest = true
          }
          return response.json()
        })
        .then(function(json) {
          if (json.errorCode === 0) {
            component.setState({ticket: component.state.ticket, catalog: json.catalog, catalogFetched: true}); 
          }
          if (json.errorCode === 1) {
            {alert('Hubo un error al procesar su ticket');}
          }
          if (badRequest) {
            {alert(json.error)}
          }
        })
        .catch(function (error) {
          console.log('Looks like there was a problem: \n', error);
          {alert('Hubo un error al procesar su ticket');}
        });
    }
  
    render() {
      const {
        router
      } = this.props

      return (
        <div>
       <List component="nav" aria-label="productos">
        { this.state.catalog && this.state.catalogFetched && Object.keys(this.state.ticket.products).map((key, ix) => {
            return (
              <ListItem
                key={ix}
                >
                <ListItemText primary={this.state.catalog[key].title}
                              secondary={`ISBN ${key}`} />
                {this.state.ticket.products[key].quantity} x ${this.state.catalog[key].price}
              </ListItem>
            )
          })
        }
      </List>
      Total: ${this.state.ticket.total}
      </div>
      )
    }
  }
