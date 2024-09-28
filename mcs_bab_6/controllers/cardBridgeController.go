package controllers

import (
	"mcs_bab_6/database"
	"mcs_bab_6/entities"
	"mcs_bab_6/repositories"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetCards(c *gin.Context) {
	var result gin.H

	card, err := repositories.GetCards(database.DbCoonnection)

	if err != nil {
		result = gin.H{
			"result": err.Error(),
		}
	} else {
		result = gin.H{
			"result": card,
		}
	}

	c.JSON(http.StatusOK, result)
}

func InsertCard(c *gin.Context) {
	var card entities.Card
	idCard := c.Param("id")

	// err := c.BindJSON(&card)

	// if err != nil {
	// 	panic(err)
	// } handle menggunakan panic

	// if err != nil {
	// 	c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	// 	return
	// } skip JSON Binding, karena menggunakan praram dari url

	card.ID = idCard

	err := repositories.InsertCard(database.DbCoonnection, card)

	// if err != nil {
	// 	panic(err)
	// } handle menggunakan panic

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"errpr": err.Error()})
		return
	}

	c.JSON(http.StatusOK, card)
}

func DeleteCard(c *gin.Context) {
	var card entities.Card
	idCard := c.Param("id")

	card.ID = idCard

	err := repositories.DeleteCard(database.DbCoonnection, card)

	if err != nil {
		// panic(err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	}

	c.JSON(http.StatusOK, gin.H{"message": "data berhasil dihapus", "id": idCard})
}
