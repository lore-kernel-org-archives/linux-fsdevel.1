Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB1309EFC;
	Mon, 12 Oct 2026 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806013; cv=none; b=fWzbwGDS/15kR2w9hxBavQpOanH3khLyTG/EvfEvvfAUEiKJ9Wc8yOYPufcgtaLaekSHgL09WTMumo7fc/im+qGEtF1bCinALqrCmJK9oTczXuWJGlNEjkPn4Y/kfkfWWx9EB9keeFJfIOIg+tGl6t5cHmT1PxvD4TZ4GyGp3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806013; c=relaxed/simple;
	bh=Mlh0nExt41pjiqUsnhH74ZHL3kKo5jmHPPyIf1cPy6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGuP4wkZ3OZl0UWOV65GLiwSbNQmTYnXFTx3Ft7WFAElyq8LDVcpCUnaWc7EYa8kFD3WebbASY2Mp0t+HQKCQ/+2ViqCgi6MMNJHwWzK8MSQAQjXaINxFg4Itk8Id46mHiSkOj07f5gJ0ytjOyGfb1y3+MVPxlvlqbXehQ+lsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU9uNdBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU9uNdBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC6B1F0089B;
	Mon, 12 Oct 2026 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791806012;
	bh=wF5mKfBKPgFMslZvkvo8h8pjJ6s1wOGfzAfUrLXqVhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fU9uNdBOhCDhi8QKrbRprm0eh7b3yCP9AAMgvZN0Rpi9eI2JAG292YLEVeAG/fqDX
	 YHGYgVI1VcWBCsh/HBiFEPFeAeOtonfADTkx8Ic20SKCzHvOzhR6o8M0yRCYNTNN3z
	 cVflhWUh+r5su104ZEgieQnSWHz94JYQ7ZjZwTDk4XOE7iuHOtyUjyMR1n7py3HZ13
	 yLvGf6p/x3Fp5TSj4z7wxeScNz/ewCFvywLy9lizxxnBaccSdusHqNQHsItVxxvBqw
	 7+cSv8ft6F6IbSYzWqOUqgEhisJn4IXmZGs/NAue2CuEk6wVxRFrAbouP4DROBRMjH
	 K3PMHTELLTSjA==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/proc: proc-pid-vm: fix unused variable warning on non-x86
Date: Mon, 12 Oct 2026 07:53:29 -0400
Message-ID: <20261012115330.3777115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011191746.52b84811a6385d4ee414408b@linux-foundation.org>
References: <20261011191746.52b84811a6385d4ee414408b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

g_vsyscall is only used by the x86_64 test, so clang builds for other
architectures get:

  proc-pid-vm.c:224:21: warning: unused variable 'g_vsyscall' [-Wunused-variable]

The vsyscall strings next to it had the same problem and were marked
__maybe_unused for it. Move all of the vsyscall variables into the
__x86_64__ block that uses them instead, and drop those annotations
along with the local __maybe_unused fallback that was added for them.

Fixes: 17415606f9d8b ("tools/testing/selftests/proc/proc-pid-vm.c: test with vsyscall in mind")
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Changes in v2:
- Move the vsyscall variables into the __x86_64__ block instead of marking
  g_vsyscall __maybe_unused, and drop the existing annotations (Andrew Morton)
- Link to v1: https://lore.kernel.org/r/20261011223358.2327625-11-sashal@kernel.org

 tools/testing/selftests/proc/proc-pid-vm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 4e6a3e53f9757..98e882e568154 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -47,10 +47,6 @@
 #include <sys/resource.h>
 #include <linux/fs.h>
 
-#ifndef __maybe_unused
-#define __maybe_unused __attribute__((__unused__))
-#endif
-
 #include "kselftest.h"
 
 static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
@@ -214,7 +210,6 @@ static int make_exe(const uint8_t *payload, size_t len)
 
 	return fd1;
 }
-#endif
 
 /*
  * 0: vsyscall VMA doesn't exist	vsyscall=none
@@ -222,15 +217,14 @@ static int make_exe(const uint8_t *payload, size_t len)
  * 2: vsyscall VMA is r-xp		vsyscall=emulate
  */
 static volatile int g_vsyscall;
-static const char *str_vsyscall __maybe_unused;
+static const char *str_vsyscall;
 
-static const char str_vsyscall_0[] __maybe_unused = "";
-static const char str_vsyscall_1[] __maybe_unused =
+static const char str_vsyscall_0[] = "";
+static const char str_vsyscall_1[] =
 "ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
-static const char str_vsyscall_2[] __maybe_unused =
+static const char str_vsyscall_2[] =
 "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
 
-#ifdef __x86_64__
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
 {
 	_exit(g_vsyscall);
-- 
2.53.0

