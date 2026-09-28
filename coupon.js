/*******************************************************
 * RICHCAN MECHANICAL
 * COUPON SYSTEM
 *
 * CUSTOMERS:
 *   Customer ID
 *   Customer Name / Nickname
 *   Customer Type
 *   Job Type
 *   Referral Code
 *
 * COUPONS A:Q:
 *   A Coupon ID
 *   B Customer ID
 *   C Usage Count
 *   D Last Used Job ID
 *   E Commission
 *   F Drive File ID
 *   G Created At
 *   H Service Price
 *   I Customer Name
 *   J Credit Amount
 *   K Valid From
 *   L Valid Until
 *   M Created By
 *   N Update At
 *   O PNG Generated At
 *   P Show Referrer
 *   Q Last Used Date
 *
 * RULES:
 * 1. Coupon ID is generated only when creating a new Coupon.
 * 2. Referral Code is generated only when creating a new Coupon.
 * 3. Existing Coupon ID never changes.
 * 4. Existing Customer Referral Code never changes.
 * 5. Referral Code = Job Type shortName + independent sequence.
 * 6. First 100 regular codes are reserved.
 * 7. Regular first generated code is 0101.
 * 8. Partner first generated code is 0020.
 * 9. Discount always comes from JOBTYPES CONFIG.
 * 10. Coupon Service Price has priority over CONFIG basePrice.
 * 11. Coupon Commission has priority over CONFIG commission.
 * 12. Existing Coupon is UPDATED, not duplicated.
 * 13. Created At never changes when updating.
 * 14. Update At changes whenever Coupon is updated.
 * 15. PNG Generated At records the latest successful file generation.
 * 16. Coupon PNG is regenerated when Update At > PNG Generated At.
 * 17. Customer Name comes from Customers.
 * 18. Customer Type and Job Type remain in Customers only.
 * 19. Commission is backend only and is not printed on the coupon.
 * 20. Existing Valid From / Valid Until are protected when they already have values.
 * 21. Empty Valid From / Valid Until may be filled when updating.
 * 22. Both Valid From and Valid Until empty means no date restriction.
 * 23. Referral Code exists only in Customers.
 * 24. Usage Count, Last Used Job ID and Last Used Date are statistics.
 *******************************************************/


/*******************************************************
 * DELETE COUPON RECORD
 *******************************************************/

function deleteCouponRecordById(couponId) {
  const props = PropertiesService.getScriptProperties();
  const spreadsheetId = props.getProperty('SPREADSHEET_ID');
  if (!spreadsheetId) throw new Error('Spreadsheet has not been configured.');

  const ss = SpreadsheetApp.openById(spreadsheetId);
  const sheet = ensureCouponSheet(ss);
  const lastRow = sheet.getLastRow();
  if (lastRow < 2) return false;

  const values = sheet.getRange(2, 1, lastRow - 1, 17).getValues();

  for (let i = values.length - 1; i >= 0; i--) {
    if (String(values[i][0] || '').trim() === String(couponId || '').trim()) {
      sheet.deleteRow(i + 2);
      return true;
    }
  }

  return false;
}


/*******************************************************
 * GET NEXT COUPON ID
 *
 * CP0001
 * CP0002
 * CP0003
 *******************************************************/

function getNextCouponId(sheet) {
  if (!sheet) throw new Error('Coupon sheet is required.');

  const lastRow = sheet.getLastRow();
  if (lastRow < 2) return 'CP0001';

  const values = sheet.getRange(2, 1, lastRow - 1, 1).getValues();
  let maxNumber = 0;

  values.forEach(function(row) {
    const id = String(row[0] || '').trim();
    const match = id.match(/^CP(\d+)$/);

    if (match) {
      const number = parseInt(match[1], 10);
      if (number > maxNumber) maxNumber = number;
    }
  });

  return 'CP' + String(maxNumber + 1).padStart(4, '0');
}



/*******************************************************
 * GET NEXT REFERRAL CODE
 *
 * Referral Code:
 *   Regular  → BM0101
 *   Partner  → BMP0020
 *
 * Customers.Job Type stores JOBTYPES.value.
 * JOBTYPES.shortName is used to generate Referral Code.
 *
 * Referral Code is stored in Customers.
 * Customers.Referral Code is the source of truth.
 *
 * First 100 regular codes are reserved.
 * First generated regular code is 0101.
 * First generated partner code is 0020.
 *******************************************************/
