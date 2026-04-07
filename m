Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B85377EA2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592164; cv=none; b=Wpd2QS/ojcauEGSdUfOVDfDxIJSSPci9uEKLl5/rGJVn0sHlf6+eWKPCdNzFjxlAgzT8auITgZZeQqmxzZWFOHjpeP3/ZQvMAGRfTy6Z3KRzgAjSpmTDng5gT63xpCXEkgjuBm1awWQWcy5rbr3qAywe2qxCJwO18aMg0IURSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592164; c=relaxed/simple;
	bh=Bhmr5gWqL+JDPgJaISRrzYD37Nv62i3zLzurNCt0yxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVy3B2CEFdq/vUkg6h2aFZkSGV5fsuGHK+UMEz96n5Y1ZqSMukwfUfgffR+bkKINXcPqt5Em7TvfiNeRNwFexAy2KJA6GevI8nxU6ndnKH63XoYuPLou4AVEoGW3F4muz2DfBat76NEiyZvwywcrJnT4RXc0MxPY3gfFgqPFo0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijS0Id8f; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijS0Id8f"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-650775f427eso1943480d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592162; x=1776196962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38OElJLF47wRKkPx0WVIhanOIa+XzcnkE/4SXvVPtEA=;
        b=ijS0Id8febaPlK43v81mrI12BHpt5y0AWX5ByjnZupyOHBQvdX8YQ7r0tUSdqDwnWh
         BE22Qok6cAdmXP9icBnyfxgE7mawvcjfwggeCcQmaqg+Nwv78BA1J71HbqyF2eZHp/0L
         cVZF+oBNeuzu7X01o1q5AyP20FyEnTDTnV9xm03ZaZ5oeypaph0Lju87NDQbC5eqaRK+
         4vo41YLlylN8nZRahlK6pkpejor6Txm+nb/6mYBKgPvv+vKk9TiKqaGCWjl8E6GYySgT
         hEybW/TIbFPDPf1jc6sTP3QEw8/Oe7VomDGUX+bl5QVl6b5+n2ADK1GsqFrsQIqPYsmd
         RczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592162; x=1776196962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38OElJLF47wRKkPx0WVIhanOIa+XzcnkE/4SXvVPtEA=;
        b=cGlNJpsBTTjUll8EcOIEOVqFXls/cXAvN7p0PHA3kvg26tVa5f3JQkb5d5o14s5jEB
         g2vfcsZv8SMtPdB4AC/Oj4LR44yJB4JHUPzoB/yezdUU0q3ehmMHtJdQ/uzaFNgwAbB6
         lQWcJ/z+nYrVJ9rNvvrWPKugqcvTbxCLoFu53SkXhulI6Juxx/xdPgYQ3M867Xw6PMpc
         T77ntfWGOx3yU/hRmrDTUHrn78nzuOCpaieOHVFruFfb1QH4rKgamdNUj5/fY4+QpYWw
         MV7IJW0igbd6nhLv9C/w9Zm/Z+9jhEpAkJRpT3zAF71c/AK83uBGKeJY2cY21ii6r/hC
         c9cw==
X-Forwarded-Encrypted: i=1; AJvYcCWr6lxVyf60QBeAWBYhlNej3bS33oWqbXpgRhaTg64O0k8WiksDY7v9U2nkSDv8vkVUS4EB3Erpsv/NH1tQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxcDF2OSI0Q46l+a1xs+kz+0bngjqmEl8hRHYcB4bvnLp525Hi/
	f6ZRaYpaLxt47QaAH0Vg+Bjn/FD9RPPupPxD2eSsRDoArQ1LyfUI6geC
