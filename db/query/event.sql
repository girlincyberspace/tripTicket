-- name: CreateEvent :one
INSERT INTO events (
    title, description, start_time, end_time, location, ticket_price, total_tickets, tickets_available, status, event_image
) VALUES (
             $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
         ) RETURNING *;

-- name: GetEvent :one
SELECT * FROM events
WHERE id = $1 LIMIT 1;

-- name: GetEventForUpdate :one
SELECT * FROM events
WHERE id = $1 LIMIT 1
FOR NO KEY UPDATE;

-- name: UpdateEvent :one
UPDATE events
SET
    title        = COALESCE(sqlc.narg(title), title),
    description  = COALESCE(sqlc.narg(description), description),
    start_time   = COALESCE(sqlc.narg(start_time), start_time),
    end_time     = COALESCE(sqlc.narg(end_time), end_time),
    location     = COALESCE(sqlc.narg(location), location),
    ticket_price = COALESCE(sqlc.narg(ticket_price), ticket_price),
    status       = COALESCE(sqlc.narg(status), status),
    event_image  = COALESCE(sqlc.narg(event_image), event_image),
    updated_at   = now()
WHERE id = sqlc.arg(id)
RETURNING *;


-- name: ListEvents :many
SELECT * FROM events
ORDER BY created_at DESC
LIMIT $1
OFFSET $2;

-- name: DeleteEvent :exec
DELETE FROM events
WHERE id = $1;
