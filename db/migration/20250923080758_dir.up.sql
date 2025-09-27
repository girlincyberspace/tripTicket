CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,
                       username VARCHAR(50) UNIQUE NOT NULL,
                       email VARCHAR(100) UNIQUE NOT NULL,
                       password_hash VARCHAR NOT NULL,
                       role VARCHAR(20) DEFAULT 'user', -- e.g. user, admin, organizer
                       created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE events (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ,
    location VARCHAR(255),
    ticket_price NUMERIC(10,2) DEFAULT 0,
    total_tickets INT NOT NULL DEFAULT 0,
    tickets_available INT NOT NULL DEFAULT 0,
    status VARCHAR(20) DEFAULT 'active', -- active, cancelled, completed
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE bookings (
                          id BIGSERIAL PRIMARY KEY,
                          user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                          event_id BIGINT NOT NULL REFERENCES events(id) ON DELETE CASCADE,
                          tickets INT NOT NULL DEFAULT 1,
                          total_price NUMERIC(10,2) NOT NULL,
                          booking_status VARCHAR(20) DEFAULT 'confirmed',
                          created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
                          UNIQUE (user_id, event_id)
);
CREATE TABLE payments (
                          id BIGSERIAL PRIMARY KEY,
                          booking_id BIGINT NOT NULL REFERENCES bookings(id) ON DELETE CASCADE,
                          amount NUMERIC(10,2) NOT NULL,
                          payment_method VARCHAR(50), -- card, paypal, transfer
                          payment_status VARCHAR(20) DEFAULT 'pending', -- pending, completed, failed
                          transaction_ref VARCHAR UNIQUE,
                          created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_events_title ON events(title);
CREATE INDEX idx_events_location ON events(location);
CREATE INDEX idx_events_start_time ON events(start_time);
CREATE INDEX idx_bookings_user_event ON bookings(user_id, event_id);
CREATE INDEX idx_bookings_event ON bookings(event_id);
CREATE INDEX idx_payments_booking ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(payment_status);