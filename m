Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297427;
	b=zA5ZSOTkr8t0RJjfkL4/DXcaka8p7iV7AaD1Yy3ny4dhnO3FGLpjH0osfSnrSqNUilTx
	 QcWMeIR7H1cX1RJUd2YHvAwhMaKkPu3Dhxji/iCVE9UnIXUOkjFNapU0/ocxH68Iz33do
	 mGL05mhMyuc5DxfFKCgWPVlT2ftmWWWkIgypEVKAdMfrVt6oZWrJbfN6ssh9BeevZa75Q
	 rsEcPgDOkIZIbe3mIHeYpPlTUH1i453+ABgTVlE0vLExecZpRhv8sdFa9DK/X+6B3gruu
	 H4rr0PLGiJI27OFnVgB9JG2LcuSTrHkytQTU7caUfdYaXU/ivT03FBIug3VJuiV6wPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SzS3inKuIzObQRIJP0XLNfoskd/GgXHCSXyF9Wdht4c=;
	b=JqFRnvkt/1q+yrSG/3432u2T+dCJLlbqPWVnkrTA7kp8TLvXZAxpTe9pqUJOwfGx2vcJ
	 +sIoc9Qn/n4my3LanyiEMUdLs7RZqmJdYY4Jst5uTt9B/5wplBr2AtIMSnHiLJw5V1JVS
	 EA00FGRB89onK/+FysYb1v3zilrSRduHmQ4WD829O7XIV0gDwIv5MAwa6Wqytd2EsiGXi
	 I+FCfeyGT50UXEm4qA+RTpUCx08IS0j8XB/4R/7hkK8Zsged/IdfsZpo6cKsWp41hDO1O
	 ZdM3OJWw+TigNergW1WhAo4n2c+4sGfxcU0OgV9a3O2CL273iZCidE8rZBjgTDgj/mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=HCQaAvkJ;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931860A3803
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9931860A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=HCQaAvkJ
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8253bc5a613so1623569a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297425; x=1793902225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzS3inKuIzObQRIJP0XLNfoskd/GgXHCSXyF9Wdht4c=;
        b=HCQaAvkJ/BlYzUKBgPx6FYAly7bYB6v2l+zGLRA8QBqfS0Q+3X6beLcpk8M243IQa5
         GNSSRWHaya5Me9rh6sTlLJjWW0B0wctrcnNbOqA8LKi+AHSi0ayF0bwhr02D+MhFHNj/
         nLatmgmrp8PX7qscpAZe5r9ARzedXvt54XWHfHAuiuI9sq2Jj08Nha93kVmGwzLsBr1U
         XWF+G8a2+qp5HHdYB5P9S5kvM3aHRms2ylSPwmxzUK5AZG1cUIT31e41r2lU12MWavMk
         ruJxnlrj9EsSbmxAiE3EtmYDq07FLHj3UdSsS2EeMZCusmQq53jUls9KgQ5Nc44H2TRj
         IvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297425; x=1793902225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzS3inKuIzObQRIJP0XLNfoskd/GgXHCSXyF9Wdht4c=;
        b=UQ0U1Lcm1HVxoBEe7eTrF/U1WKQDJPLwCJ+o6pqgywVRkjJ9GsDmCiEenS6AMUAWg9
         mnAZVWG6PsrVwPTOP2MEPqxkHIybE+BReF7bbnS61hYvtq+j3IrbFkHsWcdUz5gzZJyf
         85CK4Qi3sdqL2VlFSJtmJTOWnKgcMXyyMPwOHoTEswkVunwRE54U7QqOUDUfAxfm+ySq
         IN00SSsYowNOGBp7fNBY2MeC49CEtZVKp0RvzLn4IkFBQQ3uzY83m/NqRwiHeX1WcCCP
         SoTT56xe/vaVCMpmr14kGQ/9T/TL0W518A+jzRB0HMeGMnZYqTNKdfQdhY53KrPW4RuJ
         4dQQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4qsLTKXKNvOf1WQc6JLbgBgRLxnGLaQ8eR9TjvXWzDH3Mb7aV/OZG1Gm26U8lgJEQHcY21bVRNAqtq4wN@vger.kernel.org
