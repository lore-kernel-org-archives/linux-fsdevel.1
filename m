Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9F36F8F5;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419943; cv=none; b=fzJ04iTVh89AOW9bW599G4qNCUOoyPUdS7Mzvljsmk8gSjZBO3j6ulrGm+VDR4tMgsjLakClQeBxY1lpQmX4b74REwQ1hw1Uqml1dw7siyQtd3rBSeevZqbRfiC7P0hZ2o1Sy7raYpN0QLjYagcGkGRcFVfyDL6Awlm94NKS7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419943; c=relaxed/simple;
	bh=shdhxGfKGO9qjBqwQcTD0b+3MSlAnTnqsYfl8Zb7ChQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTWRviXaA8tBWFBFByONAWLXzOH6S7snoV91glCQPYGvwRAeWlQnzNp2zO4qcxISn64Y+YD1N+yvIKcfqHeIvuTaYi8tdC7xm3LA6b2psDpxjyWBUgM5goKJcQvAo275oayJ6cXQdWOqZv1uIGAwhfKcfais3e5thLFnkkY5NOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zge2Pr3I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zge2Pr3I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57E34C2BCC7;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782419943;
	bh=shdhxGfKGO9qjBqwQcTD0b+3MSlAnTnqsYfl8Zb7ChQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zge2Pr3IFzJeYNndo2ZM+UqbQ67SszzjfKsm2bMH8R1SA6x67alK4hDsd0BE0Wj6g
	 a4x5c390ejMOvxdwgUdIlwsb9ljwgZudGi+SYTmxFY066jH2YZempMVvKxJ23lqGyq
	 RkZdkttVNOZMJvTUfCyGIvnzTDEKp6dViVmOrfl0p+puPbzdwM136tAKv4csgyUasj
	 oGjBpQqGcMgJVPPkiVvLJpTwNNU6rVY5EpOm8n3PIxCcqeiYc0yXqzKSd8VXvBJYeb
	 vg/R5QxSe6li21bX2Vkus59S3x6VGU/upYorMn76yuDPzOPZM9wYG4cx0GPKV+qQEm
	 VicYRYr0iLXfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F593CDE00E;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 25 Jun 2026 22:38:18 +0200
Subject: [PATCH v3 06/10] sysctl: Rename do_proc_dotypevec macro to
 do_proc_typevec
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-jag-dovec_consolidate-v3-6-176ee192bcaf@kernel.org>
References: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
In-Reply-To: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4703;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=shdhxGfKGO9qjBqwQcTD0b+3MSlAnTnqsYfl8Zb7ChQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGo9keHOkHgjJyCf8la+FgkfEBs2NJjtSDkL1
 1aW3owKWAeTnokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqPZHhAAoJELqXzVK3
 lkFPW/AL+werde0Q2yCdvZwPmk6SY8CeXF19SujCozSK3X+GzguTHur2nyeO1sImmwm5+1VN5gc
 gVMhEyIqpIOzqzDZZHgSLYwokRs5WqcdZ7P4DVB22FXDwFZBloWPYaviH52KBX+PbhtP5/v+Q3+
 rjn0twiC1t3wZdBaEQNVXe4v9jvD7ui7VLd0E7tSPuY+n2lPFblPlVHjwuAr6JkXXFuRTmDrb7g
 fVW5WEbm5Dn+3tofaQDeNL/zyZAEKIXqps2Cd0pHAhkDShhP/bJ26QpzHmDBS7tEyBEVHEL8uzB
 XfDjFHhdV7iBV3YWbecCE0eWOUoNYmd5I1LvAv0q9m5HgL+PN3YLOKWybC5A9gprIljhOxA+F0g
 bLpuWt61+lwu0yOILaiIQWbhSu8rFrPB8FqlyhyDWh9CqBIDsdMHPjk16FPPB10NoQqPTyAlEwG
 ICT4yarGt6rpBlPmEQt/5A+JLLZoa9dNExbP9A9zXKnPrKNwXGR+/cVYlOk6rPNQNrdSQ8YZ2u5
 uE=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove the do..do from the proc vector functions. The redundant "do"
