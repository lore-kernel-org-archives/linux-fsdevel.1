Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493446;
	b=XuO1QFhl1j27EfgH5Eb7CxMyFDInSkNkFao4lhDp/BMP7Jdyqn3vMXQtQFMjxBaLXF1R
	 RlQtopzJOzJ3XLFpIpqjdUFmtJddC5P8y+5HUQRKJqh9+t3624E5udmudXo6vpnDnXipH
	 ajW8K30VLupgOup1I2N0IyVhZ/2GlDC4ZAiAxQFwOmDf04Et4/wGncaI7AWhq3aAl6rDh
	 vv1pNSHYJtMgEzHWxCpi6/uGU9v2OG/KD3+Ks7yaoVuim0EBPsYya4HO55V0whVjf9efe
	 z0wfQejLLKom2grIiL7vZi77eSIjxrxLobaltLMCkvpfc6zC47C+fY/TXzkz4qwBaEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
	b=fPDqYHlXIJ0t/LQlE7oCmj7YlXHmbw4hapEw00WX4sxkYqNeoCx5NdcDxHBpVjDvVT40
	 Gd2R3EAxQoToMpHlNeOr3PWVHWmx33aLk8cPAfmxgbRKK6SCRgist8EvHEczX/DlEo+Mh
	 7XqBXensPR++nGsUOMQCS1RtD9KAclLxw6/8MkCrZ5XG+RWvMVsJ2FZLK1oxejOFmePxc
	 eLpMsG+HqHw+6AeBcKpkfpofiwAXZnagHybBvAdlT4sCsiXOL7njeZd4MA1ZX0ddGhLTZ
	 8DriC5Etg3nx3sSGFEzzOZS03aLZ01EYvyF7WMkKmbcw39ZZWLeN0IKx5Jkjo6+4YNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=CpFjF7HH;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CC606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 10:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C34CC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=CpFjF7HH
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1186995a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792493445; x=1793098245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
        b=CpFjF7HHjiBPEyxhDRihQ3nc60Cyw7biDO8DewrQJDjFdKjSR2q77jdcI1CmwnPdMZ
         o4ylYaenRJ0i0c2ZUC37IwuqhT1jiKsZg0pxehLaIZdv3mEKzVRbkM3sLlY5gimJvxgz
         hFrpy4bSAjXp2Ej4If0TH7VypNFaIOAUlKAk8IXr3sQMpNZ0OMq6UTYk+GK3l4acuY2r
         D6wCZ7JWOXgS45XELV+UcEMeFsCo296qi5jaHfg8fWnqpwj6x0SZb8deUrJ10uat0gm7
         8ehHCsjjtnf22GSXcc5xYv6kU7rudfhKMJlroNQb861zFTQbpmk0cC293LYzjq9zUOnd
         wSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493445; x=1793098245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijPSVZtN0wV/FObkbQ5coj1GUsZLgW/HlOlDTeZNmFI=;
        b=ZhaBwUyFEy50CH5enReK8MyIXLSmGKwH06yXqIk0uX3lsj9GFeMwKhFfw4qmaMHPxt
         jhk/OiW4SqZzrui9IeDy+4oO5erEmlgtjI//SR68luczem617bEooRyHDO9Z9AdQGGf+
         9/qx7qtZogEqikj7LNkEDKrTbkeFI9Eh1j1JQp4gOy7G/FQczmm/GbfjbOrIKif2O1M8
         MDe3pkmJBfKIbn4EYweLMRZSFTXcmtd1u7/1Zx4wHyHJ2U8gi0jttBlIasR6cQCVpsoB
         JpMYuWEAHrlK6Qfdh19S0pkxaSb2mcuRsMipBxil/TUTirLz+2pOVKXFpeB7I4pHjnRY
         Nhmw==
X-Forwarded-Encrypted: i=1; AKwUvBw/cBsaajRwLCgbisWJhZb2thEFqKgzPj9EJugjj+oXuEuAw/6JuvyyYa7TEbSyLhWs843Gj8cZGaKl9Xpb@vger.kernel.org
X-Gm-Message-State: AFq9FYLG1sl6hJYSkBlbuYs1SsIf0whq8/vecD7vEI7NDguYCCSxFjWP
	3i2ItAKjrawRkcZoqWK6Rv7aSBZkmORbNqnBoSybvgDo36lO7BavDGk9XHZaW0tG1IGe
