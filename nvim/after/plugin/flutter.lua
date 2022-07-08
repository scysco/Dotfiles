local status_ok, flutterTools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

flutterTools.setup{} -- use defaults


