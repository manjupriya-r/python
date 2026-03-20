from uuid import UUID

from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

# Base schema (common fields)
class UserBase(BaseModel):
    name: str
    email: EmailStr
    age: Optional[int] = None

# Create schema (POST)
class UserCreate(UserBase):
    password: str

# Update schema (PUT/PATCH)
class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[EmailStr] = None
    age: Optional[int] = None

# Response schema (GET)
class UserResponse(UserBase):
    id: int
    uuid: UUID
    created_at: datetime

    class Config:
        from_attributes = True