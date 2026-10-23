Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.3.242.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720491;
	b=uejD1edLMg3o2JxD8zVk0E+XISwIi3nSAFj7as3YqwIspHRlPkQjqQhaUdK+z4Cfrixr
	 fJrLLyEAPcqHxYDarOTS6ypRUXE81FKxIZNKI3CwD2ppiCnUbFuKdqfjYg9hRTJJwKAL3
	 hY4b4yYZwXPXrdw8q4wDit6VBeXOsr69jRsSJQKLsmLqS1Iag9Jm9ldwLWjwXLoTnuaLR
	 bT7dpz1IBuZwM+D1ngrNFQ98sjkXNlK3qwb+ZslZmi/gMbO8ngCrYgS18tpIZF3V23Pq3
	 oHGe29pwlMF1GN27dwttDFYm/2jhgKs+kFf+hOyboyxqyShkte6SblaiRxELjklwc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720491;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CO-INDEX;
	bh=4rTlpb7GfMR9wMDmMibWcW8o92S1RDunUKU4LVh+Jkc=;
	b=ln5rETOO8LuicwFv4L8fD1rQ96oY9EQyMLoMmh1zXqn47FEN1ovFbv5Z7AwRJ7UpX09k
	 0/vFQF9Z6PZqmUly0qf6n9wbWUGSe12WXJaNcY/dBP5/ECwvmFgPUl2FXdStnA+YAJsoQ
	 j6/cUU1Emvt74UvA4WVufeoA+uD26Tj7ijT/U1Bu5sOuwf65NRpJ16qot/A4Ch5A9hpJ1
	 dVdO08VIuSNSX2YtyJvA1AxTMIXMy+eF7QKm7V+6tXZyr7jfjKsFUgHiR4c+Rb9Tz3MBv
	 zsXZSVsUIiYBd9HPCJiGGnF/Yh/e/mi8GbPG0IpXrDijoE4/zD9FGvS9TNQT8pxgrNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailfence.com;
	spf=pass smtp.mailfrom=mailfence.com;
	dkim=pass header.d=mailfence.com header.i=brianwitte@mailfence.com header.a=rsa-sha256 header.s=20240605-akrp header.b=GrqaxEBa;
	arc=none smtp.remote-ip=212.3.242.97
