package repositories

import (
	"database/sql"
	"mcs_bab_7/entities"
)

func InitProj(db *sql.DB) (err error) {
	sql := "INSERT INTO status(id, srv_status) values(1, 0)"
	_, err = db.Query(sql)
	return err
}

func GetStatus(db *sql.DB) (result []entities.Status, err error) {
	sql := "SELECT * FROM status"
	rows, err := db.Query(sql)

	if err != nil {
		return
	}

	defer rows.Close()

	for rows.Next() {
		var data entities.Status
		err = rows.Scan(&data.Id, &data.SrvStatus)
		if err != nil {
			return
		}
		result = append(result, data)
	}
	return
}

func UpdateStatus(db *sql.DB, status entities.Status) (err error) {
	sql := "UPDATE status SET srv_status = $1 WHERE id = 1"
	_, err = db.Exec(sql, status.SrvStatus)
	return
}
