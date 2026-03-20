from sqlalchemy.orm import Session

from app.repositories.user_repository import UserRepository

class UserService:
    def __init__(self, db: Session):
        self.user_repository = UserRepository(db)

    def get_users(self):
        # This is a placeholder for the actual implementation
        return self.user_repository.get_all_users()
    
    def create_user(self, user_data):
        # check if user with email already exists
        existing_user = self.user_repository.get_user_by_email(user_data.email)
        if existing_user:
            raise ValueError("User with this email already exists")
        return self.user_repository.create_user(user_data)
    
    def update_user(self, user_uuid: str, user_data):
        # This is a placeholder for the actual implementation
        existing_user = self.user_repository.get_user_by_uuid(user_uuid)
        if not existing_user:
            raise ValueError("User not found")
        # Update user fields here (this is just a placeholder)
        return self.user_repository.update_user(user_uuid, user_data)
    
    def delete_user(self, user_uuid: str):
        # This is a placeholder for the actual implementation
        existing_user = self.user_repository.get_user_by_uuid(user_uuid)
        if not existing_user:
            raise ValueError("User not found")
        # Delete user here (this is just a placeholder)
        return self.user_repository.delete_user(user_uuid)