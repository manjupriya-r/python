from fastapi import FastAPI

from app.api.v1.user_api import router as user_router
from app.db.session import engine
from app.db.database import Base

app = FastAPI()

app.include_router(user_router)

Base.metadata.create_all(bind=engine)