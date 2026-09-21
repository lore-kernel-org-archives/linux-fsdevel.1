Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5B4AA3E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000157; cv=none; b=PenhgEZPv2lSlHBRK0IjIy8qjUo8t989/7RQwPeQ4J6DKcpmsOtA51JoKxgEQWK+A3LsQqhy7fSxVOxZTFGjFbH+R3aUBBm/5/POnJ+kiYyYbIMgRSur6ZMY68L1QP73dtsFTwNC3QFX8H7ft6YBags+r+oUrFRDBJcnNqMdqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000157; c=relaxed/simple;
	bh=fKzi4NKaCiUku+3AUXODlPJCc7va425Vhk/dtvNkCwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l90j/IwHH70cKL+DTJSwy6n7MMLf2d/TdBTykfl49mTX44WjwwM137ff5yAvtYPDte3FQO57tn5JpbVCvqjKNzOUzsy0trnqzOYJL4QKPYawwxcCphPKQSXD/vDT3cUlYc6GTVURHM5WMr3diuEJdHPEjkzbP2NcKkutD7X3dQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJswiRY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJswiRY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E521F000FF;
	Mon, 21 Sep 2026 14:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000155;
	bh=ZTabm+J3Rl2RfN9OfSWUMj1gge6GQsXxaIjQLMUCHEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EJswiRY4MQUH9JDUNSG76kkaftRefltsk3ojjS0m8aAxOK0peIMyUsFbkBfDUoQhF
	 hPI4t8f0PsBNDvlnP9h4Sm3gZshWnEtuPz4fg5OVjOd97QhmIdFQYkIyZrwuGriMdX
	 1U7exbf3sncDxtoN/I3jpZuLTFBt7fJkhMa4H0Lc+jX4gx3U42MmBTfzNWFY5LKbV7
	 2qkG5SKyHcD+gaVUbWpVQSHdoVjS/Y0NMGVqroCfk6DJBD2xbVtPQuVop5y0T3AQyH
	 Xq4Ii8xYHoGGojzY4epEShNrrfCz9G/0RuZJtuSImqIzn/NfZQ/LoiHamjMhK+WU7z
	 9FMpwZ75c8s5w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:32 +0200
Subject: [PATCH 04/10] file: let dup_fd() drop everything outside of the
 range
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-4-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fKzi4NKaCiUku+3AUXODlPJCc7va425Vhk/dtvNkCwk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOFRjO79WXatM27Vu+39Fx/+LT1RqMv0uXnxF6nvM
 5bUHr35oKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiVqYM//1f6EtaMUvazVZc
 vK1DKWr5gp8KHh7u067dnBalN3n33SWMDA0+qx892XpcLOC2wQq2Z1z/Ylf6BAs9OrfNeWXsooK
 5NzgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add FD_RANGE_EXCEPT. It turns the meaning of range around. Instead of
indicating that the descriptors in the range are the ones that are left
out of the copy they indicate the range that makes it into the copy. All
other files are left behind. The clone only has to reach the last open
descriptor inside the range.

Nothing passes the flag yet.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c               | 15 ++++++++++-----
 include/linux/fdtable.h |  6 ++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 6234548be88b..ae7d021398dd 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -367,19 +367,24 @@ static unsigned long fd_range_word(struct fd_range *range, unsigned int i)
 /* Bits of word @i that dup_fd() leaves behind. */
 static unsigned long dup_fd_dropped_word(unsigned int i, struct fd_range *range)
 {
+	unsigned long dropped;
+
 	if (!range)
 		return 0;
-	return fd_range_word(range, i);
+	dropped = fd_range_word(range, i);
+	if (range->flags & FD_RANGE_EXCEPT)
+		dropped = ~dropped;
+	return dropped;
 }
 
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
  *
- * range is optional - when close_range() is asked to unshare
- * and close, dup_fd() leaves the descriptors in that range behind,
- * so the cloned table only has to reach the last open descriptor
- * outside of it.
+ * range is optional. When close_range() is asked to unshare dup_fd()
+ * will leave any files behind according to the range and its flags. The
+ * cloned table only has to reach the last open descriptor that is
+ * carried over.
  */
 static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *range)
 {
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..d6c6c7a3400d 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -101,8 +101,14 @@ struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
 int unshare_files(void);
+enum fd_range_flags {
+	/* Leave behind all descriptors outside of the specified range. */
+	FD_RANGE_EXCEPT		= (1U << 0),
+};
+
 struct fd_range {
 	unsigned int from, to;
+	enum fd_range_flags flags;
 };
 struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);

-- 
2.53.0

