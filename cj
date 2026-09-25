<!DOCTYPE html>

<html>

<head>

  <base target="_top">

<meta
 name="viewport"
 content="width=device-width, initial-scale=1, viewport-fit=cover">

  <title>RICHCAN MECHANICAL</title>

 <style>
    * {
      box-sizing: border-box;
    }

    html,
    body {
      margin: 0;
      padding: 0;
      width: 100%;
      min-height: 100%;
      background: #fff;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
      color: #222;
    }

    body {
      padding: 16px 0;
    }

    .container {
      width: 92%;
      max-width: 600px;
      margin: 0 auto;
    }

    /* =====================================================
       HEADER
       ===================================================== */

    .header {
      text-align: left;
      margin-bottom: 20px;
      padding-top: 4px;
    }

   

    .subtitle {
      margin-top: 4px;
      font-size: 15px; /* 辅助文字 */
      color: #17365D;
    }

    /* =====================================================
       SECTION
       ===================================================== */

    .section {
      margin-bottom: 20px;
    }

    .section-title {
      margin-bottom: 8px;
      padding-left: 2px;
      font-size: 16px; /* 卡片组标题 */
      font-weight: 600;
      color: #444;
    }

    .section-box {
      padding: 14px;
      border: 1px solid #e0e0e0;
      border-radius: 10px;
      background: #fafafa;
    }

    /* =====================================================
       FORM
       ===================================================== */

    .form-group {
      margin-bottom: 14px;
    }

    .form-group:last-child {
      margin-bottom: 0;
    }

    label {
      display: block;
      margin-bottom: 6px;
      font-size: 14px; /* 表单标签 */
      font-weight: 600;
      color: #333;
    }

    input,
    select,
    textarea {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      background: #fff;
      color: #222;
      font-family: inherit;
      font-size: 16px; /* 移动端标准输入字号，防止 iOS 缩放 */
      outline: none;
    }

    input:focus,
    select:focus,
    textarea:focus {
      border-color: #007aff;
    }

    input:disabled,
    select:disabled,
    textarea:disabled {
      background: #eee;
      color: #777;
    }

   textarea {
      min-height: 100px;
      resize: vertical;
      padding: 10px 12px;     /* 规范内边距：上下 10px，左右 12px */
      text-indent: 0;         /* 确保首行无额外缩进 */
      text-align: left;       /* 强制文本左对齐 */
    }

    .field-help {
      margin-top: 4px;
      font-size: 13px;
      color: #777;
      line-height: 1.4;
    }

    /* =====================================================
       CUSTOMER SEARCH
       ===================================================== */

    .search-row {
      display: flex;
      gap: 8px;
    }

    .search-row input {
      flex: 1;
      min-width: 0;
    }

    .search-button {
      flex-shrink: 0;
      padding: 0 16px;
      height: 46px;
      border: 1px solid #bbb;
      border-radius: 8px;
      background: #fff;
      color: #222;
      font-size: 15px;
      font-weight: 600;
      cursor: pointer;
    }

    .search-button:active {
      background: #eee;
    }

    .search-button:disabled {
      color: #999;
      cursor: default;
    }

    /* =====================================================
       SEARCH RESULTS
       ===================================================== */

    .search-results {
      margin-top: 10px;
      display: none;
      flex-direction: column;
      gap: 8px;
    }

    .customer-result {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      background: #fff;
      text-align: left;
      cursor: pointer;
    }

    .customer-result:active {
      background: #f2f2f2;
    }

    .customer-result-name {
      font-size: 15px;
      font-weight: 600;
    }

    .customer-result-detail {
      margin-top: 2px;
      font-size: 13px;
      color: #666;
    }

    .no-results {
      padding: 10px;
      color: #666;
      font-size: 14px;
      text-align: center;
    }

    /* =====================================================
       SELECTED CUSTOMER
       ===================================================== */

    .customer-card {
      display: none;
      margin-top: 12px;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      background: #fff;
    }

    .customer-name {
      font-size: 18px;
      font-weight: 700;
    }

    .customer-detail {
      margin-top: 4px;
      font-size: 14px;
      color: #555;
      line-height: 1.4;
    }

   

    /* =====================================================
       CREDIT
       ===================================================== */

    .credit-box {
      margin-top: 10px;
      padding-top: 10px;
      border-top: 1px solid #eee;
    }

    .credit-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 10px;
    }

    .credit-label {
      font-size: 14px;
      font-weight: 600;
      color: #555;
    }

    .credit-value {
      font-size: 16px;
      font-weight: 700;
    }

    /* =====================================================
       
  .customer-info-grid
       ===================================================== */

  .customer-info-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
}

.customer-info-item {
  display: flex;
  flex-direction: column;
  gap: 3px;
  min-width: 0;
}

.customer-info-label {
  font-size: 12px;
  color: #666;
}

.customer-info-value {
  font-size: 14px;
  font-weight: 600;
  color: #222;
  overflow-wrap: anywhere;
}

