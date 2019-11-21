function MyToolBar(props) {
  const classes = useStyles();
  const {title, router} = props;

  let menuButton = (
    <IconButton
      edge="start"
      className={classes.menuButton}
      color="inherit"
      onClick={()=>router.navigate("/createCart", {
        clientId: '',
        cartId: '',})}
      >
      <Icon>home</Icon>
    </IconButton>
  )

  if (router.current() === "/details") {
    menuButton = (
      <IconButton
        edge="start"
        className={classes.menuButton}
        color="inherit"
        onClick={()=>router.navigate("/list", {
        selectedSubstring: "",})}
      >
        <Icon>keyboard_arrow_left</Icon>
      </IconButton>
    )
  }

  return (
    <div className={classes.rootToolBar}>
      <AppBar position="static">
        <Toolbar>
          {menuButton}
          <Typography variant="h6" className={classes.title}>
            {title}
          </Typography>
          {/*<Button color="inherit">Login</Button>*/}
        </Toolbar>
      </AppBar>
    </div>
  )
}
