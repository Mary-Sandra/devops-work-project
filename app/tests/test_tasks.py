from fastapi.testclient import TestClient
from sqlmodel import SQLModel, create_engine, Session
from sqlmodel.pool import StaticPool
from app.main import app
from app.database import get_session

# Use in-memory SQLite for testing
engine = create_engine(
    "sqlite://",
    connect_args={"check_same_thread": False},
    poolclass=StaticPool
)

def override_get_session():
    with Session(engine) as session:
        yield session

app.dependency_overrides[get_session] = override_get_session

client = TestClient(app)

def setup_function():
    SQLModel.metadata.create_all(engine)

def teardown_function():
    SQLModel.metadata.drop_all(engine)

def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"

def test_create_task():
    response = client.post(
        "/api/v1/tasks",
        json={"title": "Test Task", "description": "Test Description"}
    )
    assert response.status_code == 200
    assert response.json()["title"] == "Test Task"

def test_get_tasks():
    response = client.get("/api/v1/tasks")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_delete_task():
    create = client.post(
        "/api/v1/tasks",
        json={"title": "To Delete"}
    )
    task_id = create.json()["id"]
    response = client.delete(f"/api/v1/tasks/{task_id}")
    assert response.status_code == 200