Received: from mailout-l3b-97.contactoffice.com (mailout-l3b-97.contactoffice.com [212.3.242.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E3606A31F;
	Fri, 23 Oct 2026 01:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026E3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailfence.com header.i=brianwitte@mailfence.com header.a=rsa-sha256 header.s=20240605-akrp header.b=GrqaxEBa
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id A504660A8;
	Fri, 23 Oct 2026 03:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792720486;
	s=20240605-akrp; d=mailfence.com; i=brianwitte@mailfence.com;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=4rTlpb7GfMR9wMDmMibWcW8o92S1RDunUKU4LVh+Jkc=;
	b=GrqaxEBaVJ0nFoAhJiYPusLDk3u11s7gpqWbOgCfiXe3pfgHHdoGnhazSqCJUEb5
	fqxCG10DI8NDPxrkHUpU9zz350iA3W9YR0hCskfnaRo9p6bSgkxJXogHqn+Bq6S8HBS
	Ic5xrbpOgEbPwTU1RMSwKkdMzJBqNzSjc1G/km/Us4pYzUgSq6aTKhtvgfOJQdshV0f
	1mEl7r5Hmp1OO6vURXWsnY3Whi5KYCsoLLIh9+Ae/3W3Ym+5Id1p/cF1v/SsGsXepCj
	OdbQTkUQDC9/0Emt9r5lifJrlzQC91TaEyWUFm9XAuJrbnCsJt79FG834xcYsP0AzHP
	ajlKKIQdPQ==
Received: by smtp.mailfence.com with ESMTPSA ; Fri, 23 Oct 2026 03:54:44 +0200 (CEST)
From: Brian Witte <brianwitte@mailfence.com>
To: Kees Cook <kees@kernel.org>
Cc: Brian Witte <brianwitte@mailfence.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jann Horn <jannh@google.com>,
	Helge Deller <deller@gmx.de>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Micay <danielmicay@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/exec: test the argument block's in-page offset
Date: Fri, 23 Oct 2026 03:54:46 +0200 (CEST)
Message-ID: <20261023015345.1594514-3-brianwitte@mailfence.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023015345.1594514-1-brianwitte@mailfence.com>
References: <20261023015345.1594514-1-brianwitte@mailfence.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CO-INDEX: b3VYll9dFyCFFB5P1wKTKlFLR1oD9XLpGvWEKkjq9pA=

Exec a helper, argblock-report, 64 times per case. Each case checks that
the in-page offset of argv[0] varies exactly when the stack top chosen
by the ELF loader does:
 - under ADDR_NO_RANDOMIZE: fixed;
 - by default: random;
 - a set-user-ID copy under ADDR_NO_RANDOMIZE: random;
 - that copy on a nosuid mount, under no_new_privs, or in a new user
   namespace where its owner has no mapping: fixed.

The tests use the kselftest harness. The fixture keeps the copy in a
private temporary directory and removes it on teardown. The copy is
owned by the caller, so no privilege is needed.

Link: https://github.com/KSPP/linux/issues/283
Signed-off-by: Brian Witte <brianwitte@mailfence.com>
---
 tools/testing/selftests/exec/.gitignore       |   3 +
 tools/testing/selftests/exec/Makefile         |   5 +
 .../testing/selftests/exec/argblock-offset.c  | 214 ++++++++++++++++++
 .../testing/selftests/exec/argblock-report.c  |  24 ++
 4 files changed, 246 insertions(+)
 create mode 100644 tools/testing/selftests/exec/argblock-offset.c
 create mode 100644 tools/testing/selftests/exec/argblock-report.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index e42ecd4c908d..991097f7fc43 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -9,6 +9,9 @@ execveat.ephemeral
 execveat.denatured
 non-regular
 null-argv
+/argblock-offset
+/argblock-offset.*
+/argblock-report
 /check-exec
 /false
 /inc
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 91decfa8ff2c..4835c7ca4a20 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -21,6 +21,11 @@ TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
 
+# The argument block's in-page offset must be random exactly when the
+# ELF loader randomizes the stack. Unprivileged.
+TEST_GEN_PROGS += argblock-offset
+TEST_GEN_FILES += argblock-report
+
 # binfmt_misc must not be reachable as an exec source or as a stacking layer,
 # or an 'F' entry can pin the instance that owns it. Unprivileged, no bpf.
 TEST_GEN_PROGS += binfmt_misc_selfpin
diff --git a/tools/testing/selftests/exec/argblock-offset.c b/tools/testing/selftests/exec/argblock-offset.c
new file mode 100644
index 000000000000..6edf9e6aadaf
--- /dev/null
+++ b/tools/testing/selftests/exec/argblock-offset.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The argument block should land at a random offset within its page
+ * exactly when the ELF loader randomizes the stack: always, unless
+ * ADDR_NO_RANDOMIZE is set and the exec is not set-id. Each case
+ * execs argblock-report repeatedly and compares both.
+ *
+ * Runs unprivileged: the set-user-ID copy is owned by the caller and
+ * kept in a private directory.
+ */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <sys/personality.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/statvfs.h>
+
+#include "binfmt_misc_common.h"	/* artifact_path(), copy_file() */
+#include "kselftest_harness.h"
+
+/*
+ * A page holds at least 4088 possible offsets, so 64 samples all landing
+ * on one value happen by chance with probability at most (1/4088)^63.
+ */
+#define SAMPLES 64
+
+/* How the helper is exec'd. */
+#define NO_RAND	0x1	/* under ADDR_NO_RANDOMIZE */
+#define NNP	0x2	/* under no_new_privs */
+#define USERNS	0x4	/* in a new user namespace with no mappings */
+
+FIXTURE(argblock) {
+	char report[PATH_MAX];	/* the helper */
+	char dir[32];		/* private directory for the set-id copy */
+	char setid[PATH_MAX];	/* set-user-ID copy of the helper */
+	bool have_dir, have_setid, nosuid;
+	int randomize_va_space;
+};
+
+static int read_randomize_va_space(void)
+{
+	FILE *f = fopen("/proc/sys/kernel/randomize_va_space", "r");
+	int v = -1;
+
+	if (f) {
+		if (fscanf(f, "%d", &v) != 1)
+			v = -1;
+		fclose(f);
+	}
+	return v;
+}
+
+FIXTURE_SETUP(argblock)
+{
+	struct statvfs sv;
+
+	ASSERT_EQ(artifact_path(self->report, sizeof(self->report),
+				"argblock-report"), 0);
+	self->randomize_va_space = read_randomize_va_space();
+
+	/* A private directory keeps the set-user-ID copy out of reach. */
+	strcpy(self->dir, "argblock-offset.XXXXXX");
+	self->have_dir = mkdtemp(self->dir);
+	if (!self->have_dir)
+		return;
+	snprintf(self->setid, sizeof(self->setid), "%s/setid", self->dir);
+	self->have_setid = !copy_file(self->report, self->setid) &&
+			   !chmod(self->setid, 04755);
+	self->nosuid = !statvfs(self->dir, &sv) && (sv.f_flag & ST_NOSUID);
+}
+
+FIXTURE_TEARDOWN(argblock)
+{
+	if (!self->have_dir)
+		return;
+	unlink(self->setid);
+	rmdir(self->dir);
+}
+
+struct sample {
+	unsigned long offset;		/* argv[0] within its page */
+	unsigned long stack_top;	/* end of [stack], chosen by the loader */
+};
+
+static int sample(const char *path, int how, struct sample *s)
+{
+	int pfd[2], status;
+	char buf[64];
+	ssize_t n;
+	pid_t pid;
+
+	if (pipe(pfd))
+		return -1;
+	pid = fork();
+	if (pid < 0)
+		return -1;
+	if (pid == 0) {
+		char *argv[] = { (char *)path, NULL };
+		char *envp[] = { NULL };
+
+		if ((how & NO_RAND) && personality(ADDR_NO_RANDOMIZE) < 0)
+			_exit(2);
+		if ((how & NNP) && prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+			_exit(2);
+		if ((how & USERNS) && unshare(CLONE_NEWUSER))
+			_exit(2);
+		dup2(pfd[1], STDOUT_FILENO);
+		execve(path, argv, envp);
+		_exit(3);
+	}
+	close(pfd[1]);
+	n = read(pfd[0], buf, sizeof(buf) - 1);
+	close(pfd[0]);
+	waitpid(pid, &status, 0);
+	if (n <= 0 || !WIFEXITED(status) || WEXITSTATUS(status))
+		return -1;
+	buf[n] = '\0';
+	return sscanf(buf, "%lx %lx", &s->offset, &s->stack_top) == 2 ? 0 : -1;
+}
+
+/*
+ * Exec @path SAMPLES times. The in-page offset must vary as @expect says,
+ * and vary exactly when the loader's stack top does.
+ */
+static void check(struct __test_metadata *_metadata, const char *path,
+		  int how, bool expect)
+{
+	bool offset_varies = false, stack_varies = false;
+	struct sample first, s;
+	int i;
+
+	for (i = 0; i < SAMPLES; i++) {
+		ASSERT_EQ(sample(path, how, &s), 0)
+			TH_LOG("exec of %s failed", path);
+		if (!i)
+			first = s;
+		offset_varies |= s.offset != first.offset;
+		stack_varies |= s.stack_top != first.stack_top;
+	}
+	EXPECT_EQ(stack_varies, expect)
+		TH_LOG("the loader %s the stack",
+		       stack_varies ? "randomized" : "did not randomize");
+	EXPECT_EQ(offset_varies, expect)
+		TH_LOG("the argument block offset is %s",
+		       offset_varies ? "random" : "fixed");
+}
+
+/* Can this process create a user namespace? */
+static bool have_userns(void)
+{
+	int status;
+	pid_t pid = fork();
+
+	if (pid == 0)
+		_exit(unshare(CLONE_NEWUSER) ? 1 : 0);
+	return pid > 0 && waitpid(pid, &status, 0) == pid &&
+	       WIFEXITED(status) && !WEXITSTATUS(status);
+}
+
+/* Without privilege, ADDR_NO_RANDOMIZE keeps the offset fixed. */
+TEST_F(argblock, addr_no_randomize_keeps_offset_fixed)
+{
+	check(_metadata, self->report, NO_RAND, false);
+}
+
+/* By default the offset is random. */
+TEST_F(argblock, offset_is_random)
+{
+	if (self->randomize_va_space <= 0)
+		SKIP(return, "randomize_va_space is 0");
+	check(_metadata, self->report, 0, true);
+}
+
+/* A set-id exec clears ADDR_NO_RANDOMIZE, so the offset is random again. */
+TEST_F(argblock, setid_ignores_addr_no_randomize)
+{
+	if (self->randomize_va_space <= 0)
+		SKIP(return, "randomize_va_space is 0");
+	if (!self->have_setid)
+		SKIP(return, "cannot create a set-user-ID copy");
+	if (self->nosuid)
+		SKIP(return, "set-user-ID copy is on a nosuid mount");
+	check(_metadata, self->setid, NO_RAND, true);
+}
+
+/* On a nosuid mount the exec gains nothing, so the flag holds. */
+TEST_F(argblock, setid_on_nosuid_keeps_offset_fixed)
+{
+	if (!self->have_setid)
+		SKIP(return, "cannot create a set-user-ID copy");
+	if (!self->nosuid)
+		SKIP(return, "set-user-ID copy is not on a nosuid mount");
+	check(_metadata, self->setid, NO_RAND, false);
+}
+
+/* no_new_privs makes the exec ignore the set-id bit. */
+TEST_F(argblock, setid_under_no_new_privs_keeps_offset_fixed)
+{
+	if (!self->have_setid)
+		SKIP(return, "cannot create a set-user-ID copy");
+	check(_metadata, self->setid, NO_RAND | NNP, false);
+}
+
+/* The copy's owner has no mapping there, so the set-id bit is ignored. */
+TEST_F(argblock, setid_in_user_namespace_keeps_offset_fixed)
+{
+	if (!self->have_setid)
+		SKIP(return, "cannot create a set-user-ID copy");
+	if (!have_userns())
+		SKIP(return, "cannot create a user namespace");
+	check(_metadata, self->setid, NO_RAND | USERNS, false);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/exec/argblock-report.c b/tools/testing/selftests/exec/argblock-report.c
new file mode 100644
index 000000000000..45744ec9bda9
--- /dev/null
+++ b/tools/testing/selftests/exec/argblock-report.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helper for argblock-offset: print the in-page offset of argv[0] and the
+ * end of the [stack] VMA, which the ELF loader chooses.
+ */
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	unsigned long end = 0;
+	char line[256];
+	FILE *maps = fopen("/proc/self/maps", "r");
+
+	while (maps && fgets(line, sizeof(line), maps))
+		if (strstr(line, "[stack]"))
+			sscanf(line, "%*[0-9a-f]-%lx", &end);
+	if (argc < 1 || !end)
+		return 1;
+	printf("%lx %lx\n", (unsigned long)argv[0] & (sysconf(_SC_PAGESIZE) - 1),
+	       end);
+	return 0;
+}
-- 
2.47.3

