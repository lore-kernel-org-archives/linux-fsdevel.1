Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7824BD365;
	Fri,  2 Oct 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949256; cv=none; b=laquFl6hQ4kyi76GbsKfOWNRGsczx9jHJwuQZ2+dVZjd2kc+T5ueza4YXkOUumTD9CdIwkZd+aEPrsafkzO8zn3GFX6HvINNv0j0V4kGwF6zrfq6NnDvvkYw+bl52t46e2RvUJMrW+eCPHaPXS43SmXWjQRSbakdJEEbiL4v87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949256; c=relaxed/simple;
	bh=g5H3twB1giHU4VV2s9Q3noQ3TMsM+DsUmR4KOWzvMME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDa2bFKol1WiKhYDa4HC2Zb08qSLjxr7uGBg0EKxLkYM39Y8DmfaEbO4jbtfNgO5iIlFDUYhae1HGErIJVuef9IP0PdCOuvp4QSxVJp3/3YZxkIOfRgBn/M2xvYfNI1uXEePRgFgjwgt/hfENJ3L0KdHeVzv33iL7TbKpWw+F+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnwGxvub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnwGxvub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD9C1F00898;
	Fri,  2 Oct 2026 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949254;
	bh=mqtMv1vFMKCpiKR4ge+ik9fR9VXrb/f3dlQ8hJCAD84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NnwGxvub+SIeSl1V/Qop0onQJfI7XZNg0KULuQbGxs0Ch8b/McfM0dg0onVsBn/rI
	 MbIeEli8eSJhLGRrVK8dggQixeHLhWhN8ltU952X2RDGx0Xo5rf1M4sgQkSgOZqpEQ
	 Ii3FiYXXn90vpzx0KxlWy5PkIDesp4R8pC0aJiVzNINZXN8XY2+UWRA/sy7v/CIzsW
	 nTEuR9wzR4Isdg9uK44gje2EH5Z+vy+/mDZIbFoPWVbrSRLmjLsiiC/gHvTB/KyaTV
	 YfUs9KtgiNKxXKqoH3SW+UBxgQwJyfprjUTgDv7bGui2Zkd5B+HGExfzlUfCiFWPDH
	 2rFyWchqHGkSw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:47 +0200
Subject: [PATCH 16/21] fsnotify: let a filesystem refuse marks on its
 objects
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-16-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2602; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g5H3twB1giHU4VV2s9Q3noQ3TMsM+DsUmR4KOWzvMME=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x5lMrduXn7j52f1c9yT+YqTd93ZMu2b9KqZJ//UT
 Jqhf20je0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEJogw/JUXnhOeaLtruec7
 f8uix8sTA4qmaLG6vL57bc6OECsBjnZGhp1B2+xfeU8ofrlKWk07dOnkVp8zVydOfKr1170la9Z
 8PX4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't let nullfs be watched. fanotify refuses mount and filesystem marks
on SB_NOUSER superblocks but inode marks of inotify, fanotify and
dnotify go through. The one inode of knullfs is the root of every
kernel thread and the following patches make it reachable from
userspace as the directory that stands in for an unmounted mount. A
watch placed through one such directory would report the opens through
all the others, across users.

Add FS_DISALLOW_NOTIFY next to FS_DISALLOW_NOTIFY_PERM, refuse a mark on
any object of such a filesystem in fsnotify_add_mark_list() where every
backend ends up and set it for nullfs. There's nothing to watch on a
permanently empty and immutable filesystem.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/notify/mark.c   | 4 ++++
 fs/nullfs.c        | 1 +
 include/linux/fs.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index b2640d836a71..d17628580a57 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -903,6 +903,10 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	if (WARN_ON(!fsnotify_valid_obj_type(obj_type)))
 		return -EINVAL;
 
+	/* the filesystem doesn't want its objects watched */
+	if (sb && (sb->s_type->fs_flags & FS_DISALLOW_NOTIFY))
+		return -EINVAL;
+
 	/*
 	 * Attach the sb info before attaching a connector to any object on sb.
 	 * The sb info will remain attached as long as sb lives.
diff --git a/fs/nullfs.c b/fs/nullfs.c
index 40aa228bd81a..55a04f2d7761 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -61,6 +61,7 @@ static int nullfs_init_fs_context(struct fs_context *fc)
 
 struct file_system_type nullfs_fs_type = {
 	.name			= "nullfs",
+	.fs_flags		= FS_DISALLOW_NOTIFY,
 	.init_fs_context	= nullfs_init_fs_context,
 	.kill_sb		= kill_anon_super,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..784fa20217c4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2296,6 +2296,7 @@ struct file_system_type {
 #define FS_POWER_FREEZE		256	/* Always freeze on suspend/hibernate */
 #define FS_USERNS_MOUNT_RESTRICTED 512	/* Restrict mount in userns if not already visible */
 #define FS_USERNS_DELEGATABLE	1024	/* Can be mounted inside userns from outside */
+#define FS_DISALLOW_NOTIFY	2048	/* No fsnotify marks on its objects */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;

-- 
2.53.0

