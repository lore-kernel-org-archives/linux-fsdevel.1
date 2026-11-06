Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982161;
	b=mv5DMursZmqF8TALHU9/vOMjE2vz1PwiCvZesUhUhP5DYY79zDpVYdFh2YXFWo+KldXt
	 jlFbaYZs9/5umllfNPoKN0yAdM8UVEIVpbU3kWMnYgBuA6aP+SsDF9alGT5Fja3IYQzbo
	 Rz6N/Izi20LFafvM/3si3MRM5pE4SnpPHWiwxnJisFuWOWSFuv+OfDfpV+ORdM2GVk4jp
	 sjmWgZFEgcsBBJOHG4AxehbMorzZFwyjdKP1w9FGnxRRbUYuCX3hs3tzDFdb3DgpY+nXO
	 KEHecmAkVqZHX0hpIzDJeMhh8FoKPsv3Exl3aHwp064srKlAyvIhAr2EKDZrOuYSSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982161;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=DCDzPw2F80sT4Sgs9/DcqRRmYBsFv/D5+tKuj5rotaM=;
	b=GsI4hHhuSjAbdXSW13ComDUPV/nCdJTWL99WXJsXhyIUbRsQfcErOADQh6xu2cnjTgpA
	 TE8r2HekdXLiUwoMiKXE5EKeZa+kiMx9DLHXQMP20+DwBVuqn6FsZe8LHSSUlWNNKDzjR
	 CoQSqGf4qR/iDZNkvRpX0Un3a19YckaNxzXlDBBYnfGQTxbuBF5zzA174pnG+J44WI19h
	 gWbNyIYPU3b2wsifxrMqnGnxpzEZdPHePeSRXwWBeT0CK6+6vAmUUKnotL7ORLLvWu8GZ
	 UuDGuPJzn+YK9MTFUwIRY1zgmPppSrvDs1btj3GxhzHMM+3LJkOujTsara+sdp2xjWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=f5jLN6LG;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D083606A329;
	Fri,  6 Nov 2026 16:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D083606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=f5jLN6LG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793982154; bh=DCDzPw2F80sT4Sgs9/DcqRRmYBsFv/D5+tKuj5rotaM=;
	h=From:To:Cc:Subject:Date;
	b=f5jLN6LGGpuLan+LjoawuqHFEc1HaDXPvmfUpJK5ff9wgPWYQEVSfbqpa6T7a/zVc
	 z2+SpTDeASnAtffI+lMfCsOeEynmmNgS3hLWiBM9z6ICI1kLu3EItPlW+KsUa7HN4A
	 2HFLF3ZJkd9ciDh2+4T4vY4aw+2MPgck7/WVnJw0=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 5A0AAC9A; Sat, 07 Nov 2026 00:22:32 +0800
X-QQ-mid: xmsmtpt1793982152t3zg7xqu9
Message-ID: <tencent_2F1179A70C53C9285C1F81A8ACD4A7EFD107@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzngS2+3N8gE6Jg5viauA4d7sQJIWhGTZA5YZGSuMo9TdjGYwllm2
	 WovUSwAD3YJdF7peAr2gW/4/krpuv1WIC+/Ib6gzdBSPsXU143IskuBtO9ecZeJB6cNcTFiGCaU6
	 0LuV4RWHi3fp6dFRVzJYDNYATh3K1BUYx5QvFUB8GhJXa3a8KbarCbrBBHqNUjx47Vxyq0PLqFLP
	 tYWU/nBmEWiykE2igZqb9VQKnxFyVi1xMzayxpJCCjtocs4qYo60UTZHTa6pa0B29uG4OO23HX4t
	 iD9O3prfayWGCLyEKzjW8zo0Y3vx5EnL5i5ELtHDIL4lhudXP2r2Yo6WEgc5epaGreEFLrGgtVnT
	 FFAlBdPei8HfPVAEFER1hV1ALWjLNk3o5gS3zb/3NzaDGslsIFRyTgVJQKHIZtEyA7tW2wM6QiDA
	 JBYd1OFjt6TfdVFvzGn4/4DI9Uym/2MjAte2DfBkxnr+VWJiIbt7RpiAewhEUL8VZRnD+ZfKzptx
	 rK4k2q25rK7Q02dOJZhLs3j/liDLNm9ttLq+amA2cmByM9zS2i0YCN6nO9cefxeQvXlrhLtW3AYI
	 WNspk8FatZnVx9xkD3VfTIE2ylznqxSg0JdNAft9eeh4tLOYCvfoG8hdkQjHQwAqFK54NL3qjMEo
	 f02omE8y0Hj072ac70MkbeJsqpwhBmIpAymEtHNTX8onU0fOM9rGR0ZswM9IdD1T1gku7QyWQKBl
	 J3IWgkyyw4OpUAxwtH7HqrfR8TRGxWDpSPkHriTWQGaSSr0uOw5s0C3FJ8yZRl7yVWNx26Z3W3fy
	 xyn7UzFaxn2ohZvGLCxjmkG3ZIHpNHU4RcqedulBVVrc9whIKF9QQDVSVFjitkT/2hx6a756nqyx
	 FTrxx1jzYVM+Hwgfo5tJguoX6mYiq6w/nilN71u+fCRoUt9wP2tWCiMMN5VMu6h5vcH3ii/YR08z
	 GJv4b4lZYa3WugDq1jZakqt9ZvRsi2/Z5rfQC2Us/tRXUrTMDW1arhxO3MgIUjZr/O98mtubV1Dz
	 je3PPx4lXscDZgeuQFWAYfk5Chh3qfcy0d+0LMTg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Guikun Yang <yangguikun19@qq.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: ntfs3: two out-of-bounds reads in $LogFile replay (restart page
 resize, restart table offset)