function getNextReferralCode_(customerSheet, jobType, customerType) {
  if (!customerSheet) {
    throw new Error('Customer sheet is required.');
  }

  jobType = String(jobType || '').trim();
  customerType = String(customerType || '').trim();

  if (!jobType) {
    throw new Error('Job Type is required.');
  }

  if (!customerType) {
    throw new Error('Customer Type is required.');
  }

  const jobTypes = getConfig().jobTypes || [];

  const jobTypeConfig =
    jobTypes.find(function(item) {
      return item &&
        String(item.value || '').trim().toLowerCase() ===
        jobType.toLowerCase();
    });

  if (!jobTypeConfig) {
    throw new Error('Invalid Job Type: ' + jobType);
  }

  const shortName =
    String(jobTypeConfig.shortName || '').trim().toUpperCase();

  if (!shortName) {
    throw new Error('Job Type shortName is missing: ' + jobType);
  }

  const isPartner =
    customerType.toLowerCase() === 'partner';

  const prefix =
    isPartner ? shortName + 'P' : shortName;

  const firstNumber =
    isPartner ? 20 : 101;

  const lastRow =
    customerSheet.getLastRow();

  if (lastRow < 2) {
    return prefix + String(firstNumber).padStart(4, '0');
  }

  const lastColumn =
    customerSheet.getLastColumn();

  const headers =
    customerSheet
      .getRange(1, 1, 1, lastColumn)
      .getValues()[0]
      .map(function(header) {
        return String(header || '').trim();
      });

  const referralCodeIndex =
    headers.indexOf('Referral Code');

  if (referralCodeIndex === -1) {
    throw new Error(
      'Customers sheet does not contain Referral Code.'
    );
  }

  const values =
    customerSheet
      .getRange(
        2,
        referralCodeIndex + 1,
        lastRow - 1,
        1
      )
      .getValues();

  let maxNumber =
    firstNumber - 1;

  const escapedPrefix =
    prefix.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

  const regex =
    new RegExp(
      '^' + escapedPrefix + '(\\d+)$',
      'i'
    );

  values.forEach(function(row) {
    const code =
      String(row[0] || '').trim().toUpperCase();

    const match =
      code.match(regex);

    if (match) {
      const number =
        parseInt(match[1], 10);

      if (number > maxNumber) {
        maxNumber = number;
      }
    }
  });

  return prefix +
    String(maxNumber + 1).padStart(4, '0');
}

/*******************************************************
 * TEST COUPON GENERATE
 *******************************************************/

function testGenerateCustomerCoupon() {
  const result = generateCustomerCoupon({
    customerId: 'C0001',
    validFrom: new Date(),
    validUntil: new Date('2027-09-24')
  });

  console.log(JSON.stringify(result, null, 2));
}

/*******************************************************
 * ENSURE COUPON SHEET
 *
 * Coupons A:Q
 *******************************************************/

function ensureCouponSheet(ss) {
  if (!ss) throw new Error('Spreadsheet is required.');

  let sheet = ss.getSheetByName('Coupons');

  const requiredColumns = [
    'Coupon ID',
    'Customer ID',
    'USAGE COUNT',
    'Last Used Job ID',
    'Commission',
    'Drive File ID',
    'Created At',
    'Service Price',
    'Customer Name',
    'Credit Amount',
    'Valid From',
    'Valid Until',
    'Created By',
    'Update At',
    'PNG Generated At',
    'Show Referrer',
    'Last Used Date'
  ];

  if (!sheet) {
    sheet = ss.insertSheet('Coupons');
    sheet.getRange(1, 1, 1, requiredColumns.length).setValues([requiredColumns]);
    return sheet;
  }

  const lastColumn = sheet.getLastColumn();

  if (lastColumn === 0) {
    sheet.getRange(1, 1, 1, requiredColumns.length).setValues([requiredColumns]);
    return sheet;
  }

  const headers = sheet.getRange(1, 1, 1, lastColumn).getValues()[0].map(function(header) {
    return String(header || '').trim();
  });

  requiredColumns.forEach(function(requiredColumn) {
    if (headers.indexOf(requiredColumn) === -1) {
      const newColumn = sheet.getLastColumn() + 1;
      sheet.getRange(1, newColumn).setValue(requiredColumn);
      headers.push(requiredColumn);
    }
  });

  return sheet;
}

/*******************************************************
 * FIT IMAGE INSIDE BOX
 *******************************************************/

function fitImageInsideBox_(image, boxX, boxY, boxWidth, boxHeight) {
  const originalWidth = image.getWidth();
  const originalHeight = image.getHeight();

  if (!originalWidth || !originalHeight) {
    image.setLeft(boxX).setTop(boxY).setWidth(boxWidth).setHeight(boxHeight);
    return;
  }

  const ratio = Math.min(boxWidth / originalWidth, boxHeight / originalHeight);
  const width = originalWidth * ratio;
  const height = originalHeight * ratio;
  const left = boxX + (boxWidth - width) / 2;
  const top = boxY + (boxHeight - height) / 2;

  image.setWidth(width).setHeight(height).setLeft(left).setTop(top);
}


/*******************************************************
 * STYLE COUPON TEXT
 *******************************************************/

function styleCouponText(shape, fontSize, bold, color) {
  const text = shape.getText();

  text.getTextStyle()
    .setFontFamily('Arial')
    .setFontSize(fontSize)
    .setBold(bold)
    .setForegroundColor(color);

  text.getParagraphStyle().setParagraphAlignment(SlidesApp.ParagraphAlignment.START);
}


/*******************************************************
 * FORMAT DISCOUNT
 *******************************************************/

