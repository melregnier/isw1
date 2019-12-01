class BookInfoView extends React.Component {
    constructor(props) {
      super(props)
  
      this.state = {
        bookSelected: props.bookSelected,
        catalog: props.catalog
      }
    }

    render() {
      const {
        // router,
        bookSelected,
        catalog
      } = this.state
  
      const {
        author,
        title,
        price
      } = catalog[bookSelected]

      return (
        <div>
          <Typography variant="h4" component="h4" gutterBottom>
            <b>{title}</b>
          </Typography>
  
          <TextField
            id="outlined-read-only-input"
            label="Autor"
            defaultValue={author}
            margin="normal"
            InputProps={{
              readOnly: true,
            }}
            variant="outlined"
          />
          <TextField
            id="outlined-read-only-input"
            label="ISBN"
            defaultValue={bookSelected}
            margin="normal"
            InputProps={{
              readOnly: true,
            }}
            variant="outlined"
          />
          <TextField
            id="outlined-read-only-input"
            label="Precio"
            defaultValue={price}
            margin="normal"
            InputProps={{
              readOnly: true,
            }}
            variant="outlined"
          />
        </div>
      )
    }
  }
