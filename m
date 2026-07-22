Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DD37E5CB;
	Wed, 22 Jul 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722065; cv=none; b=fXI3ak7ml06sKQadteoYLdwoAYqHEdND+AmOM2i7cPj7xuKeq4VKd0+20BzZr8igWBMqZeS7pYdyuFoUWhM7TpA0eNoR1DY9M1bIl2DD85W4vJkBxxxZMIneVVwjCeqrqi+Ajma3xcs45bgSTTKRxNY6TIQFXWur/VL0a9LEde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722065; c=relaxed/simple;
	bh=j1fv3ubYMQxHWbdJeAXUDfnq1dS85Nz79rza05Qv6NA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kYqQx6AYsK6wZ5586YRkCkuv/3tOZ2tmWKxZpMkHKldy/Tm6RbLzyt20w5EYnE+THUHouOK02USxrZRS3jCzDkNvOeIZAStfr3i93cS9Kjx8LWFnnkKBhBS6LfxECoaGLvmVJ9FSjJgbdS9mN6ilnmH7rIcmC1pFCVlfqRuzRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwdG69lD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwdG69lD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5631F00A3A;
	Wed, 22 Jul 2026 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784722062;
	bh=w9XfSAempmTrZ6+aOuQD40Eim589+DM7s67a3bnbeh0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jwdG69lDVjSDlRGh2a3z+1HaMsBR+yIDuRIQSqQm1F7pZ3AYbTDu26H2xbxK12HVA
	 ZUa45EmQB6cOBj3HWr9U04BqgtgTtITJMNduV7UiHBLLd1zKoCWkfNBBTvbUp/ZZH9
	 4dfApvNyn5LWlAciaUw7L89DkP9Ewiu54FTtwRDsO+s1CGSoXiiTZiV2qDaQUpnIbQ
	 0ADzeyEZp+mMgrpmz/Ddd9fuQrV9NiCW+12osCKtOdQk5XyPkPAOkL/tsDe9gYy4e9
	 OpZgNu22fQpUYqS31coHT/zcDWDxlLkl3eSOZOUxYE7uklhtGRM33aeT1gd6/5GUpL
	 1NWEMqCgHTIhw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] pidfs: preserve thread pidfds reopened by file handle
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Li Chen <me@linux.beauty>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <ks7xfhn7pzzm267bcfo725xwqa6famsv5yulmzgqt7hjdmepep@zm2dw2djd7yb>
References: <20260716052726.1032092-1-me@linux.beauty>
 <ks7xfhn7pzzm267bcfo725xwqa6famsv5yulmzgqt7hjdmepep@zm2dw2djd7yb>
Date: Wed, 22 Jul 2026 14:07:37 +0200
Message-Id: <20260722-esszimmer-umsetzen-nennt-ed5fc604300a@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4495; i=brauner@kernel.org;
 h=from:subject:message-id; bh=j1fv3ubYMQxHWbdJeAXUDfnq1dS85Nz79rza05Qv6NA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlbOp2ePXsb0opb1qYXa/bgtnvmR7GrM9TuWVedlZc0
 LYh7jtjRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEXCGBlW+m2Y+SH+vPjCwBcf
 Gk8XKp9t639w9MwW7rwzj1VuVc7ex8jwNNDz2bdL8nydF5WXs8cvr77SONes4cMJtwcxRpvbMus
 YAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-16 13:11 +0200, Jan Kara wrote:
> On Thu 16-07-26 13:27:22, Li Chen wrote:
> > PIDFD_THREAD shares O_EXCL. do_dentry_open() clears O_EXCL after
> > pidfs_export_open() validates the flags, so open_by_handle_at()
> > silently turns a thread pidfd into a process pidfd.
> > 
> > Restore PIDFD_THREAD on the opened file, matching pidfs_alloc_file(),
> > and cover the restored flag with F_GETFL.
> > 
> > Signed-off-by: Li Chen <me@linux.beauty>
> 
> Makes sense. Just looking at this code, what about PIDFD_AUTOKILL (aka
> O_TRUNC?)? Reading the commit introducing it 07c3ef58223e it appears it was
> never meant to be directly requested by userspace so probably
> pidfs_export_open() needs to reject it. But that's unrelated issue to your
> patch so feel free to add:

