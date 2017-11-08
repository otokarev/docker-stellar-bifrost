package main

import (
	"database/sql"
	"log"
	"io/ioutil"
	"strings"
	_ "github.com/lib/pq"
	"fmt"
	"os"
)

func main()  {
	dbUrl := os.Getenv("DB_URL")
	db, err := sql.Open("postgres", dbUrl)
	if err != nil {
		log.Fatal(fmt.Sprintf("Cannot parse db-url: `%s`", dbUrl))
	}

	dumpFile := os.Getenv("DB_DUMP_FILE")
	file, err := ioutil.ReadFile(dumpFile)
	if err != nil {
		log.Fatal(fmt.Sprintf("Cannot open sql-dump: `%s`", dumpFile))
	}

	requests := strings.Split(string(file), ";")

	// TODO: put it in transaction
	for _, request := range requests {
		_, err := db.Exec(request)
		if err != nil {
			log.Fatal(err)
		}
	}

}
