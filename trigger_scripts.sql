CREATE OR REPLACE FUNCTION check_subscription_expiry()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.expiry_date <= NEW.payment_date THEN
        RAISE EXCEPTION 'Expiry date ( % ) must be after payment date ( % )', NEW.expiry_date, NEW.payment_date;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_check_expiry_date
    BEFORE INSERT OR UPDATE ON Payment
    FOR EACH ROW
EXECUTE FUNCTION check_subscription_expiry();

CREATE OR REPLACE FUNCTION prevent_duplicate_genre()
    RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Genre
        WHERE LOWER(genre_name) = LOWER(NEW.genre_name)
    ) THEN
        RAISE EXCEPTION 'Duplicate genre name: "%" already exists (case-insensitive)', NEW.genre_name;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_prevent_duplicate_genre
    BEFORE INSERT ON Genre
    FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_genre();

CREATE OR REPLACE FUNCTION prevent_duplicate_plan()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM SubscriptionPlan
        WHERE LOWER(name) = LOWER(NEW.name)
    ) THEN
        RAISE EXCEPTION 'Duplicate subscription plan name: "%" already exists (case-insensitive)', NEW.name;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_prevent_duplicate_plan
BEFORE INSERT ON SubscriptionPlan
FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_plan();