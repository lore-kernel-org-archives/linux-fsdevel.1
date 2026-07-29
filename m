Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE011FB1
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286784; cv=none; b=CGSWfwGsjcivBKHPGQfdAkGqxDRxRGrHNw+F2HiwARX2vNrsnZWwsYJqyYkAL2f4J+qZ6PuuEqd1Uyxdm6PZ8T2TpbQs50OR9+BByTNQdB7fxpDKnAkrD8HzGxRSUFBQONqNEo60bJwK/z3Q9i/hU3Kxn4JyfsGCagua0MPo4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286784; c=relaxed/simple;
	bh=0KWF7l74NSCZbAciJn0VhYbORBxGH+vyhWCqMZH8cRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cbQrdPdWpcYuzfvpEa6Xyd6EOcHbbjTDojW2143yoh9wfmVP+ZgdOtFvQ6Xtqmca6H2jG6PWzTQkIZbojT2OWdWP/tpcEQFEtmJla4iULQa/Mboy3ZP27laictO3I5NOa/ivBQQnHsbIL0t5VIbHXGuDjyiXzFqr9Cw1q5HPSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv6iX0Ys; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv6iX0Ys"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso305941f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 17:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286781; x=1785891581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6+QL24j4d2zpvhuMtnoDkWU1oAuvMuECjOV2EZkZcU=;
        b=Tv6iX0YsEE1+h94f4YZ933PmwHuxS+TYiuXMF6q/yfQ5AB/xMF/hGoNoO5q299rT5N
         cwWH4Y7dV4g0xtsgYM8TqtmvkufaWTLE9F21FqbtQMUp0gLvqnXP7rhkQwRmzS1X2qQr
         O2HVdy2+gFbRXNI5Uy1/L0/XHxNqMmPflvg6VAuJJ5SDsEmtufa6TrYmZNmEX7s2C1Dq
         vank32z9q2ehxUjrAYSPDWwjGfCGwpHXqXxQjKyKZL7edLu0c0BBZ+d503jSxfhOi1Ew
         rY6p3y6pjjKcsZg0ICLqyt6adVQ3QnCfVORQyEl6YzvIZuqi2wMY2cnOkQl5AYO6eNKB
         DUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286781; x=1785891581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6+QL24j4d2zpvhuMtnoDkWU1oAuvMuECjOV2EZkZcU=;
        b=m5Ip2Ut4C8LVTxyudSP1DzAGz+K7rPPVaRWZzh7NOJRgE7SGsplpckvNlUdaFc7X/r
         tkpvCNRECde4/rjsKGq/tWduYcjCDDacHcjOcApmy2PDHPos5kulIGABkAD114SaZrY2
         67+t85JAEvGMImQtWcOa3QfwS5fv/tV+2TU4i9qFotir0voaoUOW0hpRGSr9oXsGDQ+t
         KRLdmanhKHbk474hpsMobdO//oYieCv/8yN874G5ix3TyCg4kUNH7bi9v1rBFiDWc3s/
         kd/42TgDxQP/XN+xbAYq9Zls0ELJ+nCzDYpkrWTuChvHZUfoutWoBYQf8TL9CHRgpHRr
         hRQg==
X-Forwarded-Encrypted: i=1; AHgh+RpAnGd0ZnDSWn6zsoALQZoALEbJFy520FNuu4AB6yuqSzTYLoaZlO1NMLgNVLMsoPKlyFJuUTpEWMkqeuUO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxhl8ZLq1Hh+wE4xMXYuPpRrWkjGkYHIHFB2JDelvO4C1JStpx
	JBtf8FvcB3eAZItawqufBn7RsetSnKrR+QnCO49IEk9m7pUj+sPZEzUc
X-Gm-Gg: AR+sD12VuueNGUTCZ9V3qI3qcCrkiHmAkI9A0pjb6mVVTJKSU2iVmbFoxNZli5kXKE/
	mbTjAkdwECrviFw6FOz5+XE3csAMtQjZB2icuRzr5y7hfAAPvVb8aQzKWAIYrKWcscJYFsMzNK/
	q5c5lycVRf4dNesZWylMABWle8J51HXAGdtC8BMG9N1PJzsx9D6/dxiZDbjv50vUg8Lnzj6WOoA
	DawVZPh6CHgGckgVcV+H3eUKZZsWOAnwctNVLpojJCBuH80ZUUZxhnc+MVYibDJkC0dKc/XTjG/
	lyxGnOJL9CKwjvjcUobK/ugmKRoxTJhrXuVV254FXsZcbNvy6dgm82RqlUgql2jl7oHs1b4TJoY
	QM2cNFOyJ/wJe/DWQh9TOXJWJLfthSmf8TF6pYnfixf5I1/9kMMoiZIS9vjmrwBcrAs6/zgeciQ
	fSrWbVZt6FpFKRCgGrmXIfKZBgmNOXLvT4HGjNineAWBQhWHk8yrdbFxVgfZDmbsgOqahRcOGNQ
	OjqRZaImLvnX+LNthUA8PdTxRUh+V535Hdrxpf3FqIKGPEhM941dm6xh0N5P1q/FTc8DLKCsgqR
	oZKOuazwyNrMcm4A+DZW1tQfdgAOxV7hkyWbZxz44qfB4is3UbZoAUvrCKqmhRL9ZWgn6Lojazf
	d/k5LSQ==
