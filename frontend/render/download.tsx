import React from 'react'
import ReactDOM from 'react-dom'
import CsvDownload from "../class/Download";

const id = "download";

export const renderDownloadButton = () => {
  const element = document.getElementById(id)
  if (!element) {
    return
  }
  const path = element.dataset["path"]
  const text = element.innerText

  if (!path || !text) {
    return
  }

  ReactDOM.render(
    <CsvDownload
      downloadPath={path}
      text={text}
    />,
    element
  );
}
