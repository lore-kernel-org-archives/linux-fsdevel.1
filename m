Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704F38A71E
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788150791; cv=pass; b=ILOT/4/EMbkxwDc0H52K7DhfDO5sLyJUMddMucI4V1SfK87LsdAVolc0r2rAp2dMnPTHzHmBh8GkiUHjl79p1rTZ3rspXa3O8am4O6qTjFNYYKRO2TgUbirQmia+tyhzp8rhmra5owybTrYDLaN7sMttRCPrvDAk9Ztxv0g4gMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788150791; c=relaxed/simple;
	bh=OWYeD8HWhxln6GiCQV1UnjBgc7MJ92h/DJUq8qWLZ/E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MvGuQXV8bHSlbyBzDa+7l6rE990RwoLe3YoLAru0/mB3rHAbybma0deJ7TQPMpcx0cPzNSMuS+qDzDzinCOvV+8rFH7cM2oe03DDLzmUUfAwXYm9SX2uXe87Ky3orvKRU8RNL4g1Jy42ojbuxiQOOSvMzmajSMDQUc2rtMnKOR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1275YqM; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1275YqM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52f9e79ed93so29863851cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 21:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788150789; cv=none;
        d=google.com; s=arc-20260327;
        b=AcHYb378VhIqAzHJ6T1lGIsdAQhkN3t363tE7+wvYUHjBy1td+3ufLfARlvj67oiIK
         6IO9obXj8UQPFZNwNR2+egZ0YbKtmLOmZyjmLD/7n93Wr4pMcMAyGTXckRw1IwQrFqUg
         IO6ha9MvylCOewAOVoARhJhYYUs7v+58SgSKqrqC9zYKDl1qNMezbtJWlazVjuHVL85I
         Sf4ApICe1TuZnu7rf67CB0NOmrCGFyPUnqXI0supP+ZGPP/8LFQsdp0Z3A/8fEDxDF0t
         Bdclvqp+4VUBG95cdAGFf+e99l7TfrMleLbdD91Z8z45Xa/28Qo6lBz9wC0TdR1RLWsZ
         S6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OWYeD8HWhxln6GiCQV1UnjBgc7MJ92h/DJUq8qWLZ/E=;
        fh=ub95YhOpEDy1hhRq/42175ekLrEDqz+zG2jhVKVPx+o=;
        b=Q/2UkJk6VlkNp3pM1lfx4JcU0PNVB+tkS3zXwmzXaJqXWUwTkz2//n8/w6xn91VbKt
         8Nwg92q7YcaNm1QmvIjW1trK0erqZPrI6ISSIcSKLgLBzgdLJVfcTSX74hUSSiUhjAcH
         nMaiVd1bhqXTXLDqKV3R2CsakT4ohU7RfFio+Q/hWtevyZ5t74VK+wSOq+dYw7FFhfjw
         Y6KduvT7J9bVyA3JjSLd35YuLGyTMa/SYl6wGth10BLxP7J097mGksRV8GsEPQH1VVrJ
         +MUosfBsF2TpKwc74FvAqraXyVg/cnjZCjEweEKUg0zLRzpDOaFYf6mBjghLZab1dXBO
         CLrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788150789; x=1788755589; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWYeD8HWhxln6GiCQV1UnjBgc7MJ92h/DJUq8qWLZ/E=;
        b=P1275YqMm7w+31RNxDq9HMJSVd2sCBBdugVvvIR59DXpDHpsTRFVFxA4g8LPlboQeB
         JysjfEhmCPj0Mi8VB1THHlg1PPamUQqP11K7baoLMmVEBzrVAXZeBLAuJEPVXMzNIkbb
         FOWrN7GoZNZf50SRAsCxuOMdKnDwo4f/N89eQw4Qyjl0bxHdSr0HYkFz70qSdyUf1mgH
         8oHPWG18aLhaAGQuMd/He1hNWSWLlQrwU+77NmmH5GXof13WOmh69XzH0ZarGtpy1gEp
         trvjQRJnC1AAtMtZaNLUixhxA5MdZsBHG27bH2MXmpa930hX0GdNpl50WNsueahOGVFi
         vhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788150789; x=1788755589;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OWYeD8HWhxln6GiCQV1UnjBgc7MJ92h/DJUq8qWLZ/E=;
        b=lGHav84LZt19QDpoNWWJzSwEnxF5pC5lLPCgGBDlB0tLGoYd1YgO0cefztx9YehlMb
         tWQk3A5kYNWsjMzP0OnFIQj9jjQcfq9xNFiGt4UHiazRLJPvuIdqxfbwZp/uKTLGHsLI
         Wh4bAji2pnmJQy07pgwBSHHdhICXtIJV0eD7MGxDCxn189/VVl/B/Y8DUfWA4OnustJq
         kb6TrrIwkB1gADnielNBpvEZo/Gry7yU1qloEuhC/RLCk1z8lp1AU6c8fFVeBrQyrNfc
         GFE1DEQe7LOeIy2qnkmIFL1/5HknIupz2xMz4apZtsBMp0Lge+p6h2/fjAm/99aHLaZ8
         c5zA==