X-Gm-Gg: AeBDietuIkj3xRcYYfyh5txpCZg5uma754Kdn6j8X+BMRQg1A7LPu0OM146S4IQNDaa
	2MAvHFibUF6rhCI5+a2vA9rZaEcYhNtSu2w4GIZ3nMISv5xdUvjlpp4SYSpAEBl14pN/8Fd5TJX
	rA7pRvrxjfTrUpzcdfBvDjBmuSsQWKHjYlCuQ51114kMIvim+vgfywPilaTbicfoUsqLEw7XIfc
	BJjguM25H7pj0nAjqzRsBZbcvfVGzYzmb1T/Kgdr5r9KaNSanQiezXf6HFOoTy2/Vx+hB69MDtX
	MukdZRWqKrwDtKwaEkkq3UgHdEd/WGiZIRcf0IWQHmQufME1DXDNH1Wb/oKmXSDIoKVAyNdJGMS
	3CDsyOZRs9kdPujSWiUIdZV6ORQQrNOswfJTQzGcgBbEWeQR87uKpZ/uKFPNLqlQ9f053WLnp6g
	OwuQg6rxX6a+xCy1OmhN5uMg/afSAvrTk9AOI6ThmdUrOQGlumpdhweseVWR6a/qRK8rwoFTbt
X-Received: by 2002:a05:690e:1588:10b0:650:dbb:e79c with SMTP id 956f58d0204a3-6504882858bmr13141127d50.40.1775592162345;
        Tue, 07 Apr 2026 13:02:42 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:42 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 14/20] selftests/bpf: Add Landlock kfunc test program
Date: Tue,  7 Apr 2026 16:01:36 -0400
Message-ID: <20260407200157.3874806-15-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a BPF program that enforces a Landlock ruleset at exec time for the
purposes of selftests. The program receives a PID and a Landlock ruleset
from userspace, and calls bpf_landlock_restrict_binprm to apply the
domain to the specified process. The program then calls
bpf_landlock_put_ruleset in order to release the ruleset.

Global counters are tracked to ensure proper execution via the test
harness.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../selftests/bpf/progs/landlock_kfuncs.c     | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/landlock_kfuncs.c

diff --git a/tools/testing/selftests/bpf/progs/landlock_kfuncs.c b/tools/testing/selftests/bpf/progs/landlock_kfuncs.c
new file mode 100644
index 000000000000..7ca089716356
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/landlock_kfuncs.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+u32 target_pid;
+bool enable_bprm_creds_for_exec;
+bool enable_bprm_creds_from_file;
+u32 restrict_flags;
+
+int matched_pid;
+int bprm_creds_for_exec_hits;
+int bprm_creds_from_file_hits;
+int lookup_calls;
+int lookup_failed;
+int restrict_calls;
+int restrict_ret;
+int put_calls;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LANDLOCK_RULESET);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} ruleset_map SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+static __always_inline bool is_target_exec(void)
+{
+	u32 pid;
+
+	if (!target_pid)
+		return false;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != target_pid)
+		return false;
+
+	matched_pid = 1;
+	return true;
+}
+
+static __always_inline int apply_landlock_ruleset(struct linux_binprm *bprm,
+						  int *hook_hits)
+{
+	const struct bpf_landlock_ruleset *ruleset;
+	__u32 key = 0;
+
+	if (!is_target_exec())
+		return 0;
+
+	(*hook_hits)++;
+
+	lookup_calls++;
+	ruleset = bpf_map_lookup_elem(&ruleset_map, &key);
+	if (!ruleset) {
+		lookup_failed++;
+		return 0;
+	}
+
+	restrict_calls++;
+	restrict_ret =
+		bpf_landlock_restrict_binprm(bprm, ruleset, restrict_flags);
+	put_calls++;
+	bpf_landlock_put_ruleset(ruleset);
+
+	return 0;
+}
+
+SEC("lsm.s/bprm_creds_for_exec")
+int BPF_PROG(bprm_creds_for_exec, struct linux_binprm *bprm)
+{
+	if (!enable_bprm_creds_for_exec)
+		return 0;
+
+	return apply_landlock_ruleset(bprm, &bprm_creds_for_exec_hits);
+}
+
+SEC("lsm.s/bprm_creds_from_file")
+int BPF_PROG(bprm_creds_from_file, struct linux_binprm *bprm,
+	     const struct file *file)
+{
+	(void)file;
+
+	if (!enable_bprm_creds_from_file)
+		return 0;
+
+	return apply_landlock_ruleset(bprm, &bprm_creds_from_file_hits);
+}
-- 
2.53.0

