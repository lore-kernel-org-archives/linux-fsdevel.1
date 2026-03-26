Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21223504B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567301; cv=none; b=oTYabDdfuSEyyCvsdL6/QwK++LD/SJc2R096CtN+Ls5zneUaxJomEfFYSTRfb40hxmSjEBAQgqD+WLC0OOCZgaZ4kKDDhUjEtafL2fv9nnLDJxIOFwbueqCIY2rtL2MqrZECiCo40Ac5BcwBbj5jKASFhE/cXn73M26A/iOeEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567301; c=relaxed/simple;
	bh=hpbfVrehy2OjGPM+jJX1ohV94KpPjBKZvlND6YVVV40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKlWLCWOIri1YSvFVikZzKtVrAwECKGmVl/h3p7G4rrdjM7bvbMzICaeMrzly2tn+skBjgb312EBBRqy4/Lbs4V8vViulgIZD81D+O7KL5YUIE+h5n1ylz9JMx8Eh4/nLf33cBs9XUyeej/9j00/pqg5XnW+A1YMDMsCzIA0tI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDgp5RN4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDgp5RN4"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35c05d7e0e9so1386208a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774567300; x=1775172100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+mEOaggnyuWbQn7RlN5WCwkPLdohB+eIDOx+cSRQiM=;
        b=tDgp5RN48Jxr+or6rZRB2JA5T1vgXSMVpJZ2nSTsn6RLklZwLa+W+6UAzP0Yx4aJgg
         4hZpOZ4RxUPV6TSYNov8mIEet5VCk9+EANVJUz4u+kK0imvROCLPQ6xvZpiQD/DcjAtY
         R7PaTuS+410B22PAc/yO0ENZv6SvzAhRV182tiFFb0oGWHlKHOclxtL8q2jSUGY0vyKq
         8Y4y9RasapVsYZL6jneOz6KVH9nvR8efg1uG9V4M/DljA09LHdwPBhctjIoe0qXGhIIe
         1qw/Rvlg1eDRZT0xKG2xfEBZKrzcuXyNdncUCoNr8M90p5upzvizDP2apyJU92rhp9zD
         EzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774567300; x=1775172100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+mEOaggnyuWbQn7RlN5WCwkPLdohB+eIDOx+cSRQiM=;
        b=Zj/OSvr+UAnRfsrFKpQMv7IzyJr3wqNE+9qG6oyZFxlw2wFuB/5Su+f/m5Z4Wbr4mY
         rAXyAxQ/k1Ea48BLs8cRKOtorx6ejBbDbJlRR8auFFaxmMls4yMhL7XeK4zdyIZjKF4/
         m2P3nobmXS2aRrLyYPjQZHRsMFmQbN2SBxDjMpbZkbJm+ifsx/lDZi4Wu8mneiWmtgyu
         V4o0EDHXiVlRhtjERGE5v7s4PLD7xRT4mxrq83l63T/cic+MTjczLhb3rP9Tz8UWhvnP
         9t5H+dYPfr2Gr3W0LhJnd1OZ9QB48MchtOcLyuW96z6vyDGwTSwjq3zZoMAxdT5yel9Y
         ICFw==
X-Forwarded-Encrypted: i=1; AJvYcCVHhO/9aT2vPr3FemeexMrPCp8GneYzl1cunI2ZCGI9sqG/hqEIy3YbugpRoBpJknttg8eVwyMCuadysfWD@vger.kernel.org
X-Gm-Message-State: AOJu0YzHReUoGx1/F2sDqeXLi9Qr8kbymJRbXtHoV7BO0yCsiXh96YRu
	/iDjf21AxHomEoA6IHEqlHExav62AFkb2qkve2TTFPnmM29dafTJeN7O
