Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363995;
	b=hYBgI03PWdquxyP+RXt4rAGTpZpDIFryaVTJ1knouVXYhUB2ymC0g5S/NxTtuGbxx3gu
	 KMPX78QW9iUJzqmdH/kdcxw0p+N2n2j3WyGGdJue9Xr49kJNBeGZsZ03Fo1J20XSIQ5Om
	 DznLw0C9bkf4Fh2JmZfY0QzL9DTJX/xjySv6EkZn8ivoQj6GsBIbmdSANxtwNXbSUjXGA
	 PAWpR7s42rb7F3LP3RPEalpIwWWTuPu1LTgwQGaahAuCrQCcmCmVjUjMRGmGijoFnE/uL
	 PDypzPhCIhk2PYjJxqk45AM9bfbm73/RJWSJqjSCrzVOSrXkndNQkisL7NRIMz3T1Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RUJ2gwwAbHEm4tvJt9u+cB77ZI1OokWfWjFrziXQD/Q=;
	b=HMkTgPBJTPnW8OuRN2DhUxwhreCmkvzVEoJShonBbuCU/PkSCQ0ce2R9S2xaTtMxyeoZ
	 /MREf17ojTTTukyQb+lXElg+Xx91gRnn6wuAk8MGCx2gBZNsx2+g8T+o4MsqSCISxCXk7
	 ZS9WWtaRSHpmERLfGmiz49bGH+6rQeZEWBz9jzkbDU8f2lTh3GvuaMOmkBNn6OWk4eY6m
	 n9sWOEJyRRhM23a/uLWBzbF8zj+MGDZYbEIZM1vRhC0gteEYaEfaikZJe/n+VRnSRa+59
	 9lIsJ7q4EmdACNGOJCLVOUvrkaavuY/VmNW4zFoVZDxjtAE/3hHBLU+QBzO4cx5rBFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VBmUMlw3;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3D606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 12:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62E3D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VBmUMlw3
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso363346f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363994; x=1793968794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUJ2gwwAbHEm4tvJt9u+cB77ZI1OokWfWjFrziXQD/Q=;
        b=VBmUMlw3mU8MUEBbTwbpv6+rln7SBqQWw9iKzzo52IxbFQrWy26L+p43Rgjv3dhub5
         kdSLHsfKgqh5fSOsJ0D9wVKcWlKC6VLgoBsBGzS/1hX1J97+sL9Muj6w5xH8aVY1rRpV
         I+cwq7G9YMs34Rd8B2iXC1dPPNmNe6R/eUwM10gQYfQyNmeeJco9jZxreJb8RvdGhGYx
         opBrYf4zguM5zf7ybrpi32vAGijEMVBHRtYNKupIWA7YVWrffvmo5k2ORHlcyaq8B4Io
         ex9hJPVPvNRiIG338pJu8QZjLl7pYV+Ln/aiiBWrUhcljhBKIbqu5415DSajDUeZj9l9
         C2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363994; x=1793968794;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RUJ2gwwAbHEm4tvJt9u+cB77ZI1OokWfWjFrziXQD/Q=;
        b=LmWlgZeDo5JC7UUCDE9yexXGfqXQk2ro3If8QMrN+WF7htRFPs0WNlO2+rkYNvyUCf
         OaOxzDcWNP4zC90UUZAUlkVwf+b/ffFqK0vdRhdwx649OSZeGt31F1aBazv1ziHzSHvv
         Uz4TFoIFdf/f+o4g03wqwm/vXqP58ia7y9bjWPlYxuywZRfBkEr7+Ys7QnYBj3OcoJ6q
         gEQcrKrsDYCjvtXwYDIMJhrrYTMOEHVEqRtblKQmiuG017C6BbSECJV8kQ1BYDeWXE3n
         rX04OnQzettDtSGrpPBJKAtPmXovCaJyGV5tT3OipFinix2AcsdQrcp3/xCC7s5Npm2t
         ax/g==
