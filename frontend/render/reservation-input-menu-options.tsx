import React from 'react'
import ReactDOM from 'react-dom'
import MenuOptionInput from '../class/MenuOptionInput'

export const renderInputMenuOptions = () => {
  const elementId = 'react_input_reservation_menu_options'
  const element = document.getElementById(elementId)

  // 関係ない場所ではrenderしない
  if (!element) {
    return
  }

  const namePrefix = element.getAttribute('data-input-name-prefix')
  const reservationDetailIndex = element.getAttribute('data-reservation-detail-index')
  const inputNamePrefix = `${namePrefix}[${reservationDetailIndex}]`

  const menuInputId = element.getAttribute('data-menu-input-id')
  const menuInputName = element.getAttribute('data-menu-input-name')
  const menuItems = JSON.parse(element.getAttribute('data-menu-items') ?? '')
  const menuValue = element.getAttribute('data-menu-value')
  const menuInputOptions = {
    id: menuInputId ?? '',
    name: `${inputNamePrefix}${menuInputName}`,
    label: element.getAttribute('data-menu-label') ?? '',
    items: menuItems,
    hint: element.getAttribute('data-menu-hint') ?? '',
    required: element.getAttribute('data-menu-required') === 'true',
    disabled: element.getAttribute('data-menu-disabled') === 'true',
    value: menuValue === null ? null : Number(menuValue)
  }

  let selectedOptionIds = JSON.parse(element.getAttribute('data-option-value') ?? '')
  if (!Array.isArray(selectedOptionIds)) {
    selectedOptionIds = null
  }
  const optionInputId = element.getAttribute('data-option-input-id')
  const optionInputName = element.getAttribute('data-option-input-name')
  const optionItems = JSON.parse(element.getAttribute('data-option-items') ?? '')
  const optionInputOptions = {
    id: optionInputId ?? '',
    name: `${inputNamePrefix}${optionInputName}`,
    label: element.getAttribute('data-option-label') ?? '',
    items: optionItems,
    hint: element.getAttribute('data-option-hint') ?? '',
    required: element.getAttribute('data-option-required') === 'true',
    disabled: element.getAttribute('data-option-disabled') === 'true',
    value: selectedOptionIds
  }
  return ReactDOM.render(
    <MenuOptionInput
      menuInputOptions={ menuInputOptions }
      optionInputOptions={ optionInputOptions }
    />,
    element
  )
}