@media (max-width: 600px) {
  .customer-info-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
    /* =====================================================
       REFERRAL
       ===================================================== */

    .referral-row {
      display: flex;
      gap: 8px;
    }

    .referral-row input {
      flex: 1;
      min-width: 0;
    }

    .apply-button {
      flex-shrink: 0;
      padding: 0 16px;
      height: 46px;
      border: 1px solid #bbb;
      border-radius: 8px;
      background: #fff;
      color: #222;
      font-size: 15px;
      font-weight: 600;
      cursor: pointer;
    }

    .apply-button:active {
      background: #eee;
    }

    .discount-message {
      margin-top: 8px;
      font-size: 14px;
      font-weight: 600;
    }

    /* =====================================================
       PRICE
       ===================================================== */

    .price-box {
      padding: 14px;
      border: 1px solid #e0e0e0;
      border-radius: 10px;
      background: #fafafa;
    }

    .price-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 12px;
      margin-bottom: 8px;
      font-size: 15px;
    }

    .price-row:last-child {
      margin-bottom: 0;
    }

    .price-label {
      color: #555;
    }

    .price-value {
      white-space: nowrap;
      font-weight: 600;
    }

    .discount-value {
      color: #b00020;
    }

    .total-line {
      margin-top: 10px;
      padding-top: 10px;
      border-top: 1px solid #ccc;
    }

    .total-line .price-label,
    .total-line .price-value {
      font-size: 18px;
      font-weight: 700;
      color: #222;
    }

    /* =====================================================
       BUTTONS
       ===================================================== */

    .button-area {
      display: flex;
      flex-direction: column;
      gap: 10px;
      margin-top: 10px;
      margin-bottom: 24px;
    }

    .primary-button,
    .secondary-button {
      width: 100%;
      height: 48px; /* 移动端触控标准高度 */
      border-radius: 8px;
      font-size: 16px; /* 标准按钮字号 */
      font-weight: 600;
      cursor: pointer;
    }

    .primary-button {
      border: none;
      background: #222;
      color: #fff;
    }

    .primary-button:active {
      background: #444;
    }

    .primary-button:disabled {
      background: #ccc;
      cursor: default;
    }

    .secondary-button {
      border: 1px solid #ccc;
      background: #fff;
      color: #222;
    }

    .secondary-button:active {
      background: #eee;
    }

    /* =====================================================
       TOP BACK BUTTON
       ===================================================== */
    .top-back-button {
      display: inline-flex !important;
      align-items: center !important;
      justify-content: center !important;
      gap: 4px !important;
      width: auto !important;
      height: 38px !important;
      margin-top: constant(safe-area-inset-top) !important;
      margin-top: env(safe-area-inset-top, 0px) !important;
      margin-bottom: 12px !important;
      padding: 0 12px !important;
      font-size: 15px !important;
      font-weight: 600 !important;
      line-height: 1 !important;
      color: #007aff !important;
      background: #f2f2f7 !important;
      border: 1px solid #d1d1d6 !important;
      border-radius: 8px !important;
      cursor: pointer !important;
      user-select: none !important;
      -webkit-user-select: none !important;
      -webkit-tap-highlight-color: transparent !important;
      transition: background-color 0.15s ease, transform 0.1s ease !important;
    }

    .top-back-button:active {
      background-color: #e5e5ea !important;
      transform: scale(0.96) !important;
    }

    /* =====================================================
       MOBILE
       ===================================================== */
    @media (max-width: 600px) {
      body {
        padding: 12px 0;
      }
      .container {
        width: 92%;
      }
    }

    /* =========================================================
       TOAST
       ========================================================= */

    .toast {
      position: fixed !important;
      top: unset !important;
      right: unset !important;
      bottom: calc(env(safe-area-inset-bottom, 0px) + 20px) !important;
      left: 50% !important;
      width: 88% !important;
      max-width: 360px !important;
      padding: 10px 14px !important;
      border-radius: 8px !important;
      font-size: 14px !important;
      font-weight: 500 !important;
      line-height: 1.4 !important;
      text-align: center !important;
      z-index: 999999 !important;
      opacity: 0 !important;
      visibility: hidden !important;
      transform: translateX(-50%) translateY(20px) !important;
      transition: opacity 0.25s ease, transform 0.25s ease, visibility 0.25s ease !important;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
      background-color: #323232 !important;
      color: #fff !important;
      pointer-events: none !important;
      -webkit-text-size-adjust: 100%;
      text-size-adjust: 100%;
    }

    .toast.show {
      opacity: 1 !important;
      visibility: visible !important;
      transform: translateX(-50%) translateY(0) !important;
    }

    .toast.success {
      background-color: #2e7d32 !important;
    }

    .toast.warning {
      background-color: #ed6c02 !important;
    }

    .toast.error {
      background-color: #d32f2f !important;
    }
</style>

</head>

<body>

  <div
    id="toast"
    class="toast">
  </div>

  <div class="container">


<!-- ===================================================
     HEADER
     =================================================== -->

<div class="header">
  <div class="page-header">
    <button type="button" class="back-button top-back-button" onclick="goBack()">← Back to menu</button>
    <div class="subtitle">Create Job</div>
  </div>
</div>


<!-- ===================================================
     CUSTOMER
     =================================================== -->

<div class="section">

  <div class="section-title">
    CUSTOMER
  </div>


  <div class="section-box">


    <!-- Search -->

    <div class="form-group">

      <label for="customerSearch">
        Search Customer
      </label>


      <div class="search-row">

        <input
          id="customerSearch"
          type="text"
          placeholder="Name, phone, address or email"
          autocomplete="off"
          oninput="handleCustomerSearchInput()">

      </div>


      <div
        id="searchResults"
        class="search-results">
      </div>

    </div>


   
<!-- Selected Customer -->