X-Gm-Gg: ATEYQzxGsosJhDnbdMS8PViSXuiygxObH19zcNAylQFwcOSIwLsFSNvl/qBD+ELoE+a
	bs/9irV8uJN2I/kWxiaNCpDEk4mS3tUkoSXGqv9En//C7jwk3HM9OsiIsCV+zLc2QeFLUB4ixbJ
	OW38DZUM51gAyLpcM0S23+N2gT4Y2oBiIreKq5fP8L23E3utHJdcB44pEuL7fROoT9CRc8iGK5j
	4GD1PrGDdB5KNo6U6w6jjGbAzQA8SU3PBFIpbgFO7U6RQyckpbboB4QLwQgigUKzqejAWgssnso
	FBCnA2/kmdVZQR/voLebbZIv5P0KQSRV1aU8B6LsBZIj34iB4eD+FcDWunKBlj1+Un69LzQQCj7
	DoggyzvUt+QJKEk2DExWqdVSf0kEpcQ7A79siCAME47pfXJgko5lt5Z5jAdi3fmJi45ufmCTT+R
	MdeRfpf9ogWQ0AJvSs/cE2q9oL4vQ=
X-Received: by 2002:a17:90b:4f41:b0:35b:af3f:3618 with SMTP id 98e67ed59e1d1-35c3010eda1mr342185a91.28.1774567299618;
        Thu, 26 Mar 2026 16:21:39 -0700 (PDT)
Received: from hpxjwg3u.sm.local ([203.123.64.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a4c36fsm2794222a91.4.2026.03.26.16.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:21:39 -0700 (PDT)
From: Xiang Shen <turyshen@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Xiang Shen <turyshen@gmail.com>
Subject: [PATCH 1/1] fs: fix deadlock in insert_inode_locked() waiting for inode eviction
Date: Fri, 27 Mar 2026 10:21:30 +1100
Message-Id: <20260326232130.1891210-1-turyshen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 88ec797c4680 ("fs: make insert_inode_locked() wait for inode
destruction") changed insert_inode_locked() to sleep via
__wait_on_freeing_inode() when it encounters an inode being freed.  This
introduces a deadlock when the caller already holds resources that the
eviction path needs.

For example, ext4_new_inode() holds an active jbd2 journal handle when
it calls insert_inode_locked().  If a stale inode with the same ino is
being freed, the function now sleeps waiting for eviction to complete.
However, ext4_evict_inode() needs to start a new journal transaction via
ext4_journal_start(), which may block in add_transaction_credits()
waiting for the current transaction to commit.  That transaction cannot
commit because the caller's handle (in ext4_new_inode) is still active,
resulting in a deadlock:

  Thread A (ext4_new_inode)         Thread B (evicting old inode)
  -------------------------         ----------------------------
  jbd2_journal_start() -> handle
  insert_inode_locked()
    finds old inode I_FREEING
    __wait_on_freeing_inode()
      schedule() [waits for B]      ext4_evict_inode()
                                      ext4_journal_start()
                                        add_transaction_credits()
                                          [waits for T to commit]
                                          [T blocked by A's handle]

Fix this by replacing the blocking __wait_on_freeing_inode() call with a
non-blocking drop-and-retry loop.  When a freeing inode is encountered,
drop both i_lock and inode_hash_lock, yield the CPU with cond_resched(),
and restart the outer while(1) loop via continue.

Unlike the pre-88ec797c4680 code which skipped freeing inodes within the
inner hlist_for_each_entry loop (risking duplicate inodes in the hash),
this fix restarts the entire lookup from scratch -- the new inode is only
inserted when no matching entry (including freeing ones) exists in the
hash chain.

Fixes: 88ec797c4680 ("fs: make insert_inode_locked() wait for inode destruction")
Cc: stable@vger.kernel.org
Signed-off-by: Xiang Shen <turyshen@gmail.com>
---
 fs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index cc12b68e021b..8ecdd297c83f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1842,7 +1842,6 @@ int insert_inode_locked(struct inode *inode)
 	while (1) {
 		struct inode *old = NULL;
 		spin_lock(&inode_hash_lock);
-repeat:
 		hlist_for_each_entry(old, head, i_hash) {
 			if (old->i_ino != ino)
 				continue;
@@ -1860,9 +1859,10 @@ int insert_inode_locked(struct inode *inode)
 			return 0;
 		}
 		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
-			__wait_on_freeing_inode(old, true, false);
-			old = NULL;
-			goto repeat;
+			spin_unlock(&old->i_lock);
+			spin_unlock(&inode_hash_lock);
+			cond_resched();
+			continue;
 		}
 		if (unlikely(inode_state_read(old) & I_CREATING)) {
 			spin_unlock(&old->i_lock);
-- 
2.34.1