X-OQ-MSGID: <c21c25-ntfs3-logfile-oob-20261106@qq.com>
Date: Fri, 06 Nov 2026 22:00:00 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

Two related out-of-bounds reads are reachable through $LogFile replay
during mount. Both are in fs/ntfs3/fslog.c, both need only a crafted
volume whose restart area is internally consistent (valid USA, client
list, seq_num_bits), and both are unfixed in current mainline.

  BUG: KASAN: slab-out-of-bounds Read in log_replay+0x...
  BUG: KASAN: slab-out-of-bounds Read in check_rstbl+0x...

Both reproduce 3/3 (6/6 for #1) with panic_on_warn=1; the unmodified
volume mounts cleanly as a control. Trigger is mount(2) alone; no file
is opened.

## 1. Restart page buffer not resized when sys_page_size is adopted

log_replay() starts with the host page size:

  log->page_size = norm_file_page(PAGE_SIZE, &log->l_size, true); /* 4096 */
  log->one_page_buf = kmalloc(log->page_size, GFP_NOFS);

The restart page is read while log->page_size is still 4096, so
log->rst_info.r_page is a 4096-byte allocation. Later the on-disk page
size is adopted:

  t32 = le32_to_cpu(log->rst_info.r_page->sys_page_size);
  if (log->page_size != t32) {
          log->page_size = norm_file_page(t32, &log->l_size, ...);
          if (log->page_size > old_page_size) {
                  buf = krealloc(log->one_page_buf, log->page_size, ...);
                  log->one_page_buf = buf;
          }
  }

5a35454179 ("fs/ntfs3: resize log->one_page_buf when adopting on-disk
page size") added exactly this krealloc, but it only covers
one_page_buf. rst_info.r_page stays at the old size and is never
re-read, and the restart area is then copied out of it:

  ra2 = Add2Ptr(log->rst_info.r_page, ra_off);
  log->ra_size = le16_to_cpu(ra2->ra_len);   /* raw on-disk u16 */
  memcpy(ra, ra2, log->ra_size);

The destination ra is kzalloc(log->restart_size), sized from the
adopted page size and large enough. The source ra2 points into the
still-4096-byte r_page, and ra_len is bounded only by
sys_page_size - ra_off. With sys_page_size = 8192 (a legal power of
two, accepted by norm_file_page) and ra_len just past 4096 - ra_off,
the memcpy reads past the end of the kmalloc-4k object (80 bytes in
our run). The branch at fslog.c:4181

  memcpy(ra->clients, Add2Ptr(ra2, t16), le16_to_cpu(ra2->ra_len) - t16);

has the same problem from the other side.

## 2. Restart table redo_off is unbounded

The restart tables (transaction table, dirty page table, open
attribute table) are loaded through a shared path:

  t16 = le16_to_cpu(lrh->redo_off);
  rt = Add2Ptr(lrh, t16);
  t32 = rec_len - t16;
  if (!check_rstbl(rt, t32))
          goto out;

redo_off is only checked for 8-byte alignment (check_log_rec()), not
against rec_len, and rec_len - t16 is an unsigned subtraction that
wraps when redo_off > rec_len. check_rstbl() then dereferences
rt->size as its first statement - either from the wrapped length or,
when redo_off lands at the end of the record buffer, from memory past
the page buffer entirely.

check_add_overflow() protection added for the record header only
covers client_data_len + rec_hdr_len; these in-record offsets are not
covered. In our run redo_off = 0xFD0 puts rt exactly at the end of the
4 KiB record buffer:

  BUG: KASAN: slab-out-of-bounds in check_rstbl+0x...
  Read of size 2 ...
   check_rstbl -> log_replay -> ntfs_loadlog_and_replay -> ntfs_fill_super
  Allocated by: read_log_page -> find_log_rec -> read_log_rec_lcb

All three table load sites share this code, so one forged offset
reaches the transaction table, the dirty page table and the open
attribute table alike.

## Environment common to both

The forged $LogFile is internally consistent - update sequence array,
client list, seq_num_bits - so every existing check passes; only the
missing bounds above are abused. The replay machinery needed two
details in last_log_lsn(): clearing RESTART_SINGLE_PAGE_IO, and giving
the tail page's last_end_lsn a different sequence number so the
major-1 tail-page logic does not rewrite file_off back to the LSN.

The reproducer (one image builder covering both cases, ready-made
images, serial logs) is available on request.

Both code paths are unchanged in mainline as of 2026-11-06.

## Suggested fixes

1. Re-read (or reallocate) rst_info.r_page at the adopted page size
   before ra2 is derived from it; alternatively bound ra_len by the
   size the page buffer was actually allocated with.
2. In the table load path, validate redo_off <= rec_len before
   computing rt, and use check_add_overflow() for rec_len - t16 (or
   reject redo_off > rec_len outright), matching what
   e2fcb0040b did for client_data_len.

Thanks,
Guikun Yang

