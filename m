Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784B3CDBA5;
	Thu, 24 Sep 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260457; cv=none; b=P/DcQsJwntRSFkY1dbULxeLaUimWwtl2xq98mHAc7OgXoX/nh6Zwci8jMtM43lJGGvcJD3/wlxVkc8Tf1lWeak79E1zIwbUg5PWxRbu6tVoE5zsoWzWARN4EkQgZHA1KCKBCf+Yu+ZBviftfZrPfFqyIv13LNR8vihpyAhprW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260457; c=relaxed/simple;
	bh=I5CKmhNtTnWeuzjiQtc94qyADu0YXow+af+CzKqUVMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubYu5DXF2bJxRHkviZeqewV34Bw8Bmz04NS9iYeR6vgWdxYhvuq3TbTphXkmPh5Sd4eUasNrYgdo5rb8hy8uWAbETe01ITNv9iFzo3FzT+aTQYQqAq3ShU5HZPGY+P62mrgU4qhNvHr/DIYjOv6I+rcOOVWPI7JWvnzFSNWYkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIxTUZ7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIxTUZ7n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82CACC2BCFB;
	Thu, 24 Sep 2026 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790260457;
	bh=I5CKmhNtTnWeuzjiQtc94qyADu0YXow+af+CzKqUVMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VIxTUZ7n+tsQy9idj+xDRS/iIX7BhWS7ODavv9m8cfbQY6cKNsLXwly9Xrns11vwc
	 oB7D/Ixn1uJIsM4/So4VOazmOYPlus9+w/lYIElX6VjrzUVjkzMMaPxF2mBwRf1Pkj
	 heZT1BgNiKJC+nxFnV95XFWXH0lN7pcH7Ih+o2XMcb7WGpmAJrwuaLGJuK/jvtqkpf
	 0qUIbBtxR2VtEQnDZtHu9i+eIeudTj3+HOx/GVKlxZxkXzgAA1xSwK92EEKCuh+rKW
	 MIygV1Llhwv6+9ErppQ127L7zuCBQgDUJt3g5G5NnzNbfeadM6I5xV1b4bGXXednJ1
	 TUzVK2j64z+dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126CC98321;
	Thu, 24 Sep 2026 14:34:17 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 24 Sep 2026 16:34:10 +0200
Subject: [PATCH RFC 2/4] sysctl: Apply sysctl context when flag is active
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-lklm-sysctl-headerctx-template-v1-2-b25e51c66ba7@kernel.org>
References: <20260924-lklm-sysctl-headerctx-template-v1-0-b25e51c66ba7@kernel.org>
In-Reply-To: <20260924-lklm-sysctl-headerctx-template-v1-0-b25e51c66ba7@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, Serge Hallyn <serge@hallyn.com>, 
 "Eric W . Biederman" <ebiederm@xmission.com>, 
 Alexey Gladkov <legion@kernel.org>, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2730;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=I5CKmhNtTnWeuzjiQtc94qyADu0YXow+af+CzKqUVMc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGq1NOXd5c0dJfW3SBiNoI1dPmuYeuj9U2c8S
 tTl/ZYcVMuHiokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqtTTlAAoJELqXzVK3
 lkFPQSwL+gMJstW2nqQmHrOX+SDossmZOHPV5GBDoHYK1RjArd8v/8QuPILsP33zPYyzPAE0gLU
 n6L5Sf5b8KIdQpthCdlmtai56LrUWNZY5pkyE56qYUYyZ7OHKX7QzKOqcLbsSonPDmJn+sgJKvR
 pLUAycJiLWnMeogMNJ1flpD9OQ7b4VAWDLM+j8BLI0S/OnKWwnogX4cNr4bG8cdkyLfHlDbMiPV
 wfcJPKIqG0tIWhFjMg3i/Q7s2Y92OxYodwOAyOCjyxgYnJjV7RTi4GAbxuDfy6AE/tZmXfrGE1c
 WTONmfzMTKjikZjVK/VgZpA0vW3PwiBc6n8eeShbWVP8rm5q38Pir9wokG0zhCbpu6aqssKu33/
 9GDnNFtcBAi6dtJTCcuqwUn/zpOBzHHEgYJEW0NVQ7aTlq6F5FWSzeNOw92oil1FESLqPQEVeTv
 7JpxrD9GwJr9CWUsqg6We2T9vSQFRslJZlsoKlbQ+1YVdgItxDLyE8z4+K5RHjtdGhTh7nZe7C8
 Ak=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Whenever CTL_TABLE_F_CTX_DATA is set on the entry, overlay the ->data
entry contained in inst on the entry to be passed to proc_handlers. No
table sets the flags yet, so there is no functional change.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 fs/proc/proc_sysctl.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index fe32337892f9badc897a29e9176e66790003fb05..1ed9f4e1a17e28c5db1d07356390cbee968cb91f 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -550,12 +550,31 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
+/* Returns @entry itself when it is not flagged, else a resolved copy in @buf. */
+static const struct ctl_table *sysctl_apply_ctx(struct ctl_table_header *head,
+						const struct ctl_table *entry,
+						struct ctl_table *buf)
+{
+	ptrdiff_t off;
+
+	if (!(entry->flags & CTL_TABLE_F_CTX_DATA))
+		return entry;
+
+	off = (const char *)entry->data - (const char *)head->ctx.tmpl;
+
+	*buf = *entry;
+	buf->data = (char *)head->ctx.inst + off;
+
+	return buf;
+}
+
 static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 		int write)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct ctl_table_header *head = grab_header(inode);
 	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+	struct ctl_table ctx_entry;
 	size_t count = iov_iter_count(iter);
 	char *kbuf;
 	ssize_t error;
@@ -567,6 +586,8 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	 * At this point we know that the sysctl was not unregistered
 	 * and won't be until we finish.
 	 */
+	table = sysctl_apply_ctx(head, table, &ctx_entry);
+
 	error = -EPERM;
 	if (sysctl_perm(head, table, write ? MAY_WRITE : MAY_READ))
 		goto out;
@@ -797,6 +818,7 @@ static int proc_sys_permission(struct mnt_idmap *idmap,
 	 */
 	struct ctl_table_header *head;
 	const struct ctl_table *table;
+	struct ctl_table ctx_entry;
 	int error;
 
 	/* Executable files are not allowed under /proc/sys/ */
@@ -810,8 +832,11 @@ static int proc_sys_permission(struct mnt_idmap *idmap,
 	table = PROC_I(inode)->sysctl_entry;
 	if (!table) /* global root - r-xr-xr-x */
 		error = mask & MAY_WRITE ? -EACCES : 0;
-	else /* Use the permissions on the sysctl table entry */
+	else {
+		/* ->permissions may inspect the entry, so resolve it first. */
+		table = sysctl_apply_ctx(head, table, &ctx_entry);
 		error = sysctl_perm(head, table, mask & ~MAY_NOT_BLOCK);
+	}
 
 	sysctl_head_finish(head);
 	return error;

-- 
2.50.1


