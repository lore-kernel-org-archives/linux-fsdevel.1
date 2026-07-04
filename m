Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD23769E1
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183293; cv=none; b=Lo/sdMIS4ka+oM8klmpYuh6eFvrjEeXxFSISnQn3JkMsz4ihE+QE0RSFvy4t9pp4/RhHAbWTH9QbN+cNZDDTO+8gk+++vzjKD/NDvkdK19b8KaMH5LgkWN957+ay5TowNXP7hCJCVZXX/dSmBcFUHwvfeRQbjf63WKlRqHemzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183293; c=relaxed/simple;
	bh=F7L38lCf/OpLKbcGbmxAtmdyJiNzy26f8F4/Mi1lfGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJPt0cJ6AJaYq44POBZ81x2w4jjp2WUZRJxAtUCW0GXyxKC82hKPnH4KItJ5kbUHgbdXRbDrnTSxdwtZ3ihOo/nhWj9pubRYL6kNazgSGwkjszOx+OT9yZAQ0hghq34eybUGr8EENiBqMNjzodn4U+WvQlmvCvXQYLnOq7Iafxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=iC6h5PC2; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="iC6h5PC2"
X-KPN-MessageId: 3108d7a5-77c7-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3108d7a5-77c7-11f1-b2a8-005056abbe64;
	Sat, 04 Jul 2026 18:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Z8MFVZ5dMSGAHtKQiZ/I8XoLMKdyCwvjMjkCAQX2JMY=;
	b=iC6h5PC2Y7ADllK1oOWYGR+eL/Z+EclxvIlk4pv1v6ZpuKyMaQ8tf29wPpd/DuE5qLoD+xUF6gAna
	 3bZ0aOFV9QR2vwcRC4N3+6ddLXc76mNW5cZSzhJOBPjNkAFgqftmmwIIcaPIo0OSxWP4GxmXjy5DUv
	 yDV3HbVCZqYvP7eeTM2Pe3PDVkK3uw7jjWxYO+/NK4CpFSelXyBiT32CU/xA/BRs3OUsqhOu9/lpV3
	 GUGsp2w+fO2LkcCgHDLmNl48+785cEEiG2A2E6w/gYms/SZ9rMmIQjJrdrGCO4FD1XqbLXWB9cHfgd
	 uoOoXqM1kULRqaK7m1Bq1nmi4MJsPHQ==
X-KPN-MID: 33|I2dvfO+ITrRPdV0i96iQkC+05EFHfp88qjmYlW2ddw8JOm4oZxHMjxOxY0zQsZ3
 fWrZfReCW0HtKskjAaW+EeQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xPZaDSW55ANp7bPayp2GZIhNxCRp7ahFopKFmkMZTmeiCyydCAFoA5t/B/Lexse
 cCXmmyxju8G4UbMQiLUek1g==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 30c2c1cf-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:22 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 11/14] vfs: refuse O_CREAT for directories through a dangling symlink
Date: Sat,  4 Jul 2026 18:41:45 +0200
Message-ID: <20260704164149.3480051-12-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
symlink target does not exist, creates it. Refuse to create through a
dangling symlink for directories.

In lookup_open() a negative target reached with nd->depth > 0 was
arrived at by following a trailing symlink; since the dentry is negative
the symlink is dangling. Set create_error to -EEXIST in that case
(matching the errorno returned by mkdir(2).) Reusing the existing
create_error path strips O_CREAT for both the generic and
->atomic_open create paths and only reports the error when the target is
actually negative. Thus opening an existing target through a symlink,
interior symlinks, and O_EXCL (which never follows the trailing link)
are all unaffected.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 76916caa264d..030cac4fbe55 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4546,6 +4546,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						    dentry, mode, create_dir);
 		else
 			create_error = -EROFS;
+		/* Refuse to create a directory through a dangling (trailing)
+		 * symlink. For regular files this has been allowed historically
+		 * on O_CREAT without O_EXCL. */
+		if (unlikely(nd->depth) && create_dir && !create_error)
+			create_error = -EEXIST;
 	}
 	if (create_error)
 		open_flag &= ~O_CREAT;
-- 
2.55.0

