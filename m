Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794653191;
	b=JeDoi49ovKFJruEB8Nmb2HAFMJkDLFXAkMNZCITP7aTPsaTNKzfz9rl1IPkZPiiB1YrR
	 6JbDxDaKTRfTmcfOcPqwwrj3BBZPb3QivOHYccKwUvIprSAqlcU5nif51lLgZCTe4mf6k
	 qzeEQpTFHIwUjUKuh/hcXWtFe2hWCFBdiZiaQKsfY7SUpLu9e/2FWGmCaYOxMtFPwIVS9
	 qa07XhxOdYXwWgu2cYQRab2HIRO6j/BYugvILONuWg6n1pQZ8d2cBhDRbqHvdhu+pWb2H
	 VuUft64U/EOAKSB1JLx4sJgJAEHsae5AZAhSHYR8vTIJ1ef2BiE4U7ej9uHMNQ4DhXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794653191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xUPXt6+031qiozoXWsb66axAJcXyAWzq4gSy4ytIzBk=;
	b=ZlELFAEw733RELsjQ8GEiMxJkYV2Dv7FiVm6JDPyTlFEfXLbrChKBzYj7hB/GLFWTkFe
	 woSfUENanXgFRRgrEtZh6LXiX9lNrAsOB7zIf3la1xFgnjGYs0Da1CWhMl8zgKZnweU8P
	 tCHWWul1cD+YsPJdCikCL5i3YxcZP2MdMy0AfHtb+ehbF5rMreGoA4FhWUgTKuhJxRz4s
	 IT/MBzjci2dEeaVxR04cv1bCEBKEjC02ALahQE9oWi7Ifm64EjGuj86RWp9v5WAXdQH0F
	 zGyTxjk4le8CC/LwHNxMUyzdRKpBL6TUBvwWWAr3wTCla1k2Qr3SIIEC5n/6ywKOTvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DCmxw6fh;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AAF606A323
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 10:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68AAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DCmxw6fh
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so25798335e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794653189; x=1795257989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xUPXt6+031qiozoXWsb66axAJcXyAWzq4gSy4ytIzBk=;
        b=DCmxw6fh9MXaDQMP7rB9DPUCr1tNfLMBcAY2ON8nDWb0GmAzf5/YNhfQXDdTzv5iqf
         n6dHS/sq5azJ8p40Wxt25yCIeYf0UsQbV3crKd7nvpJvblB6h/SVl6g6Pns83tzI3Cb0
         t0XOQpSed7uWjbv2S2zn/d2IRqMgoOp+LKdISIwRX3s9nSzBpniQZQBuMtC3t0YjbI0F
         smcfgQ8X6Vn/VPMhY0aRnGmz4iHL34j7V/PJ3FGTaBmwUl/osB09t6RgHzLEtZEbSS3L
         BqahWLHHuQzuavBorzuMmq12B9juiTEdARy1dCDXs9GHSy+k/7xLOsSoH9N4yFG/0hVU
         IopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794653189; x=1795257989;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xUPXt6+031qiozoXWsb66axAJcXyAWzq4gSy4ytIzBk=;
        b=dK5eChz/Cjuu/YyWgWiaNvr86p6J7dr0/Y7e3AjGDK/IRYmu3nSUIvYHwscB1/ei64
         61av2UfOgZ427nVk2AKkvfutvELbM1479kPUMBG067y8D9dVei117OK35/S2JWMoo+bQ
         cVO39hBKhyOXyyHs3clBNP5xXiNtMB0XfNVDNqzFAX5PnnB3Vy6/oR5IQIRDiQlbwXID
         LKS/Q3Dgzo30eFEzN+pI1LJEEcHpGnAqG55naEiPumwahnD7xxmd71mEDJLOONwKN41F
         l6jD6nZJ87iAX4h+sxBI63CsL4t2KG1d2fgDd6IyXhlIJXS8gRqET9n7jeQbpkgSohv/
         2UxQ==
X-Forwarded-Encrypted: i=1; AL+hErE8a21CP0BCl0rCgx95toB01sBrFoOEoWlndVy/ghwV7AOIgMZlWAtRNoytWT81wnfbDDBs/aNh0tGK3oLB@vger.kernel.org
X-Gm-Message-State: APuU4Z9eRYuiCXj6B/kTdJh8HuhmV3tD1WCvxtWOdOWiaWmZi3jaR8+S
	owiOQ1s3WgNvcEMRF4dntGLyWFuFIJ90doxz7a71UEOBmOqX/j1Vi7cg
