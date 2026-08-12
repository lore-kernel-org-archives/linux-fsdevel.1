Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E97431E74
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533141; cv=none; b=QeprY7Frg9yBhaa+rZETr9eY61BbO2oz/vYcY9A11bjOvGcY8OiGVnrVKiWdM/QMsCv67+iYXD/kcKqNygSD0FpfNU5OQSwt17kU9T7kA1IB3LrRDzEdkEwf577hjmITqAapq0CZbFobrDlQPjbMprKDadAzJ79EZOKNjc7gSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533141; c=relaxed/simple;
	bh=Vt4B7VdAPzg3HHiMRpJdUpbR4PPcaOpFgQUR4MjJ044=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwmEpmFN4JTQ9KB/RcNsiiXO+0aHMCY+bAIwnuGGElHXNoWHtfYi7BQLTbXoQnaGbFe2kUKl5zWDcyePr1NW4vd4W9gLFnVmb2lAWdsRVvHiuPQYXL0Rd98xCDk3qnGB/1bwlL9qg4TPrNhaBd0HNkCcn/dXadZexHi9fMLK+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlY9sLDW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlY9sLDW"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495635a85d2so5959205e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533138; x=1787137938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DniDtpSNvo/ABReRZwqLfy9Ok6b/HLHOLbbY3qeelds=;
        b=JlY9sLDWDtDapzTzws3QQeLPVJ+VVeOlPjxwE00g4ai3iQtK5L6n8BXAJjWVpV9w8b
         PC+t3v+TzJiDZBwZkQ6syADHGJbeCWPZwpyIklzbqZhP2JHQNCjpRMGbglPsPv0MdE1Q
         EsfP52vfTlZaeZMXVZ8+5H9KQKForG8MkEwMb5i6fl/O7cUSE3Mi/HLfbZmT6CXyTR1O
         MMqe1WLuAg1FasxZxabEGHPue6w7yM2hzeOwX9KQNivzpL7aDp/dxQvb42Yr8mtkyCqC
         cP1++Fnv8XGOf94gJ4hMkzPY4z/8EbVQ7yV4KB+Ho1t9Va7kpv6k18fJYlxSzp1S5p/i
         0qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533138; x=1787137938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DniDtpSNvo/ABReRZwqLfy9Ok6b/HLHOLbbY3qeelds=;
        b=TUWtdX4ELjHed6k+IBI976xwgyZTNVofIrxLAJwpExX4ksey+DNYVwbOqSWqvGHpK0
         +P2Z/+NmF6LyMsmdtVVe6eXOPTq5/YlIl565RwPrCJAYK21uM6IgLYBaXlNISIfEnTWL
         gBAeL//R40ERR8Q9Lk6gysNs/51FgvJoHgbikGWQJEWDRv8aWmY2YEZIGXmT+B8f6Gj6
         g+79uMVH/7L6cW0CcIEoMHuJEmmeM0T3WxMrJg6kS8aLeluSSulimjQLXhMbLGseb3cu
         Moaxt8h1fY9OlkgB9b+TqHqcCv0SBp+svqAb1SqhOFGdsE0ZfYC37NwfhslQ5ccZYtTw
         gqjA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9xaIW1k4IEBX5boj5IAZgsJfZ45Z0sUEgh7kJXWiI2A8QKIknYvWzO9jywVEWkybxcT/CTPgD8WTnxsYX@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNlng2El9QVrPqZnpJabM34fkLKyFW3XcsdMoovYpAMvtbtE0
	IM1+Fhn60NPBZhdbWTOVeyA3d5ovpiq17q3i4aBYN768ym+1lMTcHPpv6EpsQ9pI
X-Gm-Gg: AR+sD122jpdwbyNYphpnmdXP4+XOHNlHGBVB/KtwvE3Yegs/YvI6yO8wPqVB843ykBr
	Kcr742i24afG0hkMuRA4yqiRZKwhgF4Fhnp+3n9NWvdQibZ4E1drroHoDbvd6LwkIui//XcW4n4
	rhyOmvErW0NWzIew127lNSngVWSarwXPNyUFI2DHlXFp/vBb07meSpHULYGBLHVchXAy3zS8QZk
	DCaXXinQgZ7eOw2uS9qVauIWmOi9L8x00Zet0PR5kT4fYY1+FdR/Rk6xuUR2YjuKpIacInRMQCx
	go32Ub7mxDDoyiPdpvRRIw2gV5zHTma7pVXswRC6FEUcnP9LfxThCB2++bU79v6A9yD9hva+Ku2
	hrOxnllcoI9ytagTJzsqSpoB4/bPPdJsjHQeN4OFqLfKJIOSfvoFYfAIVPHIdn0CZj1VBX3d39t
	KXbGZ/kXCsHfvFSfn8gGZ5DYFRAS6oE6Xk1NScTkJXbZ+/UaziiAo0GWkCGupEKhHDmc0/fCDw3
	YoR45daN6mmZdE=
