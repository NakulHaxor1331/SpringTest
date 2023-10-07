import { LightningElement , wire } from 'lwc';
import getAccData from '@salesforce/apex/loadAccRecentRecApex.getAccData';

const COLUMN = [
    {label:'Account Name', fieldName :'Name'},
    {label:'Website', fieldName :'website'},
    {label:'Rating', fieldName :'Rating'},
    {label:'Industry', fieldName :'Industry'}
]
export default class SpringSOALWCCompo extends LightningElement {
    column = COLUMN
    accData
    


    @wire(getAccData)
    wireData({data,error}){
        if(data){
           this.accData = data
           console.log(this.accData)
        }
        if(error){
            console.error(error)
        }
    }

}