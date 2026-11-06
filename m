Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973293;
	b=QNNkQq1QA/iX1wWIqp3IoMPpfpKgsOEzOFgOwX/7LYLx5UZ2HA08mI6r/Jx7beI0jr3M
	 wlCOLNruwtKX8xOugPMCRsWhQ5UInDW+7ecRMDRnYbfC3l2ifaCT9ljlHmpPLqf4psxlT
	 EiNzS/xMOT22UFTEEH6N7aVU+XYa2ISfIYcq3z8B7pvnfl7syK1khF4reMC2dpbZyWaWZ
	 tX2L7DeTVAqlhwMqiuaqnzIsdGzyDhb/YgSHIPu1zYm/S8Q2DK3pDSTDURT9AoS8R4VtK
	 sjOaAKfM4qtu0BQlwUTa6gGNZYejkIQlp5nHBOaOT3GHgqWiFob1OUmbCW06KJpkJCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973293;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=f9AcNQk+E2Uh8Cu5xVuG9tcvbwsMIkzO8WOpBpYCAgs=;
	b=3yAKmZeeWB7ulqPFeYcG5Ud8XMxrTmN6AGLOuFWIfA2Dj2SVZ3OrDnNHfMDqor3gFIUW
	 x6UtHurc/Y3VShsaTe/piUOVPWyxznLuSGZTywXvF7KEUupHhkGpZIEPhDidKHxFUEpQn
	 vNE0jMkhbaWyp/2PKPzkvOI2LBFXQJ2caOLEOmRI2gSnTNzUsZtgMdhWP3TvpGylXMOr+
	 bPL+DiBDNcoG0KEljXR3A2J0dHh5mTPS8qOKMkBQz4uBIclRSoK9TtWxMr413KdhtJ318
	 dh6G2MpopQ3WgOLTrVzaW3YyJWxap+31AnCMsjD5ZP3kiW8PJ63hnqH6zmj9P8/QzIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tQuCMTAl;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B4606A339;
	Fri,  6 Nov 2026 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211B4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tQuCMTAl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793973281; bh=f9AcNQk+E2Uh8Cu5xVuG9tcvbwsMIkzO8WOpBpYCAgs=;
	h=From:To:Cc:Subject:Date;
	b=tQuCMTAlJdh9TBAB0kcxFJ3oATVWzvPPBHXN5P9liFaO6jerquWh9POmyHPNt/020
	 54iLXlJAK9/cJbWm5KDeov0r1o3wOPAtADj9EO61PFkw8567zaWzkyvhLJ7JPW4taC
	 t+cuLhx0YJNjgOtNWOinVGGN0zLKKnos8tkwNIrw=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id DA7AD633; Fri, 06 Nov 2026 21:54:39 +0800
X-QQ-mid: xmsmtpt1793973279tsdxdqbg3
Message-ID: <tencent_A85D514AA9FADF1423994E41A6F851213E08@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeF9R5xDbzU0MXB0V86cqjgru6iz3yUgboFdp3Wp3qZEkdVcYCk7
	 1BdupbI8FTABzocOqn1iq/MIdF5qIYO8r73iZNXG2No2Fs1UWjaACRFWN0acwg8dZVpx1t9zDQoM
	 IFIKYA5I8tLtQovYIOUdcYx+7bELy6/Jgns7AEWcn4xyG0i4CqS602cYUBTSsL0sx+trOyXA4Snj
	 ojYwwRk6e1/kMBBb9Up8vSku2prOigJ8YTORvKuSMkYZSvLGxejGX4+qtuDyGqJr8vH2vjP3eaS2
	 of3mh1RKX+PJIWsxz26Ly/5OixCL1j1/YCWRNAKf++VWRof1UVnJ6aKKxBX51W5CxoIBH+3+Hav9
	 jJyzrheSndFCzqK2iPGa7ktDb/oelHIthfJcYzXBr3bhGtM0t63gWBpZBDQdeeHFyo+gC2xKmbVI
	 JHolu4ETxJaWh3GNN4IKlguihpw+qF6G0DD3b7JcvL9OCD7wr2jLZ5B8k7DebDSZM/EImKERfPR0
	 nww3alyp550F/iewtdYc7F325t7o9KdzQEyxKrfLhf0WXR1Yg3zJ/7RJhqN40kC0/OR55TnpcQVN
	 WT7zslcH/niTB8pSp3400jzeQHK3gAN8qoQxaDwKslxswsUAHZFemBlyL7DZKudCRBS0rE8ADX5w
	 8KFZj8aR2BOQHyoI4CjGsbOZoYYRX3fq2JETvj0YiIPzQqisIAPtDEQOU+ZEi1WX85tAyypPEMWM
	 eWiouAXcDax1VIeRVc/yX6KYUwL1VaSRcVUWcor5zaMWkjSntBJY/LTp2yOmO1VhANjPWFS5+roG
	 MO7CLIs0+mpcAmZSqth+7aupct3Qhpfws/Jfl1yFCePcsb94cKos7y2OT3m8yZvXxV52N/R1c5Cr
	 T9wBjkUShONx0gYzFt9/kz1X0XLwOfoHpe14Fxajjm0tO/Is/ins6/oguhtX15NltbyPiOjo+RG3
	 ZW3pOrzGM4w/40R0HQtuAT3H0hXr/nZlQaXQezDMIVFPaVZ1f7YJFUPsKeePz/2bw7OB+nMAxLHY
	 snskZTgccP7a6yPypUKaGNF9JdqLO5+Kt92Nzj/lEJ7c4vba9H
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Guikun Yang <yangguikun19@qq.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: ntfs3: log replay reads past the restart page buffer when the on-disk
 sys_page_size is larger - slab-out-of-bounds in log_replay()
