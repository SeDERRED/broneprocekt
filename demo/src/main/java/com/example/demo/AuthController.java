package com.example.demo;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final UserRepository userRepository;

    public AuthController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // Регистрация
    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password) {

        Optional<User> existingUser = userRepository.findByUsername(username);
        if (existingUser.isPresent()) {
            return "Пользователь с таким ником уже существует!";
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // позже можно хэшировать
        user.setRole(username.equalsIgnoreCase("admin") ? "ADMIN" : "USER");

        userRepository.save(user);
        return "Регистрация успешна!";
    }

    // Логин
    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestParam String username,
                                                     @RequestParam String password) {
        Optional<User> user = userRepository.findByUsername(username);
        if (user.isEmpty() || !user.get().getPassword().equals(password)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Неверный логин или пароль!"));
        }

        return ResponseEntity.ok(Map.of(
                "message", "Успешный вход!",
                "role", user.get().getRole()
        ));
    }
}