X-Gm-Message-State: AFq9FYL3V8zh846adtoAIzOcrT45acovFuer5lpUB4TMPVOcVVH8hv91
	AoCRPZ2leK2v2Dkpnla5U5/FAG/Gcavxnz1Odyliiy6OW/YULWnFhVjI6v81NQ5WUP4=
X-Gm-Gg: AYBFou28HlMGaH0U5X+9g9tO1kd7LTxpOd/XLl/1vNXjKqQcRq0JQIZYpdUGcp6vSOx
	qB/jMxDBNk8fWji7wPUWEQ6slWHsmDA2WU/C5Mozg3lPdhQXZxRyyd2QxkgemmD9ApSh5P9uzvS
	iNZdBPlKkMt+XBW/qBuqXeJ42DGoXMTOIWJW0Ybh5qEkNoWePXwbSQnOs8hXF772Bk5J2aNpiKP
	6BK211N0RfD5bY1I/9o75uDvMgNceuk4Ln3lAx6rsX5Mx2SSBLiyBkaV5xWNE5EhOqwZk4p1B7e
	1K2TjUfJUNYCalMFLZ/2c6i8NsEfvSVzpXw6TNJu2+bAt4VRFCZsniuNIlXD1/jWVIA3vIsyqS4
	wLnJIsY6cYOV0xYcasHIpUjfi/AU6WtoPraiC1Z+O9fvLWNiQrBQAy3IiSUofkMTsNFMiSGFApZ
	BGbpnNZp17ZswV5g9S6PlqDYtzzQTWkaEEZAC8eJkM2Hus4QhUB2vs2SmuVJ6HJxzZ9aoOxLv8+
	5OVPjK2YUZE5uUz83RNyzNJ17IcRHwOvIprqKBYYNMp5qLKhOU+EGicEGSWYaLVh8wj5l6FTJ4p
	pLNG7+PQMm3TCKGWf7eQprv76SvqUIoDoFFoELXwdI7J01RXnJMS6LggKGIFJ9Uu1rMuxvY+
X-Received: by 2002:a05:6830:4120:b0:826:1ccc:8bb9 with SMTP id 46e09a7af769-85ab7040645mr5227606a34.6.1793297425401;
        Thu, 29 Oct 2026 11:10:25 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d351e9684sm187806a34.3.2026.10.29.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:10:24 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 11/12] nfs: look a name up again once its removal has unhashed it
Date: Thu, 29 Oct 2026 12:09:56 -0600
Message-ID: <20261029180957.387138-12-jonathan.flynn@hammerspace.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
References: <20261028041023.3738553-1-neilb@ownmail.net>
 <20261029180957.387138-1-jonathan.flynn@hammerspace.com>
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

An open or lookup of a name can wait for a removal of the same name made
with the directory locked shared, and is then ordered after it.  When
that removal succeeds while the waiter still holds the name's cache
entry, the entry is only taken out of the cache, not emptied, so the
waiter is left holding an entry for a name that no longer exists.
Revalidation can then accept it: an open without O_EXCL is sent to the
server for the removed file, and if the client holds a delegation for
the directory, an exclusive create of the name fails with "file exists".

When NFSv4's revalidation has waited for such a removal and finds the
entry out of the cache once the wait ends, have it answer that the entry
is invalid, so that the name is looked up again;
__nfs_lookup_revalidate() now reports whether the mark it waited for was
the shared one.  Without such a wait, an entry out of the cache goes
through the usual checks, as before.  Its holder may be unable to look
the name up again: overlayfs revalidates the entries of its lower layers
itself, and an answer of "invalid" for one that a transient error took
out of the cache would leave the overlay reporting it stale until it
dropped its own entry.  A lookup that took the entry while the removal
was in flight but finds the mark already clear is not covered either;
it overlapped the removal, so the old entry is still an answer it may
be given.

