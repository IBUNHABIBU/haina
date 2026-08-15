import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["count", "list"]

  connect() {
    this.loadPreferences()
    this.updateCount()
    this.setupKeyboardShortcuts()
    
    // Listen for custom events
    document.addEventListener('show-all-columns', this.showAll.bind(this))
    document.addEventListener('hide-all-columns', this.hideAll.bind(this))
    document.addEventListener('reset-columns', this.resetDefaults.bind(this))
  }

  disconnect() {
    document.removeEventListener('show-all-columns', this.showAll.bind(this))
    document.removeEventListener('hide-all-columns', this.hideAll.bind(this))
    document.removeEventListener('reset-columns', this.resetDefaults.bind(this))
  }

  setupKeyboardShortcuts() {
    document.addEventListener('keydown', (e) => {
      // Ctrl+Shift+H to toggle columns panel
      if (e.ctrlKey && e.shiftKey && e.key === 'H') {
        e.preventDefault()
        const toggleBtn = document.querySelector('[data-action="click->dropdown#toggle"]')
        if (toggleBtn) toggleBtn.click()
      }
    })
  }

  toggleColumn(event) {
    const checkbox = event.currentTarget
    const columnName = checkbox.dataset.column
    const isChecked = checkbox.checked

    this.toggleColumnVisibility(columnName, isChecked)
    this.savePreferences()
    this.updateCount()
    
    // Show feedback
    this.showToast(
      isChecked ? `Showing "${this.getColumnLabel(columnName)}"` : `Hidden "${this.getColumnLabel(columnName)}"`,
      isChecked ? 'success' : 'info'
    )
  }

  hideColumn(event) {
    const columnName = event.currentTarget.dataset.column
    const checkbox = document.querySelector(`.column-toggle[data-column="${columnName}"]`)
    
    if (checkbox) {
      checkbox.checked = false
      this.toggleColumnVisibility(columnName, false)
      this.savePreferences()
      this.updateCount()
      this.showToast(`Hidden "${this.getColumnLabel(columnName)}"`, 'info')
    }
  }

  toggleColumnVisibility(columnName, isChecked) {
    // Toggle header columns
    const headers = document.querySelectorAll(`.column-header.${columnName}`)
    headers.forEach(header => {
      header.style.display = isChecked ? '' : 'none'
    })

    // Toggle body cells
    const cells = document.querySelectorAll(`td.${columnName}`)
    cells.forEach(cell => {
      cell.style.display = isChecked ? '' : 'none'
    })
  }

  showAll() {
    const checkboxes = document.querySelectorAll('.column-toggle')
    checkboxes.forEach(checkbox => {
      checkbox.checked = true
      const columnName = checkbox.dataset.column
      this.toggleColumnVisibility(columnName, true)
    })
    this.savePreferences()
    this.updateCount()
    this.showToast('Showing all columns', 'success')
  }

  hideAll() {
    const checkboxes = document.querySelectorAll('.column-toggle')
    checkboxes.forEach(checkbox => {
      if (checkbox.dataset.column !== 'actions') {
        checkbox.checked = false
        const columnName = checkbox.dataset.column
        this.toggleColumnVisibility(columnName, false)
      }
    })
    this.savePreferences()
    this.updateCount()
    this.showToast('Hiding all columns (except Actions)', 'info')
  }

  resetDefaults() {
    // Define default visible columns
    const defaultColumns = [
      'customer', 'phone', 'tv_brand', 'tv_size', 'model_no',
      'date_in', 'status', 'profit', 'actions'
    ]
    
    document.querySelectorAll('.column-toggle').forEach(checkbox => {
      const columnName = checkbox.dataset.column
      const shouldShow = defaultColumns.includes(columnName)
      checkbox.checked = shouldShow
      this.toggleColumnVisibility(columnName, shouldShow)
    })
    
    localStorage.removeItem('columnPreferences')
    this.updateCount()
    this.showToast('Reset to default columns', 'success')
  }

  filterColumns(event) {
    const query = event.currentTarget.value.toLowerCase()
    const items = this.listTarget.querySelectorAll('.column-item')
    
    items.forEach(item => {
      const label = item.querySelector('span').textContent.toLowerCase()
      if (label.includes(query)) {
        item.style.display = ''
      } else {
        item.style.display = 'none'
      }
    })
  }

  updateCount() {
    const checkboxes = document.querySelectorAll('.column-toggle:checked')
    if (this.hasCountTarget) {
      this.countTarget.textContent = checkboxes.length
    }
  }

  getColumnLabel(columnName) {
    const labels = {
      customer: 'Customer',
      phone: 'Phone',
      tv_brand: 'TV Brand',
      tv_size: 'TV Size',
      model_no: 'Model No',
      date_in: 'Date In',
      date_out: 'Date Out',
      starting_price: 'Starting Price',
      final_price: 'Final Price',
      status: 'Status',
      spare_used: 'Spare Used',
      cost_each: 'Cost Each',
      total_cost: 'Total Cost',
      labour_cost: 'Labour Cost',
      profit: 'Profit',
      user_id: 'User ID',
      remarks: 'Remarks',
      actions: 'Actions'
    }
    return labels[columnName] || columnName
  }

  showToast(message, type = 'info') {
    const toast = document.createElement('div')
    toast.className = `fixed bottom-4 right-4 px-4 py-2 rounded-lg shadow-lg text-white z-50 transition-all duration-300 transform ${
      type === 'success' ? 'bg-green-600' : 'bg-blue-600'
    }`
    toast.textContent = message
    toast.style.transform = 'translateY(100px)'
    toast.style.opacity = '0'
    
    document.body.appendChild(toast)
    
    setTimeout(() => {
      toast.style.transform = 'translateY(0)'
      toast.style.opacity = '1'
    }, 100)
    
    setTimeout(() => {
      toast.style.transform = 'translateY(100px)'
      toast.style.opacity = '0'
      setTimeout(() => toast.remove(), 300)
    }, 2000)
  }

  savePreferences() {
    const checkboxes = document.querySelectorAll('.column-toggle')
    const preferences = {}
    checkboxes.forEach(checkbox => {
      preferences[checkbox.dataset.column] = checkbox.checked
    })
    localStorage.setItem('columnPreferences', JSON.stringify(preferences))
  }

  loadPreferences() {
    const saved = localStorage.getItem('columnPreferences')
    if (saved) {
      const preferences = JSON.parse(saved)
      const checkboxes = document.querySelectorAll('.column-toggle')
      checkboxes.forEach(checkbox => {
        const columnName = checkbox.dataset.column
        if (preferences.hasOwnProperty(columnName)) {
          checkbox.checked = preferences[columnName]
          this.toggleColumnVisibility(columnName, preferences[columnName])
        }
      })
    }
  }
}