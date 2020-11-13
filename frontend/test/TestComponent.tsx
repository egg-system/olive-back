import React from "react"

type Props = {
  test: string
}

class TestComponent extends React.Component<Props, {}> {
  render() {
    return <div className="test">
      {this.props.test}
    </div>
  }
}

export default TestComponent
