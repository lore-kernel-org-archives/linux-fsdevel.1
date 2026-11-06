Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998667;
	b=oXUFzfQiG9FNZ9dth2KhoOWO00d/EWhMTGe7eekYApSdhOWU4PWOuKkvazDmXMSpyv0m
	 lh/6/djYpLG93dH/1TqPT9sq+l7ose9DdTRUYt8P+fuXGqsDR6PP4qudOeYZYfMMeERWV
	 mxoaZYpp1+W7t5lziFT8St5F4tfgaS/ib7hhIrk+l/7AkZKO5Uzgrgt4K/WEn/ZF8mUOu
	 tBQhAOMtKUAvtUVe2r96wD2JBDdPvLDqXqTfPL0GINND1zQuMM6/zvxpspfvuOI3PtTT8
	 UBXlcAnZMBIHvPWiZqFfAh/4sL4DDR9bsZvpdNwDh7LYYFE/oPjZEhHVVzVx7jGdzcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998667;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nBmoOdVLhjxzW9Kafv3OvCDFQruGaI/hx6SsyCcZev8=;
	b=ODCuxoosjAT6ViMlcRFml1APChfKpJ5JBGvOzChJ7EugTx49fll8DJIQy9KD75fYL/lI
	 vwquT2vibgkpE8CPvvPvaaS5qXPv1mD757XyQbQIJHxZgx/LLfEM36wLkXl4b05UEq4JS
	 NYYE95O2RuiqW63etFOAwFeDyVuyR9nnyRnR220b7BN3ZAM32qiAdFwfAJa4S2hDT/CJ6
	 HCRWRbTjuNTvD1lr7mTcQm10/iwlyTI37Uv65hhJhxNJW2lWOKBnCZ77a4AFOuuqvm8y4
	 n4hkVaHxJ6AhFptQND9OasgldXdbOaE2nw98EDMGI4j4WRON2GjeiE0zddTupfQ8L5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=DA+zqU77;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A2606A329;
	Fri,  6 Nov 2026 20:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D66A2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=DA+zqU77
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=nBmoOdVLhjxzW9Kafv3OvCDFQruGaI/hx6SsyCcZev8=; b=DA+zqU77k8p0jFgv6g7
	01srGmpcj97AEgA8B4oU+0ViZRy9ctkLJmncbwxOCw94wTnUg6jW8LlwuNkNd0/8b3aPHRK1vyFUV
	iP1rL+761svdtn94+zqSiYJnMeg4vI0/D6WPPQaI5KzCvHTHUqeD2ymcG2V4lh7TBf/WNf9Q8rwcI
	k8ptJOqGLGoMktwudi32EskkA8AN3s/XDBTLNTF0lycQZEycGWI/Kflb6OiSZYooMBAerOyNQsR85
	AWycnYNJgtBBr/ki6vL0ThdqkWFtYIe0tVbbQj6brzv9F78QtL3dV140H4Enxi032mIcszl5pR6Be
	1gSnaTB7BXfINQA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xPQwI-001xD7-2m;
	Fri, 06 Nov 2026 21:57:38 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Fri, 06 Nov 2026 21:57:37 +0100
Subject: [PATCH v2 1/2] binfmt_elf: return the real error when program
 headers cannot be loaded
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v2-1-1c8b7b1dae5c@virtuozzo.com>
References: <20261106-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v2-0-1c8b7b1dae5c@virtuozzo.com>
In-Reply-To: <20261106-b4-prep-vstor-149847-binfmt_elf-enomem-load-elf-phdrs-v2-0-1c8b7b1dae5c@virtuozzo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Paul Burton <paulburton@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konstantin Khorenko <khorenko@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4140;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=8ytuiULsyJ8GCK6BkCTcVg0Z22pwFQJoQSqUN4jBPwo=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq7j9FY6+VFr8UYcnA53WtID4/c39wnuObpLQLG
 xhEUW5OItOJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCau4/RQAKCRBRlgpH+WFc
 KhN1D/9zSWJWURpegXxA67uIcvpjYExl0kS8iPabm4rqY97wMLh1JA8y7V6A2jX3rqIIUxwTA/r
 Pq/LdLGg772JYqnvmyqfmbbgKBpiTh6ZbT3P9kPD5dOFP4hxVANmGBZi3eRsdU80UuVIHb+6y3Q
 qFYCAXliEb0PppssyXMyUpZIX8Gqw8SvzhQK72AA2NgEmNgkoqBKxxIOtZRaT8ikkWPB2FaX1mD
 h8Ygg27nLDTQpCEZpqMVctCcvM4B6pX7MBMmjavPy8CkqC3RkZzqFvvpuT0AAINcT/FM6w/Szfj
 7wGZ+dz2mnLr7NrEocHTgrm4oHXI/vlq+5wZCk0ZrzxixkcSq0nUpph5itTOIDvQVNDXyUMDS90
 9VLc5aCza7Hjggtl9xidiU6AFN1tgHFjiJlDsM+4gfDSDv1F3ckutuqCPDxomSErS/2/uuKy7qB
 W7ZHpclZO1a2v8VDQgqpDFqXsJuAYbXF7c+r5x2bvpR39onCQEde6pfA3h7FzTdgnfRtHXBK94B
 rLsEutGcInb0qSzSpoSZyi859fGPSLngq6nF9l5j6PL3bWMfm4SspA/snxe5k+HSuDTtjEbYRou
 05e0fpYwm78AlMyDZxy/aQZr6GKU8ZFILSUJJFq+/+63HdMKcWU/KifjyQOTXCvUbH2+8cylbrL
 V43JacsTV1QE3XQ==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

