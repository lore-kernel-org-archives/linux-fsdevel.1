Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237513E51FE;
	Wed, 26 Aug 2026 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741263; cv=none; b=bTeV1Ue+LmuDZE3Ao3iq6R4/70GJ4AGZ8sBf8iV+745b/+qU2ZQ9qnKxscX7BAp3IGDwnxlcVieo2F5JnE7oaisxTmDoOKtUDzShwTqpc/ItugQO/UAoDsEODt/ZxGBwdnV7VdVrRsuFdLXbo8CDIG1HLkiWUxkYWUw1UwCnuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741263; c=relaxed/simple;
	bh=EsCfNGDMAD0kqB2bJvJPVAMQnbDdNoA3cfyCUB4ulu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qetruMOZ6KpgwsBOqSFRTsexytMLnZsbbfC+cB2C9NgY6dTIQztwg8MnFSZ2kYU54vqoGHHmV3h/DsF8WXJ/tqHEzhF5XRhfnrdYrknBe7XsIHniw5B1i5VjtTcWafpkauoVyuhfSFeV69k7KIxr947bxdCMCyXNfO31/dAT6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=p87huBnn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="p87huBnn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=VQVWFa01CPFDyXs47ACU6VBWm1qbgJ5kbePtNrURpkQ=; b=p87huBnn0HXuiAqTqalC8qEBqZ
	fsBngg3Foh2e04znsjcMVyPqFknD/5UC0oQmQRaQsafZqvU8dVZ6odW/zggpHE4+W4IdtTF/fWauy
	KKgeoaZ7rReRnTP31YBtryKXqBpnrrLL5gaKVnQ5vOKTK5C0mwcKTM16vScHmHPmJQQ1SmvEyJiK/
	xbhoat5fg1Ws0xAlLJW5vXRU7AFd+GC5VEJrfaMTeylVX2X64WZRhVHg31zzUp9hFS0M4qCpTMW8Z
	b6AgJfirSQZV9d2ZfQMKjJISy8NKn3N1TvstkF+6Wl/ee6utw2WbbX8s61rlN3/Ax+gDIt+sdUBYE
	Zg24As4g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzBAJ-00FA18-02;
	Wed, 26 Aug 2026 10:47:31 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 26 Aug 2026 03:47:04 -0700
Subject: [PATCH 3/4] selftests/configfs: cover symlink and unlink
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-config_selftest-v1-3-e364b07e91ac@debian.org>
References: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
In-Reply-To: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
To: Shuah Khan <shuah@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 gustavold@gmail.com, linux-fsdevel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 vasilisalmpanis@gmail.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=4576; i=leitao@debian.org;
 h=from:subject:message-id; bh=EsCfNGDMAD0kqB2bJvJPVAMQnbDdNoA3cfyCUB4ulu0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjsQz/hePnaPXqpVkzcWaZVOY88OTjEBJTpz48
 goLeTDxOtOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCao7EMwAKCRA1o5Of/Hh3
 bT+OD/9lFh69T1a8+mXdx2+tpIMeYAFdbcvEJeYYcC0U7UNYswF/oN/P3xYCVnB3190AfJPNwct
 ZPfnrpVZC6VWAAdGjlx/7wrcDFqJ+jdfp9HvNZl+eGh9nXYwyCV9KGSYt+6TJtQ5iKtHwP/ehp/
 0BXONonHJveSlLZ05zVhti/fWq6VlF/yFZVSCXC/kDzCbqKShIbmKe6BZgjCsRNi6VZ6F0VFYF2
 XkXYWCrGll4wbpNJQw9ZWn7qT9STeLE+d5oEpDwPFpZ+MQOIr7O7/qGrjNaFqHJfbAWzJJT5GL0
 Ut4z9FFvBFzPRn/2UnftuKLeegSdd28A6mGgfTkpm0LyQvYxoUhFsoyUm9U7NpNP6g/vVrCOHXO
 uZIqOMWVcnSTiQZXUnvNvXmGazjOk45V2E/3u9inm2SY3yeGW6mFCrV76UdmZG25ZiAZqXtgBbm
 G6s5NibSdBrGmf6vL+JS/n3bjZipn3LGt8PYSSzJIHly5Mu22NX6K/Kh20rlTnPai1dTUJu+wnM
 IrH4b3/xdjZURVXcGHl8u1fI5Ph9U3JFSJV06SrwKbSQ4vxPcP669f1BtYFAAN09rwffgvpk8fs
 rdXIvhRbXsAw4Nnoi0A8DQPEnkLJfH223FTli1bdmGPcQA8k4DMqmqGgCBdVPoR8UtB3uIGEOXq
 lzPcvX/FogNaYyg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

samples/configfs had nothing to link from, so symlink(2) went untested
beyond the EPERM a subsystem without ->allow_link() returns.

