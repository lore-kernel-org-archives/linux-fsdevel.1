Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D53822BB;
	Thu, 30 Jul 2026 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402402; cv=none; b=sb66XxUltYR7WP7tSeQzvUqEQLRN8jpTIWGMn9fxUInmn/sD6+OxZJOJBHxYCjkmbsSlL8lUtOYEUehh/kj1qJHWBWhOvTf8fUXHsTGtfif4drclb7friPZro/sWewSxt0u06Uy1Rnysvmy6daUY97TaD0ERbsTU1ScLuyr1LWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402402; c=relaxed/simple;
	bh=4FKE5Yn9Sxn8PdviyuIVpKjnkTuBy4yYO7aw7C135kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZU2YZbr/tYjg1c5jPpI3xE7N0Tk4LrznffjqS4ucN1SoQhJHP0AGncu8h/o0V24dArdhBnZD9o6kN4e0Js1O753YvFTnzu9sMH1fpeIUjNgaeZkPr4EERzkcUhXdwK6c5WK+l1pSCz/tMPwXfsPhSQ7U6bmFaZrRC+711SaUTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nucleisys.com; spf=pass smtp.mailfrom=nucleisys.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nucleisys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleisys.com
X-QQ-mid: zesmtpsz5t1785402353t96be601f
X-QQ-Originating-IP: n82tMJtS0h2BGnIVdAHAR+xhZ2QXDnfZ2yCuqSwaAbc=
Received: from [192.168.30.227] ( [58.19.1.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 17:05:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6578183141029421202
EX-QQ-RecipientCnt: 7
Message-ID: <976A3274AE66DB00+9877ce61-dcab-40c0-bcb3-08fbf30548b7@nucleisys.com>
Date: Thu, 30 Jul 2026 17:05:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] fat: race between fat32_ent_put FAT update and mmc_spi
 transmit on shared page
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: hqfang@nucleisys.com, linkinjeon@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
References: <3C3DB358BBDEF242+9bbeab6b-4de5-4fc4-a4c5-fefd915fb562@nucleisys.com>
 <871pckvq3t.fsf@mail.parknet.co.jp>
From: guibing <guibing@nucleisys.com>
In-Reply-To: <871pckvq3t.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:nucleisys.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NHWu+C5lrGIMQRZo8RDA/eBaoSkg6PiSWQQL6z+SQIQPU18szQj2RYRD
	M+nfGfzVjjxcXtqZQhPOv5jqOkNTvApmzkQAVMDs3ARAq7rYpEytN1gmGncApjcxfXe2uRI
	2+9SUDPblToPuJ62w2I5pOUMrttaXSIX87QCPCvhaN8mDI9GyUB9aW2F/h7j5JoCgo2A4FJ
	ctC72o0ZJMHbY4OkfPd41K/hC+u16C44iKHKIjITlJaPlMeLR8OuSbuv5YN/QaBZeKbwKjI
	zXQfUj9opeyuasJQwtE8IkVyzEVJGrouHqeHalLkq1eLb/55WGe0WL+gd5KNp86+RowAiMz
	WI5SUIhvW/FJ2qpxa0KCQaxLUkF0SjdtwWpnvZmzYgH9+QPuw0fo9guB8CXXlYmRDmgOQRy
	iNExHBxC58FUWRpCwPYM2C6+8NzKnhWMB0zmd+RcN2EQG5Ums3xfnLZB4U9CTEEnY390JEM
	2i5KEePCsUPgBDdq0YueMJl/Ax0NShP3J1u8PRcYB4viOMUCLVThux19ZR18aUEb/5B9KNV
	yLT/dQQX1zw0TN8DQ8huiYDFQ33cYUjje1oReufvW+kr/2bAkbOVfTIvuF5JL04eh3nKrKS
	jk/80faCHDJU3i5FOlKvM06Czj6ZZrV/WsAiJesdYEUVPOHWsAXokQ2hnoOr7uDBG/MPdTL
	/mzs8hILLp1z7BLXf2/mS51q/oATlle8/q9TmT/a5pamXMWuAneAk29CCh+6YDuIUr0g0ZP
	a760m0NeYDcjq8okLCq8nnIAQ+zdhDZ/teGcfSwi+PnvYrIoS07jdkiBW4p1jTzIDJFpKpN
	hI5amnqKCmnjqKYh51dLPUPV/7HFUzvg58R0m8WCGS5zWj4jGv+9ECV4sJMkWjK2ToHec0u
	MSZ6UIlbRvLMxKz34ovJ94vv50uMBrzB9/AZJyCbijCz8FeZsVHuTkTKLl5TOKvQ8a/6Yas
	PW+O5zK5DRgZ6sM98Dxs0Y/ftX18sovMYZpMtZH9KQv/L7SSioWXokjmfmak5P99bJZVddj
	vQOM47zDjXmE+zXuzauBwtGFs9NcgDoYBmu5mLVH+wDX4E+mn+IJnTx8sYtuFHkyQay2HKP
	NIwjw3Np+aM/YUel1ZdM5vPGZfI+/n3dci5omNrAeOBJLxgeenG7B/QBMfJvI/+yL5nt51D
	7wjyV802tF1v6t2ST2yoVl9Szw3sLLO0xjGGhldtkx1XVrAgUJnQWdzOQg==
X-QQ-XMRINFO: NyFYKkN4Ny6F0mTtly+dDvEakSVbKxgzoA==
X-QQ-RECHKSPAM: 0

Hi Hirofumi，

Thanks for the explanation. I noticed that syzbot has also reported 
similar data race issues related to this. I was wondering if there are 
any plans to support stable pages for FAT in the future?

Could you help me to review the workaround ? Are there any potential 
issues with it?

thank you!

在 2026/7/30 16:28, OGAWA Hirofumi 写道:
> guibing <guibing@nucleisys.com> writes:
> 
>> Hi,
>>
>> I would like to report a data corruption issue caused by a race
>> condition between the FAT32 filesystem driver and the MMC SPI block
>> device driver during background writeback.
>>
>> == Problem Description ==
>>
>> On a dual-core RISC-V platform running the SPEC CPU2006 benchmark suite,
>> the SD card inevitably becomes read-only after approximately 2 hours of
>> execution.
>>
>> The issue occurs when Core 0 attempts to write 512 bytes of data to the
>> SD card via mmc_spi. The SD card returns a CRC error.
>>
>> Investigation reveals that in the mmc_spi_writeblock() function, the
>> data in t->tx_buf is correct before calling spi_sync_locked() (verified
>> by backing up tx_buf via memcpy). However, after spi_sync_locked()
>> returns, part of the data in t->tx_buf has been tampered with, causing
>> the data actually sent to the SD card to be incorrect.
>>
>> We have ruled out the SPI driver itself; it transmits exactly what is in
>> tx_buf, but the data is being modified in memory during the transmission
>> process.
>>
>> Relevant Error Log:
>> # ./intspeed.sh 483.xalancbmk
>> Starting speed 483.xalancbmk run with 1 threads
>> [11035.536254] mmc_spi_writeblock:660 :write error eb (-84),use_crc:1
>>
>> == Debugging Evidence (Page Overlap) ==
>>
>> To pinpoint the corruption, I added debug variables to capture the
>> underlying struct page of both the FAT metadata buffer and the SPI TX
>> buffer.
>>
>> In fs/fat/fatent.c:
>>       static volatile struct page *fat_ent_put_page_debug;
>>       static void fat32_ent_put(struct fat_entry *fatent, int new)
>>       {
>>           WARN_ON(new & 0xf0000000);
>>           fat_ent_put_page_debug = fatent->bhs[0]->b_page;
>>           ...
>>       }
>>
>> In drivers/mmc/host/mmc_spi.c:
>>       static volatile struct page *mmc_spi_debug_tx_page;
>>       static void mmc_spi_data_do(...)
>>       {
>>           ...
>>           for_each_sg(data->sg, sg, data->sg_len, n_sg) {
>>               ...
>>               if (direction == DMA_TO_DEVICE) {
>>                   mmc_spi_debug_tx_page = sg_page(sg);
>>                   status = mmc_spi_writeblock(host, t, timeout);
>>               }
>>               ...
>>           }
>>       }
>>
>> When the corruption occurs, the printed values show:
>>       mmc_spi_debug_tx_page == fat_ent_put_page_debug
>>
>> This proves that the FAT metadata page and the SPI TX buffer page are
>> the exact same physical page.
>>
>> Using GDB to inspect the page flags of this shared page reveals: 0x8136.
>> This corresponds to the following flags:
>>       PG_writeback
>>       PG_dirty
>>       PG_lru
>>       PG_active
>>       PG_private
>>       PG_referenced
>>
>> The presence of PG_writeback confirms that the page is currently being
>> written back to the block device when the corruption happens.
>>
>> == Race Condition Details ==
>>
>> Core 0 (Background Writeback Path):
>> The kernel writeback worker triggers an MMC SPI write.
>> Call Trace:
>>     worker_thread -> blk_mq_dispatch_rq_list -> mmc_blk_mq_issue_rw_rq ->
>>     mmc_spi_request -> spi_sync_locked()
>>
>> Core 0 uses the page cache page directly as the SPI TX buffer and
>> transmits it to the SD card.
>>
>> Core 1 (FAT Metadata Update Path):
>> Concurrently, another core is updating the FAT table during a file write.
>> Call Trace:
>>     fat_write_begin -> cont_write_begin -> block_write_begin ->
>> fat_get_block ->
>>     fat_add_cluster -> fat_alloc_clusters -> fat32_ent_put()
>>
>> In fat32_ent_put(), the FAT entry is updated directly via the buffer_head:
>>       *fatent->u.ent32_p = cpu_to_le32(new);
>>
>> == Related Issue from Syzbot ==
>>
>> This race condition has also been detected by Syzbot using KCSAN (Kernel
>> Concurrency Sanitizer), which reported a data race between the FAT update
>> path and a read path (copy_folio_from_iter_atomic).
>>
>> Syzbot Report:
>> https://syzbot.org/ai_job?id=68b1ff7f-84fd-4057-9672-beed284a98af
>>
>> == Workaround / Verification ==
>>
>> Adding the following check in fat32_ent_put() resolves the issue:
>>
>>    static void fat32_ent_put(struct fat_entry *fatent, int new)
>>    {
>>           WARN_ON(new & 0xf0000000);
>> +
>> +       struct buffer_head *bh = fatent->bhs[0];
>> +
>> +       if (bh && bh->b_page && PageWriteback(bh->b_page)) {
>> +               wait_on_page_writeback(bh->b_page);
>> +       }
>>
>> }
>>
>> This confirms that the corruption is caused by fat32_ent_put() modifying
>> the page while it is actively being written back via the SPI path.
>>
>> == Environment ==
>>
>> Architecture: Dual-core RISC-V
>> Filesystem: FAT32
>> Block Device: MMC over SPI
>> Kernel: Linux v6.6
>> Platform: FPGA/QEMU with crc patch
>>
>> Any feedback or suggestions on the best way to fix this synchronization
>> issue in the FAT block layer would be greatly appreciated.
> 
> Looks like this is the stable page issue that FAT is not
> supporting. Maybe workaround is - if the block layer driver told
> requires the stable page, wait the block write is completed.
> 
> Thanks.

