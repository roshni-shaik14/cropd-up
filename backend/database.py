import psycopg2


def get_connection():
    return psycopg2.connect(
        host="localhost",
        database="cropdup",
        user="postgres",
        password="navyacharya2523",
        port="5432"
    )


def create_tables():
    conn = get_connection()
    cursor = conn.cursor()

    # ==========================================
    # 1. USERS TABLE
    # ==========================================
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            phone VARCHAR(15) NOT NULL,
            role VARCHAR(20) NOT NULL,
            language VARCHAR(50),
            location VARCHAR(100)
        )
    """)

    # ==========================================
    # 2. CROPS TABLE
    # ==========================================
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS crops (
            id SERIAL PRIMARY KEY,
            farmer_id INTEGER REFERENCES users(id),
            crop_name VARCHAR(100) NOT NULL,
            quantity INTEGER NOT NULL,
            expected_price INTEGER NOT NULL,
            location VARCHAR(100) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)

    # Add farmer_id to an existing crops table if needed
    cursor.execute("""
        ALTER TABLE crops
        ADD COLUMN IF NOT EXISTS farmer_id INTEGER
    """)

    # Add created_at to an existing crops table if needed
    cursor.execute("""
        ALTER TABLE crops
        ADD COLUMN IF NOT EXISTS created_at TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
    """)

    # ==========================================
    # 3. BUYERS TABLE
    # ==========================================
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS buyers (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            contact VARCHAR(15) NOT NULL
        )
    """)

    # ==========================================
    # 4. SHOPS TABLE
    # ==========================================
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS shops (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            location VARCHAR(100) NOT NULL,
            contact VARCHAR(15) NOT NULL
        )
    """)

    # ==========================================
    # 5. PRODUCTS TABLE
    # ==========================================
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS products (
            id SERIAL PRIMARY KEY,
            shop_id INTEGER REFERENCES shops(id),
            product_name VARCHAR(100) NOT NULL,
            price INTEGER NOT NULL,
            availability BOOLEAN DEFAULT TRUE
        )
    """)

    conn.commit()

    cursor.close()
    conn.close()

    print("Users table is ready!")
    print("Crops table is ready!")
    print("Buyers table is ready!")
    print("Shops table is ready!")
    print("Products table is ready!")
    print("All Phase 7 tables are ready!")


if __name__ == "__main__":
    create_tables()