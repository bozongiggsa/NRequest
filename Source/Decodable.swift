import Foundation

// sourcery: fakable
public protocol CustomDecodable {
    associatedtype Object

    var result: Result<Object, Error> { get }

    init(with data: ResponseData)
}

struct VoidContent: CustomDecodable {
    var result: Result<Void, Error>

    init(with data: ResponseData) {
        if let error = data.error {
            if let error = data.error as? StatusCode {
                switch error {
                case .noContent,
                     .accepted,
                     .created,
                     .nonAuthoritativeInformation,
                     .resetContent,
                     .partialContent,
                     .multiStatus,
                     .alreadyReported,
                     .imUsed:
                    self.result = .success(())
                case .badRequest,
                     .multipleChoises,
                     .movedPermanently,
                     .found,
                     .seeOther,
                     .notModified,
                     .temporaryRedirect,
                     .permanentRedirect,
                     .unauthorized,
                     .notFound,
                     .methodNotAllowed,
                     .notAcceptable,
                     .proxyAuthenticationRequiered,
                     .timeout,
                     .forbidden,
                     .conflict,
                     .gone,
                     .lenghtRequired,
                     .preconditionFailed,
                     .payloadTooLarge,
                     .uriTooLong,
                     .unsupportedMediaType,
                     .rangeNotSatisfiable,
                     .expectationFailed,
                     .teapot,
                     .unprocessableEntity,
                     .upgradeRequired,
                     .preconditionRequired,
                     .tooManyRequests,
                     .headersTooLarge,
                     .unavailableForLegalReasons,
                     .serverError,
                     .notImplemented,
                     .badGateway,
                     .serviceUnavailable,
                     .gatewayTimeout,
                     .httpVersionNotSupported,
                     .variantAlsoNegotiates,
                     .insufficiantStorage,
                     .loopDetected,
                     .notExtended,
                     .networkAuthenticationRequired,
                     .other:
                    break
                }
            } else if let error = data.error as? DecodingError {
                switch error {
                case .nilResponse:
                    self.result = .success(())
                case .brokenResponse:
                    break
                }
            }

            self.result = .failure(error)
        } else {
            self.result = .success(())
        }
    }
}

struct DecodableContent<Response: Decodable>: CustomDecodable {
    var result: Result<Response?, Error>

    init(with data: ResponseData) {
        if let error = data.error {
            self.result = .failure(error)
        } else if let data = data.body {
            do {
                let decoder = (Response.self as? CustomizedDecodable.Type)?.decoder ?? JSONDecoder()
                self.result = .success(try decoder.decode(Response.self, from: data))
            } catch {
                self.result = .failure(error)
            }
        } else {
            self.result = .success(nil)
        }
    }
}

struct ImageContent: CustomDecodable {
    var result: Result<Image?, Error>

    init(with data: ResponseData) {
        if let error = data.error {
            self.result = .failure(error)
        } else if let data = data.body {
            if let image = PlatformImage(data: data)?.sdk {
                self.result = .success(image)
            } else {
                self.result = .failure(DecodingError.brokenResponse)
            }
        } else {
            self.result = .success(nil)
        }
    }
}

struct DataContent: CustomDecodable {
    var result: Result<Data?, Error>

    init(with data: ResponseData) {
        if let error = data.error {
            self.result = .failure(error)
        } else if let data = data.body {
            self.result = .success(data)
        } else {
            self.result = .success(nil)
        }
    }
}

struct JSONContent: CustomDecodable {
    var result: Result<Any?, Error>

    init(with data: ResponseData) {
        if let error = data.error {
            self.result = .failure(error)
        } else if let data = data.body {
            do {
                self.result = .success(try JSONSerialization.jsonObject(with: data))
            } catch {
                self.result = .failure(error)
            }
        } else {
            self.result = .success(nil)
        }
    }
}
