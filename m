Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9A3B8BCB;
	Thu, 30 Jul 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400107; cv=none; b=VCQvfz/uUvaO1e7lrl4JlGZOvb4ALePbfcPJ9RsDBne/UhwzSQMlmZWbYcLHFOteMvovoLOVabNvx96Kk2ZqztU3H3Q5krg/rxWj3Qv2piBrBp+PXKlSKadW6iHvD3QQyXC6h/Xj3vUJP73F6Jm6C/OSI6w48+2NDyuQ9jlvHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400107; c=relaxed/simple;
	bh=NTCOoWAKaLKeipWLv93p63aESaEvGvVw3e6FCgkSZpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CpgOxh8wgan+ELRxCTgDXajwmzH/k+TysiZZhRL0B1sQYh2UjZ6iHTYBdEQ99lexYERWm1yIk3KqP8vV5Mz/FTMTUwPujTEFtq4ksoe3bjlAH53sezhyXXpPEECR8girRVhYtLFjE/7qCzRiH/cBoJxvBL0Dsw8lH4RC9ZZ6dq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=g8XSBni0; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=eAX7KMHf; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="g8XSBni0";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="eAX7KMHf"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id C49BA26F7695;
	Thu, 30 Jul 2026 17:28:06 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1785400087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGgM+o6u1POQ8QoYDw79p4qMxBgzoC4dcKdGP2O5zyc=;
	b=g8XSBni0ItfvP4zvC/RnHzgOO+4OBXxigC1CzgLqAZSu3EyQxh4E1RHCxiXNULNI3GNHJI
	KzS5+Okk0zi/5TeereCWhn9nL7qYALs9C7iOyp+X/wKN8G3CLIlVAXa/VQQu7TZmJsunBW
	r2Q/G8oF5nsWF4WWBTCMp2kc/xxn/rWp5WztG77+t0dgHF2wMYk/nqv72mJ72UDplbxcj1
	TIiozWtW3+DxzpDz626VGuyvcl7yMTMfD41ClJKWayr9G78J7CE1ZV1/rxB9GgwnKfc166
	hyGOXe5eC8xdOlXF5ghA4EdFTmm3e2sGA0/nkccxWyR4Q8teCY+2K+oMRRyDiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1785400087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGgM+o6u1POQ8QoYDw79p4qMxBgzoC4dcKdGP2O5zyc=;
	b=eAX7KMHfK0/xuoZIMppYtT01KcqzkP+Rm22YiR7dsXJjp0eEQL4tsih7383gwH5Xb/J219
	Y9jpmF+jfbXM6/BA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 56E29E0099B;
	Thu, 30 Jul 2026 17:28:06 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 498D22200185; Thu, 30 Jul 2026 17:28:06 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: guibing <guibing@nucleisys.com>
Cc: hqfang@nucleisys.com,  linkinjeon@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  sj1557.seo@samsung.com,  syzkaller-bugs@googlegroups.com
Subject: Re: [BUG] fat: race between fat32_ent_put FAT update and mmc_spi
 transmit on shared page
In-Reply-To: <3C3DB358BBDEF242+9bbeab6b-4de5-4fc4-a4c5-fefd915fb562@nucleisys.com>
References: <3C3DB358BBDEF242+9bbeab6b-4de5-4fc4-a4c5-fefd915fb562@nucleisys.com>
Date: Thu, 30 Jul 2026 17:28:06 +0900
Message-ID: <871pckvq3t.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

guibing <guibing@nucleisys.com> writes:

