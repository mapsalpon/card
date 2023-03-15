import 'dart:ui';
import 'package:flutter/material.dart';

var pixelRatio = window.devicePixelRatio;
var screenSize = window.physicalSize;
var screenWidth = screenSize.width / pixelRatio;
var screenHeight = screenSize.height / pixelRatio;