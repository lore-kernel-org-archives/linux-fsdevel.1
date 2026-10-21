Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613663;
	b=W/fUvdaoAjXMqZsXhSJ7ihrQ5F/8SEzfbUWNtUUHsygo3z+OodIhNyK9J7nIN8e4/3P5
	 hVVxUPRfoJGJ3ZqRloPX2FRBfsVJPZASCzsFMA8jtp87jjnMSPfsr0d15DjDStwEDsE29
	 Vyjt98TvXLY2I/mWqwW24HcJl7FRiivKcnJlVSWM4yTH/k3SG9rPyXpWD1bAIxU6+dBJP
	 63yklotdLQvC7UZn98bLu1Tq06CPvAQPnH//O5uKKHz5UBTfl3C4f/VMnHq3TBcB+Z4BB
	 AIFznpfEwDta4LSHf+sHFyq5nrBXGA84/J5YQAHXOUHDVLDg0IiatmdjEwDYzEct6Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613663;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MK/sCNnQliqsRAgVoxF+hCWSDeszRLqOViWrqNvyhPc=;
	b=e1+ukzw6EP8aGI4QUn0Ut1dqUogj0mv8pBT1z9Oy3IQcBLMPaWoewxgmJ0S15MDhR6/0
	 eu6ZJkLpKUP4sL09gXuQutB6VvYSU75YUMAoaJffyzudzaQ/IQwkiVp/VJQjHL/k51Srw
	 Q/NlNNn8vb0bSQCoSrTSH/9flNyI8lFXeZxU7gEVFs3aagWv7D4O+jVWkuEsvGxn8pN6i
	 qAZClq9hJL7lGy+lXPbg7rLK1k1giAB+oB5jIqjwXvSnvpnlrmQZqnsSJk69l3gT57ugw
	 KpjaoSCI+cxK8TUuy2lhFyq+XvSv5N1DghMJR3ram0RRc6zaGdfiIGM2LopZ0F9sCfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ox2VFkCo;
	arc=none smtp.remote-ip=91.218.175.118
Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E75606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 20:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E75606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ox2VFkCo
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w2yIvfdgGfmlQVpeDUGVxacsdJvhxz5P+RtAjBdIp+U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792613658; v=1; x=1793218458;
 b=ox2VFkColxaQvhbRPAOwLuz+qjvZGykGQTMQ7lMfTeQyOsOtVRJkJMu7p9uCJ5Z2qdkKLftq
 GU7CY6UM+UuLov8zO7bMaBIrCLkO2D846eb5SZ+KV15g3NAtPdkArYViUJOZ6UPH59mcy4vJ1E+
 qNKh8sdfB1ahgePZnVF3feYc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 19901bfe483d708d;
	Wed, 21 Oct 2026 20:14:18 +0000
X-Mizu-Trace-ID: 19901bfe483d708d
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH vfs v3] bpf: Allow bpf_d_path() from filp_close_sync()
Date: Wed, 21 Oct 2026 13:13:59 -0700
Message-ID: <20261021201400.5409-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
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

The d_path selftest closes its descriptors with close_range() so that
its fentry program on filp_close() runs.

Commit 056069eb2b66 ("fs: make close_range() synchronous") switched
close_range() to filp_close_sync(), so the program still attaches but
is never called:

  test_d_path_basic:FAIL:close trampoline for filp_close was not called

With that series, close(), close_range() and the closes on exec and
exit all go through filp_close_sync(). Few paths still reach
filp_close(), dup2() being one of them, so a program on filp_close()
no longer sees most file closes.

Allow bpf_d_path() from filp_close_sync(), but only from fentry.
filp_close_sync() drops the last file reference inline, so by the time
an fexit program runs, file->f_path may already be freed, with no RCU
delay for NORCU dentries such as pipes and sockets.

Attach the selftest program to filp_close_sync() and keep triggering
it with close_range().

Add a test rejecting bpf_d_path() from fexit/filp_close_sync.

Assisted-by: LLM
Fixes: 056069eb2b66 ("fs: make close_range() synchronous")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

v2->v3:
  * Drop the unreachable BPF_TRACE_FENTRY_MULTI check (Sashiko)
  * Add a Fixes: tag
