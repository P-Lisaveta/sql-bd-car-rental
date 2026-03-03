CREATE TABLE cars_models (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR,
    brand VARCHAR,
    created_at TIMESTAMP NOT NULL ,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE cars (
    id BIGSERIAL PRIMARY KEY,
    vin VARCHAR(17) UNIQUE NOT NULL,
    model_id BIGINT REFERENCES cars_models(id),
    current_rental_at TIMESTAMP,
    mileage INTEGER,
    created_at TIMESTAMP NOT NULL ,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE clients (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR,
    phone VARCHAR,

    created_at TIMESTAMP NOT NULL ,
    updated_at TIMESTAMP
);

CREATE TABLE rentals (
    id BIGSERIAL PRIMARY KEY,
    car_id BIGINT REFERENCES cars(id),
    client_id BIGINT REFERENCES clients(id),
    status VARCHAR DEFAULT 'active' CHECK ( status IN ('active', 'completed', 'cancelled')),
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP,
    price DECIMAL(10, 2),
    total_price DECIMAL(12,2),
    created_at TIMESTAMP NOT NULL ,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE UNIQUE INDEX idx_unique_active_client_id ON rentals (client_id) WHERE deleted_at IS NULL;