import { MaskElementByClass, MakeDateRangePicker } from '../util';

function maskInventoryFormElements() {
  MakeDateRangePicker('.input-group.date');

  MaskElementByClass('mask-numeric', 'integer');
  MaskElementByClass('mask-meters', 'meters');
  MaskElementByClass('mask-time', 'shortTime');
  MaskElementByClass('mask-date', 'date');
  MaskElementByClass('mask-money', 'currency');
}

document.addEventListener('inventories:new:load', maskInventoryFormElements);
document.addEventListener('inventories:edit:load', maskInventoryFormElements);
