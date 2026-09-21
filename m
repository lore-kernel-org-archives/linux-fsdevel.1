Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034154A8FE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000149; cv=none; b=LPO3lPDHMkxC/cnlnEaWx4Mgl+eRZvqT0Ss4yZmAbuYt8hvSgYwDu2IHHT8EAEAL7HcozZKsxXDuoHN/ZFZz3FhHis0JQZ8KIHts7qp4oH0P+L89BWyTgZR65powJOLiLja8MrxuX/1rECEkumz87qrPG1NuNJUqsZ9KJBSI/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000149; c=relaxed/simple;
	bh=qfZZrpNXmc7uzlP3zUqkNroYn3k7wqMIb6r2z8S5Rdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JG2a2Fcx7dyPwcB4RE1BwChBpzl/a65usyO7Jex+sbx0yVPw+xZW9jQP/gTnjwoYdVDbKhHf4sZaqIfyGzm6alqfTOPWTVYl8tEzMp9e37hm2BJNK1eFeZNWD0+gtHmk8kJ4jputWs6geCimsOPtuNmH3GNuSfAAIazrjZK/bis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGgvw0/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGgvw0/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4291F00898;
	Mon, 21 Sep 2026 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000147;
	bh=pujrUL44gnHgvefxRpulk+kg6MWNVwi0b0Ol1nxoegM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bGgvw0/+YZ8aiK1nhj1iAimgUvlQMXCxEU8oULc1RN15CPol93HZ/3yRViPXXbWp/
	 bTJUN+b0hDkOOjOhsn73CMoea3q3RuFQ8xUxH5jssUTwqKcaEnAdIPyC2bay5eIXnJ
	 /zAdT047ldou4IBBsxqV8rzX1hMVcaRfFyqnPdfubCeWgYJTQKArmcbQS9kMsZyVRC
	 pesq8BRA7+hqUqrigfmTl9ss6Yl2gk+db/iXATgQ5FZbKGGqD+BaIF3yXR1bAe2lc8
	 sQ8ZIq82eigf+p0uMwhBD6uJSx5EWN9dNxlom1+z3ozkiNGVaQQS2vMvCT8C99jb2J
	 ufMF+eIPTo1cg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:29 +0200
Subject: [PATCH 01/10] file: let dup_fd() leave the punched hole behind
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-1-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4742; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qfZZrpNXmc7uzlP3zUqkNroYn3k7wqMIb6r2z8S5Rdw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOGZzn1mz+VfIj+tkjPF30cYvj/8avUsDsXT10Mqh
 fVTjtq/7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI71OGv9LsjFNcVMq47AxZ
 ap96PZu/wGCzkim75qZyT2e1SZ1dbQx/Rfuao2sspvtIf/u25YmHWfhBDgOZv6+4oj/V+nVc2yT
 DDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

close_range(CLOSE_RANGE_UNSHARE) passed the range it is about to close
to dup_fd() so the clone is done without that range. This only works
when the last open descriptor falls into the range. A range in the
middle of the table is copied like everything else. That's wasteful.

Don't copy them. Descriptors in a skipped range stay open in the source
fdtable. They are never copied into the new table and no reference is
taken on them. Figuring out the size of the table follows the same rule.
That drops the special-case it has now.

This also means we stop calling ->flush() on fds from a table they
were never part of. With the range at the top of the table that was
already mostly the case.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 628ca07dc4b1..95dbdfee555a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -352,27 +352,51 @@ static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 	return test_bit(fd, fdt->open_fds);
 }
 
+/* Bits of [range->from, range->to] that fall into word @i of a bitmap. */
+static unsigned long fd_range_word(struct fd_range *range, unsigned int i)
+{
+	unsigned int first = i * BITS_PER_LONG;
+	unsigned int last = first + BITS_PER_LONG - 1;
+
+	if (range->to < first || range->from > last)
+		return 0;
+	return GENMASK(min(range->to, last) - first,
+		       max(range->from, first) - first);
+}
+
+/* Bits of word @i that dup_fd() leaves behind. */
+static unsigned long dup_fd_dropped_word(unsigned int i, struct fd_range *punch_hole)
+{
+	if (!punch_hole)
+		return 0;
+	return fd_range_word(punch_hole, i);
+}
+
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
  *
  * punch_hole is optional - when close_range() is asked to unshare
- * and close, we don't need to copy descriptors in that range, so
- * a smaller cloned descriptor table might suffice if the last
- * currently opened descriptor falls into that range.
+ * and close, dup_fd() leaves the descriptors in that range behind,
+ * so the cloned table only has to reach the last open descriptor
+ * outside of it.
  */
 static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *punch_hole)
 {
 	unsigned int last = find_last_bit(fdt->open_fds, fdt->max_fds);
+	unsigned int i;
 
 	if (last == fdt->max_fds)
 		return NR_OPEN_DEFAULT;
-	if (punch_hole && punch_hole->to >= last && punch_hole->from <= last) {
-		last = find_last_bit(fdt->open_fds, punch_hole->from);
-		if (last == punch_hole->from)
-			return NR_OPEN_DEFAULT;
+	/* Only words up to the last open descriptor can hold a kept one. */
+	i = last / BITS_PER_LONG + 1;
+	while (i--) {
+		unsigned long dropped = dup_fd_dropped_word(i, punch_hole);
+
+		if (fdt->open_fds[i] & ~dropped)
+			return (i + 1) * BITS_PER_LONG;
 	}
-	return ALIGN(last + 1, BITS_PER_LONG);
+	return NR_OPEN_DEFAULT;
 }
 
 /*
@@ -384,7 +408,8 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
-	unsigned int open_files, i;
+	unsigned int open_files, fd;
+	unsigned long dropped = 0;
 	struct fdtable *old_fdt, *new_fdt;
 
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
@@ -451,13 +476,18 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	 *
 	 * Instead of trying to placate userspace racing with itself, we
 	 * ref the file if we see it and mark the fd slot as unused otherwise.
+	 * Descriptors dup_fd() is asked to leave behind get the same treatment.
 	 */
-	for (i = open_files; i != 0; i--) {
+	for (fd = 0; fd < open_files; fd++) {
 		struct file *f = rcu_dereference_raw(*old_fds++);
-		if (f) {
+
+		if (!(fd % BITS_PER_LONG))
+			dropped = dup_fd_dropped_word(fd / BITS_PER_LONG, punch_hole);
+		if (f && !(dropped & BIT_MASK(fd))) {
 			get_file(f);
 		} else {
-			__clear_open_fd(open_files - i, new_fdt);
+			f = NULL;
+			__clear_open_fd(fd, new_fdt);
 		}
 		rcu_assign_pointer(*new_fds++, f);
 	}
@@ -848,10 +878,12 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		swap(cur_fds, fds);
 	}
 
-	if (flags & CLOSE_RANGE_CLOEXEC)
+	if (flags & CLOSE_RANGE_CLOEXEC) {
 		__range_cloexec(cur_fds, fd, max_fd);
-	else
+	} else if (!fds) {
+		/* If we unshared, dup_fd() left the range behind already. */
 		__range_close(cur_fds, fd, max_fd);
+	}
 
 	if (fds) {
 		/*

-- 
2.53.0

