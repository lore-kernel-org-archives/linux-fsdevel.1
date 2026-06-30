Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC43F926D
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816950; cv=none; b=CxFIsP7h88uH0D/J68jpu+qONwHRkmC6OS5YB0bUqV9GYS5DLxPBHTxhmiqWEpyngTJmt3/bS2tWC8Ke4igiRwSD0B/F4aa0fVoB5h6dfH3VNQuOW9qrsqNqwZB4qTrnjNmd0JDrS62TkbhvbHKhK0yvsk3hzvyx4VCdIHSHSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816950; c=relaxed/simple;
	bh=jwqdcgW47ulv8r7Y9NR9XQuy8aV1DXACJZm3X1xGip4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk9wzYwQkxWlCjo7SoGMuarwSTKflaWSIGFAJsoMMm5pFrVIivCOkekVY+V3fCimgDE+13rXhkV2I+lAlQdKIljWgdHsez4x8WY8KDQdmYsGVsGcsgm4BfxNjxKvJW9dj/h03ys0XOOp8L5aiLWDtYtL4jQQO7Jqiadq9AYYZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=NjsY2fgc; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NjsY2fgc"
X-KPN-MessageId: 15310771-7472-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 15310771-7472-11f1-861c-005056aba152;
	Tue, 30 Jun 2026 12:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=HTuovgE1W4w+q85ct2oMHENyA8qMx/yLAbBs3WDOnJw=;
	b=NjsY2fgcDDWIu7KqRNiPfMdWlaTTMSd7GK67SKntjdLY5sOUFvflxNrTM4LXGdr8rIij4JLbc07b/
	 lfBtPrpnC4cB+0L5xEm6t6uXzgXWR4vugiotNRF70jj1mHr34Voshd/lKvrrj43K74pieHDxUH4yj7
	 bxLb64I8JF6xkAn/xlQouRhoHvp2Jgbazt4IL4uRkGo/5qHVrmpaXt1rvn6ymro7d9v4UFoEkDSxgV
	 FMwHHJDw7Hk6AfocBPytjRk4m06jLvBh0i3zvR7TB4NrO2TU7WcBXPZo9A2MPFsJLSmSKYQzg6xmsW
	 QNE5fiSX6WLkf7G/Yu2NtFbOACxlQtA==
X-KPN-MID: 33|qKOJ0vz71aRyBZSPKmE/o5SW0n8Rv9JAh2W2zmOIKJdTc3RzzYkHuDYNS3nYzpy
 sZ9Y8M5aRVEJcotu5Nd+jkQy0Ie78mCWQdmuOnwq3HrQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tYRpYx4e8XQFAqfXKshOSjgtfdpUAHEaBfGBfpu2A8cYDdDsuGerhNwFLqiITmL
 IVU1TT/xL+QjkXKkTC6KAeg==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 150e42c5-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:35 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 16/31] jffs2: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:45 +0200
Message-ID: <20260630105400.68459-17-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
->mkdir(), so OR-ing S_IFDIR into the mode again in jffs2_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/jffs2/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index c4088c3b4ac0..2b86adcbd8f4 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -462,8 +462,6 @@ static struct dentry *jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 	uint32_t alloclen;
 	int ret;
 
-	mode |= S_IFDIR;
-
 	ri = jffs2_alloc_raw_inode();
 	if (!ri)
 		return ERR_PTR(-ENOMEM);
-- 
2.54.0

