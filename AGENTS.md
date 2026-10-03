# Cat Flight — Agent Instructions

## Project

Cat Flight is a small Godot 2D mobile-friendly game.

The project intentionally has a small scope.

## Development Priorities

Priority order:

1. Working gameplay
2. Simple architecture
3. Readable code
4. Good game feel
5. Polish

Avoid unnecessary abstractions.

Do not build systems for hypothetical future features.

## Technical Direction

- Godot 4.x
- GDScript
- 2D
- Portrait-oriented mobile-friendly gameplay
- Desktop input supported during development
- Placeholder visuals are acceptable

## Coding Guidelines

- Prefer simple Godot-native patterns.
- Keep scenes focused.
- Keep scripts small and understandable.
- Prefer signals where they naturally reduce coupling.
- Avoid premature manager/singleton systems.
- Avoid plugins unless clearly necessary.
- Avoid adding dependencies.
- Do not refactor unrelated code during a task.

## Scope Rule

Only implement what the current task requests.

Do not add:
- cosmetics
- unlock systems
- shops
- items
- additional modes
- achievements
- online functionality
- monetization

unless a future task explicitly requests them.

## Learning Goal

The owner is learning Godot partly by reading the generated code.

Prefer clear code over clever code.

When possible:
- use descriptive names
- avoid unnecessary indirection
- keep important gameplay values easy to tune

## Testing

After implementation:

- Ensure the project opens without errors.
- Ensure the edited scene runs.
- Report what was changed.
- Report any manual Godot Editor steps still required.
- Do not claim something was tested if it was not actually tested.