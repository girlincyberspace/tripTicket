-- name: CreateUser :one
INSERT INTO users (
    username, email, password_hash, role
) VALUES (
             $1, $2, $3, $4
         ) RETURNING *;

-- name: GetUser :one
SELECT * FROM users
WHERE id = $1 LIMIT 1;

-- name: UpdateUser :one
UPDATE users
SET
    password_hash = COALESCE(sqlc.narg(password_hash), password_hash),
    username = COALESCE(sqlc.narg(username), username),
    email = COALESCE(sqlc.narg(email), email),
    password_changed_at = COALESCE(sqlc.narg(password_changed_at), password_changed_at)
WHERE
    username = sqlc.arg(username)
RETURNING *;