function formatCouponDiscount(amount) {
  const number = Number(amount);

  if (!isFinite(number)) return '$0';

  if (Number.isInteger(number)) {
    return '$' + number.toLocaleString('en-CA');
  }

  return '$' + number.toLocaleString('en-CA', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  });
}


/*******************************************************
 * FIND RICHCAN LOGO
 *
 * My Drive
 * └── richcanlogo
 *     └── logo.png
 *******************************************************/

function findRichcanLogoFile() {
  const folders = DriveApp.getFoldersByName('richcanlogo');

  if (!folders.hasNext()) {
    throw new Error('Drive folder "richcanlogo" was not found.');
  }

  const folder = folders.next();
  const files = folder.getFilesByName('logo.png');

  if (!files.hasNext()) {
    throw new Error('logo.png was not found inside the richcanlogo folder.');
  }

  return files.next();
}


/*******************************************************
 * GET / CREATE COUPON DRIVE FOLDER
 *
 * My Drive
 * └── RICHCAN MECHANICAL
 *     └── Coupons
 *******************************************************/

function getOrCreateCouponFolder() {
  const rootFolders = DriveApp.getFoldersByName('RICHCAN MECHANICAL');

  let rootFolder;

  if (rootFolders.hasNext()) {
    rootFolder = rootFolders.next();
  } else {
    rootFolder = DriveApp.createFolder('RICHCAN MECHANICAL');
  }

  const couponFolders = rootFolder.getFoldersByName('Coupons');

  if (couponFolders.hasNext()) {
    return couponFolders.next();
  }

  return rootFolder.createFolder('Coupons');
}


/*******************************************************
 * UPDATE COUPON DRIVE FILE ID
 *
 * Coupons:
 * F = Drive File ID
 * O = PNG Generated At
 *******************************************************/

function updateCouponDriveFileId(couponId, fileId) {
  const props = PropertiesService.getScriptProperties();
  const spreadsheetId = props.getProperty('SPREADSHEET_ID');

  if (!spreadsheetId) throw new Error('Spreadsheet has not been configured.');

  const ss = SpreadsheetApp.openById(spreadsheetId);
  const sheet = ensureCouponSheet(ss);
  const lastRow = sheet.getLastRow();

  if (lastRow < 2) return false;

  const values = sheet.getRange(2, 1, lastRow - 1, 15).getValues();

  for (let i = 0; i < values.length; i++) {
    if (String(values[i][0] || '').trim() === String(couponId || '').trim()) {
      sheet.getRange(i + 2, 6).setValue(fileId);

  sheet.getRange(i + 2, 15)
  .setValue(new Date())
  .setNumberFormat('M/d/yyyy h:mm:ss AM/PM');
      return true;
    }
  }

  return false;
}



/*******************************************************
 * GENERATE CUSTOMER COUPON
 *
 * NEW:
 *   Coupon ID generated.
 *   Referral Code generated.
 *
 * UPDATE:
 *   Coupon ID stays unchanged.
 *   Referral Code stays unchanged.
 *   Created At stays unchanged.
 *
 * RULE:
 *   Customers.Referral Code is the source of truth.
 *
 *   If Customer has Referral Code:
 *     - Keep existing Coupon ID.
 *     - Keep existing Referral Code.
 *     - Keep Created At.
 *     - Update Coupon / PNG.
 *
 *   If Customer has NO Referral Code:
 *     - Delete old Coupon for this Customer ID.
 *     - Delete old PNG.
 *     - Generate new Coupon ID.
 *     - Generate new Referral Code.
 *     - Save Referral Code to Customers.
 *
 * Customer Type / Job Type remain in Customers.
 *******************************************************/