<div id="customerCard" class="customer-card">

  <div
    id="selectedCustomerName"
    class="customer-name">
  </div>

  <div
    id="selectedCustomerDetail"
    class="customer-detail">
  </div>

  <div
    id="creditBox"
    class="credit-box">

    <div class="customer-info-grid">

      <div class="customer-info-item">
        <span class="customer-info-label">Total Visits</span>
        <span id="totalVisits" class="customer-info-value">0</span>
      </div>

      <div class="customer-info-item">
        <span class="customer-info-label">Last Service Date</span>
        <span id="lastServiceDate" class="customer-info-value">-</span>
      </div>

      <div class="customer-info-item">
        <span class="customer-info-label">Last Service Tech</span>
        <span id="lastServiceTechnician" class="customer-info-value">-</span>
      </div>

      <div class="customer-info-item">
        <span class="customer-info-label">Available Credit</span>
        <span id="availableCredit" class="customer-info-value">$0.00</span>
      </div>

    </div>

  </div>

</div>



    <!-- Create Customer -->

    <button
      type="button"
      class="secondary-button"
      style="margin-top:14px;"
      onclick="createCustomer()">

      + Create Customer

    </button>


  </div>

</div>


<!-- ===================================================
     JOB INFORMATION
     =================================================== -->

<div class="section">

  <div class="section-title">
    JOB INFORMATION
  </div>


  <div class="section-box">

<!-- Technician -->
<div class="form-group">

  <label for="technician">
    Technician
  </label>

  <select id="technician">

    <option value="">
      Select Technician
    </option>

  </select>

</div>

    <!-- Job Date -->

    <div class="form-group">

      <label for="jobDate">
        Job Date
      </label>

      <input
        id="jobDate"
        type="date">

    </div>

    <!-- Job Time -->

<div class="form-group">

  <label for="jobTime">
    Job Time
  </label>

  <input
    id="jobTime"
    type="time">

</div>



    <!-- Job Type -->

    <div class="form-group">

      <label for="jobType">
        Job Type
      </label>

      <select id="jobType" onchange="handleJobTypeChange()">
       <option value="">Select Job Type</option>
      </select>

    </div>


    <!-- Equipment Type -->

    <div class="form-group">

      <label for="equipmentType">
        Equipment Type
      </label>

      <select
        id="equipmentType"
        onchange="handleEquipmentTypeChange()">

        <option value="">
          Select Equipment Type
        </option>

        <option value="Other">
          Other
        </option>

        <option value="Boiler">
          Boiler
        </option>

        <option value="Furnace">
          Furnace
        </option>

        <option value="Fireplace">
          Fireplace
        </option>

        <option value="Water Heater">
          Water Heater
        </option>

        <option value="Heat Pump">
          Heat Pump
        </option>

        

      </select>

    </div>


    <!-- Equipment Details -->

    


    <!-- Price Input -->

    <div
      id="customPriceGroup"
      class="form-group"
      style="display:none;">

      <label id="customPriceLabel" for="customPrice">
        Job Price
      </label>

      <input
        id="customPrice"
        type="number"
        min="0"
        step="0.01"
        value="0"
        placeholder="0.00"
        oninput="calculateTotal()">

      <div class="field-help">
        Enter the quoted price for this job.
      </div>

    </div>


    <!-- Service Price -->

    <div
      id="servicePriceGroup"
      class="form-group"
      style="display:none;">

      <label>
        Service Price
      </label>

      <input
        id="servicePrice"
        type="text"
        value="$0.00"
        readonly>

    </div>


    <!-- Priority -->

    <div class="form-group">

      <label for="priority">
        Priority
      </label>

      <select id="priority">

        <option value="Normal">
          Normal
        </option>

        <option value="Urgent">
          Urgent
        </option>

        <option value="Emergency">
          Emergency
        </option>

      </select>

    </div>


    <!-- Description -->

    <div class="form-group">

      <label for="description">
        Description
      </label>
<textarea id="description" placeholder="Describe the job..."></textarea>
    </div>


  </div>

</div>


<!-- ===================================================
     DISCOUNT
     =================================================== -->

<div class="section">

  <div class="section-title">
    DISCOUNT
  </div>


  <div class="section-box">


    <!-- Referral Code -->

    <div class="form-group">

      <label for="referralCode">
        Referral Code
      </label>


      <div class="referral-row">

        <input
          id="referralCode"
          type="text"
          placeholder="RC0001"
          autocomplete="off">


        <button
          id="applyReferralButton"
          type="button"
          class="apply-button"
          onclick="applyReferralCode()">

          Apply

        </button>

      </div>


      <div
        id="discountMessage"
        class="discount-message">
      </div>

    </div>


    <!-- Credit -->

    <div class="form-group">

      <label for="creditUsed">
        Use Credit
      </label>


      <input
        id="creditUsed"
        type="number"
        min="0"
        step="0.01"
        value="0"
        placeholder="0.00"
        oninput="calculateTotal()">

    </div>


  </div>

</div>


<!-- ===================================================
     PRICE
     =================================================== -->

<div class="section">

  <div class="section-title">
    PRICE
  </div>


  <div class="price-box">


    <div class="price-row">

      <span class="price-label">
        Service / Job Price
      </span>

      <span
        id="servicePriceDisplay"
        class="price-value">

        $0.00

      </span>

    </div>


    <div class="price-row">

      <span class="price-label">
        New Customer Discount
      </span>

      <span
        id="newCustomerDiscount"
        class="price-value discount-value">

        -$0.00

      </span>

    </div>


    <div class="price-row">

      <span class="price-label">
        Referral Discount
      </span>

      <span
        id="referralDiscount"
        class="price-value discount-value">

        -$0.00

      </span>

    </div>


    <div class="price-row">

      <span class="price-label">
        Credit Used
      </span>

      <span
        id="creditUsedDisplay"
        class="price-value discount-value">

        -$0.00

      </span>

    </div>


    <div class="price-row total-line">

      <span class="price-label">
        Total
      </span>

      <span
        id="totalAmount"
        class="price-value">

        $0.00

      </span>

    </div>


  </div>

