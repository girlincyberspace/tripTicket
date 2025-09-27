-- Remove password_changed_at from users
ALTER TABLE users
DROP COLUMN IF EXISTS password_changed_at;

-- Remove event_image and updated_at from events
ALTER TABLE events
DROP COLUMN IF EXISTS event_image,
DROP COLUMN IF EXISTS updated_at;