function generateCustomerCoupon(data) {
  if (!data) throw new Error('Coupon data is required.');

  const props = PropertiesService.getScriptProperties();
  const spreadsheetId = props.getProperty('SPREADSHEET_ID');

  if (!spreadsheetId) throw new Error('Spreadsheet has not been configured.');

  const ss = SpreadsheetApp.openById(spreadsheetId);

  ensureCustomersSheet(ss);

  const customerSheet = ss.getSheetByName('Customers');
  const customerId = String(data.customerId || '').trim();

  if (!customerId) throw new Error('Customer ID is required.');

  const customerLastRow = customerSheet.getLastRow();

  if (customerLastRow < 2) throw new Error('Customer was not found.');

  const customerLastColumn = customerSheet.getLastColumn();

  const customerHeaders = customerSheet.getRange(1, 1, 1, customerLastColumn).getValues()[0].map(function(header) {
    return String(header || '').trim();
  });

  const customerValues = customerSheet.getRange(2, 1, customerLastRow - 1, customerLastColumn).getValues();

  const customerIdIndex = customerHeaders.indexOf('Customer ID');
  const referralCodeIndex = customerHeaders.indexOf('Referral Code');

  if (customerIdIndex === -1) throw new Error('Customers sheet does not contain Customer ID.');
  if (referralCodeIndex === -1) throw new Error('Customers sheet does not contain Referral Code.');

  let customer = null;
  let customerRowIndex = -1;

  for (let i = 0; i < customerValues.length; i++) {
    const row = customerValues[i];

    if (String(row[customerIdIndex] || '').trim() === customerId) {
      customer = {};
      customerHeaders.forEach(function(header, index) {
        customer[header] = row[index];
      });
      customerRowIndex = i;
      break;
    }
  }

  if (!customer) throw new Error('Customer ' + customerId + ' was not found.');

  const customerName = String(
    customer['Nickname'] ||
    customer['Customer Name'] ||
    customer['Name'] ||
    ''
  ).trim();

  const jobType = String(customer['Job Type'] || '').trim();

  if (!jobType) {
    return {
      success: true,
      skipped: true,
      message: 'Customer Job Type is empty. Coupon skipped.'
    };
  }

  const customerType = String(customer['Customer Type'] || '').trim();

  if (!customerType) throw new Error('Customer Type is required.');

  const jobTypeConfig = getCouponJobTypeConfig_(jobType);
  const customerReferralCode = String(customer['Referral Code'] || '').trim();

  const couponSheet = ensureCouponSheet(ss);
  const couponLastRow = couponSheet.getLastRow();

  let existingRow = -1;
  let existingCoupon = null;

  if (couponLastRow >= 2) {
    const couponValues = couponSheet.getRange(2, 1, couponLastRow - 1, 17).getValues();

    for (let i = 0; i < couponValues.length; i++) {
      const row = couponValues[i];

      if (String(row[1] || '').trim() === customerId) {
        existingRow = i + 2;
        existingCoupon = row;
        break;
      }
    }
  }

  let couponId;
  let referralCode;
  let createdAt;
  let updated = false;
  let servicePrice;
  let commission;
  let creditAmount;
  let validFrom;
  let validUntil;
  let showReferrer;
  let usageCount;
  let lastUsedJobId;
  let lastUsedDate;

  if (customerReferralCode) {
    if (!existingCoupon) {
      throw new Error(
        'Customer ' + customerId +
        ' has Referral Code ' + customerReferralCode +
        ', but no matching Coupon was found.'
      );
    }

    updated = true;

    couponId = String(existingCoupon[0] || '').trim();
    referralCode = customerReferralCode;
    createdAt = existingCoupon[6] || new Date();

    if (!couponId) throw new Error('Existing Coupon is missing Coupon ID.');

    usageCount = Number(existingCoupon[2] || 0);
    lastUsedJobId = String(existingCoupon[3] || '').trim();
    lastUsedDate = existingCoupon[16] || '';

    servicePrice =
      existingCoupon[7] !== '' && existingCoupon[7] !== null
        ? Number(existingCoupon[7])
        : jobTypeConfig.basePrice;

    commission =
      existingCoupon[4] !== '' && existingCoupon[4] !== null
        ? Number(existingCoupon[4])
        : jobTypeConfig.commission;

    creditAmount =
      existingCoupon[9] !== '' && existingCoupon[9] !== null
        ? Number(existingCoupon[9])
        : jobTypeConfig.creditAmount;

    validFrom = existingCoupon[10] || data.validFrom || '';
    validUntil = existingCoupon[11] || data.validUntil || '';
    showReferrer = existingCoupon[15] !== false;

  } else {

    if (existingCoupon) {
      const oldFileId = String(existingCoupon[5] || '').trim();

      if (oldFileId) {
        try {
          DriveApp.getFileById(oldFileId).setTrashed(true);
        } catch (e) {}
      }

      couponSheet.deleteRow(existingRow);
    }

    couponId = getNextCouponId(couponSheet);

    referralCode = getNextReferralCode_(
      customerSheet,
      jobType,
      customerType
    );

    createdAt = new Date();
    usageCount = 0;
    lastUsedJobId = '';
    lastUsedDate = '';
    servicePrice = jobTypeConfig.basePrice;
    commission = jobTypeConfig.commission;
    creditAmount = jobTypeConfig.creditAmount;
    validFrom = data.validFrom || '';
    validUntil = data.validUntil || '';
    showReferrer = false;

    customerSheet
      .getRange(customerRowIndex + 2, referralCodeIndex + 1)
      .setValue(referralCode);
  }

  const discount = jobTypeConfig.discount;

  const createdBy = String(
    data.createdBy ||
    Session.getActiveUser().getEmail() ||
    ''
  ).trim();

  const updateAt = new Date();

  const pngResult = createBoilerCouponPng({
    couponId: couponId,
    referralCode: referralCode,
    nickname: customerName,
    discount: discount,
    showReferrer: showReferrer
  });

  const pngGeneratedAt = new Date();

  const couponRow = [
    couponId,
    customerId,
    usageCount,
    lastUsedJobId,
    commission,
    pngResult.fileId,
    createdAt,
    servicePrice,
    customerName,
    creditAmount,
    validFrom,
    validUntil,
    createdBy,
    updateAt,
    pngGeneratedAt,
    showReferrer,
    lastUsedDate
  ];

  if (updated) {
    couponSheet.getRange(existingRow, 1, 1, 17).setValues([couponRow]);
    couponSheet.getRange(existingRow, 14, 1, 2).setNumberFormat('M/d/yyyy h:mm:ss AM/PM');
    couponSheet.getRange(existingRow, 17).setNumberFormat('M/d/yyyy');
  } else {
    couponSheet.appendRow(couponRow);

    const newRow = couponSheet.getLastRow();

    couponSheet.getRange(newRow, 14, 1, 2).setNumberFormat('M/d/yyyy h:mm:ss AM/PM');
    couponSheet.getRange(newRow, 17).setNumberFormat('M/d/yyyy');
  }

  return {
    success: true,
    updated: updated,
    couponId: couponId,
    customerId: customerId,
    referralCode: referralCode,
    customerName: customerName,
    discount: discount,
    commission: commission,
    servicePrice: servicePrice,
    creditAmount: creditAmount,
    fileId: pngResult.fileId,
    fileName: pngResult.fileName,
    fileUrl: pngResult.fileUrl
  };
}