X-Received: by 2002:a05:600c:6305:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-4997c0d7658mr46390285e9.4.1786533137639;
        Wed, 12 Aug 2026 04:12:17 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c9417bcsm54830855e9.4.2026.08.12.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:12:17 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test linux_binprm user memory kfuncs
Date: Wed, 12 Aug 2026 14:11:40 +0300
Message-ID: <20260812111140.7762-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
References: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a sleepable BPF LSM program attached to
bprm_check_security to test bpf_copy_from_user_bprm() and
bpf_copy_from_user_bprm_str().

Starting at bprm->p, verify that bpf_copy_from_user_bprm() can copy the
contiguous NUL-separated argument data. Then use
bpf_copy_from_user_bprm_str() to read each argument separately,
by advancing the offset based on the returned length.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../bpf/prog_tests/copy_from_user_bprm.c      | 52 +++++++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 74 +++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
new file mode 100644
index 000000000000..3d5080a3975e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+
+#include "copy_from_user_bprm.skel.h"
+
+void test_copy_from_user_bprm(void)
+{
+	struct copy_from_user_bprm *skel;
+	pid_t child;
+	int status;
+
+	skel = copy_from_user_bprm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(copy_from_user_bprm__attach(skel), "attach"))
+		goto out;
+
+	child = fork();
+	if (!ASSERT_GE(child, 0, "fork"))
+		goto out;
+
+	if (!child) {
+		char *const argv[] = { "first", "second-argument", NULL };
+
+		skel->bss->monitored_pid = getpid();
+		execv("/bin/true", argv);
+		_exit(errno);
+	}
+
+	if (!ASSERT_EQ(waitpid(child, &status, 0), child, "waitpid"))
+		goto out;
+
+	if (ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		ASSERT_EQ(WEXITSTATUS(status), EPERM, "exec_errno");
+
+	ASSERT_EQ(skel->bss->bprm_argc, 2, "bprm_argc");
+	ASSERT_EQ(skel->bss->invalid_flags_ret, -EINVAL, "invalid_flags_ret");
+	ASSERT_EQ(skel->bss->copy_ret, 0, "copy_ret");
+	ASSERT_EQ(skel->bss->str_arg0_ret, 6, "str_arg0_ret");
+	ASSERT_EQ(skel->bss->str_arg1_ret, 16, "str_arg1_ret");
+	ASSERT_EQ(skel->bss->args_match, 1, "args_match");
+	ASSERT_EQ(skel->bss->str_args_match, 1, "str_args_match");
+
+out:
+	copy_from_user_bprm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
new file mode 100644
index 000000000000..679363811edc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+static const char expected_args[] = "first\0second-argument";
+static const char expected_arg0[] = "first";
+static const char expected_arg1[] = "second-argument";
+
+int monitored_pid;
+int bprm_argc;
+int invalid_flags_ret;
+int copy_ret;
+int str_arg0_ret;
+int str_arg1_ret;
+int args_match;
+int str_args_match;
+
+extern int bpf_copy_from_user_bprm(void *dst, u32 dst__sz,
+				   const void *unsafe_ptr__ign,
+					   const struct linux_binprm *bprm,
+					   u64 flags) __ksym;
+
+extern int bpf_copy_from_user_bprm_str(void *dst, u32 dst__sz,
+				       const void *unsafe_ptr__ign,
+					       const struct linux_binprm *bprm,
+					       u64 flags) __ksym;
+
+SEC("lsm.s/bprm_check_security")
+int BPF_PROG(check_exec_args, struct linux_binprm *bprm, int ret)
+{
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	char args[sizeof(expected_args)];
+	char arg0[32];
+	char arg1[32];
+
+	if (ret || pid != monitored_pid)
+		return ret;
+
+	bprm_argc = bprm->argc;
+
+	invalid_flags_ret = bpf_copy_from_user_bprm(args, sizeof(args),
+						    (void *)bprm->p, bprm, 1);
+
+	copy_ret = bpf_copy_from_user_bprm(args, sizeof(args),
+					   (void *)bprm->p, bprm, 0);
+	if (copy_ret)
+		return 0;
+
+	args_match = !__builtin_memcmp(args, expected_args, sizeof(expected_args));
+
+	str_arg0_ret = bpf_copy_from_user_bprm_str(arg0, sizeof(arg0),
+						   (void *)bprm->p, bprm,
+						BPF_F_PAD_ZEROS);
+	if (str_arg0_ret != sizeof(expected_arg0))
+		return 0;
+
+	str_arg1_ret = bpf_copy_from_user_bprm_str(arg1, sizeof(arg1),
+						   (void *)(bprm->p + str_arg0_ret),
+						bprm, BPF_F_PAD_ZEROS);
+	if (str_arg1_ret != sizeof(expected_arg1))
+		return 0;
+
+	str_args_match = !__builtin_memcmp(arg0, expected_arg0, sizeof(expected_arg0)) &&
+			!__builtin_memcmp(arg1, expected_arg1, sizeof(expected_arg1));
+
+	return args_match && str_args_match ? -EPERM : 0;
+}
-- 
2.55.0

