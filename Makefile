postgres:
	docker run --name trip-ticket -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret1234 -p 5432:5432 -d postgres:17-alpine

createdb:
	docker exec -it trip-ticket createdb --username=root --owner=root trip_ticket

dropdb:
	docker exec -it trip-ticket dropdb trip_ticket

migrateup:
	migrate -path db/migration -database "postgresql://root:secret1234@localhost:5432/trip_ticket?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret1234@localhost:5432/trip_ticket?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test