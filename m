Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211162;
	b=peovP/DfdX1TXwIOSTKk5zEy7JmMLzdDLBp9EqSTNP2KHq5n1FaMvlfUxL9QcJAy/erk
	 DJC/tSGTMrGUfHnNG+0b3uBrl7+rmnblf7LQeQt6PeF2WoMjdhLHQP5Gb3cG4GVzS9XmR
	 pgZxW7l7xbwKXEcRgmAK1pLnm3JxHpl3wBDUhQFzynbqqm/TZOp1Jsgv+1msMozLLSe/K
	 1vDDUwV+0+6QyMGooXs8XDcq5F7AtY5eA0aRDFPIzf2LiW3waBLKEDV1OwKA1rE3zR+nv
	 krN6pWnTJhfev1SCAidz56EJgClLGXqy2IyRRdPv606PDYDkCs5OWGUfCtYcX9LNSAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SC+rlLyAXoWmtdm6xDuX7v9is1jRIFMfGWnpAh7mi7I=;
	b=neOyufcqc4U7r+4n0DSfFxUv3qP5ZzErx6RlyXtgZmJz9D/1EsuJF7tSn/MCgLzdZLYD
	 opA30jSj+/72YV6YkTLBpQgR1Go9fNrVph9QYcKLdXid4KRdQ1ttZ9Ui4ScY6X0vUZfb1
	 67foRE41ksTZpD4VBPfe6FpV2fVwEXwuzanKdg4in5+jQrrwWeDa7k5czGsKkuVmo0gRR
	 3QLvd0L+yNIA/Q8oaaQ3RAbGhxIRUpemS3bS0ELVztydhvJdzTXxhEFhpf1sLUOS9EqWb
	 xWG9tiTKaf9+sH+L74SFlgQShH8wsGZd7d215wrixB+w6p2nFLmGebhwgDcy94S64og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTqxRz3a;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027060A3829
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C027060A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTqxRz3a
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35b2c599f43so2729593eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211161; x=1793815961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SC+rlLyAXoWmtdm6xDuX7v9is1jRIFMfGWnpAh7mi7I=;
        b=LTqxRz3atU/3Py4bE5qrCwTTL8ubQSIxirokP4Nj/IxLMIPzl9oXnN9LNdj77gFs0c
         WHGFKwAOq9wdzrDMT1rXbBD16vZYrdFgx6JMXIwYdbszQvOW8oY8JaVpklu+ncMfvJuR
         UgmwVADOP+HqaUmMXCxpqEFbKoADiJQLx1xc5p8ZYDofEqFAbQLjFnniYr/MqlPLw6gV
         Wyf6Sx/MtbfCkx/Cxp0TBvYJCqBUVQCDDSd2K0wMCaz10bGNcD9cvX4OfzNcjQCubmfh
         ugSHppyZKaDVe1VC30/FyZ7RKTd2DJeQaQlP+dDF0hFV80Dz+GbY+jupPABB/1+Ra005
         oDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211161; x=1793815961;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SC+rlLyAXoWmtdm6xDuX7v9is1jRIFMfGWnpAh7mi7I=;
        b=Qa0HMBJYn12xdTl9CwzSQD/9NC9uAtSYPoJFDdOkYYxFU0LeMxqLAtoD1qIZaGWdlI
         KnqMnNKY7nJERorKEV8Qw/aUK0Eql/kYJBWnm5xQc7eKru4owQ0oJkNVlsCjv+G/oMoq
         vJYpi9xCYb8r1lWsIordkRtcBt7L8rBJ7J2PyVo9AFz5CVrPGEGL5WpXajwTYMdn/Vch
         Xr7d9pRO0A4XuyvYXXnxxSFHxJhZq3glO2ug8j1McISnGJUncu4EUH42x1d1QfbzOaMK
         Krtd13OYf86wb6328/4wM2JWXasazdqbfLiN6l2qStaQ0Qh06SBNltMUWcsDHc2fMmki
         mIcg==
