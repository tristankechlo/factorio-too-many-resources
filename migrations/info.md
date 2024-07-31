https://lua-api.factorio.com/latest/auxiliary/migrations.html

The sequence in which migrations are executed is sorted by mod order first,
migration file name second (using lexicographical comparison).
Each save file remembers (by name) which migrations from which mods have been applied
and will not apply the same migration twice.
When adding a mod to an existing save, all migration scripts for that mod will be run.
