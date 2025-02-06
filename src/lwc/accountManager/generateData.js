/*
 *
 *  Purpose          :	 This will generate the Account Records.
 *
 *  Created Date     :  	24/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
export default function generateData({ amountOfRecords }) {
    return [...Array(amountOfRecords)].map((_, index) => {
        return {
            Name: `Name ${index}`,
            Website: 'www.salesforce.com',
            Amount: Math.floor(Math.random() * 100),
            Phone: `${Math.floor(Math.random() * 9000000000) + 1000000000}`,
        };
    });
}