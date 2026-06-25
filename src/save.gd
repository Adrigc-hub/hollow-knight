# Very small save helper (optional)
extends Node

func save_table(path: String, table):
    var file := File.new()
    file.open(path, File.WRITE)
    file.store_var(table)
    file.close()

func load_table(path: String):
    var file := File.new()
    if file.file_exists(path):
        file.open(path, File.READ)
        var v = file.get_var()
        file.close()
        return v
    return null
