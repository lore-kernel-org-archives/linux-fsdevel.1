Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B4410D36
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455145; cv=none; b=hIDdqba87sAoTrFOgY9qA2icWjjKuclYwf8y5fz/MPchKSPjIxA25DXvVMLvbgRoJvwVHqrV2muc3NTWmNViuIeDf0RVFKY0BuUdFkO3cAKtbj8mXAld7jj+kIqKevvNyTnbCkq140WnjzvrfLuiVoyis2fzkO6HFLptCVj29cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455145; c=relaxed/simple;
	bh=UeLmhePSWPFBkTNLrPRrGvFa0QdMl0ECbxnKCarjDNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRyaadirRHoHAZTwbQ5DV4ayDPEsrkYasxIu1nJjB/fHOcm4MxYtWMxTqt9ga4S+PzVLnSv/bzNAkEagKh8s5/UQekCfetEg6HAoD8KdnKTrboORIbSYcuvlbj8rTHFUK863xK0yKzyuJm6LR8n5J2C6shALPC0tfUhJASAPG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcN0Tc+2; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcN0Tc+2"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f0e5e36912so2740826d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785455142; x=1786059942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bZ7yPHg5vYfLp4cv5XEz6QymRiym0C5qHzBJxTtuE4=;
        b=fcN0Tc+2K8qu8lyLltORgo0w57ssv+K8cESw8jhOzqU7VeB2DkglRQQO9bhGEikiBN
         5dlf811xyvSpZGX2rzNCJmfvhnJvFUvZAaUUeGeZp5SI5p/LyrxBBXaw+DCgXDNA8Bbe
         ReKDKnUUHd4FF86S1vNfrcClSkrs3EpDczDCIneazYT/b7qC8dn2y/poW4WD0c7tQbHV
         I4f0yc+BmmibTzqVEOIqp4Mgh8qBut1kAbRY6us4R0tUqHsfmXmFtsHZN9fTlBlkKNfd
         2ZFVeLVuZ3clqAM6luCKGGWQ5tEbKalm8UJRL3JW5m4g5oW6wyx/XVkm2j8ftysDIho/
         uq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455142; x=1786059942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6bZ7yPHg5vYfLp4cv5XEz6QymRiym0C5qHzBJxTtuE4=;
        b=dITyxoeJygx7LD3n+NkmlGd8hb5NGqlLBGW/kcUjiuGEP3NTPFRfvBGZ48zwr81Mmn
         Q4Wqd+JFlrain4Ul7WfzzQfapf9C0sQweqb1/ZLgTuOyNJkc/882ndEHKmRrTIVZ+dFK
         voaolDMXNLnIpE0oB9tcaawWfSqY7nfkHPYkEa1xzjXGpxQ77axNOC0m2ryNhXf+XnSZ
         XeU2X65lJ/WWiRr9dCyGo5RhOsTx99jN6A8IzNsSPNVVwUiyfrSRaljfRlxkRhDvSKc/
         +7F7qITc3evKR/YwI2nb5U4AwHjAe8FagNNS0JPN9M7mycpgpmx1NkqOwJZM2I38G64f
         SA/w==
X-Forwarded-Encrypted: i=1; AHgh+RrnlgEDXKAxA4fsWjQLQptCZjcz/3N58P0/88wwhxOmfFCXDumHbsiXdToKotnmgrhL0so0/T8tUuHJ5kSW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7mesmSVf/OyZELyfWKUnr5uDtBN/AK6rcLNL5yhAR6IohRDB
	/em6bHOtulywHIPuLdd+9K+NX4OnwqMMQtibqog1N4jJPAGHl8qRFT95
X-Gm-Gg: AR+sD12TSTiRuZrT9OR5SlDiOWbAzdUq9J3meP1YWBqtM2QZPRsMlbQFXGQe31Wg+J2
	xAVh9wmRaEFSBrMhE3KLBXsOsH1/S4e2tqnS7FpHn7wVIXXAKKz/Kz1Y+nllDvOyIUEGa0T9GLB
	4aTgy/Nv+qPey5iUjPKJOkmrQXbxJOslVtV/WkhOx6hklYuGjVnsz85m4LXGQFn/qUts9yHHcGD
	IBCkCuGCtYbNeWK47mKGe8xuW2SZUwOj+MiUR3yygCj5wPEfRw7vY58X96tw8jHZVBgH+8G82JF
	v40MBnQhrT4FuX7GDxOSzQO/ghqfX6w+TpsYdc84thmw6szgYXv5lUKB3ow31AFkv1icx2wTCfB
	hgTgNbg4BtKXDFeINnsGUJfZalZ583jYoMwiHc6tCPfZE72+dJx2eYSO9FAD2XrcDxb/tZcAZIv
	CDKmdvwVvn/Kk4chyJYodTElH11HA5LFnvpWX0t8Xp3zXWqXwjgBIXSfoUk17oW7jcDRz7lNTcG
	zHq/KCiSIoLOBaYat+Z0dEN3TayXMea8ga50WPKfE+dGjjn+xVVvJ5ABMQZFWpQtG1AcfPB5A==
X-Received: by 2002:a05:6214:3901:b0:8ef:db4:d85f with SMTP id 6a1803df08f44-9083bb5b841mr27021636d6.41.1785455142243;
        Thu, 30 Jul 2026 16:45:42 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e8bc0sm28991836d6.26.2026.07.30.16.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:45:41 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Thu, 30 Jul 2026 19:45:32 -0400
Message-ID: <20260730234533.1912709-4-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730234533.1912709-1-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
xattrs via the inode_init_security hook using security_lsmxattr_add().
The hook now passes its xattr state as a single struct lsm_xattrs
object, which the kfunc takes directly.

This kfunc is only callable from inode_init_security; the verifier
rejects attempts to call it elsewhere.

A previous attempt [1] required a kmalloc string output protocol for
the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
provide xattrs for inode_init_security hook") [2], the xattr name is no
longer allocated; it is a static constant.

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index f1863a891db6..7b55073934e0 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -11,7 +11,9 @@
 #include <linux/file.h>
 #include <linux/kernfs.h>
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <linux/xattr.h>
+#include <uapi/linux/lsm.h>
 
 __bpf_kfunc_start_defs();
 
@@ -379,6 +381,44 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
 	return d_real_inode(file_dentry(file));
 }
 
+/**
+ * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
+ * @xattrs: inode_init_security xattr state from the hook context
+ * @name__str: xattr name (e.g., "bpf.file_label")
+ * @value_p: dynptr containing the xattr value
+ *
+ * Only callable from lsm/inode_init_security programs.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the filesystem does not accept
+ *         xattrs at inode creation, negative error on other failures.
+ */
+__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
+				     const char *name__str,
+				     const struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	const void *value;
+	u32 value_len;
+
+	if (!name__str)
+		return -EINVAL;
+	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
+		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
+		return -EPERM;
+
+	if (!xattrs->xattrs)
+		return -EOPNOTSUPP;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	return security_lsmxattr_add(xattrs, LSM_ID_BPF,
+				     name__str + sizeof(XATTR_BPF_LSM_SUFFIX) - 1,
+				     value, value_len);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -390,6 +430,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_init_inode_xattr)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.53.0