</div>


<!-- ===================================================
     BUTTONS
     =================================================== -->

<div class="button-area">


  <button
    id="createJobButton"
    type="button"
    class="primary-button"
    onclick="createJob()">

    Create Job

  </button>


  <button
    type="button"
    class="secondary-button"
    onclick="goBack()">

    Back

  </button>


</div>


  </div>

  <script>


    /* =====================================================
       GLOBAL DATA
       ===================================================== */

    let selectedCustomer = null;

    let availableCredit = 0;

    let referralDiscountAmount = 0;

    let referralCouponServicePrice = 0;

    let referralCommission = 0;

    let referralCouponId = '';

    let newCustomerDiscountAmount = 0;

    let createJobRequestId = 0;
    let currentCreateJobRequestId = 0;

    let searchRequestId = 0;

    let searchTimer = null;

    let toastTimer = null;
    let servicePrices = {};

 

    /* =====================================================
       TOAST
       ===================================================== */

    function showToast(
      message,
      type = 'success',
      duration = 3000
    ) {

      const toast =
        document.getElementById(
          'toast'
        );


      if (!toast) {
        return;
      }


      if (toastTimer) {

        clearTimeout(
          toastTimer
        );

      }


      toast.className =
        'toast';


      toast.textContent =
        message;


      toast.classList.add(
        type
      );


      requestAnimationFrame(
        function() {

          toast.classList.add(
            'show'
          );

        }
      );


      toastTimer =
        setTimeout(
          function() {

            toast.classList.remove(
              'show'
            );

          },
          duration
        );

    }


    /* =====================================================
       INITIALIZE
       ===================================================== */

    document.addEventListener(
      'DOMContentLoaded',
      function() {

        const dateInput =
          document.getElementById(
            'jobDate'
          );


        const today =
          new Date();


        const year =
          today.getFullYear();


        const month =
          String(
            today.getMonth() + 1
          ).padStart(
            2,
            '0'
          );


        const day =
          String(
            today.getDate()
          ).padStart(
            2,
            '0'
          );


        dateInput.value =
          year +
          '-' +
          month +
          '-' +
          day;


        calculateTotal();


        window.parent.postMessage({
    type: 'RICHCAN_GET_CONFIG'
   
  }, '*');


      }
    );


/* =====================================================
   JOB TYPE CHANGE
   ===================================================== */

function handleJobTypeChange() {

  const jobType = document.getElementById('jobType').value;
  const customPriceGroup = document.getElementById('customPriceGroup');
  const servicePriceGroup = document.getElementById('servicePriceGroup');
  const customPriceLabel = document.getElementById('customPriceLabel');

  /* PM */

  if (jobType === 'PM') {

    customPriceGroup.style.display = 'none';
    servicePriceGroup.style.display = 'none';

  }

  /* All other Job Types */

  else if (
    jobType === 'Service' ||
    jobType === 'Install' ||
    jobType === 'Inspection' ||
    jobType === 'Commissioning' ||
    jobType === 'Quote' ||
    jobType === 'Other'
  ) {

    customPriceGroup.style.display = 'block';
    servicePriceGroup.style.display = 'none';
    customPriceLabel.textContent = 'Job Price';

  }

  /* Nothing selected */

  else {

    customPriceGroup.style.display = 'none';
    servicePriceGroup.style.display = 'none';

  }

  /* New Customer Discount - PM only */

  if (
  jobType === 'PM' &&
  selectedCustomer &&
  selectedCustomer.isEligibleForReferral === true
) {
  if (referralDiscountAmount > 0) {
    newCustomerDiscountAmount = 0;
  } else {
    newCustomerDiscountAmount = 20;
  }
} else {
  newCustomerDiscountAmount = 0;
}

  calculateTotal();

}    


/* =====================================================
   EQUIPMENT TYPE CHANGE
   ===================================================== */

function handleEquipmentTypeChange() {

  const jobType = document.getElementById('jobType').value;
  const equipmentType = document.getElementById('equipmentType').value;

  /* Only PM uses automatic equipment pricing. */

  if (jobType === 'PM') {

    const price = servicePrices[equipmentType] || 0;

    document.getElementById('servicePrice').value = formatMoney(price);

  }

  calculateTotal();

}



/* =====================================================
   SEARCH CUSTOMER
   ===================================================== */

function handleCustomerSearchInput() {

  
  const input = document.getElementById('customerSearch');
  const query = input.value.trim();
  console.log('HANDLE SEARCH INPUT:', input.value);

  if (searchTimer) {
    clearTimeout(searchTimer);
  }

  if (query.length < 2) {
    const results = document.getElementById('searchResults');
    results.innerHTML = '';
    results.style.display = 'none';
    return;
  }

  searchTimer = setTimeout(function() {
    searchCustomer(query);
  }, 300);
}

function searchCustomer(query) {
  const requestId = ++searchRequestId;

  showSearchResultsLoading();

  window.parent.postMessage({
    type: 'RICHCAN_SEARCH_CUSTOMERS',
    query: query,
    requestId: requestId
  }, '*');
}


