Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790382;
	b=3p09AxIuC1KLZOeL8FY9KuZeA2BpkclearMSWzntZr9KGqeTXV/mgX6VMuTlERP61n0Y
	 eCGV6IsEbrS/zYF1zkv2gOXwn3OUW3OG4sClvIDnDtj+VbXa/+9ttmmKKxa/JtO26xCoE
	 M3ekYCZmw6gx9ZIfU9oRDg1eYZasP0Y87DPQv11Ot/z85J45RcRt0+rwuE8U+2sr+VEBM
	 b7i+G821ZpPFxqN1jOo3wAA4iX1PLhuj1yHjsk/Qv9ngblJPiXR1bmwPcBUShfMjmo0B3
	 fS0GYf+Gq9xFrBsICq5wdMLLD9Xn3cvRO+Mmes7WPVPMb8/ROKy/xIoyJPfLsB8C9Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8O/Rp6nZ3ve9lS3n1SP2Ck1e4kzh3avxuWTAnkwjO20=;
	b=juOhYsNOatFSNC0Ilnb9jmCHN3fKkI+/PRHJA1cMsL6ApqZnTGJJ+O2OKfNWDkWLCN2T
	 hmqiKP8EbK+NJR0dClZvk6cFtwyZQmJmHcZnlJWQPxD2M3wqf+BsFPrDsXya1BzNtH0Z3
	 hrzXyZOjCg54z9iYjIg6ZhBmXMNcXEP8++XHHfEF4Ms4CWIpmjykFPwmQkA6H7yuqKLaA
	 ObEfXu3IDDRIHZ9tSZImEoxTEQT2+7pdzvSOBDOz5m9pcT7XTRfeIakj7FPBRMfAighsr
	 j8YdvzrsUkTvDVqVFaYDrGxau9EXgqE+vgbNkGuh8YkOgktYGBbCP0IQwi1JxzUpN8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbI5RPYr;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6B606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 11:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8F6B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbI5RPYr
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so3665155e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 03:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793790380; x=1794395180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8O/Rp6nZ3ve9lS3n1SP2Ck1e4kzh3avxuWTAnkwjO20=;
        b=HbI5RPYr3Kbf90K5fXNLch2gUb1ZACwF0DopzeNBvr22vJ87RY3KJeL3+v29YDTif/
         8/SeIX0e6qx22sByKeBWaB1CWteitCzg6enalhKr8gRd8q5Pqeu1ipKGCImvaEuqHPVz
         gkGJaJFEt23ldDtnBnkIp4RDBmICL52SVgBUo16NSrICBSLKmnbgrIVU8ne823/SefQL
         4a6cMCbpN/COj1EkiWEdIpVpqmUrH9VJ07WZZAXXMLMFa8aNVoyKPGnKAVaokFhXB4Xd
         q73U+pDHznGSDg/619CVFSM+MDphgpTxlc7Ccwdt53FJUbNDH6hd/lEwLoTtwKXA80bu
         33eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793790380; x=1794395180;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8O/Rp6nZ3ve9lS3n1SP2Ck1e4kzh3avxuWTAnkwjO20=;
        b=2PXLo0Oo5fsviBLZAjvYrPQeGps5xcwH5vynV0iAJs/wd845Z1EhmNKX9hP3bFfA2w
         V3JUuZrFc419seC0zVcAJylBGTdKDknce+TNCyhQy4JizUr3XkkN5lHrZfyqsoOrl3lU
         Qfkh4QW6465w2rDR+XIIWP4GuzAgYu+6aeJ82LcLGYvjkEj1AsfXbOVitfj7NDQaIymg
         zHSDnGLL+nb/SvAdNEFpD5ymC2Gz/VdD6YbT9pR/H90JuI0XA4j+rnJgJP8DdKFdNVGH
         dAPSuxZveN37khCuyF7ibafGOplL5quhDoKmNGoQ49urNSg2nzzFEmU5L7xvzaIOkmmr
         LK5A==
X-Forwarded-Encrypted: i=1; AKwUvBxHl1dIWSuVZBjeKH5kBxfQU9iJw7SYFy2pNxYd2gYoTexNZEB9fjRqh2p3ALHXbTlG6XNCP6AZJi4dcYR/@vger.kernel.org
X-Gm-Message-State: APuU4Z/lOu8jT7gisgCMk2MIpX9N/r/k7tM3YasUbmb3KOzozlTyH8ug
	jcaJce7W8OgVpw7w3+DWV13iT6gkzVZzzZkJxwQj4HWSQ63fgT2r32uI
