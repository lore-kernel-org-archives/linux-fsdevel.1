Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCB4734CC;
	Mon, 21 Sep 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987566; cv=none; b=ePcLqdB/4wN8Jt4rKd8Zf0ZQSiR3Zd6PF6YkUHws/l9ESurlqaESjD0+QEmvCUnSlLCtFLuKRJUq22Q/ltGYBg1eAZkyUAEEe0ICEy2u0VuPAaBY0mpirB/ccBjRAyHKLNiI5QvIXmZMCln5gmky/ObnJG8/xJziTz8IYM9IwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987566; c=relaxed/simple;
	bh=p8yNUkMitpwgzvs+cGgbKwO3+XbwijnQD+AZR0s4TxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q7mSbohjp7AESf/9p5DOgbL/3/TjZqQYMegiHnmK7J9Ah3xRFuFgCFkjcVKKSrbZFaGHWte5Vap6peB1dEF07PCFl36VeBdpvqbYoUafbRx4bv3bVQoPT1kya6nee1rsiYiijFIZwgy02GNn0NGSPlfydRKvc48WqgeLMw1M9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mYcyu6dD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mYcyu6dD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=GnSX7BDD3R3C62GVxOXhW1Ll8Ux6h+dSNtOidsNAaz8=; b=mYcyu6dDYCrgItiCp3xqx7/kZ0
	RyXIRnMMl4oGyDBjhdx9EzNkDCcFPlaFNvN2/OJmKcVlVme9qM7JDGIfonToacq33tg/Pb0YnZ+ap
	sxANbuUsf6tMT79gQPssXqaQaMb3P+mRLXioYC1y9ycRUZjLyjt1acvyUr33KflM8fXBzNcJE5ZaS
	zdTKVkaTigFv4DPTQFpRub5+cSxSXjPEo0YaSTS/q+9J6zlq4tpw6VnuFVip1YOOMnnRjOTHDs1TT
	+fgaVOC4maGto2Qm5khCHKxtpfGtm6QgZEqyJVVjAXpYjDhOzG4kylcKofrEim6vtykJSvcpGGT5A
	/tMWDO6Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x8bX0-0029FF-1N;
	Mon, 21 Sep 2026 10:45:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 21 Sep 2026 03:45:42 -0700
Subject: [PATCH] vmcore: report the release of the crashed kernel
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
X-B4-Tracking: v=1; b=H4sIANUKsWoC/x3MYQqEIBAG0KsM3++EjBLzKsuyWE01RCa6RRDdP
 egd4F3InIQzHF1IfEiWLcCRLgj97MPESgY4QlVWpmy1Vcuwr/EXk4S/skb7uu1sY3qPghATj3K
 +2+d73w+I2cmPXQAAAA==
X-Change-ID: 20260918-kdump_print-861a49b856ca
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2601; i=leitao@debian.org;
 h=from:subject:message-id; bh=p8yNUkMitpwgzvs+cGgbKwO3+XbwijnQD+AZR0s4TxU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqsQrdNWo2mbPeqC2ctKM0U9OzNzT6UnZB7Ey9u
 HNsJAEFUjmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCarEK3QAKCRA1o5Of/Hh3
 bWnFD/0aDxinGR9m/HMt2DWUe2YmNdnYA4+TFUkLfyH9ek09lNxVLMsGeg01Ybgytzp7hscVcib
 Pabef81sLVvPCWaZCfvfE3lT/ab8LlbbWoaSUXqLx04n6HMQJRVlCKBagz6vi2clrVb++d1BC76
 Q+LFjUu90YlSOgCd8esIRs4WMLC0d5tit7OQ2FrtS/+HNaXnHJzEyr+vpzvjdV6xXk1x7OZZqrR
 No/L9vmFy8qT/EdcDQa+Tipk4Q67UBaME0IDJU/VsP3CPmr2cJgEB32HqVJ891KxRR2aG4Cy2jH
 ZaoYhU9K6jNgqx/xkvgQyIsJ7k32X9jfMAWodyJfYx+Xk/mJi6PcO62qiLRhP9M4p5oGebBONBv
 LiJ7KAVAzoHmrnrYuecoIOl4jpLtvplIEp0EHVghWeFlknU1R9Yb5HeWFsB8VW48TKcOaDkZqgh
 CVIsk2AL39Xy7pYRF7fHn2xAIS9D/48Ej8opUF+5w+WtPfx/pGCiqyy5E6xmdOtgGq9esNaLtj6
 SGAvqzhWmlCuCZQVQbxz0mjyl+FLdcq+1mknTHu1rUW1I/tIr8VBKa5KOpfMc+MdYc6vt1TR7To
 ub5cjYzOTC79K2XukZN7JkFsMsbGvEsVUykxrHSunUv9mDCu8oX1B9hBXYz4hu6rukmNHdFsTou
 XpGGy3SMPhl07cQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

kdump runs in a very small environment and cut-down set of drivers, and
it can die before the dump lands: it runs out of memory, a device hangs
on reset, or a watchdog fires while the dump is still being written out.
This happens about a single high digit percentage on most of big scale
datacenters.

When that happens the only evidence left is what the capture kernel
printed to the console, and that does not say which kernel crashed.

A fleet typically pins one kdump image and boots it after crashes from
many different production kernels, and it is useful to understand what
are the combination of crashed kernel panic and succesful kdump
collection.

Whether the dump completes at all tends to depend on the kernel that
died: memory pinned, devices in flight, dump size.

The release is already recorded.  crash_save_vmcoreinfo_init() puts
OSRELEASE= in the VMCOREINFO note, and by the time vmcore_init() has run
parse_crash_elf_headers() that note sits in elfnotes_buf.  Walk the notes
for it and print:

  vmcore: dump is from kernel 7.3.0-rc3-next-20260917

Given this is cheap and useful, I think it is worth adding to vmcore, to
improve kdump monitoring.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/proc/vmcore.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 44d15436439fd9..406898247d7af1 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1709,6 +1709,24 @@ static void vmcore_free_device_dumps(void)
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 }
 
+#define VMCOREINFO_OSRELEASE_KEY	"OSRELEASE="
+
+static void __init vmcore_report_crashed_release(void)
+{
+	const char *ver, *eol;
+
+	ver = strnstr(elfnotes_buf, VMCOREINFO_OSRELEASE_KEY, elfnotes_sz);
+	if (!ver)
+		return;
+
+	ver += sizeof(VMCOREINFO_OSRELEASE_KEY) - 1;
+	eol = memchr(ver, '\n', elfnotes_buf + elfnotes_sz - ver);
+	if (!eol)
+		return;
+
+	pr_notice("dump is from kernel %.*s\n", (int)(eol - ver), ver);
+}
+
 /* Init function for vmcore module. */
 static int __init vmcore_init(void)
 {
@@ -1733,6 +1751,8 @@ static int __init vmcore_init(void)
 	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 
+	vmcore_report_crashed_release();
+
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;

---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260918-kdump_print-861a49b856ca

Best regards,
--  
Breno Leitao <leitao@debian.org>

