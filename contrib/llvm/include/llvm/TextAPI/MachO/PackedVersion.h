//===- llvm/TextAPI/MachO/PackedVersion.h - PackedVersion -------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Defines the Mach-O packed version format.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_TEXTAPI_MACHO_PACKED_VERSION_H
#define LLVM_TEXTAPI_MACHO_PACKED_VERSION_H

#include "llvm/ADT/StringRef.h"
#include "llvm/Support/raw_ostream.h"

namespace llvm {
namespace MachO {

class PackedVersion {
  uint32_t Version{0};

public:
  constexpr PackedVersion() = default;
  explicit constexpr PackedVersion(uint32_t RawVersion) : Version(RawVersion) {}
  PackedVersion(unsigned Major, unsigned Minor, unsigned Subminor)
      : Version((Major << 16) | ((Minor & 0xff) << 8) | (Subminor & 0xff)) {}

  bool empty() const { return Version == 0; }

  /// Retrieve the major version number.
  unsigned getMajor() const { return Version >> 16; }

  /// Retrieve the minor version number, if provided.
  unsigned getMinor() const { return (Version >> 8) & 0xff; }

  /// Retrieve the subminor version number, if provided.
  unsigned getSubminor() const { return Version & 0xff; }

  bool parse32(StringRef Str);
  std::pair<bool, bool> parse64(StringRef Str);

  bool operator<(const PackedVersion &O) const { return Version < O.Version; }

  bool operator==(const PackedVersion &O) const { return Version == O.Version; }

  bool operator!=(const PackedVersion &O) const { return Version != O.Version; }

  uint32_t rawValue() const { return Version; }

  void print(raw_ostream &OS) const;
};

inline raw_ostream &operator<<(raw_ostream &OS, const PackedVersion &Version) {
  Version.print(OS);
  return OS;
}

} // end namespace MachO.
} // end namespace llvm.

#endif // LLVM_TEXTAPI_MACHO_PACKED_VERSION_H
