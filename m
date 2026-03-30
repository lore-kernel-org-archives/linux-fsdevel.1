Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B83C9452
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873573; cv=none; b=ln4oLL1gFFExiziA9sk5GWBnmi+VjkiV1efT/xrTTDh+wh2mLRHjbLmzPRU/kXTzLW1hXIVTscdr59KsaGKr+4N+EmOeqPS+FGLqdQ0glAzqKs9ZEGJZ9sftZzf47luZvQw3PuDrK8/bGY6FPrbMnTVB6u5qr2TlOE7fPIJlme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873573; c=relaxed/simple;
	bh=iXZRS7tiXpDFQsNbOnWsu8ZHvevn+YRlxfwIYQTCMUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHfe95UsTFNRFhmCJNHZ4Q3gcDMnWFOPu+ZInBelLyeUISmtqYnTm+6FwQERqd5mTNFkutvUdss3560F3/iviVuJLlcuRukCiPM5Qr4cnmpNdNtTN5ayOZISX1uqpONs5MNloefczSBNqDJyl/NVfgN+GA7pvCDCbLuG6XcgFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rueg9ULm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rueg9ULm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso51292995e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774873569; x=1775478369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkFTfIqiJxetZvwdSO3/FnYRN42npo/iAp2MLQjkxsk=;
        b=rueg9ULmhmAVfDu8zLUXCcBro9ROm/q/IiQqZGKvDH+zCBQ8fEHoVuQUvGq/Wp6Ayj
         KwfBR5jE/PWOBs8rtEIQxvcPIk4cXps32lqbbu6cdEZ0XMvPJ2uLoWsmauhNdN4mklqr
         dyVV7aAHYwwXtCJtgrOtmS6eak6dJBTZtFZyyhUDCUd+WH77DnMBP73cIDzWRGAtm2Oj
         D+rCv795BA8XvG1XxpdDQR6M4stF4QG7K+5hRPKNQj8hC+ohugH+jbP/DE6NNmWwSMHR
         2aiv0z3UoV8FTIcsE8ITnZkmcvvQXi+VVr/mY/S8m5qnN1GUbgvcmYfZtnUqk3LOHD7u
         w0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873569; x=1775478369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkFTfIqiJxetZvwdSO3/FnYRN42npo/iAp2MLQjkxsk=;
        b=jyAVJIRqEhYPHI3O8w5S/DNgAz6Ts68AoagUIo6ucf+bMfFbZqHPOw6UMQEf2lX1HO
         M5vkL3W7WUXGutifEMzXfA2GP/uIwktvc6BnIO/S11BXuyBggW/o1ADO+G5aiAYKwP3r
         7zHlfNXcCVTaf3EHal9x+sNkX7I1ZRoz4fWaDlrgiBj1/Vwio/XdBUdZReBeIA9L3xaT
         oxxaWTrc+qUnJuXDEmJGNBbyqQjRgz9X7ZrfjIHX8oFoIy2n3pyEYDZnosA2ry5UvyoZ
         JN3vbi/AgTe/lELNStE0cuIWPb1j/Z4PZprfDka4R2XdCZjg3XJ0lUMCUc+xONOd7AGb
         uMXg==
X-Forwarded-Encrypted: i=1; AJvYcCU18NlcM412cxvDDgtVIVGbvndISbpbZsUeFkWVlnXHRDxO0J+jDZ1lymiDNGlga/WKUmtMA10g/RyVhUhI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb905/pyjVNFkvaJA6a5k9LcWZskqwlaolDmG5wM0Vy0BuWNEz
	0lYf2Xj9JOC9U0gQ3zHU4ToDsoYvP95r4NFDVwgwJB3HCUCFO51mTpCl
X-Gm-Gg: ATEYQzxxJRX5UUJc5JowQL04jea8erXM4yqjlmMIKNc35/VFkxxWtLNyMEYZtCf9moP
	j0eJtLI/Eus0QB5oQyO/e0dB9K7v40Z3/m0LobeZH0Ccv3dbP4JJhIj3pjC2T2BAn5LwrX3m5rw
	AhJ5W0JvTS52mFODJbVzmybET8np5TDbkfr84QH82YWGJKfMv5LapHI8rt1o/8e2EZoI32htKpZ
	lsYlIEBnbXgNpE26BA9nUTGsPGQOzbYW7pzyI0AcZQLqN+oM+QG9NGKF/USznwWgJwgdmd3BA1J
	AQLZwWHH2X9mr0EiRiqBX6ARkhFLIGeW3tY1yqUttBAlT7h2nu7UxuWeg/ajR4el3EELia+v+3I
	EkIYqlfPbHZmk6WikyOV3zSEMNnvxNrDgD4FAy/4tMBnhoFsFcsUb6xnU9YJL+I610Ljab3dJtR
	NaIs4uMoB5L8bod/XThaKTpm8f1cfHUJQgzV2HMDFbrWlSdyAvTNSKP5GsVoSftPf/vm0cDgMdz
	Q==
X-Received: by 2002:a05:600c:4e0b:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-487290a9254mr182445395e9.1.1774873569098;
        Mon, 30 Mar 2026 05:26:09 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725da0333sm113541525e9.2.2026.03.30.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:26:08 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 0/4] assorted ->i_count changes + extension of lockless handling
Date: Mon, 30 Mar 2026 14:25:58 +0200
Message-ID: <20260330122602.3659417-1-mjguzik@gmail.com>
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
strongly insist on it, but at the very least the problem it sorts out
needs to be noted in a comment.

v4:
- squash icount_read patches
- use icount_read_once in the new ihold assert, reported by syzbot
- squash lockless ref acquire patches, rewrite new comments

v3:
- tidy up ihold
- add lockless handling to the hash

Mateusz Guzik (4):
  fs: add icount_read_once() and stop open-coding ->i_count loads
  fs: relocate and tidy up ihold()
  fs: handle potential filesystems which use I_DONTCACHE and drop the
    lock in ->drop_inode
  fs: allow lockless ->i_count bumps as long as it does not transition
    0->1

 arch/powerpc/platforms/cell/spufs/file.c |   2 +-
 fs/btrfs/inode.c                         |   2 +-
 fs/ceph/mds_client.c                     |   2 +-
 fs/dcache.c                              |   4 +
 fs/ext4/ialloc.c                         |   4 +-
 fs/hpfs/inode.c                          |   2 +-
 fs/inode.c                               | 122 ++++++++++++++++++-----
 fs/nfs/inode.c                           |   4 +-
 fs/smb/client/inode.c                    |   2 +-
 fs/ubifs/super.c                         |   2 +-
 fs/xfs/xfs_inode.c                       |   2 +-
 fs/xfs/xfs_trace.h                       |   2 +-
 include/linux/fs.h                       |  13 +++
 include/trace/events/filelock.h          |   2 +-
 security/landlock/fs.c                   |   2 +-
 15 files changed, 130 insertions(+), 37 deletions(-)

-- 
2.48.1