/*******************************************************
 * GENERATE UPDATED COUPON FILES
 *
 * Daily trigger:
 *
 * Update At > PNG Generated At
 *
 * Only changed Coupons are regenerated.
 *******************************************************/
function generateUpdatedCouponPngs() {
  const props = PropertiesService.getScriptProperties();
  const spreadsheetId = props.getProperty('SPREADSHEET_ID');

  if (!spreadsheetId) throw new Error('Spreadsheet has not been configured.');

  const ss = SpreadsheetApp.openById(spreadsheetId);
  const sheet = ensureCouponSheet(ss);
  const lastRow = sheet.getLastRow();

  if (lastRow < 2) return 0;

  const values = sheet.getRange(2, 1, lastRow - 1, 17).getValues();

  const customerSheet = ss.getSheetByName('Customers');

  if (!customerSheet) throw new Error('Customers sheet not found.');

  const customerLastRow = customerSheet.getLastRow();
  const customerLastColumn = customerSheet.getLastColumn();

  if (customerLastRow < 2) return 0;

  const customerHeaders = customerSheet.getRange(1, 1, 1, customerLastColumn).getValues()[0].map(function(header) {
    return String(header || '').trim();
  });

  const customerValues = customerSheet.getRange(2, 1, customerLastRow - 1, customerLastColumn).getValues();

  const customerIdCol = customerHeaders.indexOf('Customer ID');
  const referralCodeCol = customerHeaders.indexOf('Referral Code');
  const jobTypeCol = customerHeaders.indexOf('Job Type');

  if (customerIdCol === -1 || referralCodeCol === -1 || jobTypeCol === -1) {
    throw new Error('Customers sheet is missing required columns.');
  }

  const customerMap = {};

  customerValues.forEach(function(row) {
    const customerId = String(row[customerIdCol] || '').trim();

    if (!customerId) return;

    customerMap[customerId] = {
      referralCode: String(row[referralCodeCol] || '').trim(),
      jobType: String(row[jobTypeCol] || '').trim()
    };
  });

  let generatedCount = 0;

  for (let i = 0; i < values.length; i++) {
    const row = values[i];

    const couponId = String(row[0] || '').trim();
    const customerId = String(row[1] || '').trim();
    const customer = customerMap[customerId];
    const customerName = String(row[8] || '').trim();
    const updateAt = row[13];
    const pngGeneratedAt = row[14];
    const showReferrer = row[15] !== false;

    if (!couponId || !customer) continue;
    if (!customer.referralCode || !customer.jobType) continue;
    if (!(updateAt instanceof Date)) continue;

    let generatedTime = 0;

    if (pngGeneratedAt instanceof Date) {
      generatedTime = pngGeneratedAt.getTime();
    }

    if (updateAt.getTime() <= generatedTime) continue;

    try {
      const jobTypeConfig = getCouponJobTypeConfig_(customer.jobType);

      const pngResult = createBoilerCouponPng({
        couponId: couponId,
        referralCode: customer.referralCode,
        nickname: customerName,
        discount: jobTypeConfig.discount,
        showReferrer: showReferrer
      });

      sheet.getRange(i + 2, 6).setValue(pngResult.fileId);
      sheet.getRange(i + 2, 15).setValue(new Date()).setNumberFormat('M/d/yyyy h:mm:ss AM/PM');

      generatedCount++;

    } catch (error) {
      console.error(
        'Coupon generation failed: ' +
        couponId +
        ' - ' +
        error.message
      );
    }
  }

  return generatedCount;
}


/*******************************************************
 * CREATE DAILY COUPON PNG TRIGGER
 *
 * Run this function ONCE manually.
 *
 * It creates:
 *
 * Every day → generateUpdatedCouponPngs()
 *******************************************************/

function setupDailyCouponPngTrigger() {
  const functionName = 'generateUpdatedCouponPngs';

  ScriptApp.getProjectTriggers().forEach(function(trigger) {
    if (trigger.getHandlerFunction() === functionName) {
      ScriptApp.deleteTrigger(trigger);
    }
  });

  ScriptApp.newTrigger(functionName)
    .timeBased()
    .everyDays(1)
    .atHour(2)
    .create();

  return true;
}