/* =====================================================
   CUSTOMER SEARCH RESULT
   ===================================================== */

window.addEventListener('message', function(event) {
  if (!event.data) return;

  if (event.data.type !== 'RICHCAN_SEARCH_CUSTOMERS_RESULT') {
    return;
  }

  /* Ignore old search results */
  if (event.data.requestId !== searchRequestId) {
    return;
  }

  const customers = event.data.customers || [];
  displaySearchResults(customers);
});


/* =====================================================
   SHOW SEARCH LOADING
   ===================================================== */

function showSearchResultsLoading() {
  const results = document.getElementById('searchResults');

  results.style.display = 'flex';
  results.innerHTML = '<div class="no-results">Searching...</div>';
}


/* =====================================================
   DISPLAY SEARCH RESULTS
   ===================================================== */

function displaySearchResults(customers) {
  const results = document.getElementById('searchResults');

  results.innerHTML = '';
  results.style.display = 'flex';

  if (!customers.length) {
    results.innerHTML = '<div class="no-results">No customer found.</div>';
    return;
  }

  customers.forEach(function(customer) {
    const button = document.createElement('button');

    button.type = 'button';
    button.className = 'customer-result';

    button.innerHTML =
      '<div class="customer-result-name">' +
        escapeHtml(customer.customerName) +
      '</div>' +
      '<div class="customer-result-detail">' +
        escapeHtml(customer.customerId) +
        ' · ' +
        escapeHtml(customer.phone || '') +
        '<br>' +
        escapeHtml(customer.address || '') +
      '</div>';

    button.addEventListener('click', function() {
      selectCustomer(customer);
    });

    results.appendChild(button);
  });
}



/* =====================================================
   SELECT CUSTOMER
===================================================== */
function selectCustomer(customer) {
  selectedCustomer = customer;
  availableCredit = Number(customer.availableCredit || 0);

  document.getElementById('searchResults').style.display = 'none';
  document.getElementById('customerSearch').value = customer.customerName || '';
  document.getElementById('selectedCustomerName').textContent = customer.customerName || '';

  document.getElementById('selectedCustomerDetail').innerHTML =
    (customer.nickname ? '<strong>' + escapeHtml(customer.nickname) + '</strong><br>' : '') +
    escapeHtml(customer.address || '') +
    '<br>' +
    escapeHtml(customer.phone || '');

  const totalVisits = Number(customer.totalVisits || 0);
  const lastServiceDate = customer.lastServiceDate
    ? new Date(customer.lastServiceDate).toLocaleDateString('en-CA')
    : '-';

  document.getElementById('totalVisits').textContent = totalVisits;
  document.getElementById('lastServiceDate').textContent = lastServiceDate;
  document.getElementById('lastServiceTechnician').textContent =
    customer.lastServiceTechnician || '-';

  document.getElementById('availableCredit').textContent =
    formatMoney(availableCredit);

  document.getElementById('customerCard').style.display = 'block';

  const jobType = document.getElementById('jobType').value;

  if (jobType === 'PM' && customer.isEligibleForReferral === true) {
    newCustomerDiscountAmount = 20;
  } else {
    newCustomerDiscountAmount = 0;
  }

  clearReferralCodeData();

  const discountMessage = document.getElementById('discountMessage');

  if (discountMessage) {
    discountMessage.textContent = '';
  }

  calculateTotal();
}








    /* =====================================================
       CREATE CUSTOMER
       ===================================================== */

    function createCustomer() {

      window.parent.postMessage(
        {

          type:
            'RICHCAN_NAVIGATE',

          page:
            'createCustomer'

        },
        '*'
      );

    }


 
/* =====================================================
   APPLY REFERRAL CODE
   ===================================================== */

function applyReferralCode() {

  /*
   * Customer must be selected first
   */
  if (!selectedCustomer) {

    showToast(
      'Please select a customer first.',
      'warning',
      4000
    );

    return;
  }

  /*
 * Referral Code is only available
 * for PM jobs.
 */

const jobType =
  document.getElementById(
    'jobType'
  ).value;

if (jobType !== 'PM') {

  showToast(
    'Referral Code is only available for PM jobs.',
    'warning',
    4000
  );

  return;
}

/*
 * Referral discount is only available
 * for eligible customers with no PM Job.
 */

if (selectedCustomer.isEligibleForReferral !== true) {
  clearReferralCodeData();

  newCustomerDiscountAmount = 0;

  document.getElementById('discountMessage').textContent = '';

  calculateTotal();

  showToast(
    'Referral Code has already been used for this customer.',
    'warning',
    4000
  );

  return;
}


  /*
   * Get Referral Code
   */
  const input =
    document.getElementById(
      'referralCode'
    );

  const code =
    input.value
      .trim()
      .toUpperCase();


  /*
   * Empty code
   */
  if (!code) {

    referralDiscountAmount = 0;

    const creditUsed =
      Number(
        document.getElementById(
          'creditUsed'
        ).value || 0
      );

   newCustomerDiscountAmount =
  selectedCustomer &&
  selectedCustomer.isEligibleForReferral === true &&
  creditUsed <= 0
    ? 20
    : 0;

    document.getElementById(
      'discountMessage'
    ).textContent =
      '';

    calculateTotal();

    showToast(
      'Referral code cleared.',
      'success',
      2500
    );

    return;
  }


  /*
   * Clear current referral discount
   * while validation is in progress
   */
  referralDiscountAmount = 0;

  document.getElementById(
    'discountMessage'
  ).textContent =
    'Checking Referral Code...';

  calculateTotal();


  /*
   * Disable Apply button
   */
  const button =
    document.getElementById(
      'applyReferralButton'
    );

  if (button) {

    button.disabled = true;

    button.textContent =
      'Checking...';
  }


  /*
   * Send Referral Code to Login.html
   *
   * Login.html
   *      ↓
   * Code.gs
   *      ↓
   * validateReferralCode()
   */
  const requestId =
    Date.now();

  window.parent.postMessage({

    type:
      'RICHCAN_VALIDATE_REFERRAL_CODE',

    referralCode:
      code,

    requestId:
      requestId

  }, '*');

}




