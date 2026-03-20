from app.schemas.base_schema import APIResponse
from app.schemas.user_schema import UserResponse, UserCreate
from fastapi import APIRouter, Depends, Path

from app.core.dependencies import user_service
from app.services.user_service import UserService

router = APIRouter(prefix="/users", tags=["users"])

@router.get("/", response_model=APIResponse[list[UserResponse]])
async def get_users(
    user_service: UserService = Depends(user_service)
):
    users = user_service.get_users()
    return {"message": "List of users", "data": users}

@router.post("/", response_model=APIResponse[UserResponse])
async def create_user(
    user_data: UserCreate,
    user_service: UserService = Depends(user_service)
):
    users = user_service.create_user(user_data)
    # This is a placeholder for the actual implementation
    return {"message": "User created successfully", "data": users}

@router.put("/{user_uuid}", response_model=APIResponse[UserResponse])
async def update_user(
    user_data: UserCreate,
    user_uuid: str = Path(..., min_length=36, max_length=36),
    user_service: UserService = Depends(user_service)
):
    user = user_service.update_user(user_uuid, user_data)
    # This is a placeholder for the actual implementation
    return {"message": "User updated successfully", "data": user}

@router.delete("/{user_uuid}", response_model=APIResponse[None])
async def delete_user(
    user_uuid: str = Path(..., min_length=36, max_length=36),
    user_service: UserService = Depends(user_service)
):
    user_service.delete_user(user_uuid)
    # This is a placeholder for the actual implementation
    return {"message": "User deleted successfully", "data": None}
