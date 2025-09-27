-- Add password_changed_at to users
ALTER TABLE users
    ADD COLUMN password_changed_at TIMESTAMP DEFAULT NOW();

-- Add event_image and updated_at to events
ALTER TABLE events
    ADD COLUMN event_image TEXT,
ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();
