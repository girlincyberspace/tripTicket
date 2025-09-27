-- name: CreateBooking :one
INSERT INTO bookings (
    user_id, event_id, tickets, total_price, booking_status
) VALUES (
            $1, $2, $3, $4, $5
         ) RETURNING *;

-- name: GetBooking :one
SELECT * FROM bookings
WHERE id = $1 LIMIT 1;

-- name: ListBooking :many
SELECT * FROM bookings
WHERE user_id = $1
ORDER BY created_at
LIMIT $2
OFFSET $3;