Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC75374A1B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040836; cv=pass; b=NIZGVbNcQgRrwRcrb+AyU1VBWl45Ic4J3mkN1ibb20gOWoM8086bBt9FS75ccKi9V8nwzFp87oRlah+oqdXR6zTo9wQYnckl9ph23TCjESSSp6RP6sweOe2/JjcF0UqtENdlfw1UBEvWe5La5KgvESBBB/Md2Zj4YeNq7RR6THE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040836; c=relaxed/simple;
	bh=c7dQwd4y3GCsDvsFvzS2n61Fdc4YHfC7+b2AUIEs54o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n30seRvnjlAERQAEBBrfqda9uZIuMm1tXGUUeNJygysd5UKYAAL/qYyTls9QYci8WRPzXgutyAoe/JoMhFPdkyu2NcTRzqkzLEwugtObX9V64cnpPlu6ojGP0kwpvwUcvNxV+imnpmg259Fe5W4ruouleKGjBuOk5GXuCOLG1xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9OcbP37; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9OcbP37"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176a2fd597so50569191cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 14:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781040832; cv=none;
        d=google.com; s=arc-20240605;
        b=DSrhFSNB0HZpimtDNSfp8Hv3ofzVbnaceYuMS8bNfEdtz8kDqjQuiA4aStYFisX/44
         shhpqVNZo7f/LiHDvIZXEwO0T12GjfSVM6HR8edUV7QmWr18SPwMyNorIdIbAlXqgoFL
         CoUDN2tlKRDoN+5/F0bGH5wXoDGxBHfZmJhZrVFE+G9vanxR80HiXDP63o1giIJLZfPP
         iN5T0zV8nz47dYtXvQJyR09Dpvz2sxSfwftYOMaTD8+lU+vjyr+7RiT5hOhje3wCCEyY
         g1zoPSTKb/QHL3q/sqK+mgTWuj5pZdeQqB+V4NXiA2WlrI2P6EJLAWGs3EoqA9prXqeS
         ixzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tuLebF0wu6hNYzOoTZx/7fTAqQfCLBLEAcMfKvS+9QM=;
        fh=NvW0M1HP+F1Of6rGMiZYFxuaSNs03uAbuzZpJQMJmV0=;
        b=TWwROOla6luC4s+Heyo4lVPweyRscdlA0w02/pABEs4j13ie1rjuzv8JzGVA9db+ex
         4ymZG1gXhY+UqIDXXOZisyNj626xtxL3rK+Ti0U3kaFfEU/4ZItlRFZ2Wmek/sk0MGxk
         xtiBuaJOFqkCZZMzpouZLgbI9dVSg1Jba2PNFRSlqjT9Ck+XumIe+mzNyb2Lg+aDtT02
         kKQWbTrLkWUVbVDcxA+A6Uh0+HG0rZOV4iHwOlKPDOciDoUk4+UhQMObAdHNrdTBddfM
         XK8hBs9xS1U3BimXSUywzsRjfucsbBBPyElfqN94pey0D49wDfHpLX+jEtsX0WpCA2rZ
         9/pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781040832; x=1781645632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tuLebF0wu6hNYzOoTZx/7fTAqQfCLBLEAcMfKvS+9QM=;
        b=k9OcbP37LyoPqWppFeDiB1oQ6rc+ui1oV+ZHhnR5FMAt+h9Aktvjn3Ix+mR/fshSj0
         IhvbVTGd69XdngpN/sZ9i0BhEn4iXQf6kxOIa/V2ombsgZ9HZWxVpJ+JYc8TgiZevehE
         Uu+HxyCKA4Z+NaN1PMStPrrj3aLE5JbQT7Je8llw0Alxhw0fIhJLS808nZv8nq0rAaXV
         ZWrpvwuHfuIf9HDZgay3jS7eXi26IzESNjZJxcyjomxmkANSyVPCxZJB6pAZSGTmFfvn
         4Z7qrHybFIu96CyKs5Wio1Vwan16RZnXlfWHIUr/84ihV7TzpIhGd6UQetl+6ExcL1oJ
         6hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040832; x=1781645632;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuLebF0wu6hNYzOoTZx/7fTAqQfCLBLEAcMfKvS+9QM=;
        b=coOfVedNntYZjCRL5DYZHe6L52dDYosa8VrAFoH4NrAZ3iUGKO6VfpGZLOnCyVBxau
         WiTBUiLZX4ItW26f/Wd2LnpufeuhDmamaQagZ+fPskaXYvnQMUIzBP9ZTV4/iJPUxhXr
         TXoPNs8MUo5h1WddP9h/1umtjv3zCrBZm0Ymznep4TJQOad7De8AAhlgVIiQr6uT2dSh
         FaO4d+Bf6u84zGQQ9zid3heOlFMMcefEAHrMnUd3GVP2a04dNLjMEJLYywRMzZBJd5E7
         2t/ti5eDR4VhYDPvvJsfuDQnciCYE8UGmo9b+oTHKcFAzYTFNVTC3I5lXfsUkotCxUkf
         uelA==
