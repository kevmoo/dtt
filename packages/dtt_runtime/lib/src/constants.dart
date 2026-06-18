// Copyright 2026 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Internal Shelf request context dictionary key used to forward the
/// pre-decoded CloudEvent JSON envelope Map from the router down to
/// the event parser, eliminating redundant double-decoding on the hot path.
const String envelopeContextKey = 'dtt.envelope';

/// Internal exception thrown when untrusted CloudEvent payloads or
/// Protobuf JSON structures violate expected object schema contracts.
class BadEnvelopeException implements Exception {
  final String message;
  const BadEnvelopeException(this.message);
}