X-Forwarded-Encrypted: i=1; AKwUvByk1edujtIhebbTCU1OdHCqt7wZYokk2zmuhDL7TIWpE3MtZb5wFw7LvLpv9l2w/a1S9s8638kzaOHyTp+w@vger.kernel.org
X-Gm-Message-State: AFq9FYLyQR3l8WefVQ7pylZPQDx79i3lRHRsmEqLnq7p4TDXeC8yBSHA
	hHmOVRqNlFUo5G6i3yz3W4pQ8lmdYqwu+opkMkB5JjF2a/X4Nlgx8Mt3
X-Gm-Gg: AYBFou2qtSMWIIgXpOHiYDEnpo6vE6cPTK1tVelvW5iM8fcR+K7Zcr+RlSid/So520r
	MOFmhP0mmQZqURk8pffvzboQ4DEtuNDpiPwjzBvrJTNv6Ko5nnEGIhjzuY4MgUTU7LAY3g/Unb0
	YAyKW1ETY5QhB9ypLD5w+0SY/xU6N6FnWcKRPo7To7qMLf/LNf7LReTBX/Y6kcFkPncDF4Sr5FK
	Ru+Sg4Zct8gKpJT6zkdj928Kb7uB8QRQLxzQExQfEzT2QYxFVAIJ8h8n7wW12aLur4V27XfQZzY
	KwfaBK5ms2DpOqex3cBL51m+GBqxMCmVsjajpm52a2iyxh0Dco/c4ef6sXY38RVpQ2cbotMp8bk
	/MSOX13COEmXfIsrlVyPr6ZUOwTnNwLc38w1te37S39OZy2LNg9TL929r6mfl+5tlbYe07yclCS
	j6O+P43fFCyMEhHSP0tuithWMX5Vi/xmXvwUZxzyFqOMt737hyE9g/vNYVYdVdT0+Jd5DIZeiCh
	+nOqcVR8fgUmWUHliiMnvIrL5YAo3TViu54GfmPLnKX5IQ7J/jTUA3NZnQl7IehZ9beBCbqWquw
	1sz+0N3E/u9q87DRy96DYxY=
X-Received: by 2002:a05:7300:cb0b:b0:351:4866:255c with SMTP id 5a478bee46e88-36a204a1735mr5413054eec.32.1793211160870;
        Wed, 28 Oct 2026 11:12:40 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da675sm8309394eec.5.2026.10.28.11.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:12:40 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v1 2/2] netfs: add KUnit coverage for reissue prepare_write errno
Date: Wed, 28 Oct 2026 15:12:29 -0300
Message-ID: <20261028181229.1408342-3-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
References: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stub netfs_write_subrequest_terminated() and call netfs_reissue_write()
with FAILED + -EIO.  Unpatched trees terminate with 0; patched keep -EIO.

  ./tools/testing/kunit/kunit.py run --kunitconfig=fs/netfs/.kunitconfig \
	netfs_reissue_write*

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 fs/netfs/.kunitconfig          |  3 ++
 fs/netfs/Kconfig               |  9 +++++
 fs/netfs/Makefile              |  2 +
 fs/netfs/write_collect.c       |  4 ++
 fs/netfs/write_reissue_kunit.c | 73 ++++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+)
 create mode 100644 fs/netfs/.kunitconfig
 create mode 100644 fs/netfs/write_reissue_kunit.c

diff --git a/fs/netfs/.kunitconfig b/fs/netfs/.kunitconfig
new file mode 100644
index 000000000000..c783d180ab8f
--- /dev/null
+++ b/fs/netfs/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_NETFS_SUPPORT=y
+CONFIG_NETFS_KUNIT_TESTS=y
diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index d0e7b0971fa3..d796dbe4bd7c 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -33,6 +33,15 @@ config NETFS_DEBUG
 	  management module.  If this is set, the debugging output may be
 	  enabled by setting bits in /sys/module/netfs/parameters/debug.
 