X-Gm-Gg: AYBFou18T5FTepbTrIZZQ2otcH3nPYazpqNQdmrPgX2gN76CJW342455cRfYciMgVH6
	d9CHRYbc5zrzcVxiRcuOlHzSPMaIfxV1jJF5N2KTOHaEXWXlbp1t+3zw2RR8SaxjoSf9kbfcg1O
	mzlWwgmh8nkIqPdXK+2M6guYFwoAoZUthZFU6x8200/iv/GeE+xfQmVv3Qqxt1MWp1fnvhviHm5
	fGc2/soOfzCHPppUq3GWAslyhQ8Nx/hgxO/AUNM9RfDGNDxjhUGlPEgLSlxCXFzBlUMHOGO4q0I
	LrPkdoCcCrA66+/UXwPfNag7kT/4kfKGhgo+Aahkdc+rSNGVHqltibSOX9RhvNJongOHrEspILF
	4uZxD9x8I+aCRHXJ6oIhY/aiho3Db3r+PXDagwo3YNYP1lVPkPXB6p4NR2uGZ13O63b9XBs+dG0
	KLiZi07nmCy9IzZAIymLSLQXdZJp4M2k4YayzsgGZh4S5u1PSLhAd+zLKzxLcuSQ8GVqT4vBgQk
	x2fHrxCCkP1QeqiB7ZOkL3bqwzDRkP/1PR6mEqrtOYaWrVhoYSFaJ0WfaBKo0IK28wURVm4yNr4
	DUAI5H1Rkbc9i1Je+H+er/zXeL0M+Fj/vWmBfL5fCkuo2B3P8Gn4kRwTPhFMGnKCwpf2bvoEpNv
	eBvEXvV250xYiqxyC5R8F457hoeIY9d5i68MKkugvmHjraA==
X-Received: by 2002:a05:600c:6309:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4bb559f3bb9mr104453325e9.3.1794653188808;
        Sat, 14 Nov 2026 02:46:28 -0800 (PST)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb609cc1b2sm45447055e9.11.2026.11.14.02.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:46:28 -0800 (PST)
From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven29@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
Subject: [RFC PATCH v3 0/2] io_uring: add IORING_OP_UTIMENSAT
Date: Sat, 14 Nov 2026 11:46:19 +0100
Message-ID: <20261114104621.1186744-1-meven29@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Méven Car <meven@kde.org>

A file manager or cp -p that copies many files sets the times of every
copy after its last write. KDE's KIO does not use io_uring yet, but
could in the future. In a KIO prototype that copies batches of small
files through io_uring, open, create, read and write run in the ring,
but the metadata of each copy is set outside the ring, with futimens()
and, when needed, fchmod() and fchown(). On NFS and SMB each of these
calls is a round trip to the server.

In that prototype, setting the metadata from a pool of 16 threads
instead of one file at a time cut the copy of 200 files of 4 KiB by 22%
on NFS and 45% on SMB. The test copied from ext4 to an NFS 4.2 and an
SMB mount of the same machine, over loopback with a netem delay of 2 ms
each way. An opcode would give the same parallelism from the ring, and
would let a copy be one linked chain per file: WRITE, UTIMENSAT, CLOSE.

Patch 1 splits filename_utimensat() out of do_utimes_path(), so that
io_uring can pass a name imported at submission time, as it does for
mkdirat and the other path ops.

Patch 2 adds IORING_OP_UTIMENSAT with the semantics of utimensat(2).
Like the other path ops it runs from io-wq.

IORING_OP_FCHMOD was proposed in 2024 [1] and not merged. The same
questions apply to fchmod and fchown, which a copy also needs, and a
single setattr opcode could set the mode, owner and times in one
->setattr() call. I started with the times because a copy always sets
them.

Testing: a userspace test of 30 cases (paths, AT_EMPTY_PATH on O_PATH
fds, NULL path, UTIME_OMIT, permission and read-only errors, links, copy
at submission, punt to io-wq on tmpfs and ramfs) passes in a qemu guest
on for-7.4/io_uring. A liburing helper, test and man page will follow
if the interface is acceptable.

[1] https://lore.kernel.org/io-uring/e291085644e14b3eb4d1c3995098bf4e@huawei.com/

Changes in v3:
- Drop patch 3, the inline attempt with FS_SETATTR_TIMES_NOWAIT and
  mnt_want_write_trylock(). It added generic VFS API for one filesystem,
  still ran the blocking parts of notify_change(), and looked the path
  up twice on every other filesystem. (Christian Brauner)
- Patch 1: add Jan Kara's Reviewed-by.

Changes in v2:
- A NULL path now sets the times through the fd itself, like
  do_utimes_fd(), instead of a lookup of an empty name. As with
  utimensat(2), it takes no flags (-EINVAL), an O_PATH fd gives -EBADF,
  and an open file that was unlinked needs no revalidation. (Sashiko)
- Patch 2 message: drop the wrong claim that AT_EMPTY_PATH on an O_PATH
  fd differs from the syscall.

v2: https://lore.kernel.org/io-uring/20261104110604.126717-1-meven29@gmail.com/
v1: https://lore.kernel.org/io-uring/20261030123945.1704118-1-meven@kde.org/

Méven Car (2):
  fs: add filename_utimensat()
  io_uring: add support for utimensat

 fs/internal.h                 |  2 +
 fs/utimes.c                   | 12 +++--
 include/uapi/linux/io_uring.h |  2 +
 io_uring/fs.c                 | 97 +++++++++++++++++++++++++++++++++++
 io_uring/fs.h                 |  4 ++
 io_uring/opdef.c              |  8 +++
 6 files changed, 122 insertions(+), 3 deletions(-)


base-commit: ecb6817b769fd7d71af2c9f446188649020b2e53
-- 
2.56.1

