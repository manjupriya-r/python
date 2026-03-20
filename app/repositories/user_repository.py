from app.model.user_model import User
from sqlalchemy.orm import Session


class UserRepository:

    def __init__(self, db: Session):
        self.db = db

    # 🔹 Get all users
    def get_all_users(self):
        return self.db.query(User).all()

    # 🔹 Get by ID
    def get_user_by_id(self, user_id: int):
        return self.db.query(User).filter(User.id == user_id).first()
    
    # 🔹 Get by UUID
    def get_user_by_uuid(self, user_uuid: str):
        return self.db.query(User).filter(User.uuid == user_uuid).first()

    # 🔹 Get by email
    def get_user_by_email(self, email: str):
        return self.db.query(User).filter(User.email == email).first()
    
    # 🔹 Create user
    def create_user(self, user_data):
        new_user = User(**user_data.dict())
        self.db.add(new_user)
        self.db.commit()
        self.db.refresh(new_user)
        return new_user
    
    def update_user(self, user_uuid: str, user_data):
        user = self.get_user_by_uuid(user_uuid)
        for key, value in user_data.dict(exclude_unset=True).items():
            setattr(user, key, value)
        self.db.commit()
        self.db.refresh(user)
        return user
    
    def delete_user(self, user_uuid: str):
        user = self.get_user_by_uuid(user_uuid)
        self.db.delete(user)
        self.db.commit()
        return user