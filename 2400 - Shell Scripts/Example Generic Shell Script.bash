#!/usr/bin/env bash
# ↑我們不使用「#!/bin/bash」因為這包含了 bash 可執行檔是安裝在 /bin 目錄的假設，使用 /usr/bin/env 可以使得安裝於任意 PATH 變數中的路徑的 bash 得以同樣被使用，雖然這包含了 env 安裝於 /usr/bin 的假設但這比 /bin/bash 更加通用

# 這是「學習 Bash」專案中特別設計的嚴格模式設定，非必要
source "../9999 - Commons/Enable strict mode.source.bash"

# 回傳正常結束狀態（代碼 0）回作業系統，非必要
exit 0