X-Gm-Message-State: AOJu0Yzk5knD/TN/cq4+3ztBxZieAggEB/HOSNqNcVdlf0spR7fV2k7F
	Q2oUwu88oVSL93bgRWUqV72QnvPb05AL4M4z94ebpMmjYlLS5FqOntOrtPShBfVc+W6S3WtwqDo
	UQdKgZMBNK2uLG8CT67XrjUo1R0C8+95bT1pSIBs=
X-Gm-Gg: Acq92OFm6X5du0vNhgacb9gxtFYVcRth07uUOEdzTDlSGlsw5Guai5M7RjjVjuDVXQy
	NF5aBX2Zmlztnf3oisyRUbCXscWYYjp4u6tXTdnOSrc+zj+H2tscYA94AlTfuDMNLjVJi5r6MJ0
	6yrxDiXmrS+YtpK/dy+hr84MpNl3LPULsDvmExyBQnMh8MTmBUkg8u50OICQHGzZUUteXDhaNmX
	OeP2QAkbJYh7qJHf2J0RseJC3zhV8Vn7lzo2RMGe4iB1nRP1A13pFIxmdNbZ77ORZ/JFxsyGqHc
	Kh+3bPTuTxgf8xzu
X-Received: by 2002:ac8:610f:0:b0:517:8d76:5975 with SMTP id
 d75a77b69052e-51795afe67amr310876511cf.31.1781040832296; Tue, 09 Jun 2026
 14:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6rmA66+87ISc?= <neck3922@gmail.com>
Date: Wed, 10 Jun 2026 06:33:37 +0900
X-Gm-Features: AVVi8CcHJtlHTZU3pZy325I9AvY0rv0VjYDmGwhm0hrtGhrHZNnzi5yoe4c-z8o
Message-ID: <CAFmvuTWx0NUnC-q6T=SAWLJTEp-fvueRqgPQCFtULmGngUs+AQ@mail.gmail.com>
Subject: [BUG] fuse: KASAN null-ptr-deref in fuse_readpages_end after aborted
 splice read reply
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a FUSE read-reply bug reproduced on upstream v7.1-rc7
with KASAN enabled. The bug was found with a local syzkaller setup and
was also reproduced with a standalone C reproducer.

Target files:
  fs/fuse/file.c
  fs/fuse/dev.c
Subsystem: FUSE
Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
Git head: 4549871118cf616eecdd2d939f78e3b9e1dddc48
Kernel release: v7.1-rc7

Observed crash:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: fuse_readpages_end+0xe5/0x650

The same reproducer may also sometimes surface later as:

  RIP: iomap_finish_folio_read+0x163/0x230

  Call Trace:
    fuse_readpages_end
    fuse_request_end
    fuse_dev_do_write
    fuse_dev_splice_write
    do_splice
    __do_splice
    __x64_sys_splice
    do_syscall_64

Root cause analysis:

The crash appears to involve the FUSE splice read reply path replacing a
page cache folio while or shortly after the corresponding FUSE request is
aborted.

In fs/fuse/dev.c, fuse_try_move_folio() does:

  replace_page_cache_folio(oldfolio, newfolio);
  ...
  if (test_bit(FR_ABORTED, &cs->req->flags))
      err = -ENOENT;
  else
      *foliop = newfolio;

My current understanding is that replace_page_cache_folio() can detach
the old folio from its mapping. If FR_ABORTED is observed after that
replacement but before *foliop is updated, the completion path can still
keep the old folio in ap->folios[]. Then fs/fuse/file.c later does:

  mapping = ap->folios[0]->mapping;
  inode = mapping->host;

and faults because mapping is NULL.

Reproducer:

C reproducer:
  https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-readpages-end-v7.1-rc7/repro_fuse_readpages_end_rc7_userns.c

Symbolized KASAN report:
  https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-readpages-end-v7.1-rc7/clean_c_userns_report_rc7_fuse_readpages_end.txt

Kernel config:
  https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-readpages-end-v7.1-rc7/kernel-config-v7.1-rc7.config

Key config options:

  CONFIG_FUSE_FS=y
  CONFIG_KASAN=y
  CONFIG_KASAN_GENERIC=y
  CONFIG_KASAN_VMALLOC=y
  CONFIG_KASAN_EXTRA_INFO=y
  CONFIG_USER_NS=y

Runtime conditions:

  fuse.enable_uring=0
  unprivileged user namespaces enabled
  /dev/fuse accessible to the reproducer

I verified the C reproducer by starting it from uid 1000; it then creates a
user namespace before mounting FUSE.

Brief KASAN excerpt:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000000
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  CPU: 1 UID: 1000 PID: 399 Comm: repro_fuse_read Not tainted 7.1.0-rc7
  RIP: 0010:fuse_readpages_end+0xe5/0x650

  Call Trace:
    fuse_request_end
    fuse_dev_do_write
    fuse_dev_splice_write
    do_splice
    __do_splice
    __x64_sys_splice
    do_syscall_64

If you fix this issue, please add the following tag to the commit:

  Reported-by: Minseo Kim <neck3922@gmail.com>

If you need anything else, please let me know.

Best regards,
Minseo Kim
