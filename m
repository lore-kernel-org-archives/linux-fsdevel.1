Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16E382F1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153018; cv=pass; b=XSnazC/8yLjdjNEziZ4omk+RP5F8lKAPpVsmve0B4wn+otX+NCNmyyGYf8oPyh+K5dFF89uughjgQUdCKXbpQlcpXbCMhkNJTjXCAee9nI9EDX02SsxMiFC29CW2mFxdmZKpszhupqPcIlpJWptkQBfIp0TMBa/0XH4apncql8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153018; c=relaxed/simple;
	bh=pG9c7KG8qT2X44FMa5nydCOd9BrOCqG8FVeShJSbR/s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DuTwR9plb3PgmdoR4H97CAfkBdWadLRWnFechvZdUCdkx5Udj9DwZoq8u5huk/KXDv/VI+nMTfYqjujc54+2+a1DViSDES1VoeBQ/7ZsaPgLmy0/QQOEOSecV9QCEJoPMXTSFHyX7mfCDYjpzpTbr3q1t3YvGzrgrjeM1vMbxY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jarYHGrC; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jarYHGrC"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ac9ef74131so35455686d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 00:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776153014; cv=none;
        d=google.com; s=arc-20240605;
        b=JNXpKRSim/vb/6w4GiypmGugqp/9b2MK0xXd+Onc2u/4sGEn0w8gf/MVLoOJa5+kr8
         PSSscNSXR7sZu0+BqLSp44uhn1EJ40s7NvF3d5rMkeu3s7aT8uPfNnJbwTZ9m2gWlI4B
         oPiDC867X7IzLthl3+tyMO7y8L6tNt+oxTMAEkOiT8CCINdd3o89UJr4su5BrhzJqHHv
         ZXkM2cm8TLaGZk8gPyCz3EXyygoK5G++NAdI+t1J59q5Ne2QsonQNCdaDT7xMPOgVese
         hTtW8Hg0kV93l8xm8AUvXNr/ajuY5WF/hlcCcj8x3Xp7DMkYVAvLaMi4wcQKyOra1cw/
         5EUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GJwj50SpYsa8vIzaBHPSXC8N3IHFqZ2Z3+m6w1drTS4=;
        fh=6LM0eG6bLNpQ2etkEdjD6XlJQ0HLKr/29yAH7pDxw+g=;
        b=ZDEkSupgvAie21yPqG/YtuOl/4htLdWMTEZDO7Y6wZrZN3heFpxQpb5bJK27J5j+3B
         N1lHzIyWWtd8gIlKbteEayyNUa2TteI+Fl1wLqWCYRT4VIi4FU1RvT6CQ3esR7mfLL8H
         om6DVYlqXRxWdS2no+IrUjdCITSP1qTlZ0ihsGZ8CUS7EcrT70oLuAaN1r3Z0d3SUOjL
         VcmImoHwEhB8bKxmkRbVh4FHYC0vRfLIK1xvVLDvU/ceMUQUX/KU0/9sUA3oArI4ytUU
         GX71cumIzh0/PzAiPXeTd2E6qheEChICN6EWeI1ywjEzwOTMKZShrkatx5RLC1Bc/eug
         U6jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776153014; x=1776757814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GJwj50SpYsa8vIzaBHPSXC8N3IHFqZ2Z3+m6w1drTS4=;
        b=jarYHGrCdAjq/hkcmm0KqNyBiV50AYFi98qHzCwSgVv7JECIudySiTZPtYtb7Ovqmt
         hsf5sOWjSL7ZIGfBc1gxIZJIARsy9p01e4RovYFjolIfIGNoYGUqwuTrdep6J/u4wZ8O
         aDKCt02WYcr2L8PTqaXE3vy04BznRfm8D4tkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776153014; x=1776757814;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJwj50SpYsa8vIzaBHPSXC8N3IHFqZ2Z3+m6w1drTS4=;
        b=GOmoG/dFeqRFg7+ihadjXOyH4jlNs/zC8XFRR4YTI8uusYpjEhXB/X+Vlx/KXcqu4p
         LZ1zIZfogYGv1KI4dtE0lbtKXqrCoKI8gH+3sJKCVRMqWMPMvWlY7u4h1HOajPIDike/
         RARrQ6UgrH7N6/IXJ2cWVvLd8E3PvKteGydMam50K2dtyQmGgf5gmuetGjVqM7e6xrPf
         hhWnik9kSi8H9tgLN7OkQD1m8Iv6zaZb6z3UwLyEiEELKAEIUjZu/dg86ApjNPksYgEz
         OLkk1wIUlTbwT2nDq4+mtxqNUZSZmLO05FDZShqz3o2M0GXcLLsVTKah0p3wieraDXrB
         7EEg==
