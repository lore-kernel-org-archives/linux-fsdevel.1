Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B34244667
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070361; cv=none; b=tn1ZDC9CglUlv4CgP5EZFcKW9vFCX7LKFF/V8KdqC+/M/4A2gtGi9iOZYSu7zOr2yql7IGHl0R0Ul6EWYEb8V6UxDtesr3eUpnPbFGTjEUlEBI8tOf2c1Wp18G4yMok3vkouRwO9BrecHJ4BPMjqdMuEcjlgM2XZONY50SnwxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070361; c=relaxed/simple;
	bh=td5GR6kUYJaocprzw26pnEkmGbw0T4WNVQCP9yALRvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjdhfnlWnOWx/LNz0weW4o9dtOX9dzwO4XCxqqTICCjQmhPci9q4hfo59wyoqtMRvL9zmj3E4TLhArEAvf8Vr215KLdgVhWYWXx5wSlrUhUNtzU7nMG5T06gEyKK/KV+WoZn/iNwuc5KBkzyCR6AQSWKmlJDdWsrnSIGhJdI0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IPr8dVNb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jqObcntZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IPr8dVNb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jqObcntZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D8E41D0010D;
	Tue, 14 Jul 2026 19:05:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 19:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1784070355;
	 x=1784156755; bh=PJngaM3HfC9CnzsO5rUDlwnghrNEP1nqkloXnSUon3k=; b=
	IPr8dVNbzp2CiDJh2+XxL//4qgjomPiY3k8PppoRhdbVQRjH4H3tWnu60jU4tqjx
	px1cboyfTLCpo25IpXc2TVONBxGZEc9ePpu3Fseuf/kb7DwZWTjSB0Lk+gF7L3Pb
	xGGhnSdMFm5iHoLvKICEvDlgmJlZuBE6eRqOfcVFi2WD3lJXEjm1oWJtHvCwPcQP
	fZEGisVnSVpJVXr/IWoRmEWOCGw2jRik0xjpP4GermZhi2AfxFMLEQHx/b9VDHaD
	fPXVtPX2rIXgy7GX5gm2LX6hcphfXoSJKKGpA/X9RN69Vjgo26p725SHoHADMXj+
	iPZ1dyKmyX/H2vXuAHkV1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784070355; x=1784156755; bh=P
	JngaM3HfC9CnzsO5rUDlwnghrNEP1nqkloXnSUon3k=; b=jqObcntZ2CIp9uKFt
	BznWgHjDrKgEI4YNyaB99z4d4S2Nhn6olfNZZF7Kahe0DUP+hfHeJf497RJXPfzg
	BOodBitW9x2/r9pLgTfYpRBWB24M00QJUKM8GAawgTxsUra4GeqWwjjXIbM95MqK
	+LuHX83iy7/ULFzFSYftDf2cKynagYT1kNUuos/CVGkyvqncll16ypl80uUvGAuu
	tlEAjXz3B/7s7Jziofk9vghFDqy/k21/ACQOF/0Jw+0Z4el6GJiNJaz2kZkn5pJY
	AgmYFb1mdGNcOnorbt54mGfcjrSzfQ6wC3/FrmEQMN04YB4IHAcn5zJZsV7IsWa/
	O/ELQ==
X-ME-Sender: <xms:08BWan8_R8yCNX_hawd-XYJT3hifTSTb59MXWJos2usqLesgB44eww>
    <xme:08BWahprr_5bfnkj2F1Wh485zA_XZXAIWrQqOex65iDVEf3t1ey9idOOkAwLscFL3
    9fNlUKz7q2cz73ZFFon8glMxlJLOLdsrKCqUrZN2ZryBNVgJw>
