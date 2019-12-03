function MyToolBar(props) {
  const classes = useStyles();
  const {title, router, clientId, cartId, password} = props;

  let menuButton = (
    <IconButton
      edge="start"
      className={classes.menuButton}
      color="inherit"
      onClick={()=>router.navigate("/catalog", {
        clientId: clientId,
        cartId: cartId})}
      >
      <Icon>home</Icon>
    </IconButton>
  )

  let logOutButton = (
    <IconButton
      edge="start"
      className={classes.menuButton}
      color="inherit"
      onClick={()=>router.navigate("/createCart", {
        clientId: '',
        cartId: '',})}
      >
      <Icon>exit_to_app</Icon>
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
        onClick={()=>router.navigate("/cart", {
          clientId: clientId,
          cartId: cartId})}
        >
        <Icon>shopping_cart</Icon>
      </IconButton>
    )

  const purchasesButton = (
    <IconButton
      edge="start"
      className={classes.menuButton}
      color="inherit"
      onClick={()=>router.navigate("/purchases", {
        clientId: clientId,
        password: password})}
      >
      <Icon>history</Icon>
    </IconButton>
  )

  let showMenuButton = true

    if (router.current() === "/createCart" || router.current() === "/ticket" || cartId === "") {
      showMenuButton = false
    }

  let showCartButton = false

    if (router.current() === "/catalog" || router.current() === "/checkOut" || (router.current() === "/purchases"  && cartId !== "")) {
      showCartButton = true
    }

  let showLogOutButton = true

  if (router.current() === "/createCart") {
    showLogOutButton = false
  }

  let showPurchasesButton = true

  if (router.current() === "/createCart" || router.current() === "/purchases") {
    showPurchasesButton = false
  }

  return (
    <div className={classes.rootToolBar}>
      <AppBar position="static">
        <Toolbar>
          {showMenuButton && menuButton}
          <Typography variant="h6" className={classes.title}>
            {title}
          </Typography>
          {/*<Button color="inherit">Login</Button>*/}
          {showCartButton && cartButton}
          {showPurchasesButton && purchasesButton}
          {showLogOutButton && logOutButton}
        </Toolbar>
      </AppBar>
    </div>
  )
}
