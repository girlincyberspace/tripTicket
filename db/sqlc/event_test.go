package db

import (
	"context"
	"github.com/jackc/pgx/v5/pgtype"
	"github.com/stretchr/testify/require"
	"testing"
	"time"
)

func TestCreateEvent(t *testing.T) {
	arg := CreateEventParams{
		Title: "MoonShot",
		Description: pgtype.Text{
			String: "Tech Event",
			Valid:  true,
		},
		StartTime: pgtype.Timestamptz{
			Time:  time.Date(2025, 10, 6, 10, 30, 0, 0, time.UTC),
			Valid: true,
		},
		EndTime: pgtype.Timestamptz{
			Time:  time.Date(2025, 10, 9, 17, 30, 0, 0, time.UTC),
			Valid: true,
		},
		Location: pgtype.Text{
			String: "Maryland",
			Valid:  true,
		},
		TicketPrice: func() pgtype.Numeric {
			var n pgtype.Numeric
			_ = n.Scan("29.99") // Scan accepts int64, float64, string, []byte
			return n
		}(),
		TotalTickets:     32,
		TicketsAvailable: 10,
		Status: pgtype.Text{
			String: "active",
			Valid:  true,
		},
	}

	event, err := testQueries.CreateEvent(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, event)

	require.Equal(t, arg.Title, event.Title)
	require.Equal(t, arg.Description, event.Description)
	require.Equal(t, arg.StartTime.Time.UTC(), event.StartTime.Time.UTC())
	require.Equal(t, arg.EndTime.Time.UTC(), event.EndTime.Time.UTC())
	require.Equal(t, arg.Location, event.Location)
	require.Equal(t, arg.TicketPrice, event.TicketPrice)
	require.Equal(t, arg.TotalTickets, event.TotalTickets)
	require.Equal(t, arg.TicketsAvailable, event.TicketsAvailable)
	require.Equal(t, arg.Status, event.Status)

	require.NotZero(t, event.ID)
	require.NotZero(t, event.CreatedAt)
}