/* =====================================================
       GET BASE JOB PRICE
===================================================== */
function getBaseJobPrice() {
  const jobType = document.getElementById('jobType').value;
  const equipmentType = document.getElementById('equipmentType').value;

  if (jobType === 'PM') {
    return Number(servicePrices[equipmentType] || 0);
  }

  return Number(document.getElementById('customPrice').value || 0);
}

function clearReferralCodeData() {
  referralDiscountAmount = 0;
  referralCouponServicePrice = 0;
  referralCommission = 0;
  referralCouponId = '';
}


/* =====================================================
    CALCULATE TOTAL
===================================================== */
function calculateTotal() {
  let servicePrice = getBaseJobPrice();

  if (referralDiscountAmount > 0 && referralCouponServicePrice > 0) {
    servicePrice = referralCouponServicePrice;
  }

  const servicePriceInput = document.getElementById('servicePrice');

  if (servicePriceInput) {
    servicePriceInput.value = servicePrice.toFixed(2);
  }

  let creditUsed = Number(document.getElementById('creditUsed').value || 0);

  if (!Number.isFinite(creditUsed) || creditUsed < 0) {
    creditUsed = 0;
  }

  if (creditUsed > availableCredit) {
    showToast('Use Credit is greater than Available Credit.', 'warning', 4000);
    creditUsed = availableCredit;
    document.getElementById('creditUsed').value = availableCredit.toFixed(2);
  }

  const jobType = document.getElementById('jobType').value;

  const isEligibleForReferral =
    selectedCustomer &&
    selectedCustomer.isEligibleForReferral === true;

  let customerDiscount = 0;
  let referralDiscount = 0;

  if (jobType === 'PM' && isEligibleForReferral) {
    if (referralDiscountAmount > 0) {
      referralDiscount = Number(referralDiscountAmount || 0);
      customerDiscount = 0;
    } else if (creditUsed <= 0) {
      customerDiscount = Number(newCustomerDiscountAmount || 0);
    }
  }

  if (creditUsed > 0) {
    customerDiscount = 0;
    referralDiscount = 0;
  }

  let total = servicePrice - customerDiscount - referralDiscount - creditUsed;

  if (total < 0) {
    total = 0;
  }

  total = Math.round(total * 100) / 100;

  const servicePriceDisplay = document.getElementById('servicePriceDisplay');

  if (servicePriceDisplay) {
    servicePriceDisplay.textContent = formatMoney(servicePrice);
  }

  const newCustomerDiscountDisplay = document.getElementById('newCustomerDiscount');

  if (newCustomerDiscountDisplay) {
    newCustomerDiscountDisplay.textContent = '-' + formatMoney(customerDiscount);
  }

  const referralDiscountDisplay = document.getElementById('referralDiscount');

  if (referralDiscountDisplay) {
    referralDiscountDisplay.textContent = '-' + formatMoney(referralDiscount);
  }

  const creditUsedDisplay = document.getElementById('creditUsedDisplay');

  if (creditUsedDisplay) {
    creditUsedDisplay.textContent = '-' + formatMoney(creditUsed);
  }

  const totalDisplay = document.getElementById('totalAmount');

  if (totalDisplay) {
    totalDisplay.textContent = formatMoney(total);
  }
}

 
/* =====================================================
   CREATE JOB
   ===================================================== */

