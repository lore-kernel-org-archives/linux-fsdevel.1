Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494601;
	b=HdaKJ5pn4srJczZe1juGcIciYcNkc1IP3Ocjlic84jmf3P5TEo/VQSUtokiVjdunjYvS
	 TEYGgs5IZthvSo0Z4WCl5yxKu1b6TW3VsdG5FomP14qjacUTBOOBulzg1cI9hR9iVjHFU
	 VyTRHOkMXKem5JfUaBsxEgXaoW3w4jIN/0TYCggKLodVoiEqEk3sDytSY00TlwXggflSC
	 ck6k0Far7bGFMerd+hbT8TLkDjVlfB2oykYTz2GCMrkg4gTUlwguFTUCkjJcX2LyAjkcx
	 fMbwxJ7WHJolEiOq42wBUbXTAUyeiFJNWw0zrWQqAgoEvgS9C20BAiCIAz0LvgPWT2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=WpPmlyynvDUMe1He5kADoWQv2vMHrwCbBfff4xiiiVY=;
	b=vNDOTA8Zqb32pL3JgTfvQQ5JRueiTUQJmalRbIdDzfGwRYwqhaY6WfiUSVvQewuxS1o7
	 QncoUnEay88lRY8nKihS7e9Gr9W/jO/UXo1ibujQG9mvbpKf3blKYmFItOuptd3Vu1lj+
	 xYdWnCL4p+TebSum+lD5XWOGCkmW8a5daySiSrRm6d9nvQTvuK6zvjNeMw6JiKRuW4GO2
	 abpeJfY2OE+qOuNIXzAZs/vwt/S6Yo1srrJPm72ZnQYPHzVHQrjryJXj5pW1iu45RMu+U
	 gq4dGguF4ljN58I8kNWgpqWRtVuesQVKHALHHWfLMPsN3sBZE8sEet3HggGDYzVItsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xxu/mCu/";
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4685606A31D
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 00:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4685606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xxu/mCu/
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a058315c79so904393b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793494600; x=1794099400; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WpPmlyynvDUMe1He5kADoWQv2vMHrwCbBfff4xiiiVY=;
        b=Xxu/mCu/OESL41DxQmT3WfQHPJJsrR4xVMtYEYQ0t0SplR5AaE0nB+FFeycO0fv99G
         QeV5kqJw04aM2yv9L3RVq5xoMMqAxapcIBkPRdAxn4DqZaRM70kQGAtH87eaPHFBlxXg
         KeTyW3gHRaeVi+c0weAHStWKQVFttPKKXaOF/Gx98HGGhQDaRfwUvSqaJM4Nn/AWqIpC
         FasfEij4IBss6TEkUYjnsce476QMHqGpg95S8rZkdABCJ1GjDvA6NrXs5Ak97uRsWPnr
         6n4ehoRWkGKA0mXUJN5owRgKTLJoeCtKQZmyoeU3WiFELnTJv0E9dvggRpgqP8SHFVTt
         udWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793494600; x=1794099400;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpPmlyynvDUMe1He5kADoWQv2vMHrwCbBfff4xiiiVY=;
        b=IOOXI71OlSyDJlFl1Y0cPZpNDNZgSEYV5+MwWFwbdKmvqwKg5L8M13ua70JYw83huD
         T+9/s1KmEitotyEKNy5mrjcH5E1mDrSZZ9cNR8KNw7SM9BaIE6dRXfMwnMRy/FavsJJS
         d6dqEkIImD7yUywe1PjoFVWcZ4lQ6bOm7EwzV+tkpa+xKlATJ9TbX4z3TT7pI2UGvwvO
         8rMJ31/km9kWp6+nTy857yxbjIAhkohjInHRLEs0NJXdI/Phr6JoLfijuRMy67Y7nNZw
         fDD03L7sGbvF7GjKJNAUb9lmOMLNLbWzLIi7tG+vDIGk+xPjZ6XK4YkFMgHgtT0/xuCz
         /Osw==
X-Forwarded-Encrypted: i=1; AKwUvBwO0O5H/Y+y3j4ycVOP9sLxpoHdYPAE4zHcb1IH4gD81QXeyq7UmMIcGK83MHXX+W8GfW/nTJJv+95uiOD9@vger.kernel.org
X-Gm-Message-State: APuU4Z8qVZ5KkGf43IHrFwXsLeIbbWTvwFuXfcXZzs1E+WdMMCgcEZB7
	nnlHgoTyTftaV9oJVa1RFkdlYDKg9dpX3HgOKeDRw6aQC11a3JpsTPt4
