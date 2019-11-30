class CatalogView extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const {
      router,
      clientId,
      cartId,
      catalog,
      classes,
      isCatalogReady
    } = this.props

    console.log(catalog)
    console.log("catalog view")

  //   const lista = <Typography component="h1" gutterBottom>
  //   Encontramos los siguientes substrings:
  //   </Typography>
  // <List component="nav" aria-label="substrings">
  //   {
  //     catalog.map((substring, ix) => {
  //       return (
  //         <ListItem
  //           button
  //           key={ix}
  //           onClick={() => router.navigate('/details', { selectedSubstring: substring })}>
  //           <ListItemText primary={substring} />
  //         </ListItem>
  //       )
  //     })
  //   }
  // </List>

    return (
      <div>
        {isCatalogReady && <h1> Ready </h1>}
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