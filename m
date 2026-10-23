Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783339;
	b=WkvLPiOu+RTVG4MEAmn8YTneXu3XVzM8Gy934r+3MSXrCOg61PYis+mnY8VFmJjVN0zV
	 OLJYGPwHXwsrXXnSPhVpv9SBgvNvvoUnc+c1j3Y5RZlCmZ94zvjLmMvuYbJpmt2fMx4he
	 z22tExTMo+isyq8H7X6dijbtgLWPu+hTa9+hX4SD/VVaRjUYqF1IfFzBcZwOlapUkSbAj
	 gselcfh1sHfNFtBSUNsgDY7Ht5r+CPELLK/lWbfFdqXk0SY3BWihZ9Z1jkV+Wg3pjw+Wr
	 LD2KUaXCht1c2pSgQat9BIqfLzaiMF6qlXZ2bJMzXYyV5GtXLqmCPJTUUL/CbDMYvgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2O8huCNDA9D6LhH8u5r2l7pNtY046Fm8Q9bS6RsUJDY=;
	b=n2k5mbhj6DtS+ho9GcvEZBBzj3eCuTd/ZsmoopqvUljncL+t56+b3AFK//VP4HC9knAV
	 KuYsWbBpUflfLYqe3bDk8fuRWdHXzbgi94tcjKKcOXiW1qjQiT0QfMpEBk/VP8t78T1Oa
	 cGhh0Z9oYxmjH2pYZdD3C5W65X5hdQexWF+3mXt+Lvm22eZXiEI1g/YSNid93M7p4KgaT
	 ttN8sWsP1O4wXH5OqcgDIDIItrltYLliOpNhnQZcbNuXc+6hg45yjQY/2bFms5fXCoVMb
	 v9tbIxvIVB+7zDTokh36nauY8NBlEFMdbIcIofPmC6xYcmRKaotip+lxT6oIw2j3YzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=FYo2dUm9;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C8606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 19:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559C8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=FYo2dUm9
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-55651e7de9bso685487b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1792783338; x=1793388138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2O8huCNDA9D6LhH8u5r2l7pNtY046Fm8Q9bS6RsUJDY=;
        b=FYo2dUm9IDzTxiP+JO3yjXkilEcWtyqPRXdTw0z6K6HCizYBBurOEvQmtvbdr2iDnq
         QOJIdi5+DONOLbX7xJgVbVsIbf04NypIzEO3tcy288Z6vSFmcaVoDaN6TJHKPkkogNVF
         xFJ1YYIxkNaIEli8ASWpSHHMdWWy01QKtqatUP8e1jTjCyNRIMmyRkK5FenOsDGYFjbG
         XyeuPwZgY0aH5cKpMyt4KlwnO0l/KoDDWVfou2z2L4R6CSaBxoGNjidw++L66qsx/WP/
         VwqCGOPLM3/n8nYMbnLGpoC+d4oSShK31P+Tj4SpbC50hAEpJK8FTcWAbt3fNUj1xeaD
         xxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783338; x=1793388138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2O8huCNDA9D6LhH8u5r2l7pNtY046Fm8Q9bS6RsUJDY=;
        b=QBClgD33bJLt3lW9TIzzLHCfxMbg7IkhU5Ap9tNPwJ+BAbvrk1H7ZkLgl0GqQj6nPL
         B4qdpgc0lE/jbhaTrtSI1/MKTRs+8m9bB12c2fAuvAJW0tBT1i70qfq+uflpVgr8dB0o
         D4jbA4Ms8z/W/WAl2oAUdjme/s9JI6ftpbeLxLndHfl7X0rK1gBWItp/bukNwEhWhleW
         oBWQVWiXJWtMT7v/IZKhXpeCj/7/J7qtcwDFVJ6xu3iZzFtJsQt9HajGeIMEl1B2Kpov
         hfPNo8x4M23A50FkIZgrCd1CzoT+oTN+MA00O+S8C5spB4ZswXzv8pm6uUbDSOqqb1e5
         G8fg==
X-Forwarded-Encrypted: i=1; AKwUvBynEh3e517SlmEPiN18iMo7ewqJuKxP8cfbZFvDZER/bUW+3iWKNQb/fh5DZ+qswNrxzp83dfZiHn8D0i7s@vger.kernel.org
X-Gm-Message-State: AFq9FYKBWxt5wroRQcM0hkkewek3K14GKuinWneWnNbjf5oRZPHe3+FV
	EElLB76KSuCGIao1tl9KtvghaaP5gPUfIrY4v5yufy8uiFzXfDbqdkzrfPIbjdfKFm0=
