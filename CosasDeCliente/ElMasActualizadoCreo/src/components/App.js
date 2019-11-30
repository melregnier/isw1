class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/createCart",
      clientId: '',
      cartId: '',
      catalog: {},
      isCatalogReady: false
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
        isCatalogReady={this.state.isCatalogReady}
      />)
    } else if (this.state.path === "/catalog") {
      content = (<CatalogView
        router={router}
        clientId={this.state.clientId}
        cartId={this.state.cartId}
      />)
    } else if (this.state.path === "/details") {
      content = (<SubstringDetailsView
        router={router}
        selectedSubstring={this.state.selectedSubstring}
      />)
    } else if (this.state.path === "/cart") {
      content = (<CartView 
        router={router}
        clientId={this.state.clientId}
        cartId={this.state.cartId}
      />)
    }
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
          clientId={this.state.clientId}
          cartId={this.state.cartId}
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
