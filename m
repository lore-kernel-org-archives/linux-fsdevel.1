Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377B409105
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816876; cv=none; b=Gde2XjVLmEc1JxlnKonNc7OUu5MjavTrW/JY8vVoEpUbm24zx3n/Ojlst3AnWQPx0dR62vjF5HP3/MI6pcJLI/FgrGrhC+w9k6A5xt9WqLQlmg+brk2lsMlseqvEyZLg1krMYa7i32NJhnTRjwsRg1ayG6Hgzc9cDLDU3mUKOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816876; c=relaxed/simple;
	bh=HAU233QeZTC0b1Lo7nACqut4DT4hCK85Gfl1JRlYW0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuBjgpe/NMfp55WIWifzsiT2kOo7U6W3vqs8+p6y0ZOpCT6+hyryn6qI9BQuuImZMwP+Dwu3sZQTX/erO5LUTZ4MvgF23K/5whe1YXEAiuyDzPhz/vnCjGYRh05OsLXaD0JRAZjXZMx0946R0tmzcNBr4wBjDnVgrVFUmffJoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ioBv/UpK; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ioBv/UpK"
X-KPN-MessageId: 13e08605-7472-11f1-83b0-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 13e08605-7472-11f1-83b0-005056ab378f;
	Tue, 30 Jun 2026 12:54:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=xYKreFEWhn8HgQ9QkpwGnmiB5mXO4z2I8ZHSNPW3Fd4=;
	b=ioBv/UpK8o2AB9Hsnz9gSK7s4hwe0q2FJIhwax0zhQU364cpXq86x8i81xC06gxImrXBZZvMU0hlP
	 QazttJo7SDuHK3cKgpjzh1ixX2T7q+3VAcrFQJzPm/AWT/tCNvWkZHPqqcrI6oD9u9pA/pztteojny
	 zR6Gh2TcMz6RYEXdISWZUuw9sJ+r7Sq3MdJ2hqEvTjBPIOF4O8A/Z+D5TL0cupYVVmap5pY10g5XKw
	 5VpVoaK41LngMQdfjdy6M9MJFHxz28L6UpJThu7SoVBkjkrGqaCCIqwQgmcu2CkFdO9UWhzE25fGGs
	 /JXmJewym6nq0TrOo0v8meV3hkwGP1Q==
X-KPN-MID: 33|+3mOxBBvWWxJVt48HGQlzQCf4KZrYSunjaSkpvAK5ym32pb9mrt4CQSx8TrVeXn
 yFZJEAOCiKGdHDruen1Rmi84igDowzHQnZ+9ZXsuHrvE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|/9WyPoyJHNaRKrtEFayp2W3wNJce7YxeNtTovrcUIRXStWWB+3ch6Hww3uCJfqQ
 IameDGHRkKXcddIa4gpx3iA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 13c384ca-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:33 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 14/31] hpfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:43 +0200
Message-ID: <20260630105400.68459-15-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in hpfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/hpfs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 353e13a615f5..b57dee5a0660 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -105,10 +105,10 @@ static struct dentry *hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	if (!uid_eq(result->i_uid, current_fsuid()) ||
 	    !gid_eq(result->i_gid, current_fsgid()) ||
-	    result->i_mode != (mode | S_IFDIR)) {
+	    result->i_mode != mode) {
 		result->i_uid = current_fsuid();
 		result->i_gid = current_fsgid();
-		result->i_mode = mode | S_IFDIR;
+		result->i_mode = mode;
 		hpfs_write_inode_nolock(result);
 	}
 	hpfs_update_directory_times(dir);
-- 
2.54.0

