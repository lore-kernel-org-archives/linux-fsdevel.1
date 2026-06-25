Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06F371876;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419943; cv=none; b=pTw148uqnPqF8xxjozia7qcR6F+KYWWBLWk3kVofBn2doMyi7XmZMv9ta8Ngin9ugFUV9xYaV7eONtfJ4OrY5fs6cLLuz7HElW8oEUCEjaS7R492cW+v+MUw8Dwnt1WQwe8MPNHtuuakdwazmhxXFVvKwKnotQN19XzsVtae0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419943; c=relaxed/simple;
	bh=kyXLFNHGUnWAevIV1Ogp3P6AOQHOMxfj/cTapCcKySk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1owwF/UDEED3Ure1l4g9W2V1Lflf7MDD40mr3tPy149UbD0I1KR2RPyjCLVt8LDz9VKxCGXQIoiLiyYVCL3WisTknylyaKN5rnQ55MRijI7HChy8QUnBG5hshR4Z/2KDXnNDNAHdRWazv6I1KcbssSJRVmLxa4qA6Q9FtJ3a/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFVPUeeJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFVPUeeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82158C2BCB4;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782419943;
	bh=kyXLFNHGUnWAevIV1Ogp3P6AOQHOMxfj/cTapCcKySk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RFVPUeeJUU2BIhlx97spJlb5TJTdqy2KvRicLYO//9INmFoTbhr+/au6mizu+40xr
	 0s5TeVdUTCkHAQQHUA1Z5oIFa9j5SVYv7LWptcHOJXEwnDAzUDnGqMhNCZWneo3TFw
	 e1lI6gNq8vkP+jA7u7DET+KLIHfsSSemiZpEA/inYXKPkc6AV8pXxfXYT2uOUK8VSr
	 YhQcjdLYJKFwuKgVqBrQCXwQRvrOZPXgHdLYYCXcy52jwXFhCIBCWDonMRDABLEh4y
	 cmC0GyzMGBnJtCt2TCn9DNWjino/i3vMyDtpyoUXoxO2db7P21wmPs9QoEzKa7mJ1c
	 yzDvTiGN5pPUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D0CDE010;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 25 Jun 2026 22:38:20 +0200
Subject: [PATCH v3 08/10] sysctl: Rename proc_doulongvec_minmax_conv to
 proc_doulongvec_conv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-jag-dovec_consolidate-v3-8-176ee192bcaf@kernel.org>
References: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
In-Reply-To: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3589;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=kyXLFNHGUnWAevIV1Ogp3P6AOQHOMxfj/cTapCcKySk=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGo9keNCVNi3a5N05ESIgn3HDumfkErZIr0Hj
 Saf+cUWSgrc6YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqPZHjAAoJELqXzVK3
 lkFP6iwL/2yMdS/6M3QZwgqc9fAmLHGGniuVrkyOA29f42oIPNc5lXJ4O42gv3sb4IUJLpzAIKT
 G9nqH7iOUYshqYdd7bRebesmMaY0GY/dESw7GBr3pI2CCkH/ZDBV7yoLw59CZXdJvO9QVSdZ7uk
 vQQEB7sKPzyFzWsmZw7cWEBWCQXFuJuIpYX8JwQCW8eJoUkt11dzLo19ae9QfR1bz+yZh9OJQ4s
 hAlDEOs3GfXgQ7iSSa4TIinPInPRc5KQRSpyjGgc6u0RWSwZDF2EWw9uQ4KD/+/1UWf6Iq2Qp9e
 PP4n9iTTDZo+JqssBAvtrL6fVfcKficFMqLw/4UWiZ81zg+44zUhLL7fL1sernJ5AOi2U2VOz9K
 XzkuOJ1tRjTUuqlvmIqWPHQFcUg3IPakVtCBfy4MTJb34ko9l+JW/8gUnbv0LM1duLYED+/xQdL
 aG8vxeL0l1Sobqs+E/iQ1zaoH33DxgaAr5s9aWVhI50wVn2ydV+4DSInrlB5X8ahQ7OL8Ia8175
 sE=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove "_minmax" from proc_doulongvec_minmax_conv as it does not enforce
min/max limits but serves as a generic converter for unsigned long
vectors. Update function declaration in sysctl.h, definition in
sysctl.c, and caller in jiffies.c accordingly.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 8 ++++----
 kernel/sysctl.c        | 6 +++---
 kernel/time/jiffies.c  | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ad268dfd9e79f5540a4a85a9a439819fb3172640..39cf1bf9703fc66a3c9c3360ca081b5590339caa 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -121,10 +121,10 @@ int proc_douintvec_conv(const struct ctl_table *ctl, int dir, void *buf,
 			size_t *lenp, loff_t *ppos,
 			int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
 				    int dir, const struct ctl_table *ctl));
-int proc_doulongvec_minmax_conv(const struct ctl_table *ctl, int dir, void *buf,
-				size_t *lenp, loff_t *ppos,
-				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
-					    int dir, const struct ctl_table *ctl));
+int proc_doulongvec_conv(const struct ctl_table *ctl, int dir, void *buf,
+			 size_t *lenp, loff_t *ppos,
+			 int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
+				     int dir, const struct ctl_table *ctl));
 
 /*
  * bi-directional converter functions
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3c3508814f5df6727251c83913c256446b7ba41d..cff54c4ee88a36ecc643bff5531c640509cff7f4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -961,7 +961,7 @@ static int do_proc_ulong_conv(bool *negp, ulong *u_ptr, ulong *k_ptr, int dir,
 }
 
 /**
- * proc_doulongvec_minmax_conv - read a vector of unsigned longs with a custom converter
+ * proc_doulongvec_conv - read a vector of unsigned longs with a custom converter
  *
  * @table: the sysctl table
  * @dir: %TRUE if this is a write to the sysctl file
@@ -976,7 +976,7 @@ static int do_proc_ulong_conv(bool *negp, ulong *u_ptr, ulong *k_ptr, int dir,
  *
  * Returns: 0 on success
  */
-int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
+int proc_doulongvec_conv(const struct ctl_table *table, int dir,
 				void *buffer, size_t *lenp, loff_t *ppos,
 				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
 					    int dir, const struct ctl_table *table))
@@ -1257,7 +1257,7 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 	return -ENOSYS;
 }
 
-int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
+int proc_doulongvec_conv(const struct ctl_table *table, int dir,
 				void *buffer, size_t *lenp, loff_t *ppos,
 				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
 					    int dir, const struct ctl_table *table))
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 1e587791fd67f4f87ccfa64302db377f724126a7..416b94cf3ee61316b59150fabfeea4d790ce1f94 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -334,8 +334,8 @@ int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos,
-					   do_proc_ulong_conv_ms_jiffies);
+	return proc_doulongvec_conv(table, dir, buffer, lenp, ppos,
+				    do_proc_ulong_conv_ms_jiffies);
 }
 EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
 

-- 
2.50.1


