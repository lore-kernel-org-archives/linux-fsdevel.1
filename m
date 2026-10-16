Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E53E51EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142370; cv=none; b=b/QmS/AoRLNf5Rawwo47Mnlg9JfWy0gIQugQuEGHZeEBh31yLLqxjt3U3S50MoO5m4FO5+nGsgSEQVkecBJQTJRX+XEWS97mJfgiBkEA786UU3AVPI0t1VPirpGt4qcZ2h2iFChf6ToH+jwPHIynlWs/NPN8z1q/OTlDjeMDwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142370; c=relaxed/simple;
	bh=aTMUcqZURy19NxFvWbxUVqjPoyE/i6xWtuoBHgM6v5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFjyZ/shk7UC/YyCnT+wMVLvvDcCZ01g6B5Km/WpuIbvktD9JQJ90RV6sWh0Zten+mhnxb4zRoASF4yE7hle/EQo5wCJFpVbpb9Jf6xaLkfW+3RxbPGC11DgMuguGC+bSG6ECbNGEy4iGlXgOhj5a2ziUzFxubvzeqOIAwi+SFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGFgvUJA; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGFgvUJA"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15dd124bbe7so574159c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142368; x=1792747168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKIcc9y2gPYr67ZGxXeokwj+kkWiL3V5XBf1VhWPUVU=;
        b=FGFgvUJAv8s2A6YxIjHQoZU7x5wvf7kQ4xu+ZoTgCQWRbGCz1Xg9tKW93AcvOzwgAi
         8LRnhT3op7JDqFFFmQhJ4CHy3tDzDHQq/eYpE7xf+7T08hE5qGPUvKu7A1V6tKUEqMrW
         5rRbMspLxGfMii0OaJvlAtjKTnkXnh1k4qhjo0IfhzSLw28jh7uuFmG3QCeAQQKn7k4H
         TwN4am2PyPHq0iS6sSwbdmsEjGQi+vItStQRrGaQDavCDjQJoP6a/OnKT0QxonRz6DUH
         0A8hXHgezZb7NvG+bSP8Sjp7wAwRdQIxI2lWdw9ngKCyw7QFCCx01xdja1WWBgMAFpkO
         3NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142368; x=1792747168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKIcc9y2gPYr67ZGxXeokwj+kkWiL3V5XBf1VhWPUVU=;
        b=rxkts0nJ62FViVS6GnhTt8Dd1ff+Qiy2N5f0HoHr9urJARXpFgRc4PyGpKa9QEv+ZV
         6fHgf9D0CYY/fPtyPrkCf9+QfbMMIYDkBO6rKgu2Nt6ii3VcRJj7z7/xy9YOB4UCN39c
         gsvCESz/HxXwvWDRh0xS0o01GuljeAsqxNLvqPwFQZNCgnfJcPhFMmOe1U6G9UpL1Y0Q
         zm9RoRV68FdAS6BsQVqiSNAe/oG2p0051QiUrLZqDylLMCveSbLCKZ82BlZrFB8Db/I0
         rvPPptP3dhEzyrhKYvcKkmBUxpabc/m52kB50/A6edBOMj4ynV7pSTzsXz8Lv+IldKU4
         Z92A==
X-Forwarded-Encrypted: i=1; AKwUvBwU4uw+xAzv/i219GWYFsHovUzuDAETLtyLv8y97LFt6KupvKANGA9rnXXxOACFKJChEPgADig96WVr0bR7@vger.kernel.org
X-Gm-Message-State: AFq9FYI/8MsCvvkt9awxb5Yt4BJaPpqRdPfg66Mffk8em+2x90uzTlcx
	f2aFv4BEoWtdSEDdZ/486s4HKjV+e3XiQI1AHPdeQccqR/vhgmVr3zg=
X-Gm-Gg: AYBFou0/YJVObXPt5F1z/eCMlh0Gu6her1Gj21JTnLx22g0Ajfo3LK7NCFMqB8eyznY
	bf++u71tbTcR/YiZcBEL8q2XqzGXV+bVnlcTKrzd1AZ9bGAqSnH1OpgcKWQz9TfenYNWJjli+ub
	Cq3n1qqXgCJ/6lEyw4he6gElWO9XI2GMSU0iuZznOFkRGoiZ4OR6gAYKazrWF30XJ2t2bsqrvJr
	hY3lbdu6SRKha8IHK0SxzIH6sUkZK03gjF+N2W9KJIkFwwagROabrtxiMPEdAg4OXWwdM0B76ng
	+sUC5i7CQkjagdQhv69ru0v1RaJr7AiOzZ49OA7vptBZ9lf3V1nLuXpxyVcRjGuMlRKLmBZEgFU
	uZPzq1kEMdcpU6Z6pTjOvlwAG7Mny8L2Ft3VYnTuape72TyDkEUbtG04NBN5jWFLTpuWUYyFVqA
	UpOlRkRSi8/ffIctqGjCTvTot74ymRwvcIWVQYE2R1uAyc/LY24YIphDJvSzLMDjGhv4p8Sfzth
	CaDtV9oFsWNG0pCM+/dIDjtZ3iUwOuqfXmKKwCoL5m3md2U58sX/OtHOS5PVMY=
X-Received: by 2002:a05:701b:4544:10b0:144:c12b:dfc6 with SMTP id a92af1059eb24-16a60ce7b43mr28678298c88.44.1792142368095;
        Fri, 16 Oct 2026 02:19:28 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:7bfc:fc3a:e718:89f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm9840943eec.24.2026.10.16.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:19:27 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: asml.silence@gmail.com,
	hch@lst.de,
	djwong@kernel.org,
	cem@kernel.org,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	nj.shetty@samsung.com
Subject: [RFC 0/4] fs: support dma-buf backed direct I/O
Date: Fri, 16 Oct 2026 14:49:10 +0530
Message-ID: <20261016091919.971295-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets an application register a dma-buf against a file,
so reads and writes go directly to the device as dma-buf backed
bios with no per-command DMA mapping.

This series builds on Pavel Begunkov's dma-buf block support v11,
https://lore.kernel.org/all/cover.1791975048.git.asml.silence@gmail.com/
which is queued in Jens Axboe's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-7.4/io_uring-dmabuf

A separate kernel tree is present here:
https://github.com/anuj7781/linux-kernel/tree/anuj/fs-dmabuf-rfc-v11-desc-v2

Nitesh Shetty (4):
  block: factor out bdev_init_dma_buf_io_ctx()
  block: refuse a dma-buf bio for a disk the buffer was not registered
    on
  iomap: add dma-buf direct I/O guards and registration helper
  xfs: support dma-buf registered buffers for direct I/O

 block/bio.c                | 15 +++++++++++++++
 block/fops.c               | 19 +++++++++++++++----
 fs/iomap/direct-io.c       | 31 ++++++++++++++++++++++++++++++-
 fs/xfs/xfs_file.c          | 30 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h     |  3 +++
 include/linux/dma-buf-io.h |  2 ++
 include/linux/iomap.h      |  3 +++
 7 files changed, 98 insertions(+), 5 deletions(-)

-- 
2.43.0

