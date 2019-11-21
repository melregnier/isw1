const fetchCatalog = () => {
  const [details, setDetails] = React.useState([])
  const [loading, setLoading] = React.useState(false)
  const [error, setError] = React.useState(null)

  React.useEffect(() => {
    setLoading(true)
    setError(null)

    let details = {}

    getLocalAsJson(`catalog`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        

        setLoading(false)
        
      })
      .catch(err => {
        setError(err)
        setLoading(false)
      })
  }, [substring])

  return { details, loading, error }
}


function CatalogView(props) {

  const { router, clientId } = props
  const classes = useStyles();

  return (
    <div>
      <Typography component="h1" gutterBottom>
          Catálogo
          </Typography>
      <List component="nav" className={classes.rootList} aria-label="Catálogo">
        {
          substrings.map((substring, ix) => {
            return (
              <ListItem
                button
                key={ix}
                onClick={() => router.navigate('/details', { selectedSubstring: substring })}>
                <ListItemText primary={substring} />
              </ListItem>
            )
          })
        }
      </List>
    </div>
  )
}


