package infrastructure

import (
	"app/interfaces/database"
	"fmt"
	"github.com/jinzhu/gorm"
	"log"
	"time"
)

type SqlHandler struct {
	Conn *gorm.DB
}

func NewMySqlDb() database.SqlHandler {
	//FIX: DB接続
	connectionString := fmt.Sprintf(
		"%s:%s@tcp(%s:%s)/%s?parseTime=true",
		"root",
		"password",
		"db",
		"3306",
		"go-rest",
	)
	//root:password@tcp(db:3306)/go-rest?charset=utf8mb4&parseTime=true&loc=Local
	log.Println(connectionString)

	// 接続確認
	conn, err := open(connectionString, 30)
	if err != nil {
		panic(err)
	}

	// print log
	conn.LogMode(true)
	// Set DB engine
	conn.Set("gorm:table_options", "ENGINE=InnoDB")

	sqlHandler := new(SqlHandler)
	sqlHandler.Conn = conn

	return sqlHandler
}

func open(path string, count uint) (*gorm.DB, error) {
	db, err := gorm.Open("mysql", path)
	if err != nil {
		log.Println("Not ready. Retry connecting...")
		if count == 0 {
			return nil, fmt.Errorf("Retry count over")
		}
		time.Sleep(time.Second)
		count--
		return open(path, count)
	}
	log.Println("Successfully")
	return db, nil
}

func (handler *SqlHandler) Find(out interface{}, where ...interface{}) *gorm.DB {
	return handler.Conn.Find(out, where...)
}

func (handler *SqlHandler) Create(value interface{}) *gorm.DB {
	return handler.Conn.Create(value)
}

func (handler *SqlHandler) Save(value interface{}) *gorm.DB {
	return handler.Conn.Save(value)
}

func (handler *SqlHandler) Delete(value interface{}) *gorm.DB {
	return handler.Conn.Delete(value)
}