X-Received: by 2002:a05:6000:1861:b0:47f:80d1:be0a with SMTP id ffacd0b85a97d-47fb1e924ccmr5560631f8f.14.1785286780935;
        Tue, 28 Jul 2026 17:59:40 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b323-2b01-0d98-9fe8-a4cd-78ab.310.pool.telefonica.de. [2a02:3100:b323:2b01:d98:9fe8:a4cd:78ab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6abc703sm3598526f8f.9.2026.07.28.17.59.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 17:59:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] dcache: keep shrink_dcache_for_umount() making progress on busy roots
Date: Wed, 29 Jul 2026 02:59:33 +0200
Message-Id: <20260729005933.15858-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e9895609cb7f ("wind ->s_roots via ->d_sib instead of ->d_hash")
moved secondary roots from ->d_hash to ->d_sib.  Secondary roots are
now d_unhashed(), so __d_drop() returns without removing them from
->s_roots.  Consequently, d_drop() in do_one_tree() no longer
guarantees progress through the list.

If a secondary root has an unexpected extra reference, do_one_tree()
reports it, but its final dput() cannot evict it.  The root remains
->s_roots.first and the loop selects it forever, holding ->s_umount for
write and repeatedly reporting the same dentry.

Before e9895609cb7f, ___d_drop() special-cased IS_ROOT dentries and
removed them from ->s_roots regardless of their refcount.  Commit
9c8c10e262e0 ("more graceful recovery in umount_collect()") deliberately
made busy dentries nonfatal: report them and finish the unmount rather
than BUG() while holding ->s_umount.

Detaching busy secondary roots from ->s_roots restores the previous
behavior.  A permanently leaked reference remains leaked after unmount;
if the extra reference is only delayed, its final dput() may run after
teardown has advanced and hit poisoned or freed filesystem state.  The
current code avoids that late cleanup only by looping indefinitely under
->s_umount for a real leak.

Restore that behavior by removing each live secondary root from
->s_roots after taking the temporary reference.  In the normal case,
dentry_unlist() finds ->d_sib already unhashed when eviction occurs.

Fixes: e9895609cb7f ("wind ->s_roots via ->d_sib instead of ->d_hash")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    The reproducer mounts ramfs, allocates a fresh directory inode on its
    superblock, calls d_obtain_root(), and deliberately retains the returned
    dentry reference before unmounting.  The fresh inode ensures that no
    existing alias is returned.

                            d_unhashed()   reports   umount returns
      v7.1                             0         1              yes
      7.2-rc4+ unpatched               1     13013               no
      7.2-rc4+ patched                 1         1              yes

    All 13013 reports in the unpatched run identified the same dentry,
    confirming that the loop kept selecting ->s_roots.first.  With the patch,
    diagnostics match v7.1: one busy-dentry warning, one busy-inode warning,
    and no list-debug corruption.

    This injects a pre-existing refcount bug; no in-tree filesystem was found
    to create one by itself.

    Detaching the root guarantees progress for a permanent leak.  If the extra
    reference is merely delayed, however, its eventual dput() can run after
    teardown has advanced.  Leaving the root attached avoids that late cleanup
    but retries indefinitely for a permanent leak.

 fs/dcache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3e9af9de7074..2aff15ee07fb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1832,6 +1832,9 @@ void shrink_dcache_for_umount(struct super_block *sb)
 				wait_for_completion(&wait.completion);
 		} else {
 			dget_dlock(dentry);
+			// A busy root survives do_one_tree(); unlink it so the
+			// ->s_roots loop keeps making progress.
+			unlink_secondary_root(dentry);
 			spin_unlock(&dentry->d_lock);
 			do_one_tree(dentry);
 		}
-- 
2.53.0
