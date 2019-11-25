

class CatalogView extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clientId: '',
      cartId: '',
      catalog: {},
      loading: true
    };
  }

  componentDidMount() {
    getLocalAsJson(`catalog`)
      .then(function (response) {
        this.state.catalog = response.json();
        this.state.loading = false
      })
      .catch(err => {
        setError(err)
        this.state.loading = false
      })
  }

  render() {
    /*const {loading, clientId, cartId} = this.state;
    return (
      <div>
      {loading && <div> <Typography component="h1" gutterBottom>
          Loading...
          </Typography>
          <CircularProgress />
        </div>
      }
      {!loading }
      </div>
      );
    }*/
    if (this.state.loading) {
      return (
        <div>
          <Typography component="h1" gutterBottom>
          Loading...
          </Typography>
          






          <CircularProgress />
        </div>
    )
    } else {
      return(
        <div>
          <Typography component="h1" gutterBottom>
          Catálogo:
            </Typography>
            <CircularProgress />
        </div>
      )
    }

  }
}

