Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC223E25B;
	Mon, 23 Mar 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278069; cv=none; b=BBACPkzqD8Mwb8yQvn4TsZQDJzaA7L9ILhgTjhdg7W3MMVWLyFosjYrK/bMRgY2Td685wpoquED3dzLUzIyiRDb2KIYwN3AUQj/pF5HcWHdiwe5nI+sTrXLm9Krq/1wQcu4QKtg19SXuMo2CuybBkq16EZSxMHik4jmJ9LGX7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278069; c=relaxed/simple;
	bh=u18iTr5PRqvoh7iTQu1HrKZDXlL61UdRdRTUhmb3GAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0yLUfWT3/4+C3JEXI9BpOhzRCWaOCGBD4QB6uvJdn18TRMeqmyCa8+z9922tIL4R3q5omK7m/1Q/QCvXAf4BQF8psZfMtC+zjdwlh+m9Gq6eJSp2pCrFHwJqdJtYE/kC9lkau/m/1YR4fW6hYpy+NOMHrf/VvCpM5oBzIJrOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCQ73ImG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCQ73ImG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774278068; x=1805814068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u18iTr5PRqvoh7iTQu1HrKZDXlL61UdRdRTUhmb3GAk=;
  b=bCQ73ImGlcyJTVa0/y61mhdenI6Ulxl4wiwWFCGz4xK7a68KlLm9zV8P
   kOG/T+eNvVucgAa8jSkmY0FUh3nnxFFdjp9j8ASDbKQvC+0fmrqbj67jZ
   h65Rd/BqXW5gU9gy8si/1ToUtvnIgx42nljk/F2tr8stpySlFyd+Ihw3z
   Z4vCMsD3iRhITExMctPmyH2kIoeBc1aUN+Bu8UkQsNYHjriugjWpW5Ez6
   tnJWjtUaUcogVyfnt6gQ5xxR24e1jQMdtpoexyS3FnjlSSxoJTv1tfE4E
   DEBbkpiOL/yCKt4EOpLx+e4KGypCWWNU5qSNK/CnstCbWbkhyQSi460jR
   g==;
X-CSE-ConnectionGUID: BBsV0ENwQYGtnxbV1956HQ==
X-CSE-MsgGUID: 9dcFxjz3QoGqFkGqm5nPlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74456159"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74456159"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:01:05 -0700
X-CSE-ConnectionGUID: 0c6tXsbPTFWJy3QS4RAtCQ==
X-CSE-MsgGUID: Cj7h1WmARQqc+04u/NdEDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223119641"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 23 Mar 2026 08:01:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 251569B; Mon, 23 Mar 2026 16:01:00 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Disseldorp <ddiss@suse.de>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 2/6] initramfs_test: test header fields with 0x hex prefix
Date: Mon, 23 Mar 2026 15:54:18 +0100
Message-ID: <20260323150054.3587083-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Disseldorp <ddiss@suse.de>

cpio header fields are 8-byte hex strings, but one "interesting"
side-effect of our historic simple_str[n]toul() use means that a "0x"
(or "0X") prefixed header field will be successfully processed when
coupled alongside a 6-byte hex remainder string.

"0x" prefix support is contrary to the initramfs specification at
Documentation/driver-api/early-userspace/buffer-format.rst which states:

  The structure of the cpio_header is as follows (all fields contain
  hexadecimal ASCII numbers fully padded with '0' on the left to the
  full width of the field, for example, the integer 4780 is represented
  by the ASCII string "000012ac"):

Test for this corner case by injecting "0x" prefixes into the uid, gid
and namesize cpio header fields. Confirm that init_stat() returns
matching uid and gid values.

This test can be modified in future to expect unpack_to_rootfs() failure
when header validation is changed to properly follow the specification.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs_test.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 7b6ecab794c7..4d9a4075476c 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -495,6 +495,65 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	kfree(tbufs);
 }
 
+static void __init initramfs_test_hdr_hex(struct kunit *test)
+{
+	char *err, *fmt;
+	size_t len;
+	struct kstat st0, st1;
+	char fdata[] = "this file data will be unpacked";
+	struct initramfs_test_bufs {
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
+	} *tbufs = kzalloc(sizeof(struct initramfs_test_bufs), GFP_KERNEL);
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.uid = 0x123456,
+		.gid = 0x123457,
+		.nlink = 1,
+		.namesize = sizeof("initramfs_test_hdr_hex_0"),
+		.fname = "initramfs_test_hdr_hex_0",
+		.filesize = sizeof(fdata),
+		.data = fdata,
+	}, {
+		.magic = "070701",
+		.ino = 2,
+		.mode = S_IFDIR | 0777,
+		.uid = 0x000056,
+		.gid = 0x000057,
+		.nlink = 1,
+		.namesize = sizeof("initramfs_test_hdr_hex_1"),
+		.fname = "initramfs_test_hdr_hex_1",
+	} };
+	/*
+	 * override CPIO_HDR_FMT and instead use a format string which places
+	 * "0x" prefixes on the uid, gid and namesize values.
+	 * parse_header()/simple_str[n]toul() accept this.
+	 */
+	fmt = "%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s";
+	len = fill_cpio(c, ARRAY_SIZE(c), fmt, tbufs->cpio_src);
+
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
+	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
+
+	KUNIT_EXPECT_TRUE(test,
+		uid_eq(st0.uid, make_kuid(current_user_ns(), (uid_t)0x123456)));
+	KUNIT_EXPECT_TRUE(test,
+		gid_eq(st0.gid, make_kgid(current_user_ns(), (gid_t)0x123457)));
+	KUNIT_EXPECT_TRUE(test,
+		uid_eq(st1.uid, make_kuid(current_user_ns(), (uid_t)0x56)));
+	KUNIT_EXPECT_TRUE(test,
+		gid_eq(st1.gid, make_kgid(current_user_ns(), (gid_t)0x57)));
+
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+
+	kfree(tbufs);
+}
+
 /*
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
@@ -508,6 +567,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_many),
 	KUNIT_CASE(initramfs_test_fname_pad),
 	KUNIT_CASE(initramfs_test_fname_path_max),
+	KUNIT_CASE(initramfs_test_hdr_hex),
 	{},
 };
 
-- 
2.50.1