X-Gm-Gg: AYBFou1UkAI5VyEGl3Xbf0AoA0ZQxl+T1gikrHOwMcpwyctdyQ/U2wk/EjC3PI4yl9m
	7qCsjpenkBc4YajZD+qFfqF/DzKuvNvw3F9c1LG69at4VXrMt5WajdrWr9MXmr55R2tjlGhoUVV
	Z+ZY/vE9cxO/DO4zxBSPENdW1OlRlGPZ46GjlvlF/1n6uTSFeWgyrE2vsaN3UvR7B3GSk+6a+J2
	iGfGTrznc8QnF8nG9IFazLDEgwfDc283HiaEi21LJLXtaTkjaGIr2g5OXu7LrtOX9ipxviKy6yP
	A1BAkdFkKu7Z8OhPzgxN5UGfUFpBnka9MpBhqFfadHMmVGytv08FH5Mq08/42IJgPsDqNY3CS/E
	1cMxbOQUj7Kwdn3sulvZgv5BTyZvq/MJcUTXHpaK7YHbJNYrEYj1Xec/bZa5TeSekjBK6m4EGoh
	HV0g2XM7NILClxUZpZQ0MaI6HT7N6KrZJwEGSzJ7bE59N149K6Yw9k8Da1Y5OeLDX0Z0yXCPOVU
	CVUWROKPKPrs7wh/onGHjWLp8a5mFutIQmxc6Ca4mVxtKiC9jafpHGrj96c4MbZlzrcqoL1x5OX
	iCs2MLFpRyNvz7sAD8lCXp0=
X-Received: by 2002:a05:6808:1982:b0:4f4:3790:65fd with SMTP id 5614622812f47-55c002b7e97mr146807b6e.29.1792783338131;
        Fri, 23 Oct 2026 12:22:18 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55bfe114ba4sm409050b6e.3.2026.10.23.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:22:16 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: NeilBrown <neilb@ownmail.net>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: set NFS_FSDATA_BLOCKED before invalidating d_seq
Date: Fri, 23 Oct 2026 13:22:15 -0600
Message-ID: <20261023192215.1795577-1-jonathan.flynn@hammerspace.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023015239.2163480-2-neilb@ownmail.net>
References: <20261023015239.2163480-2-neilb@ownmail.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

block_revalidate() calls write_seqcount_invalidate(&dentry->d_seq) and
only then sets dentry->d_fsdata to NFS_FSDATA_BLOCKED.  Because ->d_seq
is invalidated before NFS_FSDATA_BLOCKED is set, an RCU-walk open can
get past an unlink that is in progress.

The barrier in write_seqcount_invalidate() is issued before the
increment, so it orders only the stores made before the call.  An
RCU-walk lookup that samples ->d_seq after the increment can still read
the old ->d_fsdata, and so ->d_revalidate() accepts the dentry.  The
walker then waits for ->d_lock in lockref_get_not_dead(), takes its
reference, and passes the ->d_seq recheck in __legitimize_path(),
because ->d_seq still holds the value the walker sampled.  By then
nfs_unlink() has seen d_count() == 1 and sends the REMOVE instead of
silly-renaming, so the open proceeds on a file the server is removing.

Set NFS_FSDATA_BLOCKED first, then call write_seqcount_invalidate().  A
walker that samples the new ->d_seq then also sees NFS_FSDATA_BLOCKED
and returns -ECHILD.  A walker that sampled the old ->d_seq fails the
recheck and retries in ref-walk, which waits for the unlink to finish.
__d_drop() follows the same order: unhash the dentry, then invalidate
->d_seq.

Also correct the comment in block_revalidate(): the ->d_seq recheck is
in __legitimize_path() and try_to_unlazy_next(), not in
legitimize_mnt().

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
Neil, this answers Sashiko's second point on 1/9: v3 still calls
write_seqcount_invalidate() before it sets NFS_FSDATA_BLOCKED.  This
patch applies on top of v3; fold it into 1/9 if you prefer.

The window with the v3 order:

  CPU0: nfs_unlink(), ->d_lock held     CPU1: RCU-walk open, same name
  d_count() == 1, no silly-rename
  write_seqcount_invalidate(&d_seq)
                                        __d_lookup_rcu() samples the
                                          new ->d_seq
                                        ->d_revalidate() reads ->d_fsdata,
                                          not yet NFS_FSDATA_BLOCKED
  d_fsdata = NFS_FSDATA_BLOCKED
  spin_unlock(&dentry->d_lock)
  REMOVE sent                           lockref_get_not_dead() takes a ref
                                        read_seqcount_retry() passes
                                        the open proceeds

Your afs 1/5 also sets DCACHE_BLOCKED after write_seqcount_invalidate().

 fs/nfs/dir.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 53cd3adf3ffe..79331e0fa044 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1879,15 +1879,20 @@ static void block_revalidate(struct dentry *dentry)
 	/* Any new reference that could lead to an open
 	 * will either:
 	 *  - take ->d_lock in lookup_open() -> d_lookup() or
-	 *  - will check d_seq in legitimize_mnt()
+	 *  - will check d_seq in __legitimize_path() or try_to_unlazy_next()
 	 *
 	 * Holding this lock and invalidating ->d_seq ensures we cannot
 	 * race with __nfs_lookup_revalidate().
 	 */
 	lockdep_assert_held(&dentry->d_lock);
-	write_seqcount_invalidate(&dentry->d_seq);
-
 	dentry->d_fsdata = NFS_FSDATA_BLOCKED;
+
+	/*
+	 * Set NFS_FSDATA_BLOCKED before invalidating ->d_seq: the barrier in
+	 * write_seqcount_invalidate() orders only earlier stores, so an
+	 * RCU-walk that samples the new ->d_seq also sees NFS_FSDATA_BLOCKED.
+	 */
+	write_seqcount_invalidate(&dentry->d_seq);
 }
 
 static void unblock_revalidate(struct dentry *dentry)
-- 
2.43.0

