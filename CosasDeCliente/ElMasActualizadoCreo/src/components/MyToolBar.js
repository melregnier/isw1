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

  if (router.current() === "/listCartView") {
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


const cartButton = (
    <IconButton
      edge="start"
      className={classes.menuButton}
      color="inherit"
      onClick={()=>router.navigate("/createCart", {
        clientId: '',
        cartId: '',})}
      >
      <Icon>shopping_cart</Icon>
    </IconButton>
  )

let showCartButton = false

  if (router.current() === "/catalog") {
    showCartButton = true
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
          {showCartButton && cartButton}
        </Toolbar>
      </AppBar>
    </div>
  )
}
