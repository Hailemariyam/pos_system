import 'package:hive/hive.dart';
import 'package:pos_sales_app/models/user_model.dart';

class UserService {
  static const _userBox = 'userBox';

  // Initialize and open the Hive box for users
  static Future<Box<User>> _openBox() async {
    final box = await Hive.openBox<User>(_userBox);
    return box;
  }

  // Add a new user
  Future<void> addUser(User user) async {
    final box = await _openBox();
    await box.add(user); // Adds the user to the box
  }

  // Retrieve a user by their email (used for login)
  Future<User?> getUserByEmail(String email) async {
    final box = await _openBox();
    final users = box.values.where((user) => user.email == email).toList();
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  // Update a user (can be used to update user details like password, role, etc.)
  Future<void> updateUser(int userId, User updatedUser) async {
    final box = await _openBox();
    await box.put(userId, updatedUser); // Updates the user based on their ID
  }

  // Delete a user by ID
  Future<void> deleteUser(int userId) async {
    final box = await _openBox();
    await box.delete(userId); // Deletes the user by ID
  }

  // Get all users (if needed)
  Future<List<User>> getAllUsers() async {
    final box = await _openBox();
    return box.values.toList();
  }
}
