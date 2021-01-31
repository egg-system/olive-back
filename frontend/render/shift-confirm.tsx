import React from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios'


export function setUp() {
    const confirmButton = document.getElementById('shift-confirm-btn') as HTMLButtonElement
    const fileBtn = document.getElementById('shift_shift_csv') as HTMLInputElement
    if (!confirmButton || !fileBtn) {
        return
    }
    const host = confirmButton.dataset.url! as string;
    let file: File | null;
    fileBtn.addEventListener("change", function (e) {
        const target = e.target as HTMLInputElement;
        if (target.files) {
            file = target.files.item(0)
        }
    }, false);
    confirmButton.addEventListener('click', () => {
        if (!file) {
            return
        }
        fetchShifts(host, file);
    })
}

async function fetchShifts(host: string, csv: File) {
    const token = $('meta[name="csrf-token"]').attr('content');
    let formData = new FormData();
    formData.append("shift[shift_csv]", csv);

    const headers = {"X-CSRF-Token": token, "content-type": "multipart/form-data"};
    const res = await axios.post(host, formData, {headers});
    console.log(res)
}