X-Forwarded-Encrypted: i=1; AKwUvBznuwCObuZSEKz8oi6hYRwidco5CEuuGi10Gp2sZOlbsReyw/PUIvTUzrPJUvepOIUhzYhwgvani1Jaf5TA@vger.kernel.org
X-Gm-Message-State: AFq9FYLx/MWhfKFgaWJRFHG994Ghd8QQRWs972ss9aM3ZfVyqzArFxpe
	ZwYk6Qundvk4curjTfUS/S+6CRLyIVfkF+A+CCDfzy1xjOaF6g08PC4U
X-Gm-Gg: AYBFou1giwVV18ORl9QQNLur5AdQ/JGV+oCtXMGbcnRZczRO7vnz9uOK3dYdpM3wA9y
	Z61MMlVEmDPontZzk8nirexQeJoWr7YZ3kb+deBYTkPNx8YpWCsDb9+NQxIw/IWgqbfkqUzTcWs
	08PIjXTeA/u93W5WKuEkNYFKlZkvBttkv2VuUwA7lFQrUXWBe/NTjiQBj7HpOqCajz6e3MWUEwG
	In0G9WzB+jVuB51fnxFvyPtXJ94MbtEGF65XJMWmfZEYRPH9No8Bc5jJiwPgsaq4FECgQnWzZEH
	R6erTiBoEGod2J1KbO9Vcuq5/X28mRGylRmApyg6+Lfsm8F8WOJIzgs4QINmSonten4ppaK13YW
	VLDCX5gZ6j03/ZpOtwdN0g+BkykTlxT/DUI1yTbnEjB4YSiw0qpX+bbhlyJof/fZWsP8RXArZuv
	j5q3BZBhe/SGJL36kKj56RmALPDL8MPXJTj4vJyFtujCcwJhTDupZaHcaFfCawOvMJjZNkRSKrl
	nEE4PSyDZeLZappBd8sQNO44X/JKJdo455KQwshQ74OR2IsqNV/79B3a3Ht4JwKYEXQ4y3fhWzc
	QJhDYNdBkal5vPE8SQoJ3IppkcT/Ec3fnZZnKz72+f2qByEf0GvK49ndrcBlAcWYuNdvwxfG1/M
	7KurNyJ7UlzZQTCTuVhb4
X-Received: by 2002:a05:6000:24c5:b0:48e:d7c:4bc8 with SMTP id ffacd0b85a97d-48e6e2bdddbmr5939049f8f.7.1793363993170;
        Fri, 30 Oct 2026 05:39:53 -0700 (PDT)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm3088971f8f.23.2026.10.30.05.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:39:52 -0700 (PDT)
From: "=?UTF-8?q?M=C3=A9ven=20Car?=" <meven29@gmail.com>
X-Google-Original-From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] io_uring: add IORING_OP_UTIMENSAT
Date: Fri, 30 Oct 2026 13:39:42 +0100
Message-ID: <20261030123945.1704118-1-meven@kde.org>
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

Testing: a userspace test of 28 cases (paths, AT_EMPTY_PATH on O_PATH
fds, NULL path, UTIME_OMIT, permission and read-only errors, links, copy
at submission, inline on tmpfs and punt on ramfs) passes in a qemu
guest, on v7.2.3 and on for-7.4/io_uring. A liburing helper, test and
man page will follow if the interface is acceptable.

[1] https://lore.kernel.org/io-uring/e291085644e14b3eb4d1c3995098bf4e@huawei.com/

Méven Car (3):
  fs: add filename_utimensat()
  io_uring: add support for utimensat
  io_uring: set times inline when the filesystem cannot sleep

 fs/internal.h                 |   3 +
 fs/namespace.c                |  20 +++++++
 fs/utimes.c                   |  56 ++++++++++++++----
 include/linux/fs.h            |   1 +
 include/uapi/linux/io_uring.h |   2 +
 io_uring/fs.c                 | 105 ++++++++++++++++++++++++++++++++++
 io_uring/fs.h                 |   4 ++
 io_uring/opdef.c              |   8 +++
 mm/shmem.c                    |   3 +-
 9 files changed, 191 insertions(+), 11 deletions(-)


base-commit: ecb6817b769fd7d71af2c9f446188649020b2e53
-- 
2.56.0