load_elf_phdrs() returns NULL on any failure, and load_elf_binary()
turns that into -ENOEXEC for the executable and -ELIBBAD for its
interpreter. So a failed allocation or read of the program headers
makes glibc's execvp() run the ELF file with /bin/sh, and for the
interpreter reports a healthy ld.so as a corrupted shared library.

Return an ERR_PTR instead:

  +------------+------------------------------------------------------+
  | error      | when                                                 |
  +------------+------------------------------------------------------+
  | -ENOEXEC   | bad e_phentsize, e_phnum or e_phoff, or a short read |
  | -ENOMEM    | the allocation fails                                 |
  | read error | kernel_read() fails                                  |
  +------------+------------------------------------------------------+

Malformed files and short reads keep getting -ENOEXEC and -ELIBBAD.
The table is read with kernel_read() directly, as elf_read() turns a
short read into -EIO. An e_phoff past LLONG_MAX - size is rejected up
front, so that rw_verify_area() does not turn it into -EINVAL.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 fs/binfmt_elf.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index bf7f8f47548d3..ee44a354c7243 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -512,39 +512,41 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
  *
  * Loads ELF program headers from the binary file elf_file, which has the ELF
  * header pointed to by elf_ex, into a newly allocated array. The caller is
- * responsible for freeing the allocated data. Returns NULL upon failure.
+ * responsible for freeing the allocated data. Returns an ERR_PTR upon failure:
+ * -ENOEXEC for a malformed header or a short read, the allocation or read
+ * error otherwise.
  */
 static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 				       struct file *elf_file)
 {
-	struct elf_phdr *elf_phdata = NULL;
-	int retval = -1;
+	struct elf_phdr *elf_phdata;
 	unsigned int size;
+	loff_t pos;
+	ssize_t rv;
 
 	/*
 	 * If the size of this structure has changed, then punt, since
 	 * we will be doing the wrong thing.
 	 */
 	if (elf_ex->e_phentsize != sizeof(struct elf_phdr))
-		goto out;
+		return ERR_PTR(-ENOEXEC);
 
 	/* Sanity check the number of program headers... */
-	/* ...and their total size. */
+	/* ...their total size and their offset. */
 	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
-	if (size == 0 || size > 65536)
-		goto out;
+	if (size == 0 || size > 65536 || elf_ex->e_phoff > LLONG_MAX - size)
+		return ERR_PTR(-ENOEXEC);
 
 	elf_phdata = kmalloc(size, GFP_KERNEL);
 	if (!elf_phdata)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	/* Read in the program headers */
-	retval = elf_read(elf_file, elf_phdata, size, elf_ex->e_phoff);
-
-out:
-	if (retval) {
+	pos = elf_ex->e_phoff;
+	rv = kernel_read(elf_file, elf_phdata, size, &pos);
+	if (rv != size) {
 		kfree(elf_phdata);
-		elf_phdata = NULL;
+		return ERR_PTR(rv < 0 ? rv : -ENOEXEC);
 	}
 	return elf_phdata;
 }
@@ -864,8 +866,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 
 	elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
-	if (!elf_phdata)
+	if (IS_ERR(elf_phdata)) {
+		retval = PTR_ERR(elf_phdata);
 		goto out;
+	}
 
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
@@ -968,8 +972,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		/* Load the interpreter program headers */
 		interp_elf_phdata = load_elf_phdrs(interp_elf_ex,
 						   interpreter);
-		if (!interp_elf_phdata)
+		if (IS_ERR(interp_elf_phdata)) {
+			if (PTR_ERR(interp_elf_phdata) != -ENOEXEC)
+				retval = PTR_ERR(interp_elf_phdata);
+			interp_elf_phdata = NULL;
 			goto out_free_dentry;
+		}
 
 		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
 		elf_property_phdata = NULL;

-- 
2.43.0