X-ME-Received: <xmr:08BWanU3U0ruzwXKwHHJvZ5QptotSGYX901BzZRlh0zPBHdJnOvGf2R34OWicvetdhR1iYRiCLH_Ew5ChLLaljJo14BmzGQ>
X-ME-Proxy-Cause: dmFkZTEKtPkulQhhkOCGBpYYlx1h3n0BQsr2H4Q5Jyrwtd3tgAPbyK2kGHjJ5oUEU+ztuQ
    zjN8lRwLF0HQ953KfrsGos58bkiHo6DuHBrkkGn3YK4tcGR5ptbUu9mya2ie6dQiJ7biUZ
    o7KN+hmYIRUVQpn2DphRT7NUNAwPKnoBhxD5JoYOSa3cGcYev033T1QkKDCkaya8x9hQbp
    i1E3q7rp7bRmzTE7LZrDJFqNOcbZMU7UkabwcHaxGpllM83GJtDD97GB1WsU7BcqvgtPK1
    3Y2wq9WJz+jt0HWGiguWM2ImmyhaSfbfEpSrrvzkbl5nJDodLvRSODUuFGSLBhxwXVCBK7
    NdncDFqKLJy3xCrhONluIpAiIIKbg6mWS3X6A1A3yJzwlJwm32MZtaVBuILEZm5ROScV01
    i/1t+/7EWeFXIIaCbpouLx5uMDBEAWXmoo6wIuLP695BLVmazNjVqidbqj53Afxihj/wi8
    66j9zzqcZTXw7wrHVZaHDr1nSmq2WCWXLNneGdF/jLC6Yt0WiRqUqm+gmwo3XwpDx0mLKH
    WtLbmx+uFt6sOSTkU0E848+G7+NJ+V328YCuRC0GTXNsGpLlE9MD8p4ARYH56Pexpe7MbQ
    W0AdTJEBvH9ErG41s/g0B0lDujrvreBwXyUzddXQtGkVPZ6L5D03ydYgk9Ow
X-ME-Proxy: <xmx:08BWaoAV4Ufc1A4MFvnRv8d2KpVxzzHV6_hbiMfcmoagfSpl0PhMXg>
    <xmx:08BWaj2XFIoSRhHNqDm1P5TLSZZzJZr6kW67XaZVw8EGF0YAF-c8mg>
    <xmx:08BWai0CVwPJiDlDboxtNHpoWrJh41vzEugBwyAoSyqc4OKXBjCYFw>
    <xmx:08BWagB6rC6XRXtL-XY2nfQUIQbgTk51dhplfIhBvfM7Tmwr4D6HIw>
    <xmx:08BWaqBVf4YX48FkpBsbRYLdjxplt1InW7cJC9nUsVZYAiH6DYQsfssE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 19:05:53 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v4 2/3] VFS: move delegated_inode retry loop into lookup_open()
Date: Wed, 15 Jul 2026 09:04:13 +1000
Message-ID: <20260714230534.776886-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260714230534.776886-1-neilb@ownmail.net>
References: <20260714230534.776886-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

By moving this retry into lookup_open() we no longer need to pass around
the delegated_inode pointer.

Various variable assignments need to be moved out of the declaration
block so that they can be repeated after the "goto retry".

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 55404fe0e269..cb33a01d16eb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4397,17 +4397,23 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  * An error code is returned on failure.
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
-				  const struct open_flags *op,
-				  struct delegated_inode *delegated_inode)
+				  const struct open_flags *op)
 {
+	struct delegated_inode delegated_inode = { };
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
-	int open_flag = op->open_flag;
+	int open_flag;
 	struct dentry *dentry;
-	int error, create_error = 0;
-	umode_t mode = op->mode;
-	bool got_write = false;
+	int error, create_error;
+	umode_t mode;
+	bool got_write;
+
+retry:
+	open_flag = op->open_flag;
+	got_write = false;
+	mode = op->mode;
+	create_error = 0;
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
@@ -4505,7 +4511,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
 		if (error)
 			goto out_dput;
 
@@ -4539,6 +4545,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
+	if (is_delegated(&delegated_inode)) {
+		/* Must have come through out_dput: dentry is an ERR_PTR() */
+		error = break_deleg_wait(&delegated_inode);
+
+		if (!error)
+			goto retry;
+		dentry = ERR_PTR(error);
+	}
+
 	return dentry;
 
 out_dput:
@@ -4586,7 +4601,6 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
-	struct delegated_inode delegated_inode = { };
 	int open_flag = op->open_flag;
 	struct dentry *dentry;
 	const char *res;
@@ -4616,19 +4630,10 @@ static const char *open_last_lookups(struct nameidata *nd,
 				return ERR_PTR(-ECHILD);
 		}
 	}
-retry:
-	dentry = lookup_open(nd, file, op, &delegated_inode);
-
-	if (IS_ERR(dentry)) {
-		if (is_delegated(&delegated_inode)) {
-			int error = break_deleg_wait(&delegated_inode);
 
-			if (!error)
-				goto retry;
-			return ERR_PTR(error);
-		}
+	dentry = lookup_open(nd, file, op);
+	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
-	}
 
 	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);
-- 
2.50.0.107.gf914562f5916.dirty

