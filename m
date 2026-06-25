Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25336EAA7;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419943; cv=none; b=Ldr1AvfwS61NL0oQ6um2wOmpVUbgfmSaddUS/Gwi30m9g3dBEg5vgdgix5Fp8+irPHF2hJ8reQEi15VNuIuP+4czxiPMzsuwJQyLCSWoyS6Yyk/4KvcG6g8Iyf01pbIKXX7w/5wMrJztmMTRJ8aqnrZihrOdnPypuY6znpegN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419943; c=relaxed/simple;
	bh=/RdXu0eAZL0rDz+maQLbVfoBITW3eQjdtUVKAmdH738=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnHrResUBThfTZDFhfPDyO1XT7sVTNnJXXGWeW8gj7ckcKbdvgGtKGGJd5RFY0dU2IzDzG/mOdgRpNVHIlaU1OFY3t2c5n2sd6hAfEjIfDQ9wn7QdPPl8l6x1F6syKku2iUdC2VnltSCdvkxDI/9uKEADsJLLOcMitLFK5oLFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiCtP7v4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiCtP7v4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C43CC2BCFB;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782419943;
	bh=/RdXu0eAZL0rDz+maQLbVfoBITW3eQjdtUVKAmdH738=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AiCtP7v44OZpfbRjEOlxbDtCpWkMVGqlWKzLGD64j1r7O8FvzQije2EDXVeBFhto0
	 mzNqXsjihN10yjafpOEbwqGbzoVJGZoYqnbaw4K2fqABBZtDWjnyM23Yiw/l6woQQt
	 XtH8riCF423fJ8EdMD1wHqORkhOXXICfnh76pZ36K68ZA8K6lMvnZJtIS1nuGjtYvu
	 hLRiCd1L+4Bf+YoaS9RFAi4AeAl32htKUg0wF08yuHnNZt1wC9HLukIVGaKVovxkoG
	 gbNgcwY4v9p9ICrWyjxhOIQWwbiuHIA54BkKqGFZA3EMxH7IlFBcc3Acdr5czwhcSe
	 eo/u1FW3DJ2tA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E868CDE009;
	Thu, 25 Jun 2026 20:39:03 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 25 Jun 2026 22:38:17 +0200
Subject: [PATCH v3 05/10] sysctl: Generate do_proc_douintvec with a
 type-generic macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-jag-dovec_consolidate-v3-5-176ee192bcaf@kernel.org>
References: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
In-Reply-To: <20260625-jag-dovec_consolidate-v3-0-176ee192bcaf@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3459;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=/RdXu0eAZL0rDz+maQLbVfoBITW3eQjdtUVKAmdH738=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGo9keGwA6rK0iyMB6sjlhoFyr0YAiKJ5ra3N
 7r1j/eOTAheK4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqPZHhAAoJELqXzVK3
 lkFPPQAMAIDn0WxdmGOzL2dr8JVZWipRTf85d8zgbP5ME9fEwo7/w+aY90FqUfmn/Z7aoZMYAaV
 F+ktuh8dvAQoi7TQg6lVehb/RjTiD9ULXAoXyuIqRmPL0EBwNQrk1zLE1xng4JTf09mC2JQ4Tt2
 6ISVicLdU9QWyakfW+WyB9nvsZ7zJcWATHfhZqmHPZ2RNtKwo0WrVWcbnNBX6KZzf2w8Z2CKR93
 Qf1Pf8rKA2aCBYekouTN443LmpX9P0xneJBDvRCKb839CAKd67k2QI1Ewk7RU1Pf+25xf8mY3nm
 0b56cB2kt1dG3ICJhnNBVH9cllBN726ojrYNSe1wEt1cTZOtcvOsYWwxc8mnt5EBkRbpCJbWAu7
 o4UuunFBLXGjbrb6igE8U8fC4FpcSEi1aEyxzCh8G+K2fUTNZ9XqVBv+bWr8euTqRcGiV6vsa8K
 bPFsgz6sPiL1K8PP6eH74cINrdO5+sBUFUEXIOet+O0WpVFCdH7AR6X7v1qqVPoYVi0vxKv6bM5
 Zw=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Generate the behavior in do_proc_douintvec{,_w,_r} functions with
do_proc_dotypevec(uint). The originals (do_proc_douintvec{,_w,_r})
where created in the same way as do_proc_dotypevec but for individual
values (no vectors). In this commit we use the existing macro
implementation to extend do_proc_douintvec to include vectors of values.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 114 +-------------------------------------------------------
 1 file changed, 1 insertion(+), 113 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 08a32918d79d9e098bfd95ed95ff30943a38c2d5..04281e3accbb74659f9d2298ca06528acbd35bbf 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -651,119 +651,7 @@ out: \
 
 do_proc_dotypevec(int)
 do_proc_dotypevec(ulong)
-
-static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
-			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(bool *negp, unsigned long *u_ptr,
-					   unsigned int *k_ptr, int dir,
-					   const struct ctl_table *table))
-{
-	unsigned long lval;
-	int err = 0;
-	size_t left;
-	bool neg;
-	char *p = buffer;
-
-	left = *lenp;
-
-	if (proc_first_pos_non_zero_ignore(ppos, table))
-		goto bail_early;
-
-	if (left > PAGE_SIZE - 1)
-		left = PAGE_SIZE - 1;
-
-	proc_skip_spaces(&p, &left);
-	if (!left) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	err = proc_get_long(&p, &left, &lval, &neg,
-			     proc_wspace_sep,
-			     sizeof(proc_wspace_sep), NULL);
-	if (err || neg) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	if (conv(&neg, &lval, (unsigned int *) table->data, 1, table)) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	if (!err && left)
-		proc_skip_spaces(&p, &left);
-
-out_free:
-	if (err)
-		return -EINVAL;
-
-	return 0;
-
-bail_early:
-	*ppos += *lenp;
-	return err;
-}
-
-static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
-			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(bool *negp, unsigned long *u_ptr,
-					   unsigned int *k_ptr, int dir,
-					   const struct ctl_table *table))
-{
-	unsigned long lval;
-	int err = 0;
-	size_t left;
-	bool negp;
-
-	left = *lenp;
-
-	if (conv(&negp, &lval, (unsigned int *) table->data, 0, table)) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	proc_put_long(&buffer, &left, lval, false);
-	if (!left)
-		goto out;
-
-	proc_put_char(&buffer, &left, '\n');
-
-out:
-	*lenp -= left;
-	*ppos += *lenp;
-
-	return err;
-}
-
-static int do_proc_douintvec(const struct ctl_table *table, int dir,
-			     void *buffer, size_t *lenp, loff_t *ppos,
-			     int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
-					 int dir, const struct ctl_table *table))
-{
-	unsigned int vleft;
-
-	if (!table->data || !table->maxlen || !*lenp ||
-	    (*ppos && SYSCTL_KERN_TO_USER(dir))) {
-		*lenp = 0;
-		return 0;
-	}
-
-	vleft = table->maxlen / sizeof(unsigned int);
-
-	/*
-	 * Arrays are not supported, keep this simple. *Do not* add
-	 * support for them.
-	 */
-	if (vleft != 1) {
-		*lenp = 0;
-		return -EINVAL;
-	}
-
-	if (SYSCTL_USER_TO_KERN(dir))
-		return do_proc_douintvec_w(table, buffer, lenp, ppos, conv);
-	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
-}
+do_proc_dotypevec(uint)
 
 /**
  * proc_douintvec_conv - read a vector of unsigned ints with a custom converter

-- 
2.50.1


