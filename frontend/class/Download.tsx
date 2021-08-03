import React, {ChangeEvent} from 'react'
import Button from '@material-ui/core/Button';
import CircularProgress from '@material-ui/core/CircularProgress';
import downloadStyle from '../styles/Download.scss';

interface DownloadProp {
  downloadPath: string
  text: string
  fileName?: string
}

interface DownloadState {
  loading: boolean
}

class Download extends React.Component<DownloadProp, DownloadState> {
  constructor(props: DownloadProp) {
    super(props)
    this.state = {
      loading: false,
    }
  }

  public fetchContent = async () => {
    try {
      this.setState({loading: true})
      const response = await fetch(this.props.downloadPath)
    } catch (error) {
      console.log(error)
    } finally {
      this.setState({loading: false})
    }
  }

  public saveFile = (object: Blob | File | MediaSource, fileName: string) => {
    const url = URL.createObjectURL(object);
    const a = document.createElement("a");
    document.body.appendChild(a);
    a.download = fileName;
    a.href = url;
    a.click();
    a.remove();
    URL.revokeObjectURL(url);
  }

  public handleButtonClick = async () => {
    if (!this.state.loading) {
      await this.fetchContent()
    }
  };

  public render() {
    return <React.Fragment>
      <Button
        variant="contained"
        color="primary"
        disabled={this.state.loading}
        onClick={this.handleButtonClick}
        className={downloadStyle.loadingBtn}
      >
        {this.props.text}
        {this.state.loading && <CircularProgress size={24} className={downloadStyle.spinner}/>}
      </Button>
    </React.Fragment>
  }
}

export default class CsvDownload extends Download {
  public fetchContent = async () => {
    try {
      this.setState({loading: true})
      const response = await fetch(this.props.downloadPath)
      const reader = response.body?.getReader();
      if (!reader) {
        throw new Error();
      }

      let responseData: string[] = [];
      const decoder = new TextDecoder();
      const writeContent = ({done, value}: any) => {
        if (done) {
          this.saveFile(new Blob(responseData, {type: 'text/csv'}), this.getFileName(response));
          return;
        }
        responseData.push(decoder.decode(value));
        reader.read().then(writeContent)
      }
      reader.read().then(writeContent)
    } catch (error) {
      console.log(error)
    } finally {
      this.setState({loading: false})
    }
  }

  private getFileName = (response: Response) => {
    let name = this.props.fileName || '';
    let fileName = response.headers.get("content-disposition")?.match(/filename="(.+)"/);
    if (!fileName) {
      return name;
    }

    if (fileName && fileName.length !== 0) {
      name = fileName[1];
    }
    return name;
  }
}