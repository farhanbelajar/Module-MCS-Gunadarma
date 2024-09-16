package routers

import (
	"mcs_bab_7/controllers"

	"github.com/gin-gonic/gin"
)

func StartServer() *gin.Engine {
	router := gin.Default()
	router.POST("/servo/init-proj", controllers.InitProj)
	router.GET("/servo/status", controllers.GetStatus)
	router.PUT("/servo/update/:srv_status", controllers.UpdateStatus)
	return router
}
