Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A683D7D78
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589302; cv=none; b=pKoHhkOTjqlawu7FrmKpoNm5T0Nc5X7/I5kl+VXaWL0W56oYOXsJeHMD3glT89B9qAg7e2pgKZ29utpeQlwg0NJUI3Gk7imznQH480r9QK0VKurPQdinaIREXVRDQmOat4berrYmpL3/8+kZ02Ftq2GfFctsyVTdaUDjqctqpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589302; c=relaxed/simple;
	bh=bUF0WWM/m3OaIUFsDDSwWLaisMG6lHQGDTvC/M/rkrk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=dCl/cR+R0IvWEfBh/Qa454uy529oH7f0iEjyDNr3T62ygE3z3Xqn7qXfdRY4/+iNwqUlCANE6WoTGvGPREqWdBYp6mulZhpNI2wlNnGm5qaABqSiVVo93xVs48RwZ5yBduoNPnpXrCos3NYpg7DoIj4QnYe0vJDwaxxLxVBzUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=XPgMjkKU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="XPgMjkKU"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3967738c801so35248681fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781589299; x=1782194099; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqgXefFuOd3LpRQqkqqqOZeyN+jGArCTQFfTEtCT6Rs=;
        b=XPgMjkKU1IpIOfZL78Du1QJKWtgSlT1Nhi/mNDT7s+tMKqwSgZXHzI32kCLhDwpRWk
         JS2Pw5LRDT9d8ByZn+N6dGnAwFqRTPY/U1WNjESTAiovGH1tHhGjNFPllehGFFNDpHmo
         5B0aFO4hMSUEfB3iWZ85GlWLm0djtuMvldkuZWY1j37LpSlxjXX4B9NKgzlrzP+HwCRV
         iNSVq4CN+37lKPQ1wYqCDCdg4WJidJL5OSIuO+3Ge3ZclariEoyzXBQlY8LiqnFmOBdB
         +Ju5YRcHB6R2iG5OxR+suGp4C/x0Yi/Di5qO9y6JyIRNGQvrTDJA6g/ChiJMKcwwcBjw
         gHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589299; x=1782194099;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqgXefFuOd3LpRQqkqqqOZeyN+jGArCTQFfTEtCT6Rs=;
        b=F9pHj+SxIFTCnmRKhJcxEDBahHTljIuCK2gvYGHKH4/AzrStVpu+0MndV5ZD8q3jw4
         gr9RcnqSblUuT1b2mPSbTpWykPCMYymqaOtPz5qxnI1Z+E657QZFUgA0woJCQpPqCNaz
         nXISgp2c8L2C4vll97DilD3+f4PUbzus8meuLab66u0F3Hl/kQdx4dHo5Nt3O0GIk9RG
         RznQCl/IVztXbyExUtuNvh46Q84R3Yq3uhwwBrZafkr435hnY4cJEEJoHMKwlEYnQBEn
         B2mXPTb9TCZwDCy4LXWbZYf++CBzt5dagtOM338vZW+ln3ESOEYObCFO0U0XYK/MpUXP
         Mdew==
X-Forwarded-Encrypted: i=1; AFNElJ9Y2RIbevk1y1U4Yh/kaLML8ZWF9N56C7ajrFVMua7NOQt4SeRpDGRLmFHYmQFK9pNTPKOFQhbfDabKwjKB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Ss/0Ap/uGbD482WRJg54oN2FhExbQzcyZUojPgn+f2KS9JVj
	Autimo12vAAExhLi13ZPUVyvN0nzqEEqyKMoQKNItKwtrBdyzXRuSgqqEDB24YW8JhE=
