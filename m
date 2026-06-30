Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D372623
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788746; cv=none; b=eBWLRLJ0asaU4/k8mjLHozG0JOJQvrzvfSBGT4bBlblYIGMStJOTJaLDk4qE3KnwjbD4m0NNSy5Av7zCgPmxqWfh9/kdQ0gs58W0EsLsUN1ugNDd/B4U6hbeEnh8Y8KC7MLVaDqfsRNhoqOpa3Q8kWPkEhtqqQDFmVCFMItEwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788746; c=relaxed/simple;
	bh=gZGEgMQsqYkk4U6xVt2LXnjcjO41Y9xmH3s6kEZs9wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLK1es+a7eG6SbMXJCXUcbPO04rZuCKGPSPYb1ouKvnMWa1uhHC2Hd1+uV+5gH+55qj5XZcXUK5NhAC1xm2VLC3L78txRgDHtUFSL3C5zXN6+UDlciigjI9DHuuTsC+aAjznQ/K0wp6rJVk5TjGZP8HH/+dLRquTAnbVVfB6frk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK2Wto9U; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK2Wto9U"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c858961a8efso1504494a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 20:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782788744; x=1783393544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYUwa5SWJODh41lHbkqVdEqGxK3t/Ss9xv0IBj7fNXs=;
        b=BK2Wto9U1eqqv/T1g5gqR+0ie0JpU6NeQywmujWghsSQdMDXIORyvw+q2NZvdlpPDQ
         oSi1j5ZmcgxjZXwRKUxBcxM6IowoVtUUwQ9GTA8LltjUtK4SVQzvT0PCZspsVWYXqoUG
         jshsvcA5ldlD7m9gIDy+5FMwkYUVfT35RL9DljebV3dtWVdeCNp4RnSwWcL7tLZGz8Ry
         heQk9n4k/Kt+fJuTSw6lXiCTT+VVbLLCSIjnX7CEYjmvTMg5a94zj+cD44KFQPcf0LC4
         BW/R3Ujhipj1PvkAFEeFGVQihIpHu32FdAcMMvFewnTxeyjihSHLbxkwnzGWDs/SQGeA
         lzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782788744; x=1783393544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYUwa5SWJODh41lHbkqVdEqGxK3t/Ss9xv0IBj7fNXs=;
        b=kRPaEc8OcDUZdHS+wZUNbimkTU/mKEgZhYjXngPD0V4V4ouSM+jjnDrMI7UQjqLy2G
         h2ZjfZr9KaiZb82haNxvroOQwPXllfD1MEV/kz0Jys6mSTW+kRoK09SyrcAWX1GhQpX2
         FtrwcL3zdQd99Bc6UqTLpFOPlw//8T3zhqm1OCoSBqC4vBrhnDR1/vgHJ7+zsJPBLJN2
         tjOzEgw+KtaNx59aqARUy29SBd+UZ4JC9iBMDAXYGF8yLTPqC6nmp8Z19fPX8Hoh2aRG
         mpDMvlG/bJk03UsUYjeEp9mmSR1Gx2S8IHoEzUxIqmXi+1ahinW931I0JXGuU2L33EEP
         J4/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8sscinTV0X6i5hHrDLJbxoHSGpwp+wYL1XTYpUOwCg25KTZSPxnav1Yesvyx2WpzrVoFskOqPiw2uqg2Gk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzh/g0gyZveAqXqnj+MZJlQ3jZODqNQnroauzyURO920NqW3kk
	ubXwLEG1J1LGZilgz5akSh5qWZ1W77DF+JvC+9KSlr0PhBlNG7cmT5r565nYq6sL
X-Gm-Gg: AfdE7cmujGMP531ne0wrjTrfffQkjQDOrLEyTIJzZArT9rCUjsf+kNQms7WOrYdIqgV
	zJB2aozD287GEU++NGDb7yjAOxhLvvN3kOkowHfNPMpVgv2rMuziF84bsFIM8ZRWi9Q9D4OjanU
	9Y2uwhKzfAePyf7OO1UOZC8myYlnV+VJz7AoDZKJA+Po9Q7iEW+DvoH6lNh/fOZrLViUHEGwlHe
	1ph1E7sslYpFNowE4xFhIL9S5TV1un/NG/ROwWuDTp+/YLRwuj+BpzP3z2rr6lZjOy4IxcpHcJx
	xXojFuq2oFZEKvNWLi5Q1CymHpEWPqw2kKCumv1XU3UJ0Z12y3jhLKsuLOcd5xjViBe5uNG233p
	uagDBTvetUHa/dKsDO+sz/z+El8uU259HgIZImcHgrLiYxVczTQN3tnh+GL9tqL0=
X-Received: by 2002:a05:6a20:2447:b0:3bf:866b:b74a with SMTP id adf61e73a8af0-3bfc5273c06mr1526316637.35.1782788744402;
        Mon, 29 Jun 2026 20:05:44 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95aa99sm638053a12.17.2026.06.29.20.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 20:05:43 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: syzbot+cie60057db19604ba2@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	hch@infradead.org,
	jack@suse.cz,
	jbingham@gmail.com,
	jkoolstra@xs4all.nl,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	syzkaller@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot ci] Re: minix: convert to iomap and add direct I/O
Date: Mon, 29 Jun 2026 20:05:35 -0700
Message-ID: <20260630030535.3309854-1-jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: 6a42024c.9dc7bc9d.3393b4.0006.GAE@google.com
References: <6a42024c.9dc7bc9d.3393b4.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

minix: add the same dentry check as ext4_get_link to minix_get_link

It turns out that minix_get_link does need to have both the sb_bread and
the sb_getblk paths, like ext4_get_link does. It working with just the
sb_bread one initially was deceptive.
---
 fs/minix/namei.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index e245f55a68ff..a4caaa3f7c9a 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -393,12 +393,23 @@ const char *minix_get_link(struct dentry *dentry, struct inode *inode,
 	else
 		blk = v2_block_to_cpu(*(v2_i_data(inode)));
 
-	bh = sb_bread(sb, blk);
-	if (IS_ERR(bh))
-		return ERR_CAST(bh);
-	if (!bh) {
-		pr_err("bad symlink on inode %llu", inode->i_ino);
-		return ERR_PTR(-EFSCORRUPTED);
+	/* This tried dodging the dentry check that ext4 does, but it turns out
+	 * that it's necessary after all.
+	 */
+	if (!dentry) {
+		bh = sb_getblk(sb, blk);
+		if (!bh || !buffer_uptodate(bh)) {
+			brelse(bh);
+			return ERR_PTR(-ECHILD);
+		}
+	} else {
+		bh = sb_bread(sb, blk);
+		if (IS_ERR(bh))
+			return ERR_CAST(bh);
+		if (!bh) {
+			pr_err("bad symlink on inode %llu", inode->i_ino);
+			return ERR_PTR(-EFSCORRUPTED);
+		}
 	}
 
 	set_delayed_call(callback, minix_free_link, bh);
-- 
2.47.3

