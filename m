Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4639D6F6
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461916; cv=none; b=FY34C9n4sw2blYVbWAZALoH//grAWiwZUeUm4DhOSe2LMzA8nkCLLvNzCn3/zyzkmnh3EZX8OX8HSv9G8pMB0MKEcHdav6OWGV93d+ZAmskT6gx77mVwDLxwK/vPj4g0YU3p2j53XTq2u4zPZT3pJWxTUFcThMdtlENnTb+6cOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461916; c=relaxed/simple;
	bh=uSMZyhpWb3Lewk10aGyLoJhwKy1RPso0pdHWRzUeHRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSC3g8dwRwuUOb6MvLVXbVlsOTxmrYW0skt5VWLNtKiXiN84RMxpwmIg+du/6mrhH6jOnKWbuguFPyRfWG/6vHMQ1pgSQ+ntMjmkEtwkmSS3BbkGNIswMyrfq5eT7Z5StqeAJCYG+tK/oWDkYdFwak4ZO0WXUjE83G19+CorMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfUDzcGo; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfUDzcGo"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44865cf3010so23510fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461914; x=1784066714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFuyHyO9x9zi/vB/Fo3WcH6RsLoMos07zpCuStd3IHg=;
        b=KfUDzcGoCc78/vgregPW+g4+LZ5Y3vrvKTH3aW+QMpi7aX5MEoaB2dXOe/oqJM3nWX
         Ck5qkFxPO4xc7vloae0C4zOyUxWfj+eGHKlrgm52FesC6uCGV/zDsdnqLo3+DxI5+zYJ
         9TGmRk2gFi6pb6QPVzaBEiMyWsqWH1xGr/0fAHiSnvJsJu/cDRCMQk2rFKNj7+WmDW4W
         gmaYtWovFURuaQZWET392kO3ULaO701FxO8yhM+6qFNdDcNAztZGwPMC/TvUyQBFvrLv
         qqk+BBUKaoIutION4ZJvMb41kK3Ns12Bjjp8l9lZcJ7BZ1Tbzlee30P4R/4HreAVP2xH
         xs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461914; x=1784066714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFuyHyO9x9zi/vB/Fo3WcH6RsLoMos07zpCuStd3IHg=;
        b=N7GKbrQ6zeTI1sMmcsVlk/FzcKf65TVTMZU4VCz8jlyJjNPLQwGbCLBVi6k/c0Lyd4
         lxvGjJWYfmz/LJ++LsXck7e2CJVvB7tu8NnLGXHtFhnO5YMBrdNGulyA4NJi6Ic7ZUHs
         xaf3R1+J3UQSDZSlMs8SDkhFoRLUwEDFkyXX0Od5I7QNVj06Madn3LR6cdvXDHCT+9tU
         bITYs6hcDaMN+EAmkvyxpb816kcj+Aw45ORjbSuA86RqojBS6XI1+8O/5azeKH7gT94E
         Uz2JRvi/LaQKfOVeYf3GPKsrr3fHVDhcaKUJWpsLaMb//o/f0WrBF75MtX5ppPoRXhip
         SXNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3JkN0+cqeqxhA7lbiSSCMNmeSSEt3l6Sk74o+LF8+hCysy+NQh+ZA/3sI7kVCeBWZ2lEc18USFRLztwLR@vger.kernel.org
X-Gm-Message-State: AOJu0YwJobfaPL8YspUsvmuyiBb3tk9vnpV3j/oq/uV5sc7qY7vtOynP
	6xO438610KQdzqSJB5pnXEnkGLZAFkN7p9VjoxR2kKYKirN/wnZr39t6
X-Gm-Gg: AfdE7cnEXzc/5DygSbngYj7X8c+adon+Q5XPuVaXEtvQlIrYf+Syr9kPVDcem+H4m8N
	OYT7ktWec9ekSI/sAYSsZZUfAclUMGJKVdM+euF9fQfuqF9iDhTqBfihQjVSfcsYvWQ1jyrVcJA
	S5NruYdLJrItXHExJQvVVjhiJHRjJLkpbcI8VU9/+84FkoC8AI/Mu2aiqiH4jlnXwVU0weRwfdF
	A/cYQKjznjA8/KgEcO5wQd1KOdT3u/A4rhjdeTT0YjrWwe56vRTIkDXgp7lY/RELuxouWkuxDQ4
	FTLYxsb1IutXl5ZCIMAW0iN55ayNwLBtj8VGMXgS2mN4CW0NCEg8jYtveJ0MjPiqod3GCF/lo11
	VsT6JrXMtf8Fcg4JwQ57iSd8czrgOR/29wq/+V6Lo6/O7T6lt2MjtDYj3gohaGtcDTNjCVjGMn9
	wfxY92ioEsTwYn6my8vybXPKj287maFx7wrGVMC9enqTlAO36whdCoRSovmP4kk+d9
X-Received: by 2002:a05:6870:9d8f:b0:43d:31dc:a6e2 with SMTP id 586e51a60fabf-45105cd2026mr4752593fac.24.1783461914313;
        Tue, 07 Jul 2026 15:05:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb559559sm15139599fac.9.2026.07.07.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:05:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@lst.de,
	miklos@szeredi.hu,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v3 0/3] iomap/fuse: add helper to keep uptodate bitmap in sync
Date: Tue,  7 Jul 2026 15:04:47 -0700
Message-ID: <20260707220450.1200943-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystems that use iomap normally mark folios uptodate through the iomap
read/write paths, which keep iomap's internal uptodate bitmap in sync.
However, some filesystems need to write data directly into the page cache
outside of those paths (eg fuse, which may need to write server-pushed data
straight into the page cache for servicing notify stores). These filesystems
need a way to mark a folio uptodate that also updates the iomap bitmap so
they're kept in sync.

This series adds iomap_folio_mark_uptodate() for filesystems to do that and
updates the relevant fuse call paths to use this. This is needed before fuse
can enable large folios.

Patch 1 ("fuse: don't clear folio uptodate on writethrough errors") was
originally submitted to the fuse tree [1] but patch 3 ("fuse: use iomap helper
to mark folio uptodate") has a dependency on it, so to make cross-coordination
between trees easier, patch 1 is now part of this series and submitted to the
vfs tree. This series is based on top of the vfs-7.3.iomap branch (head commit
e1b77fb85836e ("Merge patch series "iomap: add simple dio path...")).

Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/20260624205201.842714-1-joannelkoong@gmail.com/

Changelog
---------
v2: https://lore.kernel.org/linux-fsdevel/20260624212925.1668662-1-joannelkoong@gmail.com/
* add Reviewed-by tags and rebase onto the vfs-7.3.iomap branch 
* include patch 1 from [1], to ensure ordering between patches for bisectability

v1: https://lore.kernel.org/linux-fsdevel/20260623202843.2064992-1-joannelkoong@gmail.com/
v1 -> v2:
* drop helper for clearing uptodate state, as per Matthew and Christoph's
  comments

Joanne Koong (3):
  fuse: don't clear folio uptodate on writethrough errors
  iomap: add helper to mark folio uptodate
  fuse: use iomap helper to mark folio uptodate

 fs/fuse/file.c         | 20 ++------------------
 fs/fuse/notify.c       |  4 +++-
 fs/iomap/buffered-io.c |  6 ++++++
 include/linux/iomap.h  |  1 +
 4 files changed, 12 insertions(+), 19 deletions(-)

-- 
2.52.0

