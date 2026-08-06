Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA084854E9
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035596; cv=none; b=s0qyg/hQ507dK6Da0+8x5xKxzWMZXdL0BOeTSj4swQzbZEom0UH84kCWLRQDUENTOVU/a3RDok01KjnPZkOvNN+/7eQQgQL1ZPiKWTvzak8cOv1W6qY7agjqaJ3dpYdb77dWLNLQcBinF2/HHf/xVAJcQon+/K9+TaP/A/NOqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035596; c=relaxed/simple;
	bh=PhUfiLl4o8/gnM5dBdAr9/CI3mtr8neFPCeerCnHCbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXB5pTG4bHskYbvW66AMyJN4lfaI6i+jdnJHLs+9aEleNmb/yDKExrqYKtluAPsSl8CBeiIV7ob7IuHC9Omg2XC3oSJTP7O4IcMpB290zZNhg/owADQdnfCoMAn8D40lboXCY9WhoQFu/R3jfut1JMd0FLcT1Hxmaq/bff9vsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK9FazpK; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK9FazpK"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so1679461e0c.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035594; x=1786640394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0eDfGNL18OJWRoQDXpl4mokl45SZAvTsQakbJs+ewI=;
        b=iK9FazpK4YT7CI/a0908Op2Wo+SMHFr5IcWGldEOkw0g0Vox3sVreDirnyg/dxtMU0
         gW85+Bpx3hkC+xU/FrHIVnDFdW34dHo+HXI48f0DCxlSUo35WrRPSWEfAA+SYmnLbDXp
         Nu1eu9oWwpjwORQtH/uSf6dBIwGrxv/S8PiFdekbqIWvELMz9BzbWbNpucDj14fxow5F
         rSSmDu39oQkBjwLAMXw0Mt58OhYwU3U2/ncLkH6vX4c/P3i+IhbvliyCwiE0EkrFQZ1q
         pJrNTtApqq+hGpHlvo//W1F3z3wSZhUhfLkPdM8gA23YuGjr+u/1ip3JIFoaHJq8kQp9
         T6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035594; x=1786640394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0eDfGNL18OJWRoQDXpl4mokl45SZAvTsQakbJs+ewI=;
        b=hkEq6Tc0YtWYTAQ6T+ZAG5/a1DtNiUqO0vbOwKw1uWtjnZL+dTt8a+FeenEj7obRjV
         XVoUL/WWpyEOZP1rm/VrXihLFE1SmRY2u26pxUY0CUqK1eG33avLmAJHtjB7QpKyezQK
         XWFxI9HdlLPJJNVtzTlCxSm8mvS0c/Jamoxn/z8EN4vHrULQg08v/usBwRQmX+mnz12+
         1YXBHcSe3Eyej7bGOqmjTwSIMO7Xa5RLMPF69itoZi6GL7A7AnS8YTxDTBOSVjZFVVQ8
         STMpgPNRuGD0GOq2CFc/i23qBxB6gdt2etn8QNsIq8MFplSQvHg9nD3ReYKFKQ7FZb4C
         VwGQ==
X-Forwarded-Encrypted: i=1; AHgh+RriOK9sCt6+5fYfUhPCrGp8dGEfoQ2EFw6GhQ6Wnv/RHwQWSxwwEfc+uju1BVZ5sSFGpMG7Vw7wnWMWUVtD@vger.kernel.org
X-Gm-Message-State: AOJu0YxAowyoIc1NyhoPjJVfKiWRbt0XicYtMfNvMSUz8gb2HP8cxLNs
	7el7txRqknuW4f3z1b3May6b5WV122ec9qIkd/ys44S5j+hAa1c3Zjq9
X-Gm-Gg: AR+sD12vJwOlTUgxXogmtwiM0i4cTlj0QmAQMLPWDtKK3+M/0xkRCyTS1/fIGnW6fx7
	tSLlb+6lrtsFy9eZB6+1Ws9qSDMSeRqw9K+2+vkg6o2cJ8naMDWfhiK9qe7znTv7ceLuQTssaD5
	vlZpxRa9Tz8pFDba0VyNWyQ7qHjRxnMQZ8VCJYbzATie2o45OvrALzVIeo9ijT+GT/2HW5Icks1
	orZ1kEwkQ5O5m8LzXza0ycO/hC/Vwen1MLJzynGU6qDv/5fzktrjas92UQE5OSNRteKmsliVyp+
	mjskbt6yiIQUIFVlKNXgR5inO3vEJLlbLuTAoUvTzIutX4RARr5MlT+kT35dg/aMVe+D85MqWVU
	WbeQ2xQTZcsF7aym0tpUXdxhy7ikxkNaUkk68F3uIsYQUx++VOZzg8s6LX50rQYzuS8mtuLtTOG
	YFPf2xBLOsnNC9DbHfqypedk88Y8cvFKrn/jbQyd/7KBKCgxdMnhAYJ0HaO3OOJnZi4C2l/Eww6
	FE62dg=
X-Received: by 2002:a05:6122:8b8d:b0:5bd:ecad:8f80 with SMTP id 71dfb90a1353d-5c3f9e68046mr593995e0c.2.1786035594156;
        Thu, 06 Aug 2026 09:59:54 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:53 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 13/21] ext4: check for a metadata write error with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:36 -0400
Message-ID: <568e57d184da17041872fd4b498f31dd6259a4c1.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two places detect a failed metadata write by testing !buffer_uptodate()
after waiting for it.  That relies on the write completion handler clearing
BH_Uptodate on error, which this series removes: a buffer whose write
failed still holds the data the filesystem asked to be written, so
declaring it not up to date is wrong and makes callers re-read it.

ext4 already does this correctly for the superblock - see
ext4_commit_super(), which tests buffer_write_io_error() - so this brings
the other two into line.

In __ext4_handle_dirty_metadata() the old test also required BH_Req.
BH_Write_EIO implies it, so the pair collapses into one test.  The new test
is also strictly stronger than consuming sync_dirty_buffer()'s return
value, because it still fires when the buffer was written by background
writeback and that write hit an error, which sync_dirty_buffer() does not
report.

Note that the failing write does not clear BH_Write_EIO, so an unrepaired
itable block now reports on every subsequent sync of that inode rather than
only on the write that failed.  That is the intended behaviour, and matches
what ocfs2 has always done with this flag.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.c | 2 +-
 fs/ext4/mmp.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 02b066299164..f338d6e3c29f 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -413,7 +413,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 		}
 		if (inode && inode_needs_sync(inode)) {
 			sync_dirty_buffer(bh);
-			if (buffer_req(bh) && !buffer_uptodate(bh)) {
+			if (buffer_write_io_error(bh)) {
 				ext4_error_inode_err(inode, where, line,
 						     bh->b_blocknr, EIO,
 					"IO error syncing itable block");
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 7ce361484b38..4b18ddef468d 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -49,7 +49,7 @@ static int write_mmp_block_thawed(struct super_block *sb,
 	bh_submit(bh, REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO,
 			bh_end_write);
 	wait_on_buffer(bh);
-	if (unlikely(!buffer_uptodate(bh)))
+	if (unlikely(buffer_write_io_error(bh)))
 		return -EIO;
 	return 0;
 }
-- 
2.43.0

