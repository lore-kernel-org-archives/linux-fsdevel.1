Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122415687D
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804816; cv=none; b=kvn8sVjPk1rZNSiGqJ4C3dA5bu6bEGuilk+IbTw0wOp8RradGNY/qGVfalKKNA11UeFtjoq9wQqXTm8T6uTmdzXpn6rsUydwmnUAu3Cfr8Oyg0ncyKE2PeSKZdS7WpRvbrFBMWaxdQDOJ2uGzx4aYxYjd/KVM6U6HCIVF9ubTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804816; c=relaxed/simple;
	bh=6R+9nd88tZ3TlYfp/qqHQHU2Es9EiRsRPP1CEhhHxP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjPHXx65ejtBNWcAm0kwSasE51bqlW42x3fECC1brGNWr7573Fix7U9dbwsCaxGLlqN/UbxfXsBfdW47TVqJiUpDhz4jqbyrJccK+XNJ53u1Vz0R+6ySWTuF0GMXdPi20il/zsmkbAyy3LPUn1riQLHrw0O7HZK9JYv2IvQRXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+aG3cpM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+aG3cpM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso31551465e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774804814; x=1775409614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzw4iBHMRARSh5usnBy+gH9KubUL5EZBuRXquFbr29E=;
        b=M+aG3cpM/mPBdVreOAUXQEBrxrTEFPyJKItBPkvGf7FWPT9mG+hsPT0P7d1V3qVTQf
         u/tzBAB/l909uk9DWONC/f4hNeJSDm6/Y7tx0bKFGF3QmR9mOf2/oIiWsL5vh872r+t6
         MPXm6EBma0sCiYqot13+dd1RDUbBsgAaQEAxkeSFOEcUxI4zHQsO1B4jPQZG9BqRzbry
         TqstTXEb6765bKVSpN+Z6oIWD8Y/tNjMvgNhU726W9hrIxURUW6FaAKsLsDMuu2Xmd9v
         +ZfguMTsQiA6wPZsGGmoKsxQQ63wCOmuck+Zgsk+lHTbScjk7DN36Ciazqy26eNxqbY3
         Cy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804814; x=1775409614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzw4iBHMRARSh5usnBy+gH9KubUL5EZBuRXquFbr29E=;
        b=GROlo7SH7f/Eg/1MdP9ZYN2Q6W7bBb+FI0moU+NYHA3cgfhiLqCD8Idlj7BoQ+1w7w
         v3lRmkuD0DFndS0MEx9R4/YZ5EKYlVZDaWEQE+LqqG21fGCWBJmZV47rI4ETNSZwxZJo
         fTecjBgKYOAa3V4HEcyhqrSozOEKyrFYa4NLoAsYLU3umbGGs8zFmMqdB+SMSJer33kN
         CFpxpMZNA1+tA3Zdwh7AYWAY0KB5S2h2GtJrpme4x6Gi0V5WqeXBn1Ee36DJ9SIEXRRv
         vJiVz6ltlZ//oU8zyikukkJJrsXB4yLpNSd+yu3FYJMExlcPL9BBbLwIXhV+C8Am1SMM
         tazw==
X-Forwarded-Encrypted: i=1; AJvYcCVQx9j1UcwqCwAOzhrHyVg920+WYOrxVfDkWC19n6+c2f+8ez1HbBO2Zp5B4SoW8txLDil6w8DQtYYIjsI9@vger.kernel.org
X-Gm-Message-State: AOJu0YyZw/wXvPYQTdBXlwBF2jslFa5zRoPNcj9SqIqCYSMU8k1K4F4o
	56+cpdJK5SHzlKNl9SEKnlcCIbzkuGvgTjWw4tqrFjUCnr/QfuVlFWLh
X-Gm-Gg: ATEYQzzmByUSIs32pnTH/i/do/z9t6w0rvdcYNxBBpUkZRfUrHVvGoZ5m/cYGhgCiFH
	o7dMJd7Ez+EsTN+cXVf9VsWztzJ86mQxjzPLRwQldb1lzCVaH/E1mCNJlMXvSbLl1mkVfGQIrZi
	GJG1B9SBdN7rN9mGTQt+7b47Z+dMy/WZ4MzIzjSEDXf5ZB5cN5g44X4pncaCSLqNbuj52wHFYsb
	6qXRpvvMflKx5nnQ8uJtVcLG8nDcv3+n8d4LQb8DCPPAGfIZ6/vQ1IdiFIAINSf/iupwi6kOXTE
	XeWzBsDGStIWSO897fMRamqJe9qgbGhJ9XJNQ9zTaupuf3cUszvyRdd6wnZs5TBm1eb04xLnqS7
	a6IKKWOpderVYMZ2IwtZ77CffbazwBX8y0gc2Qk/rfeLUh6ZPSpVsA5Fc55mVS7c1cPnM01uU93
	wMq8Dn5pJXOyH0EuJE2SAa3rcvN1Uvve2HQciYaKfsI59bdGvHyXDygQtv75KNIGWxNvh9B+fbJ
	w==
X-Received: by 2002:a05:600c:8b70:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-48727d317f6mr167084705e9.0.1774804813402;
        Sun, 29 Mar 2026 10:20:13 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm9776805e9.15.2026.03.29.10.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 10:20:12 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 0/7] assorted ->i_count changes + extension of lockless handling
Date: Sun, 29 Mar 2026 19:19:55 +0200
Message-ID: <20260329172002.3557801-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stock kernel support partial lockless in handling in that iput() can
decrement any value > 1. Any ref acquire however requires the spinlock.

With this patchset ref acquires when the value was already at least 1
also become lockless. That is, only transitions 0->1 and 1->0 take the
lock.

I verified when nfs calls into the hash taking the lock is typically
avoided. Similarly, btrfs likes to igrab() and avoids the lock.
However, I have to fully admit I did not perform any benchmarks. While
cleaning stuff up I noticed lockless operation is almost readily
available so I went for it.

Clean-up wise, the icount_read_once() stuff lines up with inode_state_read_once().
The prefix is different but I opted to not change it due to igrab(), ihold() et al.

There is a future-proofing change in iput_final(). I am not going to
strongly insist on it, but at the very least the problem needs to be
noted in a comment.

v2:
- tidy up ihold
- add lockless handling to the hash

Mateusz Guzik (7):
  fs: add icount_read_once()
  Use icount_read() and icount_read_once() as appropriate.
  fs: enforce locking in icount_read(), add some commentary
  fs: relocate and tidy up ihold()
  fs: handle hypothetical filesystems which use I_DONTCACHE and drop the
    lock in ->drop_inode
  fs: locklessly bump refs in igrab as long as it does not transition
    0->1
  fs: locklessly bump refs in the inode hash when possible

 arch/powerpc/platforms/cell/spufs/file.c |   2 +-
 fs/btrfs/inode.c                         |   2 +-
 fs/ceph/mds_client.c                     |   2 +-
 fs/dcache.c                              |   4 +
 fs/ext4/ialloc.c                         |   4 +-
 fs/hpfs/inode.c                          |   2 +-
 fs/inode.c                               | 114 ++++++++++++++++++-----
 fs/nfs/inode.c                           |   4 +-
 fs/smb/client/inode.c                    |   2 +-
 fs/ubifs/super.c                         |   2 +-
 fs/xfs/xfs_inode.c                       |   2 +-
 fs/xfs/xfs_trace.h                       |   2 +-
 include/linux/fs.h                       |  13 +++
 include/trace/events/filelock.h          |   2 +-
 security/landlock/fs.c                   |   2 +-
 15 files changed, 122 insertions(+), 37 deletions(-)

-- 
2.48.1

