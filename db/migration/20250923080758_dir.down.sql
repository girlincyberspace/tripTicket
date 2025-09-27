-- Drop dependent objects first (indexes, views, triggers, functions)

-- Drop payments
DROP INDEX IF EXISTS idx_payments_status;
DROP INDEX IF EXISTS idx_payments_booking;
DROP TABLE IF EXISTS payments CASCADE;

-- Drop bookings
DROP TRIGGER IF EXISTS set_total_price ON bookings;
DROP FUNCTION IF EXISTS update_total_price();
DROP INDEX IF EXISTS idx_bookings_event;
DROP INDEX IF EXISTS idx_bookings_user_event;
DROP TABLE IF EXISTS bookings CASCADE;

-- Drop events
DROP INDEX IF EXISTS idx_events_start_time;
DROP INDEX IF EXISTS idx_events_location;
DROP INDEX IF EXISTS idx_events_title;
DROP TABLE IF EXISTS events CASCADE;

-- Drop users
DROP INDEX IF EXISTS idx_users_username;
DROP INDEX IF EXISTS idx_users_email;
DROP TABLE IF EXISTS users CASCADE;
