-- name: CreatePayment :one
INSERT INTO payments (
    booking_id, amount, payment_method, payment_status, transaction_ref
) VALUES (
          $1, $2, $3, $4, $5
         ) RETURNING *;