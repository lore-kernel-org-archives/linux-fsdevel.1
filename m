Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493438;
	b=jI0sBXzE3TZ20jXexxjLrPcuvfD8ytQEIq+hlR4cy3pj/fEwcODuCrQCrbYU80/x3MFZ
	 JmJyas/SkYPPm0eKwH6JDKjCkIb7Ur+r+5JCFHjbKyiYvB4pPdf3XYajtZRSd2BIdlZyR
	 FFqqG4pHtPLaxV5hKbZ8ktMKefxYMFuIUFLp5YJV7cvCWi2X/Ea+I3VH59gNrLbR218Wq
	 HzxvkV5W6GguLZ61K/E2y9CpCC1g4sEbONtvB9bD633EEvOK05x3YZerK4G7P6kKCbcNS
	 6OpU0LgVyNQOaBi8UDWA4lDzx67puQA2741QArY10jtp+7Xw+pyZU74ONb/6uJt3f4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MhMu5FEtXkntHOOeoX3WjHhxNQ8l3+u41N1zcltWVZs=;
	b=WiNXgPK+NkKrwxBto+1EB1jqN9h1X4SJrTnXb5VgZyrKR9MJFT2H8NvrFUpoa1MmQRXK
	 78W7kjmLn+lU3duK0ndNkTXgMTyy0k13usMMrdnQCq1YVTvdTRQWRo/1GG1u1ZibnQ9Ed
	 f0y80s3qEk22b9sjErDEftUkcD3V9mZWEBdPhfa5mr66nNohSq6q3EuQP/MBzH3EOW2Bn
	 UsSw9X1wL9MLhUvHNbhugUyZ/VTxmB7pQnyfSNe3UL/eFNB2VJqMAN8cd90TM41ZyBswV
	 LDsWsGYymBnnVBIk0wnQyr35lyLovxgSSe5yT1eR0BA/pc0Pji4zP/PHwtvX86y/nxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=n+VfWZJI;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D360A261F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 10:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71D360A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=n+VfWZJI
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1907531a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792493437; x=1793098237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhMu5FEtXkntHOOeoX3WjHhxNQ8l3+u41N1zcltWVZs=;
        b=n+VfWZJIKH/eHZfmEe72UdQhnBP9Je9qNV4IRjnamQjgVdBQhPN9njTJVunf0jOrP6
         oYbRpWsnOoeTevf0f/rjBxqKCdsWFINxEEZI79dSqk3R4Yyudue2Ks6o+EbPdSnADKWN
         vDd9NZskb8KiLYgFUu10H3DsdkBofXbMl8JgNtb0j4e0ms70854zd8g0gCy+5zqLOb0T
         3o4yrg0G4k+pJSzQiZ8Buupx7mDS8oRYfi1TEBlMDZ26NshhM4qoX6RaO0MUIlmYZtcI
         uLZ8P/FtRFJOJ3EqY+p2tI1qJnPZgP5tXs2fu1vLAYm4iD3Mv69nNPVojREEGl2EgQEa
         kkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493437; x=1793098237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MhMu5FEtXkntHOOeoX3WjHhxNQ8l3+u41N1zcltWVZs=;
        b=XtWQ3rftT+bNqyqYPDp63RMOd520h2xUur8wPJMMWFlwJq9dHZBvNzRoYATwqygYa/
         eC3h7OByQqFk/KfseZjxgi1O1HgHlHKysiT1KqMi7f+L2mQR70nH4YvXfqomUT56Rd5I
         rfAktnyCl1EGaOh6mwhmzGbyLduh4CpYggQ+Gm8bc+kVP38yIssm9ujvAcqWr3WBD/Ii
         /cR+fgriuS0G4O++TcPdygf2MxACd1UwBDdlU/4d+/uU1QcgBD9x+0JnmB3tDPdtnA1P
         k2gJqw0PcZ8da3QTu65rJ844uOPLKSrt91RNou41ODsEHBUf7HUeMoh8IDLdsQLqzvgS
         tG4w==
X-Forwarded-Encrypted: i=1; AKwUvBw5r9FsgX0Xs9CGpWlRzy+pZazUMldDzdG5nRbM0FjR1s+ok4hj+vFTfBkXR6YGwLWfsRsKUoJt6l9Y+2/Z@vger.kernel.org
X-Gm-Message-State: AFq9FYIi+XIO+ftgt2bhaQryTpUOZs22dIqgz4sliVpq+UJMrQRjK5Ej
	9BcUB1ocuJjH2PeezYJ8Yuor3JRiBryd6Mwgay+v7mmAMvQqdySjTBX7AFCoqqsOi6cl