/*******************************************************
 * DOWNLOAD CUSTOMER COUPON
 *
 * Find Coupon by Coupon ID.
 * Download existing original PNG.
 * Do NOT regenerate.
 *******************************************************/
function downloadCustomerCoupon(data) {
  if (!data) throw new Error('Download data is required.');

  const couponId = String(data.couponId || '').trim();

  if (!couponId) throw new Error('Coupon ID is required.');

  const props = PropertiesService.getScriptProperties();
  const spreadsheetId = props.getProperty('SPREADSHEET_ID');

  if (!spreadsheetId) throw new Error('Spreadsheet has not been configured.');

  const ss = SpreadsheetApp.openById(spreadsheetId);
  const couponSheet = ss.getSheetByName('Coupons');

  if (!couponSheet) throw new Error('Coupons sheet not found.');

  const lastRow = couponSheet.getLastRow();

  if (lastRow < 2) throw new Error('No coupon found.');

  const values = couponSheet.getRange(2, 1, lastRow - 1, 17).getValues();

  let couponRow = null;

  for (let i = 0; i < values.length; i++) {
    const row = values[i];

    if (String(row[0] || '').trim() === couponId) {
      couponRow = row;
      break;
    }
  }

  if (!couponRow) throw new Error('Coupon not found: ' + couponId + '.');

  const fileId = String(couponRow[5] || '').trim();

  if (!fileId) throw new Error('Coupon PNG file ID is missing.');

  const file = DriveApp.getFileById(fileId);
  const blob = file.getBlob();

  if (blob.getContentType() !== 'image/png') {
    throw new Error('Coupon file is not a PNG.');
  }

  const customerId = String(couponRow[1] || '').trim();
  const customerSheet = ss.getSheetByName('Customers');

  if (!customerSheet) throw new Error('Customers sheet not found.');

  const customerLastRow = customerSheet.getLastRow();
  const customerLastColumn = customerSheet.getLastColumn();

  const headers = customerSheet.getRange(1, 1, 1, customerLastColumn).getValues()[0].map(function(header) {
    return String(header || '').trim();
  });

  const customerIdCol = headers.indexOf('Customer ID');
  const referralCodeCol = headers.indexOf('Referral Code');

  if (customerIdCol === -1 || referralCodeCol === -1) {
    throw new Error('Customers sheet is missing required columns.');
  }

  let referralCode = '';

  if (customerLastRow >= 2) {
    const customerValues = customerSheet.getRange(2, 1, customerLastRow - 1, customerLastColumn).getValues();

    for (let i = 0; i < customerValues.length; i++) {
      if (String(customerValues[i][customerIdCol] || '').trim() === customerId) {
        referralCode = String(customerValues[i][referralCodeCol] || '').trim();
        break;
      }
    }
  }

  return {
    success: true,
    customerId: customerId,
    couponId: String(couponRow[0] || '').trim(),
    referralCode: referralCode,
    fileName: file.getName(),
    dataUrl: 'data:image/png;base64,' + Utilities.base64Encode(blob.getBytes())
  };
}



/*************************************************
 * Get Coupon Job Type Config
 *************************************************/
function getCouponJobTypeConfig_(jobType) {
  const jobTypes = getConfig().jobTypes || [];
  const item = jobTypes.find(function(item) {
    return item && String(item.value || '').trim() === String(jobType || '').trim();
  });

  if (!item) throw new Error('Invalid Job Type: ' + jobType);
  if (item.active !== true) throw new Error('Job Type is inactive: ' + jobType);
  if (item.couponEnabled !== true) throw new Error('Coupon is not enabled for Job Type: ' + jobType);
  if (!item.shortName) throw new Error('Coupon shortName is missing for Job Type: ' + jobType);

  const basePrice = Number(item.basePrice);
  const discount = Number(item.discount);
  const commission = Number(item.commission);
  const creditAmount = Number(item.creditAmount);

  if (!Number.isFinite(basePrice) || basePrice < 1) {
    throw new Error('Invalid basePrice for Job Type: ' + jobType);
  }

  if (!Number.isFinite(discount) || discount < 0) {
    throw new Error('Invalid discount for Job Type: ' + jobType);
  }

  if (!Number.isFinite(commission) || commission < 0) {
    throw new Error('Invalid commission for Job Type: ' + jobType);
  }

  if (!Number.isFinite(creditAmount) || creditAmount < 0) {
    throw new Error('Invalid creditAmount for Job Type: ' + jobType);
  }

  return {
    value: String(item.value).trim(),
    shortName: String(item.shortName).trim(),
    basePrice: basePrice,
    discount: discount,
    commission: commission,
    creditAmount: creditAmount
  };
}


/*************************************************
 * SEARCH COUPONS
 *************************************************/