X-Gm-Gg: Acq92OHkuzGhYAgs59XyubIIbzdwp5ykKZvNG2kNpzinN06Um2RUW2VlvcsmBW6q5N4
	U816gG4UcaRjUKz1Ezc6QJMaXu3733TVOkdmxdN+QNXw+03GVMRSXSd+c731eA6hItQMIsQxLQb
	oNm5V/G5BcrwAd2A909a5F+BRcJG+F5yiGgIrJ4QXyZ7EYWY3t4lz5bk9vj6BZjSvCF4iL2kkun
	ASH2AbW7RvpGne1ErmFN7XloMcHtK6bpXSYMeWiCkXcAf/3ecYyHkY2IPlL1Dtek7CR6famRni5
	ub8m8TbJzWNjlEWskIj73kdTYExMTETPpP2cIgQ5E4dJoRCdSQIzDL/KwLKvZxKzrcMdJnEe7Xf
	iRP028NT9UBShKUIy5oSuDEkJkfrHcfI4GlEN7te3Na405VKzSewtno+QcGdvjCY9ys6dnsCo1O
	ZYVLM1dw5zQPlkvGt0xl75TGKqGY/ZfLHaNqz7uCi/x7l1M2rvCvs/ovcOehYUCW7fTyrihifwL
	ppD66slhveSFOJkREuY
X-Received: by 2002:a2e:a80e:0:b0:396:6bd5:a9c7 with SMTP id 38308e7fff4ca-3995c85103dmr5860411fa.19.1781589299019;
        Mon, 15 Jun 2026 22:54:59 -0700 (PDT)
Received: from [192.168.3.148] ([31.23.24.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c1918a1sm4087581fa.19.2026.06.15.22.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:54:58 -0700 (PDT)
Message-ID: <6865b4242f6352ef0b2b40a9cf7a85d12464279e.camel@dubeyko.com>
Subject: [GIT PULL] nilfs2 changes for 7.2-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, konishi.ryusuke@gmail.com,
 kartikey406@gmail.com, 	shuangpeng.kernel@gmail.com,
 zenghongling@kylinos.cn, Slava.Dubeyko@ibm.com
Date: Mon, 15 Jun 2026 22:54:56 -0700
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Linus,

This pull request contains fixes of syzbot reported issue and
various small fixes in NILFS2 functionality.

Deepanshu Kartikey has fixed syzbot reported issue of a hung
task in nilfs_transaction_begin(). The root cause is that
user-supplied segment numbers are not validated before
nilfs_clean_segments() begins doing work; the range check on
each segnum is performed deep inside the call chain by
nilfs_sufile_updatev(), which emits a nilfs_warn() per invalid entry
while still holding the segctor lock and the sufile mi_sem.
Fix it by validating the contents of kbufs[4] in nilfs_clean_segments()
immediately after acquiring ns_segctor_sem via
nilfs_transaction_lock().

Hongling Zeng has fixed a smatch warning in nilfs_mkdir() warn.
The patch corrects a semantic issue related to the use of the ERR_PTR
macro that arose from a recent VFS change.

Shuangpeng Bai has fixed a backing_dev_info reference leak.
The setup_bdev_super() already initializes sb->s_bdev and takes a
reference on the block device backing_dev_info when assigning sb-
>s_bdi.
nilfs_fill_super() takes another reference to the same
backing_dev_info and stores it in sb->s_bdi again. The extra
reference is not paired with a matching bdi_put(), since
generic_shutdown_super() releases sb->s_bdi only once.
Drop the redundant bdi_get() in nilfs_fill_super(). The single
reference taken by setup_bdev_super() is enough and is released
during superblock shutdown.

The following changes since commit
254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/nilfs2.git
tags/nilfs2-v7.2-tag1

for you to fetch changes up to
e5925f33e4fa9ee313d481557607adce8e30ed2e:

  nilfs2: Fix return in nilfs_mkdir (2026-05-20 11:20:56 -0700)

----------------------------------------------------------------
nilfs2 updates for v7.2

- nilfs2: Fix return in nilfs_mkdir
- nilfs2: fix backing_dev_info reference leak
- nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment numbers

----------------------------------------------------------------
Deepanshu Kartikey (1):
      nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment
numbers

Hongling Zeng (1):
      nilfs2: Fix return in nilfs_mkdir

Shuangpeng Bai (1):
      nilfs2: fix backing_dev_info reference leak

 fs/nilfs2/namei.c   |  2 +-
 fs/nilfs2/segment.c | 22 ++++++++++++++++++++++
 fs/nilfs2/super.c   |  2 --
 3 files changed, 23 insertions(+), 3 deletions(-)
