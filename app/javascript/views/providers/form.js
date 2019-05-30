import { MaskElementByClass, MakeDateRangePicker } from '../util';

function maskProviderFormElements() {
  MakeDateRangePicker('.input-group.date');

  MaskElementByClass('mask-numeric', 'integer');
  MaskElementByClass('mask-meters', 'meters');
  MaskElementByClass('mask-time', 'shortTime');
  MaskElementByClass('mask-date', 'date');
  MaskElementByClass('mask-money', 'currency');
}

document.addEventListener('providers:new:load',  maskProviderFormElements);
document.addEventListener('providers:edit:load', maskProviderFormElements);