X-Gm-Gg: AYBFou24GYEmioQHKEHpbmwd5ji4WJsgxOJG/6GAXhFsEWOjODGnUqWfQnbAQDdmaGf
	UN+GySs68CsaSiAObxQ+lpPJ3+ZM0ebBQxd04g8rZiMtrFNGMwLkGu+Bq9EOC298ipYsxSvoCGI
	1hjVBuFWqypFtl8kvxVc4SnmR7FxlVCLoURSiZ8HuXtpYkwPMFjMchUtNkNcpPjg0/1ql3NyEYh
	uORiLZac28xhA7MKaP5EatwLAvWwHnP0SABNX3vKMUYqaDN7lZpahce3141gnZFoBRKuP2n5s28
	OUMHuISCl3I241KTNDVwxsTfGx1GxT61sy1AL6MmErhnmLSFRqZzy8+RPayVQrscV4x7kpLoVnt
	4LH68T5Oryd1E9D7UEf+YomVVnFsURW2TtM7ibwT5yN5S07Ez+h9Qd/LHEWuNAFeY6zXpNOgp/X
	pJzCtuGcQY0hLYW0GZG9UD71KdxSaKcLtocc+6syR/qDd5gMk/UT4a4M7/CT/UFWQ/5XdoaHkml
	/7QlDKLQWySzp8mHMznqKxWtE35YfcnUlKzl3KzKAeWHxbZ+grhtpFx
X-Received: by 2002:a17:90b:5109:b0:3a7:ef4:164b with SMTP id 98e67ed59e1d1-3acee2958cdmr7889908a91.2.1792493437009;
        Tue, 20 Oct 2026 03:50:37 -0700 (PDT)
Received: from workstation.. (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f36a5asm3487902a91.9.2026.10.20.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:50:36 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for exiting tasks
Date: Tue, 20 Oct 2026 21:50:13 +1100
Message-ID: <20261020105014.97985-2-matt@bobrowski.net>
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

bpf_path_d_path() passes its path to d_path(), which resolves it
against current->fs through get_fs_root_rcu() without checking that
the calling task still has one. An exiting task does not. do_exit()
calls exit_fs(), which clears tsk->fs, before exit_task_work(), and a
file whose last reference the task drops in exit_files() has its final
__fput() deferred to that task work.

A BPF LSM program attached to security_file_release, which may pass
file->f_path to bpf_path_d_path() as a trusted argument, dereferences a
NULL fs whenever a task exits with a file still open:

  Call trace:
   lock_acquire+0x8c/0x218
   d_path+0x270/0x378
   bpf_path_d_path+0x28/0x80
   bpf_prog_9801cf2b982f05b2_file_release+0x1d0/0xc60
   bpf_trampoline_6442515074+0x7c/0x100
   bpf_lsm_file_release+0x8/0x20
   security_file_release+0x58/0x90
   __fput+0xcc/0x320
   ____fput+0x1c/0x30
   task_work_run+0x88/0x100
   do_exit+0x210/0x3e8
   do_group_exit+0x3c/0xa0
   __arm64_sys_exit_group+0x20/0x30

With lockdep enabled the fault is taken in lock_acquire(), from the
seqcount read in get_fs_root_rcu(); without it, on the read of
fs->seq itself.

Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
is NULL. Only the task itself clears its fs, in exit_fs(), so the check
cannot race with that.

Fixes: d08e2045ebf0 ("bpf: introduce new VFS based BPF kfuncs")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Bobrowski <matt@bobrowski.net>
---
 fs/bpf_fs_kfuncs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08f0847c4970..6665a78218e1 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -87,6 +87,14 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
 	if (!buf__sz)
 		return -EINVAL;
 
+	/*
+	 * An exiting task releases its last files from exit_task_work(), after
+	 * exit_fs() has already dropped its ->fs, which d_path() uses to
+	 * resolve against.
+	 */
+	if (!current->fs)
+		return -EINVAL;
+
 	ret = d_path(path, buf, buf__sz);
 	if (IS_ERR(ret))
 		return PTR_ERR(ret);
-- 
2.47.3

