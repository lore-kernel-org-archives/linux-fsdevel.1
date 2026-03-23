Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D233C9EC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288450; cv=none; b=mk8GYp0cIchjhW29X4/9nYdjE2ih+ynFAkH19olwNqLijD6mb9wbQVCPWRPObiO2LJnwwtsGvegiztLO5IRWVGgtl5jEQziKxmCkFYPv/pj0nYC5cx2QVQrSmfSLXJLN/62VVVNRdOm0rrGdZyiJe0Rg9LO4cDCrvErfGSSwmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288450; c=relaxed/simple;
	bh=L2zTtGTNTw3phxOrswp+iUaPq/4BsNNONZQKwH6jDDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sdxcv2/M/vaWDbeSzXd4NvxQJFj2ZibC2s6jUuzxOaktbw7uK6PeIRu9kBfkJZk+ONhbZDZ2uYN+ZOLVqXKEFS3BukaeISI+sGAMqeA2ZfxRG33pBlGxQRL5E3r7aWtjVMT/RBMLg1iN7j+I8q0vp6zTpk3Fe6DHIJ/7BlDdO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4cK75Uy; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4cK75Uy"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-67dec1314b5so9498597eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774288447; x=1774893247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz01D+Qvtpuy+jqrKUW1E7zaDqaJMt9I2Ue5ziSPeb0=;
        b=W4cK75UyBcl7snsjvR7ZgphxNiZClz8sYs3aDFPe/nYIy2WEr/FwzB7rtaTkcEaa/5
         vXkHvrursI4QcGyn3sYyvgSDa/5O0RLZAp5fpLlSPE0eRUmyKcDVi/LgrCEwslAEvc7P
         D0/AxJ3LPJX/g+wHwSgQe6f7bnDySXI39b5v0GrCM8BiOs9spi2P21OchCi1kjv1iBPv
         nOer0zVuRg7Ni1x2WeXc3LxcJZIYax8gUhsOv6wWJbp1aXRALQqlqUw4z7F9mXeyAzwi
         cP7U+RmYh79kPvC/qwyyYHPWlu9p73WEZ+aaMwC/3Uj9Frl1jFHlSvGibqGFJgXf4DSh
         A67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288447; x=1774893247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz01D+Qvtpuy+jqrKUW1E7zaDqaJMt9I2Ue5ziSPeb0=;
        b=MZht/+GB0uGCFnOmxuC+0JQHsZtVjjkCW9/sNw7jMSSp7sYRbU9zQwdLW+ZXpJY3xg
         16h1FW3tzIVXKTxZQiraRsdEPwdzXOqo63TEgLSf2SHgOpJNYlVATPvvEwLbZQ5DG+bH
         67Qw8mGciYx+ddu/bERNhErkDsTp/hfTSNolYg+i1t5MnffUHSlBVjH3+S640h8LX+x7
         0InJ2RdLg112dWIEdXAfuEz+pnEkxCePfdgDhwxFxFm5hOYakIgcLNCMmvMTJZztvF4J
         jXxyQzUg3wiUgi/FHPgsZiL3pI1qu/Y/f7zcYsvS3GxXKj+zuvApFe4rXKVjgKcyDt9s
         xTHA==
X-Forwarded-Encrypted: i=1; AJvYcCWEUOqJNeqKr5I33lOomW08fb2PRq/8Ixti4PNbr1+Ue4Xi7xSahvBiYqcPQHPMDx1RNJz4Axuk+UWIvqmu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mccUfpICYOVZfN1azt57VpJU0RCo+Fd2zk0ZGy/XDWyPKfEE
	3hAs90YkheWbZvZrR8aVQhPtOq9ZnI3hvD+Err4NQVg6vVBSm6w1qM5d5lYgAYMK/K4MvALzJGP
	pt6Rwmg==
X-Received: from jalw26.prod.google.com ([2002:a05:6638:379a:b0:5d4:6a6a:67ca])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:200e:b0:67d:eeb7:476f
 with SMTP id 006d021491bc7-67deeb74d00mr2420094eaf.0.1774288447326; Mon, 23
 Mar 2026 10:54:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:53:40 +0000
In-Reply-To: <20260323175340.3361311-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323175340.3361311-5-avagin@google.com>
Subject: [PATCH 4/4] selftests/exec: add test for HWCAP inheritance
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Koutny <mkoutny@suse.com>, Andrei Vagin <avagin@google.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"

Verify that HWCAPs are correctly inherited/preserved across execve() when
modified via prctl(PR_SET_MM_AUXV).

