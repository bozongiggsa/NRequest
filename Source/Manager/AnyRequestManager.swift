import Foundation
import NCallback

public struct AnyRequestManager<Error: AnyError>: RequestManager {
    private let box: AbstractRequestFactory<Error>

    public init<K: RequestManager>(_ provider: K) where K.Error == Error {
        self.box = RequestFactoryBox(provider)
    }

    public func requestPureData(with parameters: Parameters) -> Callback<ResponseData> {
        return box.requestPureData(with: parameters)
    }

    public func requestCustomDecodable<T: CustomDecodable>(_ type: T.Type, with parameters: Parameters) -> ResultCallback<T.Object, Error> {
        return box.requestCustomDecodable(type, with: parameters)
    }

    public func requestVoid(with parameters: Parameters) -> ResultCallback<Void, Error> {
        return box.requestVoid(with: parameters)
    }

    public func requestDecodable<T: Decodable>(_ type: T.Type, with parameters: Parameters) -> ResultCallback<T, Error> {
        return box.requestDecodable(type, with: parameters)
    }

    public func request<T: Decodable>(with parameters: Parameters) -> ResultCallback<T, Error> {
        return box.request(with: parameters)
    }

    public func requestImage(with parameters: Parameters) -> ResultCallback<Image, Error> {
        return box.requestImage(with: parameters)
    }

    public func requestOptionalImage(with parameters: Parameters) -> ResultCallback<Image?, Error> {
        return box.requestOptionalImage(with: parameters)
    }

    public func requestData(with parameters: Parameters) -> ResultCallback<Data, Error> {
        return box.requestData(with: parameters)
    }

    public func requestOptionalData(with parameters: Parameters) -> ResultCallback<Data?, Error> {
        return box.requestOptionalData(with: parameters)
    }

    public func requestAny(with parameters: Parameters) -> ResultCallback<Any, Error> {
        return box.requestAny(with: parameters)
    }

    public func requestOptionalAny(with parameters: Parameters) -> ResultCallback<Any?, Error> {
        return box.requestOptionalAny(with: parameters)
    }
}

private class AbstractRequestFactory<Error: AnyError>: RequestManager {
    func requestPureData(with parameters: Parameters) -> Callback<ResponseData> {
        fatalError("abstract needs override")
    }

    func requestCustomDecodable<T: CustomDecodable>(_: T.Type, with _: Parameters) -> ResultCallback<T.Object, Error> {
        fatalError("abstract needs override")
    }

    func requestVoid(with _: Parameters) -> ResultCallback<Void, Error> {
        fatalError("abstract needs override")
    }

    func requestDecodable<T: Decodable>(_: T.Type, with _: Parameters) -> ResultCallback<T, Error> {
        fatalError("abstract needs override")
    }

    func request<T: Decodable>(with _: Parameters) -> ResultCallback<T, Error> {
        fatalError("abstract needs override")
    }

    func requestImage(with _: Parameters) -> ResultCallback<Image, Error> {
        fatalError("abstract needs override")
    }

    func requestOptionalImage(with _: Parameters) -> ResultCallback<Image?, Error> {
        fatalError("abstract needs override")
    }

    func requestData(with _: Parameters) -> ResultCallback<Data, Error> {
        fatalError("abstract needs override")
    }

    func requestOptionalData(with _: Parameters) -> ResultCallback<Data?, Error> {
        fatalError("abstract needs override")
    }

    func requestAny(with _: Parameters) -> ResultCallback<Any, Error> {
        fatalError("abstract needs override")
    }

    func requestOptionalAny(with _: Parameters) -> ResultCallback<Any?, Error> {
        fatalError("abstract needs override")
    }
}

private final class RequestFactoryBox<T: RequestManager>: AbstractRequestFactory<T.Error> {
    private var concrete: T

    init(_ concrete: T) {
        self.concrete = concrete
    }

    override func requestPureData(with parameters: Parameters) -> Callback<ResponseData> {
        return concrete.requestPureData(with: parameters)
    }

    override func requestCustomDecodable<T: CustomDecodable>(_ type: T.Type, with parameters: Parameters) -> ResultCallback<T.Object, Error> {
        return concrete.requestCustomDecodable(type, with: parameters)
    }

    override func requestVoid(with parameters: Parameters) -> ResultCallback<Void, T.Error> {
        return concrete.requestVoid(with: parameters)
    }

    override func requestDecodable<T: Decodable>(_ type: T.Type, with parameters: Parameters) -> ResultCallback<T, Error> {
        return concrete.requestDecodable(type, with: parameters)
    }

    override func request<T: Decodable>(with parameters: Parameters) -> ResultCallback<T, Error> {
        return concrete.request(with: parameters)
    }

    override func requestImage(with parameters: Parameters) -> ResultCallback<Image, Error> {
        return concrete.requestImage(with: parameters)
    }

    override func requestOptionalImage(with parameters: Parameters) -> ResultCallback<Image?, Error> {
        return concrete.requestOptionalImage(with: parameters)
    }

    override func requestData(with parameters: Parameters) -> ResultCallback<Data, Error> {
        return concrete.requestData(with: parameters)
    }

    override func requestOptionalData(with parameters: Parameters) -> ResultCallback<Data?, Error> {
        return concrete.requestOptionalData(with: parameters)
    }

    override func requestAny(with parameters: Parameters) -> ResultCallback<Any, Error> {
        return concrete.requestAny(with: parameters)
    }

    override func requestOptionalAny(with parameters: Parameters) -> ResultCallback<Any?, Error> {
        return concrete.requestOptionalAny(with: parameters)
    }
}