X-OQ-MSGID: <c21-ntfs3-logreplay-oob-20261106@qq.com>
Date: Fri, 06 Nov 2026 20:00:00 +0800
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

Mounting an NTFS volume whose restart page declares a sys_page_size
larger than the host page size ends in a slab-out-of-bounds read inside
log_replay(), during mount:

  BUG: KASAN: slab-out-of-bounds Read in log_replay+0x...
  Read of size 80 at addr ... (kmalloc-4k)
  Call Trace:
   log_replay fs/ntfs3/fslog.c
   ntfs_load_log_and_replay
   ntfs_fill_super

## The gap

log_replay() starts with the host page size:

  log->page_size = norm_file_page(PAGE_SIZE, &log->l_size, true);  /* 4096 */
  log->one_page_buf = kmalloc(log->page_size, GFP_NOFS);

The restart page is read by log_read_rst() -> read_log_page() while
log->page_size is still 4096, so the buffer holding it
(log->rst_info.r_page) is a 4096-byte allocation.

Later, log_replay() adopts the on-disk page size:

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
one_page_buf. rst_info.r_page is left allocated at the old page size
and is never re-read:

  ra2 = Add2Ptr(log->rst_info.r_page, ra_off);
  ...
  log->ra_size = le16_to_cpu(ra2->ra_len);   /* raw on-disk u16 */
  ...
  memcpy(ra, ra2, log->ra_size);             /* fs/ntfs3/fslog.c:4176 */

The destination ra is kzalloc(log->restart_size) - sized from the
adopted page size, so it is large enough. The source ra2 points into
the still-4096-byte r_page, and ra_len is a raw on-disk field bounded
only by sys_page_size - ra_off. With sys_page_size = 8192 (a legal
power of two, accepted by norm_file_page) and ra_len = ra_off + 80,
the memcpy reads 80 bytes past the end of the kmalloc-4k object.

The branch at fslog.c:4181 has the same problem from the other side:

  memcpy(ra->clients, Add2Ptr(ra2, t16), le16_to_cpu(ra2->ra_len) - t16);

same source, same unbounded length.

## Observed

Deterministic, 6/6 runs with panic_on_warn=1; the unmodified volume
mounts cleanly as a control. Trigger is mount(2) alone - no file is
opened. The forged restart page carries a valid update sequence array,
a consistent client list and matching seq_num_bits, so every existing
check passes; only the page-size adoption is abused.

sys_page_size = 8192, ra_len chosen just past 4096 - ra_off gives the
reported 80-byte overread; larger ra_len values read further.

## Suggested fix

Re-read (and reallocate) the restart page at the adopted page size, or
grow rst_info.r_page alongside one_page_buf in the same branch, before
ra2 is derived from it:

  if (log->page_size > old_page_size) {
          ...
          log->one_page_buf = buf;
  +       /* r_page was allocated with the old page size */
  +       kfree(log->rst_info.r_page);
  +       log->rst_info.r_page = kmalloc(log->page_size, GFP_NOFS);
  +       /* re-read the restart page at the new size */
  ...
  }

Alternatively, validating that ra_len fits within the buffer the page
was actually allocated with would bound the memcpy directly.

The reproducer (image builder that walks $MFT/$LogFile runlists and
writes the restart page with USA and client-list consistency, plus a
ready-made image and serial log) is available on request.

Tested on 7.3.0 (ntfs3 as a module); the adoption branch, ra_len
handling and the memcpy are unchanged in current mainline as of
2026-11-06.

Thanks,
Guikun Yang

