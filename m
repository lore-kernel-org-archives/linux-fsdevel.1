Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED33372ECB;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419943; cv=none; b=gs7Kw/M2gKT3Utfsdw7NJKrZCDOccOp9Y+hdU+p1XlxuYYzMALCgW/l//UOnMZ+cmrFgDiSIWottwtt3d40JMZyFMrL+d3oJnZK+5XpLrSeJ5YRtg1Ht0ivnSlMyGFCpSdlXKQdec0xuaLjIaNAOzopq0Ze0AA8RPKMZNdEHKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419943; c=relaxed/simple;
	bh=k3wBF4b69LYmcdJHMZkwq5B3w6ha/hzctMpJG5T820M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omS7dz+RXHXrPeKRwpZ9BvRAIUSvFkR5/2rFhwRpq2HL1+PqKbGzD0qHRvfhWBWq1w0M4D5POV01or8h2fXAwm8Q/7KA0SbiMUo+d+v2CYljpMdb/3upooHqFj6tsOMXLNLIMSyX2X5TamoSeILlKMSxZV5PiLhDMPq0aSWdU2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJLGgRg6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJLGgRg6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF1E2C2BCC7;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782419943;
	bh=k3wBF4b69LYmcdJHMZkwq5B3w6ha/hzctMpJG5T820M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nJLGgRg6VEGHOJhY1dqJURrjBPk+/mFROtW/JBQV43MImwtwjuOpco6Wv53H8wmHS
	 2Tq4Vl8fcCquoym4xMrUCS/qO8Mst/9Gj6b2jDjqXDGZBMowXniw87shuJ5VLIHWea
	 cWoUFm1Co7wwU9W0C3csr8OCDpMh8cXPL9yVfoPtyHmGYRdT3mWsT1sAm4I6W9OLcZ
	 nZOzfetq7Yz1FNmVxwIRqPV4bC15ntOCdJ2GxT/lggbkUkDsHVz+m9mQ4+ml5gVGjT
	 xwZ9xmICXjL4M5QaJrhIYZR9bDr4FOdjrhpf21XaQKmvUPaOLuPm3UVvlWFrDqLftm
	 hZ9j9hAAf6mBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B2CDE010;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 25 Jun 2026 22:38:21 +0200
Subject: [PATCH v3 09/10] sysctl: Update API function documentation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-jag-dovec_consolidate-v3-9-176ee192bcaf@kernel.org>
References: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
In-Reply-To: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3622;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=k3wBF4b69LYmcdJHMZkwq5B3w6ha/hzctMpJG5T820M=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGo9kePBl9qfXx7gvC+PCAXMfIXGs2EC9W9Xh
 ai3UJv3NIWWqIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqPZHjAAoJELqXzVK3
 lkFPoScL/1Oqh9Ig0FdLm39n0X79Ekhsp6a6zxC8+aMRwStZDzWuuzI1r+Y8fQktoNDwenQ25bh
 w6+hxIJP42sZ3df9mF2BS0m9Jb1lOg0R8W+qU6K35runyzXH+82XmHBYtPz6I0VNqOfyI+ZvntN
 RcXjGd5BPNap9pcJcZeNsa/LfNq+GX6Jw4HICtqqaffq6wxconS1UD8blajEBjuzExmfd6Ye+tq
 xqoc05x17ZVb/Med5NPC9aT3iCAeEAvidEf8TcydBGTNnlX0/wvwKeoPcoSXZk/bUWJBKnmOrVf
 WIUvuxH+yqC79ZvwyHFszAXFxfjuqwU0cd689pvYnFLuRIlKGqrFFXGYMhqt+XC9S+OCTHQDo3i
 pA5+6CkzC39Cs1+Z542GhYMBXfxUdd35pGymRIlKf/B+VlwP3PZhUSEEW3gUM69imqoZfmqa7M5
 SzDLCaG8heVazLZpvUiLl+ksjRFNZK0ha3yz+Ny/vxQGdOZ5IZ/CDKWsmDBF9KlSb+akHn6BJ39
 Z4=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add colon ":" after argument name where it is missing
Add doc for proc_int_conv and proc_dointvec_conv

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cff54c4ee88a36ecc643bff5531c640509cff7f4..a26011c3967faffaa19b358038c35d7f8868a051 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -365,7 +365,7 @@ static void proc_put_char(void **buf, size_t *size, char c)
  * not NULL. Check that the values are less than UINT_MAX to avoid
  * having to support wrap around from userspace.
  *
- * returns 0 on success.
+ * Returns: 0 on success.
  */
 int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
 			   ulong (*u_ptr_op)(const ulong))
@@ -386,7 +386,7 @@ int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
  *
  * Uses READ_ONCE to assign value to u_ptr.
  *
- * returns 0 on success.
+ * Returns: 0 on success.
  */
 int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr)
 {
@@ -515,6 +515,23 @@ int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
 	return 0;
 }
 
+/**
+ * proc_int_conv - Change user or kernel pointer based on direction
+ *
+ * @negp: will be passed to uni-directional converters
+ * @u_ptr: pointer to user variable
+ * @k_ptr: pointer to kernel variable
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @tbl: the sysctl table
+ * @k_ptr_range_check: Check range for k_ptr when %TRUE
+ * @user_to_kern: Callback used to assign value from user to kernel var
+ * @kern_to_user: Callback used to assign value from kernel to user var
+ *
+ * When direction is kernel to user, then the u_ptr is modified.
+ * When direction is user to kernel, then the k_ptr is modified.
+ *
+ * Returns: 0 on success
+ */
 int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
 		  const struct ctl_table *tbl, bool k_ptr_range_check,
 		  int (*user_to_kern)(const bool *negp, const ulong *u_ptr, int *k_ptr),
@@ -912,7 +929,7 @@ int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
  * Uses WRITE_ONCE to assign value to k_ptr. Executes u_ptr_op if
  * not NULL.
  *
- * returns: 0 on success.
+ * Returns: 0 on success.
  */
 int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
 			    ulong (*u_ptr_op)(const ulong))
@@ -938,7 +955,7 @@ static int proc_ulong_u2k_conv(const ulong *u_ptr, ulong *k_ptr)
  * Uses READ_ONCE to assign value to u_ptr. Executes k_ptr_op if
  * not NULL.
  *
- * returns: 0 on success.
+ * Returns: 0 on success.
  */
 int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
 			    ulong (*k_ptr_op)(const ulong))
@@ -1014,15 +1031,13 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
- * @conv: Custom converter call back
+ * @conv: Custom converter call back. Defaults to do_proc_int_conv
  *
- * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned integer
- * values from/to the user buffer, treated as an ASCII string. Negative
- * strings are not allowed.
+ * Reads/writes up to table->maxlen/sizeof(int) integer values from/to the
+ * user buffer, treated as an ASCII string.
  *
  * Returns: 0 on success
  */
-
 int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,

-- 
2.50.1