only adds confusion to the already large amount of functions in sysctl.c

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 04281e3accbb74659f9d2298ca06528acbd35bbf..3c3508814f5df6727251c83913c256446b7ba41d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -576,8 +576,8 @@ static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
  * Do not export this macro outside the sysctl subsys.
  * It is meant to generate static functions only
  */
-#define do_proc_dotypevec(T) \
-static int do_proc_do##T##vec(const struct ctl_table *table, int dir, \
+#define do_proc_typevec(T) \
+static int do_proc_##T##vec(const struct ctl_table *table, int dir, \
 		  void *buffer, size_t *lenp, loff_t *ppos, \
 		  int (*conv)(bool *negp, ulong *u_ptr, T *k_ptr, \
 			      int dir, const struct ctl_table *table)) \
@@ -649,9 +649,9 @@ out: \
 	return err; \
 }
 
-do_proc_dotypevec(int)
-do_proc_dotypevec(ulong)
-do_proc_dotypevec(uint)
+do_proc_typevec(int)
+do_proc_typevec(ulong)
+do_proc_typevec(uint)
 
 /**
  * proc_douintvec_conv - read a vector of unsigned ints with a custom converter
@@ -678,7 +678,7 @@ int proc_douintvec_conv(const struct ctl_table *table, int dir, void *buffer,
 	if (!conv)
 		conv = do_proc_uint_conv;
 
-	return do_proc_douintvec(table, dir, buffer, lenp, ppos, conv);
+	return do_proc_uintvec(table, dir, buffer, lenp, ppos, conv);
 }
 
 /**
@@ -737,7 +737,7 @@ int proc_dobool(const struct ctl_table *table, int dir, void *buffer,
 int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos, do_proc_int_conv);
+	return do_proc_intvec(table, dir, buffer, lenp, ppos, do_proc_int_conv);
 }
 
 /**
@@ -756,8 +756,7 @@ int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-	return do_proc_douintvec(table, dir, buffer, lenp, ppos,
-				 do_proc_uint_conv);
+	return do_proc_uintvec(table, dir, buffer, lenp, ppos, do_proc_uint_conv);
 }
 
 /**
@@ -780,8 +779,8 @@ int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_int_conv_minmax);
+	return do_proc_intvec(table, dir, buffer, lenp, ppos,
+			      do_proc_int_conv_minmax);
 }
 
 /**
@@ -807,8 +806,8 @@ int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_douintvec(table, dir, buffer, lenp, ppos,
-				 do_proc_uint_conv_minmax);
+	return do_proc_uintvec(table, dir, buffer, lenp, ppos,
+			       do_proc_uint_conv_minmax);
 }
 
 /**
@@ -851,8 +850,8 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 		tmp.extra2 = (unsigned int *) &max;
 
 	val = READ_ONCE(*data);
-	res = do_proc_douintvec(&tmp, dir, buffer, lenp, ppos,
-				do_proc_uint_conv_minmax);
+	res = do_proc_uintvec(&tmp, dir, buffer, lenp, ppos,
+			      do_proc_uint_conv_minmax);
 	if (res)
 		return res;
 	if (SYSCTL_USER_TO_KERN(dir))
@@ -982,7 +981,7 @@ int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
 					    int dir, const struct ctl_table *table))
 {
-	return do_proc_doulongvec(table, dir, buffer, lenp, ppos, conv);
+	return do_proc_ulongvec(table, dir, buffer, lenp, ppos, conv);
 }
 
 /**
@@ -1004,8 +1003,8 @@ int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_doulongvec(table, dir, buffer, lenp, ppos,
-				  do_proc_ulong_conv);
+	return do_proc_ulongvec(table, dir, buffer, lenp, ppos,
+				do_proc_ulong_conv);
 }
 
 /**
@@ -1031,7 +1030,7 @@ int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 {
 	if (!conv)
 		conv = do_proc_int_conv;
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos, conv);
+	return do_proc_intvec(table, dir, buffer, lenp, ppos, conv);
 }
 
 /**

-- 
2.50.1


