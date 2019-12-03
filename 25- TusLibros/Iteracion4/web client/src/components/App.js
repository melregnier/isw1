class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/createCart",
      clientId: '',
      cartId: '',
      ticket: {},
      bookSelected: '',
      catalog: {},
      password: ''
    };
  }

  render() {
    let title = "Tus Libros"
    let content = "Where am I?"
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        // http://es6-features.org/#SpreadOperator
        this.setState({ ...state, path: path })
      }
    }

    if (this.state.path === "/createCart") {
      content = (<CreateCartView
        router={router}
      />)
    } else if (this.state.path === "/catalog") {
      content = (<CatalogView
        router={router}
        clientId={this.state.clientId}
        cartId={this.state.cartId}
      />)
    } else if (this.state.path === "/info") {
      content = (<BookInfoView
        router={router}
        bookSelected={this.state.bookSelected}
        catalog={this.state.catalog}
      />)
    } else if (this.state.path === "/cart") {
      content = (<CartView 
        router={router}
        clientId={this.state.clientId}
        cartId={this.state.cartId}
      />)
    } else if (this.state.path === "/checkOut") {
      content = (<CheckOutView 
        router={router}
        clientId={this.state.clientId}
        cartId={this.state.cartId}
      />)
    } else if (this.state.path === "/ticket") {
      content = (<TicketView 
        router={router}
        ticket={this.state.ticket}
      />)
    } else if (this.state.path === "/purchases") {
      content = (<PurchasesView
      router={router}
      clientId={this.state.clientId}
      password={this.state.password}
      />)
    }
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
          clientId={this.state.clientId}
          cartId={this.state.cartId}
          password={this.state.password}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
