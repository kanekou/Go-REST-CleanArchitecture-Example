package main

import "app/infrastructure"

func main() {
	//e := echo.New()
	//e.GET("/", func(c echo.Context) error {
	//	return c.String(http.StatusOK, "Hello!, Echo World!!")
	//})
	//e.Logger.Fatal(e.Start(":8080"))
	infrastructure.Init()
}
