Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA783BCD02;
	Thu, 30 Jul 2026 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396479; cv=none; b=KhcQqseOnBruPRvHHrokeZA0KfeJbz8TLCZuaZ14vJzFnu+rIFYlqFzu/q3nq3BJQ6OfpnajfcQeDsOI7qR2cVZpZaLpfNktiKlYWXcRT/Q3Ew2tN2KlbUGyr5WvmJ8xB40FJzQPE0B+/D7I/YQeA7n+v/J+mCifKa15INdQWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396479; c=relaxed/simple;
	bh=2p8ZYs6r/qxuufuUL3/HJrWefbUaSdNIXvCXjp9B7vw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=WIng7XpoR/yd0viXKAYjR01Hdw/iHCVi1VcnRmfDGrgMe3m03TW02JkkiUzihXQ0fy759uEmPOrd/vXIiHLIGbpsLFqlVSZvuKEA7k7jBeYC9GcSIJHxhowjd3gtvzDeZ6mTvTrtUR5ikdV+JYvVmDYKHUeCI4zMixMvILhmBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nucleisys.com; spf=pass smtp.mailfrom=nucleisys.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nucleisys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleisys.com
X-QQ-mid: zesmtpgz6t1785396426t837dc9d6
X-QQ-Originating-IP: mPlfs4n06BCjo5tUECzdIfZL6IpwSlhPN+His4ne8gI=
Received: from [192.168.30.227] ( [58.19.1.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 15:27:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7464616806111507561
EX-QQ-RecipientCnt: 7
Message-ID: <3C3DB358BBDEF242+9bbeab6b-4de5-4fc4-a4c5-fefd915fb562@nucleisys.com>
Date: Thu, 30 Jul 2026 15:27:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: guibing <guibing@nucleisys.com>
Subject: [BUG] fat: race between fat32_ent_put FAT update and mmc_spi transmit
 on shared page
To: hirofumi@mail.parknet.co.jp, hqfang@nucleisys.com
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:nucleisys.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MRY6qckr/MVJesLSmQg7MRP0hCREuv//YSjWGrEAW4bWOxHkdD7YvMAh
	x4X0WV8wq8wGzPRtk+iLhYjGs1JkhxL/9qUkDEG37PUeIBb639D5IoKVQWuIZO4XyavFx3F
	gVmZuUmFMHppCvqCAqyjt9mYHzDIjEUMmf43sk1TO3Cv0JlkeAuiBBtSslILrZyKRtYCIKW
	rEqNk1x2HaADD32nAgCrRCqhnTuCcH4Dd2PuZVZ2DEa9gAwL6I++sHyjaGmnVIIftO4Q8qC
	zt23jtVb8p41bE6cHRWPKGSi4g3qtCR0e5mIzZnJ9eVzBSnwaeT+UnmX7FqzCSEjITKibgX
	Ige0b60HsiZTtjPXotVhtG5xUAHyptKjy6flXYMQ4RNid5j0DnwBN1fJF1UXMZWDN2hXHNf
	IRyuvN4EdNZGnR/M4aYXeqYJdqVGiYtJuIOmgKg1FX0DfOkZ9UCUHWigYzNmYX0kRJvvpxm
	ZsOlQBI373Kk6h6yJ3d8iyPPFwPDOP42m/tO8JaqNZk8nKnohjl42ufA/x+WbFnEEElOvxY
	JyTLLkcpquZs6YNSubpT33fMMRIe8cIrsJXTuFiVVAH80JANZOErKnszQzoKJwXRjghOJ8Q
	8gtnOXhyiN4NsqPlhf9p26PktpO76LcsNGb5KLC6voCP6+IEDvTXwpxIEqF1exhP3ymur9w
	7+7oadKybJctf/QTmgbIUjxCHNLZWME9kSKdyGu7gaCDp0BkRvH8uyuwTB91n6L6uFXXXb2
	yvLChLWP7VvnPzdo5O/4EZ4P/nZSo05yyDcpR1/nNgW6rPShDSYzeacj+BpArc1oAYC3pP0
	OCmBDy4yVTePzfknSm6zIIYvhu/S4rIhgv9wGFl/6UWAh2tr4oAGIB7UNebwVVtbVNyYzjd
	gSeTYDT3LiDx8BXK05jqyBzm0wndH9mAgxK0980dF1e/+LhCf53F/K+buJZ9l2AQrIbfewt
	RXZPvedUUByu7nb+3xEjrxfbggCM82KIXrJthAvH7uhUemvWqo0OmfsOO4OLDDxKyYvKuLJ
	5i6Rw4OOGuLFLnU+tBhokmmlX/dvRuK+QS6HY+/abV32vjmywiIxhFxqBdLSs=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hi,

I would like to report a data corruption issue caused by a race 
condition between the FAT32 filesystem driver and the MMC SPI block 
device driver during background writeback.

== Problem Description ==

On a dual-core RISC-V platform running the SPEC CPU2006 benchmark suite,
the SD card inevitably becomes read-only after approximately 2 hours of
execution.

The issue occurs when Core 0 attempts to write 512 bytes of data to the
SD card via mmc_spi. The SD card returns a CRC error.

Investigation reveals that in the mmc_spi_writeblock() function, the 
data in t->tx_buf is correct before calling spi_sync_locked() (verified 
by backing up tx_buf via memcpy). However, after spi_sync_locked() 
returns, part of the data in t->tx_buf has been tampered with, causing 
the data actually sent to the SD card to be incorrect.

We have ruled out the SPI driver itself; it transmits exactly what is in
tx_buf, but the data is being modified in memory during the transmission
process.

Relevant Error Log:
# ./intspeed.sh 483.xalancbmk
Starting speed 483.xalancbmk run with 1 threads
[11035.536254] mmc_spi_writeblock:660 :write error eb (-84),use_crc:1

== Debugging Evidence (Page Overlap) ==

To pinpoint the corruption, I added debug variables to capture the
underlying struct page of both the FAT metadata buffer and the SPI TX
buffer.

In fs/fat/fatent.c:
     static volatile struct page *fat_ent_put_page_debug;
     static void fat32_ent_put(struct fat_entry *fatent, int new)
     {
         WARN_ON(new & 0xf0000000);
         fat_ent_put_page_debug = fatent->bhs[0]->b_page;
         ...
     }

In drivers/mmc/host/mmc_spi.c:
     static volatile struct page *mmc_spi_debug_tx_page;
     static void mmc_spi_data_do(...)
     {
         ...
         for_each_sg(data->sg, sg, data->sg_len, n_sg) {
             ...
             if (direction == DMA_TO_DEVICE) {
                 mmc_spi_debug_tx_page = sg_page(sg);
                 status = mmc_spi_writeblock(host, t, timeout);
             }
             ...
         }
     }

When the corruption occurs, the printed values show:
     mmc_spi_debug_tx_page == fat_ent_put_page_debug

This proves that the FAT metadata page and the SPI TX buffer page are
the exact same physical page.

Using GDB to inspect the page flags of this shared page reveals: 0x8136.
This corresponds to the following flags:
     PG_writeback
     PG_dirty
     PG_lru
     PG_active
     PG_private
     PG_referenced

The presence of PG_writeback confirms that the page is currently being
written back to the block device when the corruption happens.

== Race Condition Details ==

Core 0 (Background Writeback Path):
The kernel writeback worker triggers an MMC SPI write.
Call Trace:
   worker_thread -> blk_mq_dispatch_rq_list -> mmc_blk_mq_issue_rw_rq ->
   mmc_spi_request -> spi_sync_locked()

Core 0 uses the page cache page directly as the SPI TX buffer and
transmits it to the SD card.

Core 1 (FAT Metadata Update Path):
Concurrently, another core is updating the FAT table during a file write.
Call Trace:
   fat_write_begin -> cont_write_begin -> block_write_begin -> 
fat_get_block ->
   fat_add_cluster -> fat_alloc_clusters -> fat32_ent_put()

In fat32_ent_put(), the FAT entry is updated directly via the buffer_head:
     *fatent->u.ent32_p = cpu_to_le32(new);

== Related Issue from Syzbot ==

This race condition has also been detected by Syzbot using KCSAN (Kernel
Concurrency Sanitizer), which reported a data race between the FAT update
path and a read path (copy_folio_from_iter_atomic).

Syzbot Report:
https://syzbot.org/ai_job?id=68b1ff7f-84fd-4057-9672-beed284a98af

== Workaround / Verification ==

Adding the following check in fat32_ent_put() resolves the issue:

  static void fat32_ent_put(struct fat_entry *fatent, int new)
  {
         WARN_ON(new & 0xf0000000);
+
+       struct buffer_head *bh = fatent->bhs[0];
+
+       if (bh && bh->b_page && PageWriteback(bh->b_page)) {
+               wait_on_page_writeback(bh->b_page);
+       }

}

This confirms that the corruption is caused by fat32_ent_put() modifying
the page while it is actively being written back via the SPI path.

== Environment ==

Architecture: Dual-core RISC-V
Filesystem: FAT32
Block Device: MMC over SPI
Kernel: Linux v6.6
Platform: FPGA/QEMU with crc patch

Any feedback or suggestions on the best way to fix this synchronization
issue in the FAT block layer would be greatly appreciated.

Thank you！
