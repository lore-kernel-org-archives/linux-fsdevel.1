Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39193CF960
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701719; cv=none; b=bvv1oTB9UJIIsxMC0DftKIQ6BlVorXIHc4VO4ydp/dwQzndAnAMfmQPWZIHRxfwiLdm0S7/L9YpRbZHBu9DwP0BD7npgEuXtq+U2R1kcSm8woZuRi9IkYpdXfNX6kAss/WrIDnVw8H7yqyzDF0wz98DQBdKa4Q3pU7+p4PPlcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701719; c=relaxed/simple;
	bh=dxWo5Dg9JCf5/XiY+3vXgdjZ9J5/Nb+V1DiRQcwjLJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYzXSPnUgNZiVAJasFPHfP1ECuTV8g3MUXeUtcZQLWcE44zdFoKQW+YcEWEOPX65UcXaTEbdcdVKsOwc6VD5akI+2402Z4HJdMPAqQzka9YJuTqk22XF+s9OiSNOW7rVhn7R4BZvlVcdvqz34ygE7UOCWwbOLXpJp1QrXdIPEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=t0sjOKk/; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="t0sjOKk/"
X-KPN-MessageId: 3ff206c9-7c7e-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3ff206c9-7c7e-11f1-b2a8-005056abbe64;
	Fri, 10 Jul 2026 18:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=tgLEUqN3eyFIKH8Kh5sXTONzDSLVMzZNmmtEIiwOT/c=;
	b=t0sjOKk/+cFSPI2UjCkvkzRWuiw29BxCbimmdKNHlUY3iEfnvNehXkhEpVAF0Y6gUG1xWP4zUupSp
	 fsf5Yauno8/51TRKAcqzcSi26AWkUd83HuXcVJyhCCc5FWrLKPc8bK87Q6bq8W7lRyP9ZIjAzR6W/X
	 dR9m3dqL3bFzH+Is4z6VhnJMa53+8YLPAoLnxX1h43GtJEGqwhIFD/W7w/bfg/7Pw5HiVatqUUncLd
	 8Wf9IHLnBlUGzYXGACUOFkCv9BrLoUnryE/8fwwPmGRDuxf2scNAWm4M/FBnqlUzjJhLybfl2/5Czv
	 QWAxmrH8NQUV9hwZpFFvXPrBMCrrhaw==
X-KPN-MID: 33|05G7S5y2hL+oCSWMLSowtt2M5ndWgXHsdPqA4GJZRp10L5kZOGqCDyiqGWquQZI
 vgrL/0PeY0+KFmAG38ocIww==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|/fiYSMeCkcL7FpaLC1R5li/LA2+if/lClZbunrf7frRIcF8rQyl5LmUE8c5rU7a
 PXPkhCJLkjCgLi5qucXluJw==
Received: from daedalus.home (unknown [178.229.235.145])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 3fb1b635-7c7e-11f1-91ec-005056ab1411;
	Fri, 10 Jul 2026 18:41:50 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 1/3] vfs: move create error && negative dentry case in lookup_open() up
Date: Fri, 10 Jul 2026 18:42:31 +0200
Message-ID: <20260710164233.827744-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710164233.827744-1-jkoolstra@xs4all.nl>
References: <20260710164233.827744-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

O_CREAT is stripped when create_error is set in lookup_open(), so when
lookup does not return an inode, the case

	if (!dentry->d_inode && (open_flag & O_CREAT))

is always skipped. We can get rid of this cognitive step by handling the
error case first.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 19ce43c9a6e6..447eda7cbe34 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4491,6 +4491,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		}
 	}
 
+	if (unlikely(create_error) && !dentry->d_inode) {
+		error = create_error;
+		goto out_dput;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
@@ -4510,10 +4515,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (error)
 			goto out_dput;
 	}
-	if (unlikely(create_error) && !dentry->d_inode) {
-		error = create_error;
-		goto out_dput;
-	}
+
 	return dentry;
 
 out_dput:
-- 
2.55.0

