Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5383E3D86;
	Wed, 26 Aug 2026 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741272; cv=none; b=AiWrcEGM0ge59b2hOiPfZPyOWaW7zBuTOwCEVcpI4OtL7TG2K0vw5pNLNOkslil7r8zho/LyUKSjrJNcqB4kWUGWAr7dy3cw3PLlILnnHPynRt1Nl8g0KmisQ8tRytz66HhXYZtqg6XXzlPrtY6sSg47wWsFQAXFNit2XuF3wMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741272; c=relaxed/simple;
	bh=GkzTfTFbLQND+U+cNyP76kQ59TA5pINipegGDM2lRpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJhU/uL8jZpbnDxLeXcXZXYRr84goHnhslyXwAE6HH8D5tA6JwrdJrfzAHnx7bG0qK64E+k3yAM67Om+OYzcyF9NSApwrieBihW4sL0bmCKxP0ogEu2lypv26c2vRBwtc8BwAPDs893oQ3cgb+YgApmJ0UxHRI2M4mZ+Y80YOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PAFkpgUv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PAFkpgUv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=tT85b5NbK6bRM9en6qm/KfwNm49d+ZHKHssrA665pMw=; b=PAFkpgUvM2CGE9ZPFA6++L8Bya
	kk6kKe9YHglCuXt+97yD8XJFgU4t1D6YIKh79ld5NZ2egxvmdMp5BH1hUCrxN0u/S7CSbPaXUjbo7
	uRBwAo9rmVVj1uXKiGVLr0uymSlK/eNsOb+CZAYQz722xvG27Fh8J/ztjHpNZ/GBb655gPPE7COwK
	lm00kf6VQF2kpsKcA5czzrSQ+jDIujgS/2qZKPjyNdO4jv0+tKGiyjvdaOTSfT+trvuuT5uGWJqrI
	yql7/DRoIZU2zDIe98S51h9CtYc190vO/MwSGNLgA9wDgfd+VUIkVNpEKMl/ug5flbn/VL734YzK8
	j6CEom+Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzBAM-00FA1G-36;
	Wed, 26 Aug 2026 10:47:35 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 26 Aug 2026 03:47:05 -0700
Subject: [PATCH 4/4] selftests/configfs: race symlink against rmdir of the
 target
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-config_selftest-v1-4-e364b07e91ac@debian.org>
References: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
In-Reply-To: <20260826-config_selftest-v1-0-e364b07e91ac@debian.org>
To: Shuah Khan <shuah@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 gustavold@gmail.com, linux-fsdevel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 vasilisalmpanis@gmail.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3688; i=leitao@debian.org;
 h=from:subject:message-id; bh=GkzTfTFbLQND+U+cNyP76kQ59TA5pINipegGDM2lRpg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjsQzVqC+PwufOkmq+yuSfBUzFxuQ3bTp68IE2
 ma7cvb7mBqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCao7EMwAKCRA1o5Of/Hh3
 bTuXD/0bIXrSL3l1F9U1heqW28ABmDwM8hA2nAqvTtYDSPxpvjAQVRqva6hA9B433BcqvzQ10jT
 9yrpeSbithEsFY1kengjlhrGjg08yMqtYBpw5dEF+BJ5fcuNwFM1Kq2At2urYBaWYv8sIiBhy4U
 7VAUnbuLRuW4A62nzw5Dkn7Afa6e/SzuDH6cCiXIS8k2bQoA2oW4BqUyYMBwUssd9HCmLHwK1yr
 6RVpW6GX+d5x6GFWYDuZcx0tYgUtFqXUNkfXLucbnBFXU5xl6EzzJy+hYw+GqF+5qWTXkQwqYnM
 ILi0Qy3lPOMp7S7u9AAc0nLXYYigm9oUu4eCoPgoyymsUEChIe3/F/43mNNhsx+IU8Hk3v2/giH
 xRthjFt4/hZsYwGwfJKytpISrOu1oPyd9d0pB06NuQEair9mi/ZspDvDZScOdg/D4vzMKUFDx8w
 9oof2KEnzfTgAsj7aZF6+jZGWGrzMSg8cthBRORqvWx/ANPviYX5itpyUB+Oo/PKErqqoUxewAx
 WSlbDNkfluRp8IbNJjZ8vBsFgoPRU5pXj0vRpoghIQ0FrDfMKzPx0jVixoKlnxPOtOql4N07cDm
 SPpWDHP3fQMBGYP8i+orYHs1/JHrK0GXObbAGrddWEwS6v9+w9u7FYDnZbSEUuS/iiLqGfGIuGN
 dF7R8x3peBbOApg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