v2: https://lore.kernel.org/bpf/20260925210347.1364191-1-ihor.solodrai@linux.dev/

v1->v2:
  * Allow bpf_d_path() from filp_close_sync() only for fentry (bpf-ci-bot)
  * Add a verifier test rejecting bpf_d_path() from fexit/filp_close_sync
v1: https://lore.kernel.org/bpf/20260924204226.190315-1-ihor.solodrai@linux.dev/

The issue was found by BPF CI when running on linux-next:
https://github.com/kernel-patches/bpf/actions/runs/35923662147/job/107398237366
---
 kernel/trace/bpf_trace.c                      | 15 +++++++++++--
 .../testing/selftests/bpf/prog_tests/d_path.c |  7 ++++---
 .../testing/selftests/bpf/progs/test_d_path.c |  2 +-
 .../selftests/bpf/progs/verifier_d_path.c     | 21 +++++++++++++++++++
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..4b2f944bf67f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -974,6 +974,10 @@ BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
 BTF_SET_END(btf_allowlist_d_path)
 
+BTF_SET_START(btf_allowlist_d_path_fentry)
+BTF_ID(func, filp_close_sync)
+BTF_SET_END(btf_allowlist_d_path_fentry)
+
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING &&
@@ -983,8 +987,15 @@ static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 	if (prog->type == BPF_PROG_TYPE_LSM)
 		return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
 
-	return btf_id_set_contains(&btf_allowlist_d_path,
-				   prog->aux->attach_btf_id);
+	if (btf_id_set_contains(&btf_allowlist_d_path,
+				prog->aux->attach_btf_id))
+		return true;
+
+	if (btf_id_set_contains(&btf_allowlist_d_path_fentry,
+				prog->aux->attach_btf_id))
+		return prog->expected_attach_type == BPF_TRACE_FENTRY;
+
+	return false;
 }
 
 BTF_ID_LIST_SINGLE(bpf_d_path_btf_ids, struct, path)
diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 1a2a2f1abf03..7665e1d28a64 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -109,8 +109,9 @@ static int trigger_fstat_events(pid_t pid)
 	fstat(indicatorfd, &fileStat);
 
 out_close:
-	/* sys_close no longer triggers filp_close, but we can
-	 * call sys_close_range instead which still does
+	/*
+	 * filp_close_sync() may be inlined into close(2), so use
+	 * close_range(2), which calls it directly.
 	 */
 	syscall_close(pipefd[0]);
 	syscall_close(pipefd[1]);
@@ -165,7 +166,7 @@ static void test_d_path_basic(void)
 
 	if (CHECK(!bss->called_close,
 		  "close",
-		  "trampoline for filp_close was not called\n"))
+		  "trampoline for filp_close_sync was not called\n"))
 		goto cleanup;
 
 	for (int i = 0; i < MAX_FILES; i++) {
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 561b2f861808..edb5494a47f7 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -41,7 +41,7 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
 	return 0;
 }
 
-SEC("fentry/filp_close")
+SEC("fentry/filp_close_sync")
 int BPF_PROG(prog_close, struct file *file, void *id)
 {
 	pid_t pid = bpf_get_current_pid_tgid() >> 32;
diff --git a/tools/testing/selftests/bpf/progs/verifier_d_path.c b/tools/testing/selftests/bpf/progs/verifier_d_path.c
index 87e51a215558..7ab9b6b1d589 100644
--- a/tools/testing/selftests/bpf/progs/verifier_d_path.c
+++ b/tools/testing/selftests/bpf/progs/verifier_d_path.c
@@ -45,4 +45,25 @@ __naked void d_path_reject(void)
 	: __clobber_all);
 }
 
+SEC("fexit/filp_close_sync")
+__description("d_path fexit reject")
+__failure __msg("helper call is not allowed in probe")
+__naked void d_path_fexit_reject(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + 0);				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r6 = 0;						\
+	*(u64*)(r2 + 0) = r6;				\
+	r3 = 8 ll;					\
+	call %[bpf_d_path];				\
+	r0 = 0;						\
+	exit;						\
+	"
+	:
+	: __imm(bpf_d_path)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.56.0