> Hi,
>
> I would like to report a data corruption issue caused by a race 
> condition between the FAT32 filesystem driver and the MMC SPI block 
> device driver during background writeback.
>
> == Problem Description ==
>
> On a dual-core RISC-V platform running the SPEC CPU2006 benchmark suite,
> the SD card inevitably becomes read-only after approximately 2 hours of
> execution.
>
> The issue occurs when Core 0 attempts to write 512 bytes of data to the
> SD card via mmc_spi. The SD card returns a CRC error.
>
> Investigation reveals that in the mmc_spi_writeblock() function, the 
> data in t->tx_buf is correct before calling spi_sync_locked() (verified 
> by backing up tx_buf via memcpy). However, after spi_sync_locked() 
> returns, part of the data in t->tx_buf has been tampered with, causing 
> the data actually sent to the SD card to be incorrect.
>
> We have ruled out the SPI driver itself; it transmits exactly what is in
> tx_buf, but the data is being modified in memory during the transmission
> process.
>
> Relevant Error Log:
> # ./intspeed.sh 483.xalancbmk
> Starting speed 483.xalancbmk run with 1 threads
> [11035.536254] mmc_spi_writeblock:660 :write error eb (-84),use_crc:1
>
> == Debugging Evidence (Page Overlap) ==
>
> To pinpoint the corruption, I added debug variables to capture the
> underlying struct page of both the FAT metadata buffer and the SPI TX
> buffer.
>
> In fs/fat/fatent.c:
>      static volatile struct page *fat_ent_put_page_debug;
>      static void fat32_ent_put(struct fat_entry *fatent, int new)
>      {
>          WARN_ON(new & 0xf0000000);
>          fat_ent_put_page_debug = fatent->bhs[0]->b_page;
>          ...
>      }
>
> In drivers/mmc/host/mmc_spi.c:
>      static volatile struct page *mmc_spi_debug_tx_page;
>      static void mmc_spi_data_do(...)
>      {
>          ...
>          for_each_sg(data->sg, sg, data->sg_len, n_sg) {
>              ...
>              if (direction == DMA_TO_DEVICE) {
>                  mmc_spi_debug_tx_page = sg_page(sg);
>                  status = mmc_spi_writeblock(host, t, timeout);
>              }
>              ...
>          }
>      }
>
> When the corruption occurs, the printed values show:
>      mmc_spi_debug_tx_page == fat_ent_put_page_debug
>
> This proves that the FAT metadata page and the SPI TX buffer page are
> the exact same physical page.
>
> Using GDB to inspect the page flags of this shared page reveals: 0x8136.
> This corresponds to the following flags:
>      PG_writeback
>      PG_dirty
>      PG_lru
>      PG_active
>      PG_private
>      PG_referenced
>
> The presence of PG_writeback confirms that the page is currently being
> written back to the block device when the corruption happens.
>
> == Race Condition Details ==
>
> Core 0 (Background Writeback Path):
> The kernel writeback worker triggers an MMC SPI write.
> Call Trace:
>    worker_thread -> blk_mq_dispatch_rq_list -> mmc_blk_mq_issue_rw_rq ->
>    mmc_spi_request -> spi_sync_locked()
>
> Core 0 uses the page cache page directly as the SPI TX buffer and
> transmits it to the SD card.
>
> Core 1 (FAT Metadata Update Path):
> Concurrently, another core is updating the FAT table during a file write.
> Call Trace:
>    fat_write_begin -> cont_write_begin -> block_write_begin -> 
> fat_get_block ->
>    fat_add_cluster -> fat_alloc_clusters -> fat32_ent_put()
>
> In fat32_ent_put(), the FAT entry is updated directly via the buffer_head:
>      *fatent->u.ent32_p = cpu_to_le32(new);
>
> == Related Issue from Syzbot ==
>
> This race condition has also been detected by Syzbot using KCSAN (Kernel
> Concurrency Sanitizer), which reported a data race between the FAT update
> path and a read path (copy_folio_from_iter_atomic).
>
> Syzbot Report:
> https://syzbot.org/ai_job?id=68b1ff7f-84fd-4057-9672-beed284a98af
>
> == Workaround / Verification ==
>
> Adding the following check in fat32_ent_put() resolves the issue:
>
>   static void fat32_ent_put(struct fat_entry *fatent, int new)
>   {
>          WARN_ON(new & 0xf0000000);
> +
> +       struct buffer_head *bh = fatent->bhs[0];
> +
> +       if (bh && bh->b_page && PageWriteback(bh->b_page)) {
> +               wait_on_page_writeback(bh->b_page);
> +       }
>
> }
>
> This confirms that the corruption is caused by fat32_ent_put() modifying
> the page while it is actively being written back via the SPI path.
>
> == Environment ==
>
> Architecture: Dual-core RISC-V
> Filesystem: FAT32
> Block Device: MMC over SPI
> Kernel: Linux v6.6
> Platform: FPGA/QEMU with crc patch
>
> Any feedback or suggestions on the best way to fix this synchronization
> issue in the FAT block layer would be greatly appreciated.

Looks like this is the stable page issue that FAT is not
supporting. Maybe workaround is - if the block layer driver told
requires the stable page, wait the block write is completed.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
