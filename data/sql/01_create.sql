-- Clear table if it already exists
DROP TABLE IF EXISTS social_accounts;

-- Tables
CREATE TABLE social_accounts(
    id serial PRIMARY KEY
    , username VARCHAR(255)
    , social_type VARCHAR(255)
    , created_at timestamptz DEFAULT current_timestamp
    , updated_at timestamptz DEFAULT current_timestamp
);

-- Updated at trigger - refresh the timestamp during an update
CREATE OR REPLACE FUNCTION updated_at_trigger()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers
CREATE TRIGGER update_social_accounts_timestamp BEFORE UPDATE ON social_accounts FOR EACH ROW EXECUTE PROCEDURE updated_at_trigger();