X-Gm-Message-State: AOJu0YwlEAuierD1jdhkd5yRSByrkvSEL/GF19ozYTIqwaXPUueTPI4M
	6kmhVzbxMXDfnQ2uTbvCQK4JHAH+8OJmRq5AM9TB3EF2FGGzdOjv111qz4vI8TDMvJ0K5s7NAk+
	ZAiLH1TAChIchs68JWp6eCHEVyhp7pSR8uBLmV4GMB/UZxBRPgy8Mx74=
X-Gm-Gg: AeBDieuI0e0Jr9+XLVYDcoL2r5LAr4QIVeoJSUn3YOfmRkujldYjFoAh3UIsvt4/izw
	1Er6ox3o9WCzImwJhDvYVT6pxXM2HAXKiBo3U2/SzfINPmrWEQIQrLoHD6aQJP104VT8JGbx6jQ
	jzMHS6jwjGQs2I+AA6LChalsQtViVPszssjjNQPHAyJSZ4ZbST5Xu76hCC8BWvxAUcKmDY9ywV2
	XuK6SV9rq1xl4PaFpk/v2wQuTTGGAYpnhtmiyE7OPpdZgtpoutjwMUbghPqcSnPLcLdZchSREke
	duHVrWuZH6Xjef3v6JRs5Ibh86P9ihDWDQfy
X-Received: by 2002:a05:6214:43c8:b0:89c:de0e:263b with SMTP id
 6a1803df08f44-8ac862bbcbcmr245100976d6.42.1776153013935; Tue, 14 Apr 2026
 00:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Apr 2026 09:50:03 +0200
X-Gm-Features: AQROBzBxfI-lp1KKyyUeZ1x4jxeIIoJfZWlGo7PssyNQkHaVdxiI1tg9Ck9S5Hg
Message-ID: <CAJfpegt4sD_u1Qv+NQcQdJa=b+Je7Z973J=Ztcad8YgmEQU8Gw@mail.gmail.com>
Subject: [GIT PULL] fuse update for 7.1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-7.1

- Fix possible hang in virtiofs when cleaning up a DAX inode (Sergio Lopez)

- Fix a warning when using large folio as the source of SPLICE_F_MOVE
on the fuse device (Bernd)

- Fix uninitialized value found by KMSAN (Luis Henriques)

- Fix synchronous INIT hang (Miklos)

- Fix race between inode initialization and FUSE_NOTIFY_INVAL_INODE (Horst)

- Allow fd to be closed after passing fuse device fd to fsconfig(...,
"fd", ...) (Miklos)

- Support FSCONFIG_SET_FD for "fd" option (Miklos)

- Misc fixes and cleanups

Thanks,
Miklos

---
Bernd Schubert (1):
      fuse: Check for large folio with SPLICE_F_MOVE

Darrick J. Wong (1):
      fuse: quiet down complaints in fuse_conn_limit_write

Horst Birthelmer (1):
      fuse: fix inode initialization race

Jingbo Xu (1):
      fuse: fix premature writetrhough request for large folio

Joanne Koong (4):
      fuse: validate outarg offset and size in notify store/retrieve
      fuse: simplify logic in fuse_notify_store() and fuse_retrieve()
      fuse: use DIV_ROUND_UP() for page count calculations
      fuse: use offset_in_page() for page offset calculations

Luis Henriques (2):
      fuse: drop unnecessary argument from fuse_lookup_init()
      fuse: fix uninit-value in fuse_dentry_revalidate()

Miklos Szeredi (8):
      fuse: abort on fatal signal during sync init
      fuse: fuse_dev_ioctl_clone() should wait for device file to be initialized
      fuse: check connection state on notification
      fuse: create fuse_dev on /dev/fuse open instead of mount
      fuse: add refcount to fuse_dev
      fuse: don't require /dev/fuse fd to be kept open during mount
      fuse: clean up device cloning
      fuse: support FSCONFIG_SET_FD for "fd" option

Sergio Lopez (1):
      fuse: mark DAX inode releases as blocking

Yuto Ohnuki (2):
      virtiofs: add FUSE protocol validation
      fuse: refactor duplicate queue teardown operation

---
 fs/fuse/control.c    |   4 +-
 fs/fuse/cuse.c       |   2 +-
 fs/fuse/dev.c        | 156 +++++++++++++++++++++++++--------------------------
 fs/fuse/dev_uring.c  |  36 ++++++------
 fs/fuse/dir.c        |  14 +++--
 fs/fuse/file.c       |  18 +++---
 fs/fuse/fuse_dev_i.h |  34 ++++++++---
 fs/fuse/fuse_i.h     |  19 +++----
 fs/fuse/inode.c      | 136 ++++++++++++++++++++++++++------------------
 fs/fuse/readdir.c    |   8 +--
 fs/fuse/virtio_fs.c  |  33 ++++++++---
 11 files changed, 263 insertions(+), 197 deletions(-)
