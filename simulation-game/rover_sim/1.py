import random

# Simulated motor control class
class MotorControl:
    def __init__(self):
        self.speed = 0
        self.direction = 'stop'

    def set_speed(self, speed):
        self.speed = speed
        print(f"Speed set to {self.speed}")

    def change_direction(self, direction):
        self.direction = direction
        print(f"Direction changed to {self.direction}")

# Simulated obstacle detection (using random values for simplicity)
class ObstacleDetection:
    def __init__(self, detection_range=10):
        self.detection_range = detection_range

    def detect_obstacle(self):
        # Randomly simulate whether an obstacle is detected within range
        distance_to_obstacle = random.randint(0, 20)  # Random distance between 0 and 20 meters
        if distance_to_obstacle < self.detection_range:
            print(f"Obstacle detected {distance_to_obstacle} meters ahead!")
            return True
        else:
            print(f"Clear path ahead, no obstacle within {self.detection_range} meters.")
            return False

# Main autonomous navigation system
class AutonomousNavigationSystem:
    def __init__(self):
        self.motor_control = MotorControl()
        self.obstacle_detection = ObstacleDetection(detection_range=10)

    def navigate(self):
        while True:
            obstacle = self.obstacle_detection.detect_obstacle()

            if obstacle:
                # Stop and change direction if an obstacle is detected
                self.motor_control.set_speed(0)
                print("Obstacle detected! Changing direction...")
                self.motor_control.change_direction("right")  # For simplicity, turn right
                self.motor_control.set_speed(5)  # Slow speed after avoiding obstacle
            else:
                # If no obstacle, keep moving forward
                self.motor_control.change_direction("forward")
                self.motor_control.set_speed(10)

            # Simulate a time step
            input("Press Enter for the next navigation step (or Ctrl+C to exit)...")

# Instantiate and start the navigation system
if __name__ == "__main__":
    nav_system = AutonomousNavigationSystem()
    try:
        nav_system.navigate()
    except KeyboardInterrupt:
        print("Navigation stopped.")

