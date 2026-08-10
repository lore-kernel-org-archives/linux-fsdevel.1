Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DE442FAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394494; cv=none; b=VS2dZrh3O/8xpdyDmKaLIr/oTWWFjA71NbH45WlmA2tMRZK/O8mym043aP9NchQS4SsKe6rcpw1Wh5wW9Rbujof0Gm66ZNFBOKifO5ZP0uke73CfC1U9aTAee8WgH0HbxoGIohZBgAX+WXKE5gxRnb+CxFuZB4mgHTf1TOLxb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394494; c=relaxed/simple;
	bh=11lwwhf51a8jtMkyr3zD1leOkoMzlOq+orz8Z8qYctM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=DXcj+Y/sSDd3ukSSX7YrtOORO7eNqoU8YlODvTwnjlG0z+8bC+Eqwl1dSxN4hL92ffW2b7uBVtRS4gHXqToMNFDEnW8bEWc7kyIwMMSB9W7HXiJUeVPGxeyFPDC82ZAqZO7X+0QVErZK8Xn8dWwi06ZffgrcpSOMzkKMl4YQZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=om7hJnVJ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="om7hJnVJ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e048a801dso3395032b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786394492; x=1786999292; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57hn69LoORcAARZ3NWfsdO/TCnOwkjz9mGtEcWdmx/M=;
        b=om7hJnVJ3mqP34q0TzG5UKRLU32GrspR1q4tLMKWGjACYntP9/09+3f4SHkBAUesx4
         qRkC/FEP/+KintcuMzyOxY3Mm9yoHPU4g1Wh4NhAyeAcEAVoQn2DZrqeXUSHnqJ//n9v
         qKeSNacC7MuwTHree9cM7PiEwGJ3zYHXF+ND8ZT9I5xRuMsTsJmd85dbmc7zYY4wnozG
         lfCQdHgJbSJIxYUJ4YQKnTcuwuKx+Ag705arnIBmIVSgHuALumh1RD88IELvECYXbnlo
         U6frCYxUZPT9c26opf+OWGbHWJbp5YqUNqMrP1LDb523B+Y51bXqa2fPme0uBC0RtEUs
         ni7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394492; x=1786999292;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57hn69LoORcAARZ3NWfsdO/TCnOwkjz9mGtEcWdmx/M=;
        b=XPA+gcpn1bo24uwQdSPhg/TNZuE/jDwm/yEcCW26pmbZ3R/g7WZuEg+nXYzCxcrBf/
         xTOBhtAMB7yZr8vZisi120aQiR5Wf40Yg29KQjJHV5rdl6Jm8VADLhJpFRynIASgOcqL
         0PPn2weFncD8S11hr2ofatps6myXFxI5aLjW9vlXAgwEU6ak7T5je0PjENthKedoTcmU
         m9QjagChqU53IIYN3r3uHNNzP0hvPEFsqf/9kkVeEhGCBsF2chUo22K8yOp2cGHzlcPL
         Mr/EQsAA+3RzBQVrlj3ktTppQ0/tAQWgQH2TnL40ESUXFyRjlZAoauSkFvrQJM4oRfMR
         nxTw==
X-Forwarded-Encrypted: i=1; AHgh+RqZqgdpJzaHSOKP+CzKe9pyNCd98zudoDJ0ltHsTL7ErJZZjnX2q/E8XggRZhDvkK8WmDk8lCpbNzH4Wd46@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxn+1MGh9cq3QpP4yeCZLBoo6hryPIYm8SPCghny98xspE03U
	cNX3EYzNQKyEra2UmToDUoyLzfY2J9ed9zjzWLL38imwMqttfhlgLh1yDt3yVUd6h5ysfQn0ZN6
	l
X-Received: from pgbeu25.prod.google.com ([2002:a05:6a02:4799:b0:c99:d21a:f6c5])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:93d0:0:b0:84f:a170:4f5b
 with SMTP id d2e1a72fcca58-84fa1705062mr1047736b3a.8.1786394491846; Mon, 10
 Aug 2026 13:41:31 -0700 (PDT)
Date: Mon, 10 Aug 2026 20:41:13 +0000
In-Reply-To: <20260810204118.1981755-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810204118.1981755-3-morbo@google.com>
Subject: [PATCH 2/2] vfs: Add KUnit tests for fdtable
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This adds a KUnit test suite for fdtable to verify correct allocation,
max_fds initialization, and dynamic object size of the fd array under
__counted_by_ptr when CONFIG_CC_HAS_COUNTED_BY_PTR is enabled.

This patch was generated by CodeMender and checked by submitter.

Cc: codemender-patching+linux@google.com
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 fs/Kconfig               |  8 ++++++++
 fs/file.c                |  4 ++++
 fs/tests/.kunitconfig    |  2 ++
 fs/tests/fdtable_kunit.c | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 fs/tests/.kunitconfig
 create mode 100644 fs/tests/fdtable_kunit.c

diff --git a/fs/Kconfig b/fs/Kconfig
index cf6ae64776e6..f4b9235ab883 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -423,4 +423,12 @@ source "fs/unicode/Kconfig"
 config IO_WQ
 	bool
 
+config FDTABLE_KUNIT_TEST
+	bool "KUnit test for fdtable" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the fdtable KUnit tests, which tests various aspects
+	  of the fdtable structure and allocation.
+
 endmenu
diff --git a/fs/file.c b/fs/file.c
index 628ca07dc4b1..9c7001b901cf 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1529,3 +1529,7 @@ int iterate_fd(struct files_struct *files, unsigned n,
 	return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+#ifdef CONFIG_FDTABLE_KUNIT_TEST
+#include "tests/fdtable_kunit.c"
+#endif
diff --git a/fs/tests/.kunitconfig b/fs/tests/.kunitconfig
new file mode 100644
index 000000000000..de67125a9421
--- /dev/null
+++ b/fs/tests/.kunitconfig
@@ -0,0 +1,2 @@
+CONFIG_KUNIT=y
+CONFIG_FDTABLE_KUNIT_TEST=y
diff --git a/fs/tests/fdtable_kunit.c b/fs/tests/fdtable_kunit.c
new file mode 100644
index 000000000000..41bae6b7400f
--- /dev/null
+++ b/fs/tests/fdtable_kunit.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+
+static void fdtable_test_alloc(struct kunit *test)
+{
+	struct fdtable *fdt;
+	unsigned int slots = 64;
+
+	fdt = alloc_fdtable(slots);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
+
+	/* Check that max_fds is set correctly and is >= slots */
+	KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
+
+	/* Check that fd is allocated */
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);
+
+	/* Check dynamic object size of fdt->fd if compiler supports __counted_by_ptr */
+#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+	KUNIT_EXPECT_EQ(test, __builtin_dynamic_object_size(fdt->fd, 0),
+			fdt->max_fds * sizeof(struct file *));
+#endif
+
+	/* Free the fdtable */
+	__free_fdtable(fdt);
+}
+
+static struct kunit_case fdtable_test_cases[] = {
+	KUNIT_CASE(fdtable_test_alloc),
+	{}
+};
+
+static struct kunit_suite fdtable_test_suite = {
+	.name = "fdtable",
+	.test_cases = fdtable_test_cases,
+};
+
+kunit_test_suite(fdtable_test_suite);
-- 
2.55.0.679.g6767b8d81c-goog

