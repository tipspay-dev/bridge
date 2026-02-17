const fs = require("fs");

module.exports = {
  loadCursor(path) {
    if (!fs.existsSync(path)) return 0;
    return Number(fs.readFileSync(path, "utf8"));
  },

  saveCursor(path, block) {
    fs.writeFileSync(path, String(block));
  }
};
