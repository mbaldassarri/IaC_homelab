var express = require("express");
var router = express.Router();
var wol = require("node-wol");
const fs = require("fs");
const path = require("path");
const { NodeSSH } = require("node-ssh");
const ssh = new NodeSSH();

router.get("/turnon", function (req, res) {
  var check =
    req.query.token ===
    "5678";

  if (check) {
    // add NAS MAC Address here
    wol.wake("00:00:00:00:00:00", function (error) {
      if (error) {
        res.send("There was an error sending the WOL packet");
        return;
      } else {
        res.send("WOL Packet Sent ! Turn ON Successful !");
      }
    });
  } else {
    res.send("There was an error turning on the NAS");
  }
});

router.get("/turnoff", function (req, res) {
  var check =
    req.query.token ===
    "1234";
  if (check) {
    ssh
      .connect({
        host: "192.168.1.3",
        username: "user",
        port: 22,
        privateKeyPath: "/app/routes/id_rsa",
      })
      .then(function () {
        ssh.execCommand("sudo poweroff").then(function (result) {
          res.send("Server is going to sleep");
        });
      });
  } else {
    res.send("Wrong Token!");
  }
});

module.exports = router;
