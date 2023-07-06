import http from '@ohos.net.http'

class HttpRequest {
  url: string
  extraData: Object
  options: http.HttpRequestOptions

  constructor() {
    this.url = ''
    this.options = {
      method: http.RequestMethod.GET,
      extraData: this.extraData,
      header: { 'Content-Type': 'application/json' },
      readTimeout: 50000,
      connectTimeout: 50000
    }
  }

  setUrl(url: string) {
    this.url = url
  }

  setMethod(method: string) {
    switch (method) {
      case 'GET':
        this.options.method = http.RequestMethod.GET
        break
      case 'POST':
        this.options.method = http.RequestMethod.POST
        break
      case 'PUT':
        this.options.method = http.RequestMethod.PUT
        break
      case 'DELETE':
        this.options.method = http.RequestMethod.DELETE
        break
      default:
        this.options.method = http.RequestMethod.GET
        break
    }
  }

  setExtraData(extraData: Object) {
    this.options.extraData = extraData
  }

  setOptions(option: Object) {
    this.options = option
  }

  setList(list: number[], flag: number) {
    list = []
    for (let i = 0; i < flag; i++) {
      list[i] = i
    }
    return list
  }

  setParameter(keys: string[], values: string[]) {
    let result = {}
    for (let i = 0; i <= keys.length - 1; i++) {
      let key = keys[i]
      let value = values[i]
      result[key] = value
    }
    return result
  }

  async request(callback) {
    console.log('HttpRequest-url = ' + this.url);
    let httpRequest = http.createHttp()
    let result = httpRequest.request(this.url, this.options)
    result.then((data) =>{
      if (data.responseCode == 200) {
        let resultJson = JSON.parse(data.result.toString())
        callback.onSuccess(resultJson)
      } else {
        callback.onFail(data.responseCode)
      }
    })
  }
}

export default new HttpRequest()