X-Gm-Gg: AYBFou2qPgNWRyt42PaOPw+VB+TZZz4+1VcsckFESvi6uqbz3D1sVJXTJSX7tVfGL6j
	drwOW6X6jLbbi2SpKWDPOwN/goLLx1iQ2fKtPweFLU4dvf1RdEHIFDP3WHu/+AZjJ/SNlV0fTHA
	VlqWJr9JzeQOQgwhbe0EZiW1dx/TXRMAdwrBRxdHKoNGLay4qL/R8uiJUaV5IB/FOrc4e9UIGBJ
	e1kQos68R2A/MeSIB/nF3efZkgXtRsDg2YA2tOBfKRrwJM7oTmnGcpEUTnLGvBWY/YE/a4w6xhj
	6GmvttsaTKfvnOuEa3b/XAiPbOJoDSbkqvc7LZXZ4Funv8dHuHcFHetKgoG7jVZfA7l0gYEhm4D
	Z5qAhWNVd0vxGxmcInow4wu98SSMe4dve3ajVUqc15Ve5s9qcMGtYufaRsosVUVsSLHV4j7HVRM
	TC6D1tYJ02Ew5X7NiazH3nEz+sxpFC7zhNmQ5IO9G7VzubW14rpvYjifXXfGVdzz8NabhUN/d1+
	ljXIH3NoNTPZ/evBz1+Kr+nX51jo8+14nzt9gEEBEV0uA==
X-Received: by 2002:a17:90b:5743:b0:3ac:9d14:feb2 with SMTP id 98e67ed59e1d1-3acef14fe3bmr8737797a91.35.1792493445059;
        Tue, 20 Oct 2026 03:50:45 -0700 (PDT)
Received: from workstation.. (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f36a5asm3487902a91.9.2026.10.20.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:50:44 -0700 (PDT)
From: Matt Bobrowski <matt@bobrowski.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Matt Bobrowski <matt@bobrowski.net>,
	stable@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: test bpf_path_d_path() on a file released at task exit
Date: Tue, 20 Oct 2026 21:50:14 +1100
Message-ID: <20261020105014.97985-3-matt@bobrowski.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020105014.97985-1-matt@bobrowski.net>
References: <20261020105014.97985-1-matt@bobrowski.net>
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

Add a fs_kfuncs subtest for the crash fixed by the previous commit. A
child opens a file and exits without closing it, so exit_files() drops
the last reference and the file is released from exit_task_work(),
after exit_fs() has cleared the task's fs. A file_release program calls
bpf_path_d_path() on that release, matched by the file's inode number,
and records what it returned.

Without the fix the subtest crashes the kernel in d_path(). With it,
bpf_path_d_path() returns -EINVAL.

Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Bobrowski <matt@bobrowski.net>
---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 51 +++++++++++++++++++
 .../selftests/bpf/progs/test_path_d_path.c    | 35 +++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_path_d_path.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..510cf11c8bd8 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -4,12 +4,15 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/xattr.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
 #include <linux/fsverity.h>
 #include <unistd.h>
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
 #include "test_fsverity.skel.h"
+#include "test_path_d_path.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
 
@@ -268,6 +271,51 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_path_d_path_on_exit(void)
+{
+	struct test_path_d_path *skel = NULL;
+	struct stat st;
+	int fd, status;
+	pid_t pid;
+
+	fd = open(testfile, O_CREAT | O_RDONLY, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		return;
+	close(fd);
+
+	if (!ASSERT_OK(stat(testfile, &st), "stat"))
+		goto out;
+
+	skel = test_path_d_path__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_path_d_path__open_and_load"))
+		goto out;
+
+	skel->bss->monitored_ino = st.st_ino;
+
+	if (!ASSERT_OK(test_path_d_path__attach(skel), "test_path_d_path__attach"))
+		goto out;
+
+	/*
+	 * The child exits with testfile still open, so exit_files() drops
+	 * the last reference and the file is released from exit_task_work(),
+	 * after exit_fs().
+	 */
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+	if (pid == 0)
+		_exit(open(testfile, O_RDONLY) < 0);
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		goto out;
+	ASSERT_TRUE(WIFEXITED(status) && !WEXITSTATUS(status), "child_open");
+	ASSERT_EQ(skel->bss->called, 1, "called");
+	ASSERT_EQ(skel->bss->ret, -EINVAL, "bpf_path_d_path");
+out:
+	test_path_d_path__destroy(skel);
+	remove(testfile);
+}
+
 void test_fs_kfuncs(void)
 {
 	/* Matches xattr_names in progs/test_get_xattr.c */
@@ -288,4 +336,7 @@ void test_fs_kfuncs(void)
 
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
+
+	if (test__start_subtest("path_d_path_on_exit"))
+		test_path_d_path_on_exit();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_path_d_path.c b/tools/testing/selftests/bpf/progs/test_path_d_path.c
new file mode 100644
index 000000000000..4ea50a067819
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_path_d_path.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define PF_EXITING 0x00000004
+
+char _license[] SEC("license") = "GPL";
+
+__u64 monitored_ino;
+int called;
+int ret;
+
+/*
+ * A task that exits with a file still open releases it from
+ * exit_task_work(), after exit_fs() has already cleared its fs.
+ */
+SEC("lsm/file_release")
+int BPF_PROG(path_d_path_on_exit, struct file *file)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	char buf[64];
+
+	if (file->f_inode->i_ino != monitored_ino ||
+	    !(task->flags & PF_EXITING))
+		return 0;
+
+	ret = bpf_path_d_path(&file->f_path, buf, sizeof(buf));
+	called = 1;
+	return 0;
+}
-- 
2.47.3