function createJob() {

  /*
   * Customer
   */

  if (!selectedCustomer) {
    showToast('Please select a customer.', 'warning', 4000);
    return;
  }

  /*
   * Job Date
   */

  const jobDate = document.getElementById('jobDate').value;

  if (!jobDate) {
    showToast('Please select a job date.', 'warning', 4000);
    return;
  }

  /*
   * Job Time
   */

  const jobTime = document.getElementById('jobTime').value;

  if (!jobTime) {
    showToast('Please select a job time.', 'warning', 4000);
    return;
  }

  /*
   * Technician
   */

  const technicianSelect = document.getElementById('technician');
  const technicianUserId = technicianSelect.value.trim();

  if (!technicianUserId) {
    showToast('Please select a technician.', 'warning', 3000);
    return;
  }

  const technician =
    technicianSelect.options[technicianSelect.selectedIndex].text;

  /*
   * Job Type
   */

  const jobType = document.getElementById('jobType').value;

  if (!jobType) {
    showToast('Please select a job type.', 'warning', 4000);
    return;
  }

  /*
   * Equipment Type
   */

  const equipmentType =
    document.getElementById('equipmentType').value;

  if (!equipmentType) {
    showToast('Please select equipment type.', 'warning', 4000);
    return;
  }

    /*
   * Price
   *
   * PM:
   *     Automatic price based on equipment.
   *
   * All other Job Types:
   *     Manual job price.
   */

  let servicePrice = 0;

  if (jobType === 'PM') {

    if (
      referralDiscountAmount > 0 &&
      referralCouponServicePrice > 0
    ) {
      servicePrice = referralCouponServicePrice;
    } else {
      servicePrice = Number(getBaseJobPrice() || 0);
    }

  } else {

    const customPrice =
      Number(document.getElementById('customPrice').value || 0);

    if (
      !Number.isFinite(customPrice) ||
      customPrice <= 0
    ) {
      showToast('Please enter the job price.', 'warning', 4000);
      return;
    }

    servicePrice = customPrice;
  }

  /*
   * Make sure price is valid.
   */

  if (!Number.isFinite(servicePrice) || servicePrice <= 0) {
    showToast('Invalid job price.', 'warning', 4000);
    return;
  }

  /*
   * Priority
   */

  const priority = document.getElementById('priority').value;

  /*
   * Description
   */

  const description =
    document.getElementById('description').value.trim();

  /*
   * Credit
   */

  let creditUsed =
    Number(document.getElementById('creditUsed').value || 0);

  if (!Number.isFinite(creditUsed) || creditUsed < 0) {
    creditUsed = 0;
  }

  /*
   * Cannot use more credit
   * than available credit.
   */

  if (creditUsed > availableCredit) {
    creditUsed = availableCredit;
  }

  /*
   * Referral Code
   */

  const referralCode =
    document.getElementById('referralCode').value
      .trim()
      .toUpperCase();

  /*
   * Discounts
   */

  let customerDiscount =
    Number(newCustomerDiscountAmount || 0);

  let referralDiscount =
    Number(referralDiscountAmount || 0);

  /*
   * Referral $30 replaces
   * normal $20 customer discount.
   */

  if (referralDiscount > 0) {
    customerDiscount = 0;
  }

  /*
   * Credit removes
   * normal $20 customer discount.
   */

  if (creditUsed > 0) {
    customerDiscount = 0;
    referralDiscount = 0;
  }

  /*
   * Total
   */

  let totalAmount =
    servicePrice -
    customerDiscount -
    referralDiscount -
    creditUsed;

  /*
   * Never allow negative total.
   */

  if (totalAmount < 0) {
    totalAmount = 0;
  }

  /*
   * Round money to 2 decimals.
   */

  servicePrice =
    Math.round(servicePrice * 100) / 100;

  customerDiscount =
    Math.round(customerDiscount * 100) / 100;

  referralDiscount =
    Math.round(referralDiscount * 100) / 100;

  creditUsed =
    Math.round(creditUsed * 100) / 100;

  totalAmount =
    Math.round(totalAmount * 100) / 100;

  /*
   * Prepare data
   */

  const data = {
    customerId: selectedCustomer.customerId,
    customerName: selectedCustomer.customerName,
    address: selectedCustomer.address || '',
    phone: selectedCustomer.phone || '',
    email: selectedCustomer.email || '',
    jobDate: jobDate,
    jobTime: jobTime,
    jobType: jobType,
    equipmentType: equipmentType,
    technician: technician,
    technicianUserId: technicianUserId,
    priority: priority,
    description: description,
    referralCode: referralCode,
    servicePrice: servicePrice,
    newCustomerDiscount: customerDiscount,
    referralDiscount: referralDiscount,
    referralCommission: Number(referralCommission || 0),
    referralCouponId: referralCouponId,
    creditUsed: creditUsed,
    totalAmount: totalAmount
  };

  /*
   * Request ID
   */

  const requestId = ++createJobRequestId;

  /*
   * Remember current request.
   */

  currentCreateJobRequestId = requestId;

  /*
   * Disable button
   */

  const button =
    document.getElementById('createJobButton');

  if (button) {
    button.disabled = true;
    button.textContent = 'Creating Job...';
  }

  /*
   * Show creating message.
   */

  showToast('Creating job...', 'loading', 3000);

  console.log(
    'Sending CREATE JOB request:',
    data,
    'requestId:',
    requestId
  );

  /*
   * Send request to
   * login.html / App Shell
   */

  window.parent.postMessage(
    {
      type: 'RICHCAN_CREATE_JOB',
      data: data,
      requestId: requestId
    },
    '*'
  );
}

/* =====================================================
   CREATE JOB RESULT
   ===================================================== */

window.addEventListener(
  'message',
  function(event) {

    if (
      !event.data ||
      event.data.type !== 'RICHCAN_CREATE_JOB_RESULT'
    ) {
      return;
    }

    /*
     * Ignore result from
     * an old request.
     */

    if (
      event.data.requestId !==
      currentCreateJobRequestId
    ) {
      console.warn(
        'Ignoring CREATE JOB result for old request:',
        event.data.requestId
      );
      return;
    }

    const result = event.data.result || {};

    /*
     * Restore button
     */

    const button =
      document.getElementById('createJobButton');

    if (button) {
      button.disabled = false;
      button.textContent = 'Create Job';
    }

    /*
     * Failed
     */

    if (result.success !== true) {
      showToast(
        result.message ||
        event.data.error ||
        'Unable to create job.',
        'error',
        5000
      );
      return;
    }

    /*
     * Success
     */

    showToast(
      'Job created successfully' +
      (
        result.jobId
          ? ' — ' + result.jobId
          : ''
      ),
      'success',
      4000
    );

    console.log('Job created:', result);

    /*
     * Return to Index
     * after 3 seconds
     */

    setTimeout(
      function() {
        goBack();
      },
      2500
    );

  }
);



    /* =====================================================
       BACK
       ===================================================== */

    function goBack() {

      window.parent.postMessage(
        {

          type:
            'RICHCAN_NAVIGATE',

          page:
            'index'

        },
        '*'
      );

    }


    /* =====================================================
       ESCAPE HTML
       ===================================================== */

    function escapeHtml(
      value
    ) {

      return String(
        value || ''
      )

        .replace(
          /&/g,
          '&amp;'
        )

        .replace(
          /</g,
          '&lt;'
        )

        .replace(
          />/g,
          '&gt;'
        )

        .replace(
          /"/g,
          '&quot;'
        )

        .replace(
          /'/g,
          '&#039;'
        );

    }


    /* =====================================================
       MONEY
       ===================================================== */

    function formatMoney(
      value
    ) {

      return (
        '$' +
        Number(
          value || 0
        ).toFixed(2)
      );

    }