X-Gm-Gg: AYBFou3R+lxFY4xJClKJLw6viUP23dByr3i+1Yg5KpzmIBCZbbPXtHtLb9ZKlNnEHfU
	AMn82gYSFn3rEMMZu5LOYhBCm7uOolCoURmhp7XVC+8EAZQXDmo1ZnuJxXfFEd4G7CqCY1YSIMG
	WE8z8nb84RMkkWfiJiG2KJ9PCXRmAp8yFQdOPYMnZbHSHnTtGifsR56cC8KICfbzQ2hXSBl+hv0
	aDd3vrh23MD1fI92MhGZLemIS7egZg2mJhEXCRBoWCMjnuRRnYgC4QZ6afEk8tiqxQgW8PZMw2W
	8EpUCRBlUPomQAaYPqO8zhCxX3RMhF5u/uOjOemcW5a9qRT05KI3FPTfxW8rc0tqHtzi7bnFfan
	QvCKkc2c0cREMTLHAFRZeNmckAqGZkb5YE3ptb6vR1Zp5OBzomRJMzgN3OZcLz993wM3E/JbGvS
	4qsdV3sksUDA3JSFO5GwuezhPxjSinru0EmksTHR0x/5ZWdPoGs+TalwmSpILAgWmig9PKb5iRw
	T7VqBqmFK1/YG71Bj2YmxswDSitzKjl/PI/5+IuE6YUENPNDHqCLh6xD17eYzDXmH3LRaKWjah3
	qd+KVc0/tAiqy2b2rvBW8hCUbqdIWT/dhH+2Si65WiU1sh5yVkS2BoIv0seqzi2XGe04JJOCDW8
	hdy+syqT91e13guLqiKpc3qCDOMeklv8iaPtQ6j8By3K3IbliM+GsIW8=
X-Received: by 2002:a17:90b:1644:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3ae897c94ddmr5486226a91.47.1793494600050;
        Sat, 31 Oct 2026 17:56:40 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae880a46f1sm3921333a91.3.2026.10.31.17.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 17:56:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 00:56:38 +0000
Message-Id: <DMJGRWDYEWL1.3FPGI4KTRWAPW@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
 <jack@suse.cz>
Subject: Re: [PATCH bpf-next 0/3] bpf: Add bpf_path_getattr()
In-Reply-To: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
References: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 02:59 AM Anastasios Papagiannis <tasos.papagiannnis@gmail.com> wrote:
> The kfunc returns a 64-byte bpf_file_stat. We avoid using struct kstat
> directly as this is an internal structure and this can lead to changing
> the user API. Inode and device identity follow the filesystem's getattr

kfuncs are not uapi. See "kfunc lifecycle expectations" in
Documentation/bpf/kfuncs.rst.
The prog reads struct kstat with CO-RE like any other kernel struct.
No need for bpf_file_stat.

> operation, and the device number uses stat(2) encoding. Mount IDs,
> mount-root attributes and ownership translation follow statx(), including
> mount idmapping and translation into the current task's user namespace.

bpf_path_d_path(), bpf_real_data_inode(), bpf_get_task_exe_file() are
thin wrappers of vfs functions.
Lets do the same with vfs_getattr_nosec().
like:

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -96,6 +96,37 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
 	return len;
 }
 
+/**
+ * bpf_path_getattr - get the attributes of the supplied path
+ * @path: path to get the attributes of
+ * @request_mask: STATX_* flags of the attributes that the caller wants
+ * @query_flags: AT_STATX_SYNC_AS_STAT, AT_STATX_FORCE_SYNC or AT_STATX_DONT_SYNC
+ * @stat__uninit: buffer to return the attributes in
+ * @stat__sz: size of the supplied buffer
+ *
+ * Ask the filesystem for the attributes of *path*. This is vfs_getattr()
+ * without the call into security_inode_getattr().
+ *
+ * This BPF kfunc may only be called from sleepable BPF LSM programs.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_path_getattr(const struct path *path, u32 request_mask,
+				 u32 query_flags, struct kstat *stat__uninit,
+				 size_t stat__sz)
+{
+	struct kstat stat;
+	int ret;
+
+	ret = vfs_getattr_nosec(path, &stat, request_mask, query_flags);
+	if (ret)
+		return ret;
+
+	/* struct kstat in the prog's vmlinux.h can be smaller or larger */
+	memcpy(stat__uninit, &stat, min(stat__sz, sizeof(stat)));
+	return 0;
+}
+
 static bool match_security_bpf_prefix(const char *name__str)
 {
 	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
@@ -504,6 +535,7 @@ BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path)
+BTF_ID_FLAGS(func, bpf_path_getattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
@@ -515,8 +547,9 @@ BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
 #endif
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
-/* Side-effecting kfuncs that stay exclusive to LSM programs. */
+/* Kfuncs that stay exclusive to LSM programs. */
 BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
+BTF_ID(func, bpf_path_getattr)
 BTF_ID(func, bpf_set_dentry_xattr)
 BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)

pw-bot: cr
