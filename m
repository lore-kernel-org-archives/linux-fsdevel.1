Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B940B6E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816879; cv=none; b=Re/HzMkC8HLNK/lQT12teCmhoN5AzU7ymXugh7sxylr6NtUUoiVQJ2+K4Y4n07bw/3CbuEzgfDxGvivZYpoSVJoh4JJistLKZkcpJmgeyNpc7jV1Z1YRB4cHQOJ6ZbfM+ec5ACYD6qeeRItdlEFNHs4RLWV9lcFVVReV8hnD3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816879; c=relaxed/simple;
	bh=omNxzYijm82b/MFSKfvcOiJLKxEC3VUl9i0UvBoDJn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucMNiq7YOyJUaubXl9Jn5QG2+GIgUBbBwo0orBHTFPIXeHeElQdAPoLF9h4GdK3FS2F/Dd0YQ698BaAIRUAfXoFHUlc438HIXx7OVRGCMDJpes8iLGlo5lrZ9Lwtx0WRY1guOSGzXCY+73Yo9PBzv4jeV6NLPEs7zy9C4H0zzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=fhwgdhRy; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fhwgdhRy"
X-KPN-MessageId: 15f4fa8d-7472-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 15f4fa8d-7472-11f1-b2a8-005056abbe64;
	Tue, 30 Jun 2026 12:54:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=7m0UikfZeZUSssDAR0qd7JW+Xm4SaIJPo/m9dfOFLlU=;
	b=fhwgdhRybL3NBh/Yx3pv8RlKrJAeqAYUpS24vcQ68NtiH4voSVeuLMi8Yi6cvS0e4iaM8rmjHBoXY
	 PLeO4+ZuTbPLlZsmLrNQb0oLoDoSdiybTT9h14S99Ts57ikA7iPqwgie11u0f1PjYBZ6TUHCBTfQZj
	 TLd0u2iOlHtsbiKLcaeH18JOPZB5WbCgUhvZnzyNN6YFZ20P2yLi2xb54AvdKKNgKFgd+1L27/T2If
	 PTxibGRV6FuSD6eqvd7wNQBTO7arjk4DfbDqsw+dGx4BTYr92VofNUV+Tuuf77O8Wu6Iuv1gaG1acc
	 Sqab60eUoJQsbcOfccwvmnBddQ2nfWg==
X-KPN-MID: 33|QDbCnPPZHbzcLW2RvVu3Q/zlqlrR2EgIIxf2aAXkL5kNoApCgWjAK2g+M8BHFba
 7MxmvMptkIwdcTRVdtvfPzfq+/5oLCGZW5KBY2aSemWM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|8AZH92tPRO4HB+e/IjjogVgRpgyNjoIrlOd8i09//I/WliKS2hdqcd1T+RsiBx+
 SrRkIb0qVgx5e8gtneFSsqQ==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 15a7619e-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:36 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 17/31] jfs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:46 +0200
Message-ID: <20260630105400.68459-18-jkoolstra@xs4all.nl>
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
->mkdir(), so OR-ing S_IFDIR into the mode again in jfs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/jfs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 442d62679262..9ce5b8ff91bf 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -223,7 +223,7 @@ static struct dentry *jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
 	 * block there while holding dtree page, so we allocate the inode &
 	 * begin the transaction before we search the directory.
 	 */
-	ip = ialloc(dip, S_IFDIR | mode);
+	ip = ialloc(dip, mode);
 	if (IS_ERR(ip)) {
 		rc = PTR_ERR(ip);
 		goto out2;
-- 
2.54.0