function searchCoupons(token, query) {
  validateAdminSession_(token);

  const ss = SpreadsheetApp.openById(
    PropertiesService.getScriptProperties().getProperty('SPREADSHEET_ID')
  );

  const sheet = ss.getSheetByName('Coupons');

  if (!sheet) throw new Error('Coupons sheet not found.');

  const lastRow = sheet.getLastRow();

  if (lastRow < 2) return [];

  const values = sheet.getRange(2, 1, lastRow - 1, 17).getValues();

  query = String(query || '').trim().toLowerCase();

  const results = [];

  values.forEach(function(row) {
    const coupon = {
      couponId: row[0],
      customerId: row[1],
      usageCount: Number(row[2] || 0),
      lastUsedJobId: String(row[3] || '').trim(),
      commission: row[4],
      driveFileId: row[5],
      createdAt: formatCouponDate_(row[6]),
      servicePrice: row[7],
      customerName: row[8],
      creditAmount: row[9],
      validFrom: formatCouponDate_(row[10]),
      validUntil: formatCouponDate_(row[11]),
      createdBy: row[12],
      updateAt: formatCouponDate_(row[13]),
      pngGeneratedAt: formatCouponDate_(row[14]),
      showReferrer: row[15] !== false,
      lastUsedDate: formatCouponDate_(row[16])
    };

    const searchable = [
      coupon.couponId,
      coupon.customerId,
      coupon.customerName,
      coupon.lastUsedJobId
    ].join(' ').toLowerCase();

    if (query && searchable.indexOf(query) === -1) return;

    results.push(coupon);
  });

  results.reverse();

  return results.slice(0, 50);
}

/*************************************************
 * UPDATE COUPON
 *
 * Does NOT modify:
 * C USAGE COUNT
 * D Last Used Job ID
 * Q Last Used Date
 *
 * Discount is always from CONFIG.
 * Commission and Service Price can be customized
 * per Coupon and have priority over CONFIG.
 *************************************************/