This relies on the VFS taking the entry out of the cache before it calls
->unlink_shared_done(), which clears the mark, and on the wait reading
the mark with acquire ordering, which pairs with the release in the
clear: a lookup that finds the mark clear, whether it slept or not, then
also sees the entry out of the cache.  A removal made with the directory
locked exclusive, and a rename onto the name, can clear the mark before
the entry is taken out of the cache; say so at the wait.

Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/nfs/dir.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0b6de87030..1f255001a1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1889,6 +1889,11 @@ nfs_do_lookup_revalidate(struct inode *dir, const struct qstr *name,
 	return nfs_lookup_revalidate_done(dir, dentry, inode, error);
 }
 
+/*
+ * Answers -ECHILD under LOOKUP_RCU while a removal of the name is in
+ * flight.  Otherwise waits for any such removal to end, and answers 1 if
+ * the one it found was made with the parent held shared, else 0.
+ */
 static int
 __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 {
@@ -1898,15 +1903,28 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 			return -ECHILD;
 	} else {
 		void **fsdata = &dentry->d_fsdata;
+		void *mark;
 
-		/* Wait for unlink to complete - see unblock_revalidate().
-		 * smp_load_acquire() ensures ->d_fsdata is read after
-		 * ->d_seq was read, matching block_revalidate() which
-		 * sets ->d_fsdata before ->d_seq.
+		/*
+		 * Wait for unlink to complete - see unblock_revalidate().  One
+		 * load, as there are two values to test.  smp_load_acquire()
+		 * ensures ->d_fsdata is read after ->d_seq was read, matching
+		 * __block_revalidate(), which sets ->d_fsdata before ->d_seq.
+		 * The acquire in the wait pairs with the release in
+		 * unblock_revalidate(): a waiter that finds the mark clear
+		 * sees what the remover did before clearing it.  For a removal
+		 * made with the parent held shared, that includes the unhash of
+		 * a dentry it took away, as the VFS calls d_delete() before
+		 * ->unlink_shared_done(); nfs_unlink() and nfs_rename() may
+		 * clear the mark first and unhash after.
 		 */
+		mark = smp_load_acquire(fsdata);
+		if (!nfs_fsdata_blocked(mark))
+			return 0;
 		wait_var_event(fsdata,
-			       /* one load: there are two values to test */
+			       /* acquire: pairs with unblock_revalidate() */
 			       !nfs_fsdata_blocked(smp_load_acquire(fsdata)));
+		return nfs_fsdata_blocked_shared(mark);
 	}
 	return 0;
 }
@@ -1914,7 +1932,7 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 static int nfs_lookup_revalidate(struct inode *dir, const struct qstr *name,
 				 struct dentry *dentry, unsigned int flags)
 {
-	if (__nfs_lookup_revalidate(dentry, flags))
+	if (__nfs_lookup_revalidate(dentry, flags) < 0)
 		return -ECHILD;
 	return nfs_do_lookup_revalidate(dir, name, dentry, flags);
 }
@@ -2329,10 +2347,28 @@ nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 		       struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
+	int ret;
 
-	if (__nfs_lookup_revalidate(dentry, flags))
+	ret = __nfs_lookup_revalidate(dentry, flags);
+	if (ret < 0)
 		return -ECHILD;
 
+	/*
+	 * A removal made with the parent held shared that succeeded while
+	 * this lookup waited for it, holding the dentry, has left the dentry
+	 * positive but unhashed: d_delete() empties a dentry only for its last
+	 * user.  The dentry no longer stands for its name, so have the caller
+	 * look the name up again; the checks below could accept it, since
+	 * with a directory delegation the removal stamped it delegated.  Only
+	 * ref-walk waits, so this never answers 0 under LOOKUP_RCU.  A dentry
+	 * found unhashed without such a wait is left to the checks below, as
+	 * before: its holder may be unable to look the name up again, as
+	 * overlayfs is for the dentries of its lower layers, which it
+	 * revalidates itself.
+	 */
+	if (ret && d_unhashed(dentry))
+		return 0;
+
 	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
 
 	if (!(flags & LOOKUP_OPEN) || (flags & LOOKUP_DIRECTORY))
-- 
2.43.0

