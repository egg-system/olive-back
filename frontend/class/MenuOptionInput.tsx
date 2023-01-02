import React, { Fragment, ChangeEvent } from 'react'

interface Item {
  text: string
  value: number
}

interface MenuItem extends Item {
  menu_category_id: number
}

interface OptionItem extends Item {
  menu_category_ids: number[]
}

interface inputOptions<Item> {
  name: string
  label: string
  items: Item[]
  hint: string
  required: boolean
  disabled: boolean
  value: Array<number> | number | null
}

interface MenuOptionInputProps {
  menuInputOptions: inputOptions<MenuItem>
  optionInputOptions: inputOptions<OptionItem>
}

interface MenuOptionInputState {
  selectedMenuId: number | null
  selectedOptionIds: Array<number> | null
}

export default class MenuOptionInput
extends React.Component<MenuOptionInputProps, MenuOptionInputState>
{
  constructor(props: MenuOptionInputProps) {
    super(props)

    this.state = {
      selectedMenuId: props.menuInputOptions.value as number || null,
      selectedOptionIds: props.optionInputOptions.value as Array<number> || null
    }
  }

  private getMenuCategoryId = (): number | null => {
    if (this.state.selectedMenuId === null) {
      return null
    }

    const selectedMenuItem = this.getMenuItem(this.state.selectedMenuId)
    return selectedMenuItem?.menu_category_id === undefined
      ? null
      : selectedMenuItem.menu_category_id
  }

  private getRequiredClass = (className: string, required: boolean): string => {
    return `${className} ${required ? 'required' : ''}`
  }

  private getMenuItem = (menuId: number | null): MenuItem | null => {
    if (menuId === null) {
      return null
    }

    const menuItems = this.props.menuInputOptions.items
    const item = menuItems.find((item) => item.value === menuId)
    return item === undefined ? null : item
  }

  private changeSelectedMenuId = (event: ChangeEvent) => {
    const element = event.target as HTMLSelectElement
    
    const isSelected = element.value !== undefined && element.value !== ''
    const selectedMenuId = isSelected ? Number(element.value) : null

    // カテゴリIDの新旧を比較する
    let selectedOptionIds = this.state.selectedOptionIds
    const newMenuItem = this.getMenuItem(selectedMenuId)
    const newMenuCategoryId = newMenuItem ? newMenuItem.menu_category_id : null
    const oldMenuCategoryId = this.getMenuCategoryId()

    // メニューカテゴリIDが変わった場合、選択されているオプションを精査する
    if (newMenuCategoryId !== null && newMenuCategoryId !== oldMenuCategoryId) {
      const optionItems = this.props.optionInputOptions.items
      const validOptionIds = optionItems.filter((item) => {
        if (!this.state.selectedOptionIds?.includes(item.value)) {
          return false
        }

        return item.menu_category_ids.includes(newMenuCategoryId)
      }).map((option) => option.value)
      selectedOptionIds = validOptionIds.length === 0 ? null : validOptionIds
    }

    // 未選択の場合は空にする
    if (newMenuCategoryId === null) {
      selectedOptionIds = null
    }

    this.setState({ selectedMenuId, selectedOptionIds })
  }

  private changeSelectedOptionIds = (event: ChangeEvent) => {
    const element = event.target as HTMLInputElement
    const optionItems = this.props.optionInputOptions.items
    const selectedOptionIds = optionItems.filter((optionItem) => {
      if (element.value === String(optionItem.value)) {
        return element.checked
      }

      return this.state.selectedOptionIds?.includes(optionItem.value)
    }).map((optionItem) => optionItem.value)

    this.setState({ selectedOptionIds })
  }

  private getOptionInputHint = (): string => {
    if (this.props.optionInputOptions.hint !== '') {
      return this.props.optionInputOptions.hint
    }

    if (this.state.selectedMenuId === null) {
      return 'メニューを選択しなければ、オプションは選択できません。'
    }
    
    return '選択されたメニューで使用可能なオプションのみ、チェックをつけられます。'
  }

  public render() {
    return <Fragment>
      <div className={ 
        this.getRequiredClass(
          'form-group row select required',
          this.props.menuInputOptions.required
        )
      } >
        <label className="col-sm-3 col-form-label select">
          メニュー {
            this.props.menuInputOptions.required &&
            <abbr className="req">&nbsp;(必須)</abbr>
          }
        </label>
        <div className='col-sm-9'>
          <select
            className={ this.getRequiredClass(
              'form-control select required',
              this.props.menuInputOptions.required
            ) }
            name={ this.props.menuInputOptions.name }
            value={ this.state.selectedMenuId
                ? Number(this.state.selectedMenuId)
                : undefined
            }
            required={ this.props.menuInputOptions.required }
            area-required={
              this.props.menuInputOptions.required ? 'true' : null
            }
            disabled={ this.props.menuInputOptions.disabled }
            onChange={ this.changeSelectedMenuId }
          >
            <option />
            {
              this.props.menuInputOptions.items.map((item) => {
                return <option
                  key={ item.value }
                  value={ item.value }
                >{ item.text }</option>
              })
            }
          </select>
        </div>
      </div>
      <hr />
      <div className='custom_row row'>
        <div className='custom_left col-sm-3'>
          <label>
            オプション {
              this.props.optionInputOptions.required &&
              <abbr className="req">&nbsp;(必須)</abbr>
            }
          </label>
        </div>
        <div className="custom_right col-sm-9 custom_input_row">
            <input
              type='hidden'
              name={ this.props.optionInputOptions.name }
              value=''
            />
            { this.props.optionInputOptions.items.map((item) => {
              const menuCategoryId = this.getMenuCategoryId()
              return <span key={ item.value }>
                <input
                  id={ `${this.props.optionInputOptions.name}_${item.value}` }
                  type='checkbox'
                  name={ this.props.optionInputOptions.name }
                  value={ item.value }
                  onChange={ this.changeSelectedOptionIds }
                  disabled={
                    menuCategoryId === null
                    || !item.menu_category_ids?.includes(menuCategoryId)
                  }
                  checked={ this.state.selectedOptionIds !== null
                    && this.state.selectedOptionIds?.includes(item.value) }
                />
                <label
                  htmlFor={ `${this.props.optionInputOptions.name}_${item.value}` }
                  className='check_box_label'
                >{ item.text }</label>
              </span>
            }) }
            <small className='form-text text-muted'>
              { this.getOptionInputHint() }
            </small>
        </div>
      </div>
    </Fragment>
  }
}
