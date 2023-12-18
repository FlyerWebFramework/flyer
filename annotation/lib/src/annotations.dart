class SimpleAnnotation {
  final bool addHello;

  const SimpleAnnotation({this.addHello = false});
}

const simple = SimpleAnnotation();


class PropertyAnnotation {
  const PropertyAnnotation();
}

class ObservableAnnotation {
  const ObservableAnnotation();
}

class ScriptAnnotation {
  const ScriptAnnotation();
}

class ComputedAnnotation {
  const ComputedAnnotation();
}

class ComponentAnnotation {
  const ComponentAnnotation();
}

const script = ScriptAnnotation();
const property = PropertyAnnotation();
const observable = ObservableAnnotation();
const computed = ComputedAnnotation();
const component = ComponentAnnotation();