The test performs the following steps:
* reads the current AUXV using prctl(PR_GET_AUXV);
* finds an HWCAP entry and toggles its most significant bit;
* replaces the AUXV of the current process with the modified one using
  prctl(PR_SET_MM, PR_SET_MM_AUXV);
* executes itself to verify that the new program sees the modified HWCAP
  value.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/exec/.gitignore      |   1 +
 tools/testing/selftests/exec/Makefile        |   1 +
 tools/testing/selftests/exec/hwcap_inherit.c | 105 +++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/exec/hwcap_inherit.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 7f3d1ae762ec..2ff245fd0ba6 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -19,3 +19,4 @@ null-argv
 xxxxxxxx*
 pipe
 S_I*.test
+hwcap_inherit
\ No newline at end of file
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 45a3cfc435cf..e73005965e05 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -20,6 +20,7 @@ TEST_FILES := Makefile
 TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
+TEST_GEN_PROGS += hwcap_inherit
 
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
diff --git a/tools/testing/selftests/exec/hwcap_inherit.c b/tools/testing/selftests/exec/hwcap_inherit.c
new file mode 100644
index 000000000000..1b43b2dbb1d0
--- /dev/null
+++ b/tools/testing/selftests/exec/hwcap_inherit.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <linux/prctl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <elf.h>
+#include <linux/auxvec.h>
+
+#include "../kselftest.h"
+
+static int find_msb(unsigned long v)
+{
+	return sizeof(v)*8 - __builtin_clzl(v) - 1;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long auxv[1024], hwcap, new_hwcap, hwcap_idx;
+	int size, hwcap_type = 0, hwcap_feature, count, status;
+	char hwcap_str[32], hwcap_type_str[32];
+	pid_t pid;
+
+	if (argc > 1 && strcmp(argv[1], "verify") == 0) {
+		unsigned long type = strtoul(argv[2], NULL, 16);
+		unsigned long expected = strtoul(argv[3], NULL, 16);
+		unsigned long hwcap = getauxval(type);
+
+		if (hwcap != expected) {
+			ksft_print_msg("HWCAP mismatch: type %lx, expected %lx, got %lx\n",
+					type, expected, hwcap);
+			return 1;
+		}
+		ksft_print_msg("HWCAP matched: %lx\n", hwcap);
+		return 0;
+	}
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	size = prctl(PR_GET_AUXV, auxv, sizeof(auxv), 0, 0);
+	if (size == -1)
+		ksft_exit_fail_perror("prctl(PR_GET_AUXV)");
+
+	count = size / sizeof(unsigned long);
+
+	/* Find the "latest" feature and try to mask it out. */
+	for (int i = 0; i < count - 1; i += 2) {
+		hwcap = auxv[i + 1];
+		if (hwcap == 0)
+			continue;
+		switch (auxv[i]) {
+		case AT_HWCAP4:
+		case AT_HWCAP3:
+		case AT_HWCAP2:
+		case AT_HWCAP:
+			hwcap_type = auxv[i];
+			hwcap_feature = find_msb(hwcap);
+			hwcap_idx = i + 1;
+			break;
+		default:
+			continue;
+		}
+	}
+	if (hwcap_type == 0)
+		ksft_exit_skip("No features found, skipping test\n");
+	hwcap = auxv[hwcap_idx];
+	new_hwcap = hwcap ^ (1UL << hwcap_feature);
+	auxv[hwcap_idx] = new_hwcap;
+
+	if (prctl(PR_SET_MM, PR_SET_MM_AUXV, auxv, size, 0) < 0) {
+		if (errno == EPERM)
+			ksft_exit_skip("prctl(PR_SET_MM_AUXV) requires CAP_SYS_RESOURCE\n");
+		ksft_exit_fail_perror("prctl(PR_SET_MM_AUXV)");
+	}
+
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_perror("fork");
+	if (pid == 0) {
+		char *new_argv[] = { argv[0], "verify", hwcap_type_str, hwcap_str, NULL };
+
+		snprintf(hwcap_str, sizeof(hwcap_str), "%lx", new_hwcap);
+		snprintf(hwcap_type_str, sizeof(hwcap_type_str), "%x", hwcap_type);
+
+		execv(argv[0], new_argv);
+		perror("execv");
+		exit(1);
+	}
+
+	if (waitpid(pid, &status, 0) == -1)
+		ksft_exit_fail_perror("waitpid");
+	if (status != 0)
+		ksft_exit_fail_msg("HWCAP inheritance failed (status %d)\n", status);
+
+	ksft_test_result_pass("HWCAP inheritance succeeded\n");
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.53.0.983.g0bb29b3bc5-goog