/***show toast request app shell result**/


/* =====================================================
   REFERRAL CODE VALIDATION RESULT
   ===================================================== */

window.addEventListener(
  'message',
  function(event) {

    if (
      !event.data ||
      event.data.type !==
        'RICHCAN_VALIDATE_REFERRAL_CODE_RESULT'
    ) {
      return;
    }


    const result =
      event.data.result || {};


    /*
     * Enable Apply button
     */
    const button =
      document.getElementById(
        'applyReferralButton'
      );

    if (button) {

      button.disabled = false;

      button.textContent =
        'Apply';
    }

    /* 
 * Invalid Referral Code 
 */
if (
  result.success !== true ||
  result.valid !== true
) {

  referralDiscountAmount = 0;

  const creditUsed = Number(
    document.getElementById('creditUsed').value || 0
  );

  newCustomerDiscountAmount =
    selectedCustomer &&
    selectedCustomer.isEligibleForReferral === true &&
    creditUsed <= 0
      ? 20
      : 0;

  document.getElementById('discountMessage').textContent =
    result.message || 'Invalid Referral Code.';

  calculateTotal();

  showToast(
    result.message || 'Invalid Referral Code.',
    'error',
    3000
  );

  return;
}


    /*
     * Referral Code is valid
     */


 

referralDiscountAmount =
  Number(
    result.discount || 0
  );

referralCouponServicePrice =
  Number(
    result.servicePrice || 0
  );

referralCommission =
  Number(
    result.commission || 0
  );

referralCouponId =
  result.couponId || '';

newCustomerDiscountAmount =
  0;


document.getElementById(
  'discountMessage'
).textContent =

  'Code Owner: ' +

  (
    result.referralOwnerNickname ||
    result.referralOwnerName ||
    ''
  ) +

  ' | Discount: ' +

  formatMoney(
    result.discount || 0
  ) +

  ' | Price: ' +

  formatMoney(
    result.servicePrice || 0
  );


    calculateTotal();


   showToast(

  'Referral Code applied. ' +
  (
    result.referralOwnerName ||
    'Customer'
  ) +
  ' | ' +
  formatMoney(
    result.discount || 0
  ) +
  ' discount.',

  'success',

  3000

);

  }
);


/**RICHCAN_GET_AVAILABLE_CREDIT_RESULT **/

window.addEventListener(
  'message',
  function(event) {

    if (
      !event.data ||
      event.data.type !==
        'RICHCAN_GET_AVAILABLE_CREDIT_RESULT'
    ) {
      return;
    }

    const credit =
      Number(
        event.data.availableCredit || 0
      );

    /*
     * Update global Available Credit
     */
    availableCredit =
      Math.max(0, credit);


    /*
     * Update Available Credit display
     */
    const creditElement =
      document.getElementById(
        'availableCredit'
      );

    if (creditElement) {

      creditElement.textContent =
        '$' +
        availableCredit.toFixed(2);

    }


    /*
     * Update Credit Used maximum
     */
    const creditInput =
      document.getElementById(
        'creditUsed'
      );

    if (creditInput) {

      creditInput.max =
        availableCredit;

      /*
       * If current Credit Used is greater
       * than Available Credit, reset it.
       */
      const currentCredit =
        Number(
          creditInput.value || 0
        );

      if (
        currentCredit >
        availableCredit
      ) {

        creditInput.value =
          availableCredit.toFixed(2);

      }

    }


    /*
     * Recalculate Job Total
     */
    calculateTotal();

  }
);

/********config ****/

window.addEventListener('message', function(event) {
  if (!event.data || event.data.type !== 'RICHCAN_CONFIG_RESULT') return;

  const config = event.data.config || {};

  servicePrices = config.servicePrices || {};

  const technicianSelect = document.getElementById('technician');

  if (technicianSelect) {
    technicianSelect.innerHTML = '<option value="">Select Technician</option>';

    (config.technicians || []).forEach(function(technician) {
      const option = document.createElement('option');
      option.value = technician.userId;
      option.textContent = technician.name;
      technicianSelect.appendChild(option);
    });
  }

  const jobTypeSelect = document.getElementById('jobType');

  if (jobTypeSelect) {
    jobTypeSelect.innerHTML = '<option value="">Select Job Type</option>';

    (config.jobTypes || [])
      .filter(function(jobType) {
        return jobType.active !== false;
      })
      .forEach(function(jobType) {
        const option = document.createElement('option');
        option.value = jobType.value;
        option.textContent = jobType.value;
        jobTypeSelect.appendChild(option);
      });
  }
});
    
  </script>

</body>

</html>