X-Gm-Gg: AYBFou11a5MJeDOQ3r38grV9E2iuqES7N8mKf7D0a6NvAgfBAp7XB+Qro7NFrzQZ5m+
	kCxc6Y+j4lzs1zhp8kLrH7/blfFn/08jgWrZaEX/3YCoXsnx6PJ8N1/Uo5+g6dP5qaSWIL4wvyU
	TuciWDgiATreCoDzbpmQOy2XXttAb5Smdd2HaKeht6eOtzMBsOdVUxX2tMvRaxiITxautcUTkmT
	bg/Ggk/wpcQq0PRkljLvVNYdSuJFHzYj0IRop0w9Wk2LqHl8Fzf2udv70SkNHdcWJ921YneMX3E
	u6pY1x0T4U9rvuNLqSePCHiDgIF4wziCj81KjlViH5yD0a8uQ6HmBo2DIRqwhOblKsvcDGeS8KO
	3EQx6KtvkEcwegTJTBMPYfE+9dsLgk4CRrzu8G7+vRPoGmfnibG4A/rRHvOYpt8lkeo7VPGyxiQ
	Oe5teqx0BNaMC4s5C1Pz8tcKU/N8xHjkKSlTp7w+oxofr5WCkQAqw0Kjdm9eSPGjHcPKJiFdWBK
	KNdNR/CpsU4C5IaB1Zr6eKPi+ZUQioXec/AdzQrXughB+ZZy9qXVJ8QnS7JGdaVYaqA7+C+4aTz
	O3MtPsatZEVkWmnX0BLH7NeaNsmh8Gm3aRgI5YO1XDqUBSD7xenDGA6MueZSs9tcDlSf/aKj+Us
	fHuEQ20dqJ6NZRG2KFpOjC/Ai
X-Received: by 2002:a05:600c:6387:b0:4a2:150f:1605 with SMTP id 5b1f17b1804b1-4ac1904a81amr368417625e9.24.1793790380090;
        Wed, 04 Nov 2026 03:06:20 -0800 (PST)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed92a753sm3704835f8f.45.2026.11.04.03.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:06:19 -0800 (PST)
From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven29@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
Subject: [RFC PATCH v2 0/3] io_uring: add IORING_OP_UTIMENSAT
Date: Wed,  4 Nov 2026 12:06:01 +0100
Message-ID: <20261104110604.126717-1-meven29@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Patch 3 is the RFC part. On a local filesystem the handoff to io-wq
costs more than the setattr: in a qemu guest on v7.2.3, setting the
times of 2000 files on tmpfs took 6-8 ms with utimensat(2) and 19-29 ms
through the ring with patch 2 alone, 32 requests per submit. The patch
tries the request inline with LOOKUP_CACHED and trylocks, on filesystems
that declare FS_SETATTR_TIMES_NOWAIT, which only tmpfs sets. The ring
then matches the syscall (6.4-6.8 ms). ext4, xfs and btrfs cannot set
the flag, because their ->setattr() starts a journal transaction. Is a
per-filesystem flag acceptable here, or would you rather keep patch 2
alone?

IORING_OP_FCHMOD was proposed in 2024 [1] and not merged. The same
questions apply to fchmod and fchown, which a copy also needs, and a
single setattr opcode could set the mode, owner and times in one
->setattr() call. I started with the times because a copy always sets
them.

Testing: a userspace test of 30 cases (paths, AT_EMPTY_PATH on O_PATH
fds, NULL path, UTIME_OMIT, permission and read-only errors, links, copy
at submission, inline on tmpfs and punt on ramfs) passes in a qemu
guest on for-7.4/io_uring. v1 also passed on v7.2.3. A liburing helper,
test and man page will follow if the interface is acceptable.

[1] https://lore.kernel.org/io-uring/e291085644e14b3eb4d1c3995098bf4e@huawei.com/

Changes in v2:
- A NULL path now sets the times through the fd itself, like
  do_utimes_fd(), instead of a lookup of an empty name. As with
  utimensat(2), it takes no flags (-EINVAL), an O_PATH fd gives -EBADF,
  and an open file that was unlinked needs no revalidation. (Sashiko)
- Patch 3: the nowait attempt passes no delegated_inode to
  notify_change(), so a delegation gives -EWOULDBLOCK. v1 read di_inode,
  which does not build with CONFIG_FILE_LOCKING=n. (Sashiko)
- Patch 2 message: drop the wrong claim that AT_EMPTY_PATH on an O_PATH
  fd differs from the syscall.
- Not changed: the inline lookup can still call ->d_weak_revalidate()
  and audit_inode() before __vfs_utimes() returns -EAGAIN for a
  filesystem without FS_SETATTR_TIMES_NOWAIT. IORING_OP_OPENAT does the
  same lookup inline, but rarely fails after it, while here every
  request on ext4, xfs or btrfs looks the path up twice. (Sashiko)

v1: https://lore.kernel.org/io-uring/20261030123945.1704118-1-meven@kde.org/

Méven Car (3):
  fs: add filename_utimensat()
  io_uring: add support for utimensat
  io_uring: set times inline when the filesystem cannot sleep

 fs/internal.h                 |   5 ++
 fs/namespace.c                |  20 +++++++
 fs/utimes.c                   |  53 +++++++++++++----
 include/linux/fs.h            |   1 +
 include/uapi/linux/io_uring.h |   2 +
 io_uring/fs.c                 | 103 ++++++++++++++++++++++++++++++++++
 io_uring/fs.h                 |   4 ++
 io_uring/opdef.c              |   8 +++
 mm/shmem.c                    |   3 +-
 9 files changed, 187 insertions(+), 12 deletions(-)


base-commit: ecb6817b769fd7d71af2c9f446188649020b2e53
-- 
2.56.0