configfs_rmdir() drops the last reference to an item while its dentry is
still hashed, so a symlink(2) resolving that target takes a reference on
freed memory.  syzbot reported it [1].

Race mkdir/rmdir of a target against symlink/unlink of a link to it,
watching /sys/kernel/warn_count.

Fails until the fix [2] lands.

Link: https://syzkaller.appspot.com/bug?extid=6b16e3d085833cbf3e25 [1]
Link: https://lore.kernel.org/all/20260730093435.195441-1-vasilisalmpanis@gmail.com/ [2]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/filesystems/configfs/Makefile        |  2 +-
 .../selftests/filesystems/configfs/configfs_test.c | 62 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/configfs/Makefile b/tools/testing/selftests/filesystems/configfs/Makefile
index 359296356c831..40a91ed788ed2 100644
--- a/tools/testing/selftests/filesystems/configfs/Makefile
+++ b/tools/testing/selftests/filesystems/configfs/Makefile
@@ -2,7 +2,7 @@
 # Copyright (c) 2026 Meta Platforms, Inc. and affiliates
 # Copyright (c) 2026 Breno Leitao <leitao@debian.org>
 
-CFLAGS += -Wall -Werror
+CFLAGS += -Wall -Werror -pthread
 TEST_GEN_PROGS := configfs_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/configfs/configfs_test.c b/tools/testing/selftests/filesystems/configfs/configfs_test.c
index 9b15e1fd69e5b..c6a1049e5852e 100644
--- a/tools/testing/selftests/filesystems/configfs/configfs_test.c
+++ b/tools/testing/selftests/filesystems/configfs/configfs_test.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <pthread.h>
 #include <sched.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -41,6 +42,8 @@
 #define LINK_SRC		SYMLINKS "/kselftest-src"
 #define LINK			LINK_SRC "/kselftest-link"
 
+#define RACE_ITERATIONS		20000
+
 static const char * const test_links[] = {
 	LINK,
 };
@@ -405,6 +408,65 @@ TEST_F(configfs, symlink_target_is_an_attribute)
 	EXPECT_EQ(errno, ENOTDIR);
 }
 
+static volatile int race_stop;
+
+static void *rmdir_target(void *arg)
+{
+	while (!race_stop) {
+		if (mkdir(ITEM_A, 0755) == 0 || errno == EEXIST)
+			rmdir(ITEM_A);
+	}
+
+	return NULL;
+}
+
+/* -1 if the kernel does not export a warning counter. */
+static long warn_count(void)
+{
+	char buf[32];
+
+	if (read_attr("/sys/kernel/warn_count", buf, sizeof(buf)) < 0)
+		return -1;
+
+	return strtol(buf, NULL, 10);
+}
+
+TEST_F(configfs, symlink_races_with_target_rmdir)
+{
+	pthread_t thread;
+	long warns;
+	int i;
+
+	warns = warn_count();
+	if (warns < 0)
+		SKIP(return, "no /sys/kernel/warn_count to watch");
+
+	ASSERT_EQ(mkdir(LINK_SRC, 0755), 0);
+	ASSERT_EQ(pthread_create(&thread, NULL, rmdir_target, NULL), 0);
+
+	/*
+	 * configfs_rmdir() drops the last reference to the item while its
+	 * dentry is still hashed, and get_target() takes a hashed dentry as
+	 * proof that the item behind it is alive.  The symlink then walks
+	 * ->ci_dentry into a released dirent, which configfs_get() warns
+	 * about.  KASAN sees the freed item itself.
+	 */
+	for (i = 0; i < RACE_ITERATIONS; i++) {
+		if (symlink(ITEM_A, LINK) == 0)
+			unlink(LINK);
+
+		/* Give up on the first splat rather than flood the log. */
+		if (!(i % 128) && warn_count() != warns)
+			break;
+	}
+
+	race_stop = 1;
+	ASSERT_EQ(pthread_join(thread, NULL), 0);
+
+	EXPECT_EQ(warn_count(), warns)
+		TH_LOG("kernel warned after %d iterations", i);
+}
+
 TEST_F(configfs, module_pinned_by_item)
 {
 	ASSERT_EQ(mkdir(ITEM_A, 0755), 0);

-- 
2.53.0-Meta