function updateCoupon(token, data) {
  validateAdminSession_(token);

  data = data || {};

  const couponId = String(data.couponId || '').trim();
  if (!couponId) throw new Error('Coupon ID is required.');

  const ss = SpreadsheetApp.openById(
    PropertiesService.getScriptProperties().getProperty('SPREADSHEET_ID')
  );

  const sheet = ss.getSheetByName('Coupons');
  if (!sheet) throw new Error('Coupons sheet not found.');

  const lastRow = sheet.getLastRow();
  if (lastRow < 2) throw new Error('Coupon not found.');

  const values = sheet.getRange(2, 1, lastRow - 1, 17).getValues();

  let rowNumber = -1;
  let rowData = null;

  for (let i = 0; i < values.length; i++) {
    if (String(values[i][0] || '').trim() === couponId) {
      rowNumber = i + 2;
      rowData = values[i];
      break;
    }
  }

  if (rowNumber < 0 || !rowData) {
    throw new Error('Coupon not found: ' + couponId);
  }

  const customerId = String(rowData[1] || '').trim();
  if (!customerId) throw new Error('Coupon Customer ID is missing.');

  const customerSheet = ss.getSheetByName('Customers');
  if (!customerSheet) throw new Error('Customers sheet not found.');

  const customerLastRow = customerSheet.getLastRow();
  const customerLastColumn = customerSheet.getLastColumn();

  if (customerLastRow < 2) {
    throw new Error('Customer not found: ' + customerId);
  }

  const customerHeaders = customerSheet
    .getRange(1, 1, 1, customerLastColumn)
    .getValues()[0]
    .map(function(header) {
      return String(header || '').trim();
    });

  const customerIdCol = customerHeaders.indexOf('Customer ID');
  const customerNameCol = customerHeaders.indexOf('Customer Name');
  const nicknameCol = customerHeaders.indexOf('Nickname');
  const jobTypeCol = customerHeaders.indexOf('Job Type');
  const referralCodeCol = customerHeaders.indexOf('Referral Code');

  if (
    customerIdCol === -1 ||
    customerNameCol === -1 ||
    jobTypeCol === -1 ||
    referralCodeCol === -1
  ) {
    throw new Error('Customers sheet is missing required columns.');
  }

  const customerValues = customerSheet
    .getRange(2, 1, customerLastRow - 1, customerLastColumn)
    .getValues();

  let customer = null;

  for (let i = 0; i < customerValues.length; i++) {
    const row = customerValues[i];

    if (String(row[customerIdCol] || '').trim() === customerId) {
      customer = {
        customerName: String(
          row[nicknameCol] ||
          row[customerNameCol] ||
          ''
        ).trim(),
        referralCode: String(
          row[referralCodeCol] || ''
        ).trim(),
        jobType: String(
          row[jobTypeCol] || ''
        ).trim()
      };
      break;
    }
  }

  if (!customer) {
    throw new Error('Customer not found: ' + customerId);
  }

  if (!customer.jobType) {
    throw new Error('Customer Job Type is empty.');
  }

  const jobTypeConfig =
    getCouponJobTypeConfig_(customer.jobType);

  /*
   * Discount is ALWAYS from CONFIG.
   * It is NOT stored in Coupons.
   */
  const discount = jobTypeConfig.discount;

  /*
   * Coupon Commission has priority over CONFIG.
   */
  let commission;

  if (data.commission !== undefined && data.commission !== '') {
    commission = Number(data.commission);
  } else if (rowData[4] !== '' && rowData[4] !== null) {
    commission = Number(rowData[4]);
  } else {
    commission = jobTypeConfig.commission;
  }

  /*
   * Coupon Service Price has priority over CONFIG.
   */
  let servicePrice;

  if (data.servicePrice !== undefined && data.servicePrice !== '') {
    servicePrice = Number(data.servicePrice);
  } else if (rowData[7] !== '' && rowData[7] !== null) {
    servicePrice = Number(rowData[7]);
  } else {
    servicePrice = jobTypeConfig.basePrice;
  }

  /*
   * Credit Amount remains editable.
   * If no new value is supplied, preserve the existing value.
   */
  let creditAmount;

  if (data.creditAmount !== undefined && data.creditAmount !== '') {
    creditAmount = Number(data.creditAmount);
  } else if (rowData[9] !== '' && rowData[9] !== null) {
    creditAmount = Number(rowData[9]);
  } else {
    creditAmount = jobTypeConfig.creditAmount;
  }

  if (
    !Number.isFinite(commission) ||
    commission < 0 ||
    !Number.isFinite(servicePrice) ||
    servicePrice < 0 ||
    !Number.isFinite(creditAmount) ||
    creditAmount < 0
  ) {
    throw new Error('Amounts cannot be negative or invalid.');
  }

  /*
   * Customer Name always comes from Customers.
   */
  const customerName = customer.customerName;

  /*
   * Existing dates are protected.
   * Empty dates can be filled.
   */
  const validFrom =
    rowData[10] || data.validFrom || '';

  const validUntil =
    rowData[11] || data.validUntil || '';

  const showReferrer =
    data.showReferrer !== undefined
      ? data.showReferrer === true
      : rowData[15] !== false;

  const now = new Date();

  /*
   * IMPORTANT:
   *
   * We ONLY update:
   * E Commission
   * H Service Price
   * I Customer Name
   * J Credit Amount
   * K Valid From
   * L Valid Until
   * N Update At
   * P Show Referrer
   *
   * We DO NOT touch:
   * A Coupon ID
   * B Customer ID
   * C USAGE COUNT
   * D Last Used Job ID
   * F Drive File ID
   * G Created At
   * M Created By
   * O PNG Generated At
   * Q Last Used Date
   */

  sheet.getRange(rowNumber, 5).setValue(commission);

  sheet.getRange(rowNumber, 8, 1, 4).setValues([[
    servicePrice,
    customerName,
    creditAmount,
    validFrom
  ]]);

  sheet.getRange(rowNumber, 12).setValue(validUntil);

  sheet.getRange(rowNumber, 14).setValue(now);

  sheet.getRange(rowNumber, 16).setValue(showReferrer);

  return {
    success: true,
    coupon: {
      couponId: rowData[0],
      customerId: rowData[1],
      usageCount: Number(rowData[2] || 0),
      lastUsedJobId: String(rowData[3] || '').trim(),
      referralCode: customer.referralCode,
      discount: discount,
      commission: commission,
      driveFileId: rowData[5],
      createdAt: formatCouponDate_(rowData[6]),
      servicePrice: servicePrice,
      customerName: customerName,
      creditAmount: creditAmount,
      validFrom: formatCouponDate_(validFrom),
      validUntil: formatCouponDate_(validUntil),
      createdBy: rowData[12],
      updateAt: formatCouponDate_(now),
      pngGeneratedAt: formatCouponDate_(rowData[14]),
      showReferrer: showReferrer,
      lastUsedDate: formatCouponDate_(rowData[16])
    }
  };
}


/*************************************************
 * GET CUSTOMER JOB TYPE MAP
 *************************************************/
function getCustomerJobTypeMap_(ss) {
  const sheet = ss.getSheetByName('Customers');

  if (!sheet) {
    throw new Error('Customers sheet not found.');
  }

  const lastRow = sheet.getLastRow();

  if (lastRow < 2) {
    return {};
  }

  const values =
    sheet
      .getRange(2, 1, lastRow - 1, 16)
      .getValues();

  const map = {};

  values.forEach(function(row) {
    const customerId =
      String(row[0] || '').trim();

    if (!customerId) {
      return;
    }

    map[customerId] =
      String(row[15] || '').trim();
  });

  return map;
}

/*************************************************
 * FORMAT COUPON DATE
 *************************************************/
function formatCouponDate_(value) {
  if (!value) {
    return '';
  }

  if (
    Object.prototype.toString.call(value) ===
    '[object Date]'
  ) {
    if (isNaN(value.getTime())) {
      return '';
    }

    return Utilities.formatDate(
      value,
      Session.getScriptTimeZone(),
      'yyyy-MM-dd'
    );
  }

  return String(value);
}

function testCreateBoilerCouponPng() {

  const data = {
    couponId: 'CP0001',
    referralCode: 'BMP0101',
    nickname: 'Test Customer',
    discount: 30
  };

  const result = createBoilerCouponPng(data);

  Logger.log(result);
}
