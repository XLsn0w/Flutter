// Copyright 2018 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// https://pub.dartlang.org/packages/test

import "package:test/test.dart";

void main() {
  setUp(() async => print("setUp1"));
  setUp(() async => print("setUp2"));
  setUp(() async => print("tearDown"));

  test("String.split() splits the string on the delimiter", () {
    var string = "foo,bar,baz";
    expect(string.split(","), equals(["foo", "bar", "baz"]));
  });

  test("String.trim() removes surrounding whitespace", () {
    var string = "  foo ";
    expect(string.trim(), equals("foo"));
  });

  group("String", () {
    test(".split() splits the string on the delimiter", () {
      var string = "foo,bar,baz";
      expect(string.split(","), equals(["foo", "bar", "baz"]));
    });

    test(".trim() removes surrounding whitespace", () {
      var string = "  foo ";
      expect(string.trim(), equals("foo"));
    });
  });

  group("int", () {
    setUp(() async => print("group setUp"));
    setUp(() async => print("group tearDown"));

    test(".remainder() returns the remainder of division", () {
      expect(11.remainder(3), equals(2));
    });

    test(".toRadixString() returns a hex string", () {
      expect(11.toRadixString(16), equals("b"));
    });
  });

  test(".split() splits the string on the delimiter", () {
    expect(
      "foo,bar,baz",
      allOf([
        contains("foo"),
        isNot(startsWith("bar")),
        endsWith("baz"),
      ]),
    );
  });
}
