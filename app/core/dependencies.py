from fastapi import Depends
from sqlalchemy.orm import Session

from app.services.user_service import UserService
from app.db.session import get_db

def user_service(
    db: Session = Depends(get_db)
):
    return UserService(db)