+config NETFS_KUNIT_TESTS
+	tristate "KUnit tests for netfs" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select NETFS_SUPPORT
+	help
+	  This builds netfs KUnit tests (e.g. write reissue errno).
+	  Say N unless developing netfs.
+
 config FSCACHE
 	bool "General filesystem local caching manager"
 	depends on NETFS_SUPPORT
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 54834cde7e56..fa1544b9a199 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -33,4 +33,6 @@ netfs-$(CONFIG_FSCACHE) += fscache_proc.o
 endif
 netfs-$(CONFIG_FSCACHE_STATS) += fscache_stats.o
 
+netfs-$(CONFIG_NETFS_KUNIT_TESTS) += write_reissue_kunit.o
+
 obj-$(CONFIG_NETFS_SUPPORT) += netfs.o
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 6e8ea534230d..f3236fe494bf 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
+#include <kunit/static_stub.h>
 #include "internal.h"
 
 /* Notes made in the collector */
@@ -529,6 +530,9 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error)
 	struct netfs_io_subrequest *subreq = _op;
 	struct netfs_io_request *wreq = subreq->rreq;
 
+	KUNIT_STATIC_STUB_REDIRECT(netfs_write_subrequest_terminated,
+				   _op, transferred_or_error);
+
 	_enter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_or_error);
 
 	switch (subreq->source) {
diff --git a/fs/netfs/write_reissue_kunit.c b/fs/netfs/write_reissue_kunit.c
new file mode 100644
index 000000000000..fca5f7dd9265
--- /dev/null
+++ b/fs/netfs/write_reissue_kunit.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * netfs_reissue_write must not clear prepare_write() errno.
+ */
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+#include <linux/uio.h>
+#include "internal.h"
+
+struct term_capture {
+	ssize_t transferred_or_error;
+	bool called;
+};
+
+static void capture_terminated(void *_op, ssize_t transferred_or_error)
+{
+	struct netfs_io_subrequest *subreq = _op;
+	struct term_capture *cap = kunit_get_current_test()->priv;
+
+	cap->called = true;
+	cap->transferred_or_error = transferred_or_error;
+	/* Mirror production: leave subreq->error as prepare_write set it. */
+	(void)subreq;
+}
+
+/*
+ * prepare_write_failed() sets FAILED + errno, then write_retry still calls
+ * reissue_write().  Before the fix, reissue wiped error to 0 so terminated
+ * reported success and mapping_set_error(0) was a no-op.
+ */
+static void reissue_preserves_prep_error(struct kunit *test)
+{
+	struct term_capture cap = {};
+	struct netfs_io_request wreq = {};
+	struct netfs_io_stream stream = {
+		.source = NETFS_UPLOAD_TO_SERVER,
+	};
+	struct netfs_io_subrequest subreq = {
+		.rreq = &wreq,
+		.len = 1,
+		.transferred = 0,
+		.error = -EIO,
+		.source = NETFS_UPLOAD_TO_SERVER,
+	};
+	char buf[1] = { 0 };
+	struct kvec kvec = { .iov_base = buf, .iov_len = 1 };
+	struct iov_iter source;
+
+	__set_bit(NETFS_SREQ_FAILED, &subreq.flags);
+	iov_iter_kvec(&source, ITER_SOURCE, &kvec, 1, 1);
+
+	test->priv = &cap;
+	kunit_activate_static_stub(test, netfs_write_subrequest_terminated,
+				   capture_terminated);
+
+	netfs_reissue_write(&stream, &subreq, &source);
+
+	KUNIT_EXPECT_TRUE(test, cap.called);
+	KUNIT_EXPECT_EQ(test, cap.transferred_or_error, -EIO);
+	KUNIT_EXPECT_EQ(test, subreq.error, -EIO);
+}
+
+static struct kunit_case netfs_reissue_test_cases[] = {
+	KUNIT_CASE(reissue_preserves_prep_error),
+	{}
+};
+
+static struct kunit_suite netfs_reissue_test_suite = {
+	.name = "netfs_reissue_write",
+	.test_cases = netfs_reissue_test_cases,
+};
+
+kunit_test_suite(netfs_reissue_test_suite);
-- 
2.43.0