Good point. But pidfs_export_open() is guarded by
pidfs_export_permission() which does:

#define VALID_FILE_HANDLE_OPEN_FLAGS \
	(O_RDONLY | O_WRONLY | O_RDWR | O_NONBLOCK | O_CLOEXEC | O_EXCL)

	if (oflags & ~(VALID_FILE_HANDLE_OPEN_FLAGS | O_LARGEFILE))
		return -EINVAL;

and so is safe. But I've added the following patch on top which also
splats if that is passed!

From 99a859485394eca8cf6271de09ae72ac3b846bda Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Jul 2026 13:56:28 +0200
Subject: [PATCH] pidfs: add pidfs_dentry_open() helper

Both pidfs_alloc_file() and pidfs_export_open() need to force O_RDWR
and reapply the pidfd flags that do_dentry_open() strips. Move the
common logic into a helper.

PIDFD_AUTOKILL is now part of the restore mask in the file handle path
as well, but pidfs_export_permission() rejects O_TRUNC, so this is a
no-op there. But warn nonetheless.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/pidfs.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c20ffd747ff5..695215aa2a58 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -915,6 +915,20 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
 	return path.dentry;
 }
 
+static struct file *pidfs_dentry_open(const struct path *path,
+				      unsigned int flags,
+				      const struct cred *cred)
+{
+	struct file *file;
+
+	/* pidfds are always O_RDWR. */
+	file = dentry_open(path, flags | O_RDWR, cred);
+	/* do_dentry_open() strips O_EXCL and O_TRUNC. */
+	if (!IS_ERR(file))
+		file->f_flags |= flags & (PIDFD_THREAD | PIDFD_AUTOKILL);
+	return file;
+}
+
 /*
  * Make sure that we reject any nonsensical flags that users pass via
  * open_by_handle_at(). Note that PIDFD_THREAD is defined as O_EXCL, and
@@ -939,18 +953,14 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 
 static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
 {
-	struct file *file;
-
 	/*
-	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
-	 * O_RDWR as pidfds always are.
+	 * Opening via file handle may never raise PIDFD_AUTOKILL. That can
+	 * only be done at task creation!
 	 */
-	oflags &= ~O_LARGEFILE;
-	file = dentry_open(path, oflags | O_RDWR, current_cred());
-	/* do_dentry_open() strips O_EXCL, which encodes PIDFD_THREAD. */
-	if (!IS_ERR(file))
-		file->f_flags |= oflags & PIDFD_THREAD;
-	return file;
+	if (WARN_ON_ONCE(oflags & PIDFD_AUTOKILL))
+		return ERR_PTR(-EINVAL);
+	/* Clear O_LARGEFILE as open_by_handle_at() forces it. */
+	return pidfs_dentry_open(path, oflags & ~O_LARGEFILE, current_cred());
 }
 
 static const struct export_operations pidfs_export_operations = {
@@ -1114,7 +1124,6 @@ static struct file_system_type pidfs_type = {
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 {
-	struct file *pidfd_file;
 	struct path path __free(path_put) = {};
 	int ret;
 
@@ -1132,16 +1141,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	VFS_WARN_ON_ONCE(!pid->attr);
 
 	flags &= ~PIDFD_STALE;
-	flags |= O_RDWR;
-	pidfd_file = dentry_open(&path, flags, current_cred());
-	/*
-	 * Raise PIDFD_THREAD and PIDFD_AUTOKILL explicitly as
-	 * do_dentry_open() strips O_EXCL and O_TRUNC.
-	 */
-	if (!IS_ERR(pidfd_file))
-		pidfd_file->f_flags |= (flags & (PIDFD_THREAD | PIDFD_AUTOKILL));
-
-	return pidfd_file;
+	return pidfs_dentry_open(&path, flags, current_cred());
 }
 
 void __init pidfs_init(void)
-- 
2.53.0


