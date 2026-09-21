Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB14AA40B;
	Mon, 21 Sep 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998347; cv=none; b=umzWhJclIo1ViFkVkzqb9NzF4cpXR1uYQrOT9Wk2nbb+KQgBqgdPOUrNvcypD6HlIjjkdqqEBTIaaMokAxgxPbZrME3BebFZqzEaBtGJJztuP2FPsx8+sZiwXJe+I9NsGZcqQl+FbKnSx6bEsoxstsyUavSySrg9TyXXU7QyA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998347; c=relaxed/simple;
	bh=y1jOkzZuO9VHLKMd/1GcHI3KZB/M7wgZM5eLLCIt5GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NlHwiaS7o4uP5GtxRfVgfuCPpjdcnLAZ13vR7kQkpJ2Nx53ewh2YLjvK+clFG06EHSCezRrN7H8Sci48WMw9Tu2l5r7UKH9/Cw9X+g82rfM/Ww6msDUAqD4VCuf5D4p/oUc9ehIwZ4beR6sfTY1OPN0vUugozUf57/60I7q5xAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPLFbMp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPLFbMp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459E01F00893;
	Mon, 21 Sep 2026 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998346;
	bh=C1pfPreOO6HKMgZ9q+Nqw+m6d7jYr0ACpShFH4V9mcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OPLFbMp5APpFtxsxTti4fNjZl+zGL2kKVPIF4twuXm8Vv5JzNj5Uk/61J1WYuyd+b
	 VFYkPbMFJlf7ujPd7iI071pGkNVX7bZEy59Ivs8GxWcWoOlaPEoxJu/82IdiMZEYMz
	 4LwQiANgIin1sxxhYMkYsdSSXn2aPB6uFzzLcLa0PtWvpLoGSB/8uN6t8Q9720TVUC
	 6ForjC4p0vkAEquj9i2NaYfeqGD8wSdrsHzFL7ZAdjoRmdQ3xID2q3ZGosVx8ld7kU
	 KoOskmGT8Q+wDg+Kdp8I54ZiaoLJaO2T1jEuZKrClfx/pFJteTsHk2TgpgFlvfAPze
	 gIQzq7HkgSGiw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:45:00 +0200
Subject: [PATCH v3 11/17] selftests/coredump: expect PTRACE_SETSIGMASK to
 be refused on a user worker
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-11-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3510; i=brauner@kernel.org;
 h=from:subject:message-id; bh=y1jOkzZuO9VHLKMd/1GcHI3KZB/M7wgZM5eLLCIt5GE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLmzN7HmW9fVol0em69sXzTtfdueq2u8xY4ErL76Y
 PkH7qXzVnaUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMJOYvwy+m5xZfq4M2P9IR
 vVVvNX++2z6uvxmnZz0S0hUVWhr53G06wx8e3qv7RBeVTH9swcyg8tkvdNVfP1nhoDeh0q9LX2b
 LnuIHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

PTRACE_SETSIGMASK returns -EPERM for a user worker now.

- inject_coredump_signal() reports whether the mask could be changed
- a refused mask means the injected SIGSEGV stays pending on the worker
- the worker cases check that the group is alive and kill it

The main thread case still dumps.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/coredump/coredump_worker_test.c      | 44 ++++++++++++++++------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_worker_test.c b/tools/testing/selftests/coredump/coredump_worker_test.c
index 81cadde0e752..9a4270b65a6e 100644
--- a/tools/testing/selftests/coredump/coredump_worker_test.c
+++ b/tools/testing/selftests/coredump/coredump_worker_test.c
@@ -16,6 +16,7 @@
  * SIGKILL still works. A failure leaves the stuck process behind.
  */
 #include <ctype.h>
+#include <errno.h>
 #include <dirent.h>
 #include <fcntl.h>
 #include <sys/mman.h>
@@ -255,24 +256,31 @@ static pid_t find_thread(pid_t pid, const char *prefix)
 
 /*
  * Attach, stop the thread with SIGSTOP, drop the signal mask that
- * copy_process() gave it and resume it with SIGSEGV instead.
+ * copy_process() gave it and resume it with SIGSEGV. Returns 1 when the
+ * mask was changed, 0 when PTRACE_SETSIGMASK was refused (a user worker
+ * keeps its mask and the SIGSEGV stays pending), -1 on any other failure.
  */
-static bool inject_coredump_signal(pid_t pid, pid_t tid)
+static int inject_coredump_signal(pid_t pid, pid_t tid)
 {
 	__u64 mask = 0;
-	int status;
+	int status, ret = 1;
 
 	if (ptrace(PTRACE_SEIZE, tid, NULL, NULL))
-		return false;
+		return -1;
 	if (syscall(SYS_tgkill, pid, tid, SIGSTOP))
-		return false;
+		return -1;
 	if (waitpid(tid, &status, __WALL) != tid)
-		return false;
+		return -1;
 	if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGSTOP)
-		return false;
-	if (ptrace(PTRACE_SETSIGMASK, tid, sizeof(mask), &mask))
-		return false;
-	return !ptrace(PTRACE_DETACH, tid, NULL, (void *)(long)SIGSEGV);
+		return -1;
+	if (ptrace(PTRACE_SETSIGMASK, tid, sizeof(mask), &mask)) {
+		if (errno != EPERM)
+			return -1;
+		ret = 0;
+	}
+	if (ptrace(PTRACE_DETACH, tid, NULL, (void *)(long)SIGSEGV))
+		return -1;
+	return ret;
 }
 
 /* Reap @pid within @timeout_ms, -1 when it is still there. */
@@ -333,7 +341,7 @@ static void run_dumper(struct __test_metadata *const _metadata, bool sqpoll,
 {
 	bool killed = false;
 	char path[64], c;
-	int ipc[2], status, fd;
+	int ipc[2], status, fd, ret;
 	pid_t pid, tid;
 
 	ASSERT_TRUE(set_core_pattern("/tmp/coredump.file.%p"));
@@ -361,7 +369,19 @@ static void run_dumper(struct __test_metadata *const _metadata, bool sqpoll,
 		break;
 	}
 	ASSERT_GT(tid, 0);
-	ASSERT_TRUE(inject_coredump_signal(pid, tid));
+	ret = inject_coredump_signal(pid, tid);
+	ASSERT_GE(ret, 0);
+	if (!ret) {
+		/* The signal sits on the worker, the group must be untouched. */
+		ASSERT_NE(dumper, DUMPER_MAIN);
+		TH_LOG("PTRACE_SETSIGMASK refused for tid %d, the SIGSEGV stays pending", tid);
+		ASSERT_EQ(wait_exit(pid, &status, 1000), -1);
+		kill(pid, SIGKILL);
+		ASSERT_EQ(wait_exit(pid, &status, EXIT_TIMEOUT_MS), 0);
+		ASSERT_TRUE(WIFSIGNALED(status));
+		ASSERT_EQ(WTERMSIG(status), SIGKILL);
+		return;
+	}
 
 	if (wait_exit(pid, &status, EXIT_TIMEOUT_MS)) {
 		/* No dump. Whatever happened, SIGKILL must still work. */

-- 
2.53.0

