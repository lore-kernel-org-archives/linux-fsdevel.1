Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92330E829
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712719; cv=none; b=GJFWtA/vvX4HSSzOfqhttWp0uXE5f/pKXQnnTvbq2hEoeFk5VZ9wGEt8Rz1nl42mFBZP/8o3pHSGPmPmOmIKeqfC+T639gRIwmEHBQhhcC+W+6k0VywXMIeNKCOMsY0vJINpWiOr+7QKlWwNVi+gqDm+kmV1KROAh4lKJHbDyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712719; c=relaxed/simple;
	bh=0143IXXElNSyg7Nm9oVd4wH33qpnhWZ280pBxKmpmMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYex/ODzvlG1o8uwpUr23j9Zj67rWtA8A6pvTlEaPJL/I9TRg+4QoOFtmmsI8ALWyw9Gwc6eMghbv2ZGt9Bk8nY+5GkSPBeEU6+6shqKfmhfGcNOES9xrCE5ZbGd75S3A6qFJbCDdpcPDEXUZ1vcr9G285vn/IyIxSMpzPOlzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEetfvBp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEetfvBp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66ba9898ae8so284917a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712717; x=1775317517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GSleJR0+hRkD8atg6lLhmCsk3DjIcRPohzR53U7fmU=;
        b=OEetfvBpMZEsDr8aRWU09OnQGrowejA73JZUcyz1RzbIWgxUekGvt0F6cps82czbQS
         p4l4/UC6wq1UjvgieeTIZQvVxU5lYRb3AWQakC83j2QIvGhB5e/RHPdM40q2JWxUPpHJ
         YvwmMVVQe9ub9KTkNT6Qt/n77VzXoGFZAvR5jWjAEX03nW0RD0Uzj3kBscvxgSA0Qeyp
         +zSrAgQzv7He3bgFRoH++aqSDaqaHiLgNDgkl9vJI63pDXD60qxdHRu1ZWN7ne84Riy9
         emql+f3GYB0thdNidinN80Y6AwNsSuDBnFHgsTTvJDPyOuitRieeTRh7ni8s44EMlG+/
         bnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712717; x=1775317517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GSleJR0+hRkD8atg6lLhmCsk3DjIcRPohzR53U7fmU=;
        b=s+61gKrg1qnG+yAWIDP2CqqGrhhoOnlS8rYGVHOr4aqJOwpMgNLp58QyJUKhvfEqpr
         MrNPjFMTdR/UZQz+20uhfDZhrjeyJxrgpoYQgv5L+k+2r8quSyyjpIZnB5Yb4WgJLPv8
         LEdqua1MFDXt+EN2CTvpgBCGCwEUJUK32JpBre9TSIllh7CLNJMkBvl4DII8subb1tpz
         gGEjrsIBmIF6oLs5RepInlACemVCErzQUt6PxHYE6kwji9HL64cBwHzr+ny1xxalzaLV
         YQw6SQUMhxPq/7TmrpwKIZZ6k1nz/HcnMeFHRudkJIHmoOoWx+EgDDdslcC38O/hfh/9
         BLFw==
X-Forwarded-Encrypted: i=1; AJvYcCXfrJR9RZaFonsBEnexpGEos1SeGZmNIah+g8UE/2SqbQ8Lm8qnP2ehnS7PrcCAbXvarcbKHGT0ScwaWtuA@vger.kernel.org
X-Gm-Message-State: AOJu0YzALBZsT9xNsdmpKYGxPKMfwdk6X0sGW00W419J0o8yUOVXRI9g
	t74z2NR/Adpp0K9SYrmBuvltclb330lSigGxXZ8eRJVyrv74KyvhT0T2DR2bDw==
X-Gm-Gg: ATEYQzyMVI7Aiz4/2wk/GeTq5PUe4p2BbHLLT1t5g5iqjXNpVul46s7Ysj/F1hxNKYg
	s04I/WvVMyzLjUzp+0XLFXB6jYAVYVQfJnMI3YV096ILQLJxlFa+5usg2FKlbtFxsk9KU7pFxOB
	ommuBGM4yBMBxGm9qMMMW9uGCF4dfCtIHJ0tzCFej9umtixFBEv288xeXDttr4OfqZb14ItkG/R
	9nlRkl4XyhKrF6z0KxFGsOr8F8DFR91v2ZZb8uNRj84QET0DPpl7wopx5OOZRyJOcxIbXhkD9pj
	J3JXxu9AW9FC8gSuAe6t/itKvxZh7dK5nXQzo4kq9wwMoydxTVPwSgHloe0niXxD5JV7UXg0JnA
	Qtdb8Eg7e8YwHFOMi2zlQNyX84SFkqvX/DEXtkos9ABXftP1GEXMpoC+31x+quAuKByg2g22v+I
	nua5Imdz0MeVTn8trsi0KOvF2KyOzGdzsqoUlXcGrlgpTJyw2kNT5Fj8AuokEQ73afUotUdK54k
	Q==
X-Received: by 2002:a05:6000:2387:b0:43b:94bf:6400 with SMTP id ffacd0b85a97d-43b9eb399f1mr10973752f8f.24.1774712299878;
        Sat, 28 Mar 2026 08:38:19 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247102dsm7196887f8f.27.2026.03.28.08.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:38:19 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 0/5] assorted ->i_count-related changes
Date: Sat, 28 Mar 2026 16:38:02 +0100
Message-ID: <20260328153807.3368975-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The icount_read_once() stuff lines up with inode_state_read_once().
The prefix is different but I opted to not change it due to igrab(),
ihold() et al.

There is a future-proofing change in iput_final(). I am not going to
strongly insist on it, but at the very least the problem needs to be
noted in a comment.

Finally, igrab() gets lockless treatment. I verified btrfs likes to call
into it in writeback code with the count > 1, same with procfs during
process reaping. Grep shows nfs also calls there, but I have not checked
how often that happens. This is a minor single-threaded speed up at
least as a lock trip is avoided in the common case.

[this is v1 except without the unrelated patch]

Mateusz Guzik (5):
  fs: add icount_read_once()
  Use icount_read() and icount_read_once() as appropriate.
  fs: enforce locking in icount_read(), add some commentary
  fs: handle hypothetical filesystems hich use I_DONTCACHE and drop the
    lock in ->drop_inode
  fs: locklessly bump refs in igrab as long as it does not transition
    0->1

 arch/powerpc/platforms/cell/spufs/file.c |  2 +-
 fs/btrfs/inode.c                         |  2 +-
 fs/ceph/mds_client.c                     |  2 +-
 fs/ext4/ialloc.c                         |  4 +--
 fs/hpfs/inode.c                          |  2 +-
 fs/inode.c                               | 42 ++++++++++++++++--------
 fs/nfs/inode.c                           |  4 +--
 fs/smb/client/inode.c                    |  2 +-
 fs/ubifs/super.c                         |  2 +-
 fs/xfs/xfs_inode.c                       |  2 +-
 fs/xfs/xfs_trace.h                       |  2 +-
 include/linux/fs.h                       | 13 ++++++++
 include/trace/events/filelock.h          |  2 +-
 security/landlock/fs.c                   |  2 +-
 14 files changed, 55 insertions(+), 28 deletions(-)

-- 
2.48.1