Cover creating and removing a link, the relative body configfs stores, the
count ->allow_link() and ->drop_link() keep, the busy errors both ends
return, and what get_target() rejects.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/filesystems/configfs/configfs_test.c | 85 +++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/configfs/configfs_test.c b/tools/testing/selftests/filesystems/configfs/configfs_test.c
index 072d0dcf3f96b..9b15e1fd69e5b 100644
--- a/tools/testing/selftests/filesystems/configfs/configfs_test.c
+++ b/tools/testing/selftests/filesystems/configfs/configfs_test.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Exercise the configfs userspace interface through the three subsystems
+ * Exercise the configfs userspace interface through the subsystems
  * registered by samples/configfs.
  *
  * Copyright (c) 2026 Meta Platforms, Inc. and affiliates
@@ -10,6 +10,7 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -31,16 +32,24 @@
 #define CHILDLESS		"01-childless"
 #define SIMPLE			"02-simple-children"
 #define GROUPS			"03-group-children"
+#define SYMLINKS		"04-symlink-children"
 
 #define ITEM_A			SIMPLE "/kselftest-a"
 #define ITEM_B			SIMPLE "/kselftest-b"
 #define GROUP			GROUPS "/kselftest-group"
 #define GROUP_ITEM		GROUP "/kselftest-a"
+#define LINK_SRC		SYMLINKS "/kselftest-src"
+#define LINK			LINK_SRC "/kselftest-link"
+
+static const char * const test_links[] = {
+	LINK,
+};
 
 /* Deepest first, so one pass empties the tree. */
 static const char * const test_dirs[] = {
 	GROUP_ITEM,
 	GROUP,
+	LINK_SRC,
 	ITEM_A,
 	ITEM_B,
 };
@@ -49,6 +58,10 @@ static void drop_test_dirs(void)
 {
 	size_t i;
 
+	/* Links first: they hold both their source and their target. */
+	for (i = 0; i < ARRAY_SIZE(test_links); i++)
+		unlink(test_links[i]);
+
 	for (i = 0; i < ARRAY_SIZE(test_dirs); i++)
 		rmdir(test_dirs[i]);
 }
@@ -131,7 +144,7 @@ FIXTURE_TEARDOWN(configfs)
 
 TEST_F(configfs, mount_and_subsystems)
 {
-	const char * const subsys[] = { CHILDLESS, SIMPLE, GROUPS };
+	const char * const subsys[] = { CHILDLESS, SIMPLE, GROUPS, SYMLINKS };
 	struct statfs sfs;
 	struct stat st;
 	size_t i;
@@ -324,6 +337,74 @@ TEST_F(configfs, symlink_without_allow_link)
 	EXPECT_EQ(errno, EPERM);
 }
 
+TEST_F(configfs, symlink_and_unlink)
+{
+	char buf[PATH_MAX];
+	struct stat st;
+	ssize_t n;
+
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+	ASSERT_EQ(mkdir(LINK_SRC, 0755), 0);
+
+	ASSERT_EQ(symlink(ITEM_A, LINK), 0);
+
+	/* configfs stores its own body, a path relative to the link. */
+	n = readlink(LINK, buf, sizeof(buf) - 1);
+	ASSERT_GT(n, 0);
+	buf[n] = '\0';
+	EXPECT_STREQ(buf, "../../" ITEM_A);
+	EXPECT_EQ(stat(LINK "/storeme", &st), 0);
+
+	/* ->allow_link() ran on the source, not on the target. */
+	ASSERT_GT(read_attr(LINK_SRC "/nlinks", buf, sizeof(buf)), 0);
+	EXPECT_STREQ(buf, "1\n");
+
+	ASSERT_EQ(unlink(LINK), 0);
+	ASSERT_GT(read_attr(LINK_SRC "/nlinks", buf, sizeof(buf)), 0);
+	EXPECT_STREQ(buf, "0\n");
+}
+
+TEST_F(configfs, symlink_pins_both_ends)
+{
+	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);
+	ASSERT_EQ(mkdir(LINK_SRC, 0755), 0);
+	ASSERT_EQ(symlink(ITEM_A, LINK), 0);
+
+	/* A linked item cannot go away under the link. */
+	ASSERT_EQ(rmdir(ITEM_A), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	/* The link counts as a child of its source. */
+	ASSERT_EQ(rmdir(LINK_SRC), -1);
+	EXPECT_EQ(errno, ENOTEMPTY);
+
+	ASSERT_EQ(unlink(LINK), 0);
+	EXPECT_EQ(rmdir(ITEM_A), 0);
+}
+
+TEST_F(configfs, symlink_target_outside_configfs)
+{
+	ASSERT_EQ(mkdir(LINK_SRC, 0755), 0);
+	ASSERT_EQ(symlink("/", LINK), -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_F(configfs, symlink_target_missing)
+{
+	ASSERT_EQ(mkdir(LINK_SRC, 0755), 0);
+	ASSERT_EQ(symlink(SIMPLE "/kselftest-gone", LINK), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+TEST_F(configfs, symlink_target_is_an_attribute)
+{
+	ASSERT_EQ(mkdir(LINK_SRC, 0755), 0);
+
+	/* The target is resolved with LOOKUP_DIRECTORY. */
+	ASSERT_EQ(symlink(CHILDLESS "/storeme", LINK), -1);
+	EXPECT_EQ(errno, ENOTDIR);
+}
+
 TEST_F(configfs, module_pinned_by_item)
 {
 	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);

-- 
2.53.0-Meta