X-Forwarded-Encrypted: i=1; AHgh+RqYxvm5gW5UtGCiNDDPD+cvjcZxl+8gNgyjsk9+4ihcGNlkAeBhkSlhiH9JdjbC2gLmd1M6NY3i72aJL3+0@vger.kernel.org
X-Gm-Message-State: AFuF++m4j397M/7GY4XzBr2ysmY4AmRTx2MuZHj+44BX5rXfwq6uPDuG
	MeoOmO7Nw/6VYvuT9FyvqUQggxpruagu9SqxuX//kCfwWvt0O/TJgXSEYc8msurjsg9Tohma1Xq
	jVBJOnS9Pqm/gRKrDUw7/G7LIlUkmd/Y=
X-Gm-Gg: AR+sD127UPnTjL/SNZCCcuweueeiz9aWWvBl5OZCa280xQJFc7NCDZ92ENHbmvMD9nt
	GJ/MbKTLQtkZYVcdtJb9zhi6AUq0Q/dbAhSnO8mzJlMm3yxCBMxtAjMv6L5ydsPeRSOtK2uLOjg
	7XtLKv2Ao/djfnKbmmmn65aiRP8O5e+bADaAtrem4DdYonlQygQ8rDDRfGr7fafgzLOsAa0E+Xf
	9FP+2m8gDJl0Y+drQr71glqGdRMA/ouJd5VJGq4BbaGPSlMKMtM4PURyWQSRLHdmK+Bjqqn7u7j
	miHbhAQC+RQPqiTX365Tv1dq1RZXKjD35QSCBrdd2yUFB3IMH/LqauZVzJPqETHhGHFTF/sK24D
	fszCdFlPaTUHkdWIBYqj9FZ5vNfpParemKnZH90ZH69wjVUEM
X-Received: by 2002:ac8:5e51:0:b0:52d:ea18:a8f with SMTP id
 d75a77b69052e-52fb9624e53mr273957141cf.29.1788150789045; Sun, 30 Aug 2026
 21:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZW Tang <tangzw515@gmail.com>
Date: Mon, 31 Aug 2026 12:32:57 +0800
X-Gm-Features: AcwNN1ULFgkJPJxRmSd92mMdodsL9Jz9781aLnZmGa6ZIMx2OfnHHfzbs0ChRPc
Message-ID: <CAA2SOT5mWrS_KN38TRCu_KfTjpG6fyaytqZbOb25Pb0kfqZ3gQ@mail.gmail.com>
Subject: [BUG] fanotify: WARNING in fanotify_handle_event with crafted msdos
 image and long path
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a warning triggered by a syzkaller reproducer on
Linux 7.2.0-rc3. A similar issue appears to have been reported upstream
before, but I can still reproduce it on Linux 7.2.0-rc3 with HEAD commit
1137d8b5df06137fb49513cc923b3b24d94cb809.

The reproducer mounts a crafted msdos filesystem image, creates a very
long pathname, installs a fanotify mark, and then calls execve() on the
long path. During execve(), the file open path triggers fsnotify, which
then calls fanotify_handle_event(). While fanotify is constructing the
event, it hits a warning in fs/notify/fanotify/fanotify.h.

This looks like a fanotify name-event encoding robustness issue. A crafted
filesystem image together with a very long pathname appears to trigger an
unexpected name/fid event layout, and fanotify_info_copy_name() reaches a
WARN_ON_ONCE() path. The kernel should probably reject or truncate the
event cleanly instead of triggering a warning, because panic_on_warn turns
this into a kernel panic.

Reproducer:

syz reproducer: https://pastebin.com/raw/JqBwvgbH
console output: https://pastebin.com/raw/2jnY4jzL
kernel config: https://pastebin.com/raw/RgvQ5DPY

Kernel:

HEAD commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
git tree: torvalds/linux
kernel version: 7.2.0-rc3 #1 PREEMPT(full) (QEMU Ubuntu 24.10)

Relevant log:

loop0: detected capacity change from 0 to 128

------------[ cut here ]------------
WARNING: fs/notify/fanotify/fanotify.h:217 at
fanotify_handle_event+0x3e93/0x4800, CPU#1: syz.0.17/10761

CPU: 1 UID: 0 PID: 10761 Comm: syz.0.17 Not tainted 7.2.0-rc3 #1 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX, 1996)

RIP: 0010+0x3e93/0x4800

Call Trace:
<TASK>
fsnotify+0x1105/0x1be0
__fsnotify_parent+0x6b6/0xd40
vfs_open+0x2e6/0x3f0
path_openat+0x29a2/0x3e20
do_file_open+0x216/0x310
do_open_execat+0xe8/0x430
alloc_bprm+0x2b/0x900
do_execveat_common.isra.0+0x1a8/0x5d0
__x64_sys_execve+0x93/0xd0
do_syscall_64+0xc4/0x7a0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
</TASK>

Kernel panic - not syncing: kernel: panic_on_warn set ...
