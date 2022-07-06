//  Created by B.T. Franklin on 7/4/22

@resultBuilder
public enum PathBuilder {

    public static func buildBlock() -> [PathComponent] {
        [EmptyPath() as PathComponent]
    }

    public static func buildBlock(_ components: [PathComponent]...) -> [PathComponent] {
        components.reduce([], { partialResult, element in
            partialResult + element
        })
    }

    public static func buildBlock(_ components: PathComponent...) -> [PathComponent] {
        components.compactMap { $0 }
    }

    public static func buildOptional(_ components: [PathComponent]?) -> [PathComponent] {
        [components] as? [PathComponent] ?? [EmptyPath()]
    }

    public static func buildEither(first components: [PathComponent]) -> [PathComponent] {
        components
    }

    public static func buildEither(second components: [PathComponent]) -> [PathComponent] {
        components
    }

}
