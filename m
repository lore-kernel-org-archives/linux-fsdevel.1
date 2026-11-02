Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616457;
	b=O3Xi4m3lp7fveE6m3Q5kmBKTsFhoAv0/vqoyyBiT+n0pcpMSpuzAD2Oqy/brUsnjg80J
	 F7BvnFoJRqKLsKHIDG1id7odnBytKySPjSREwDcf9yIB7hnlSXQ+EbPe3thaJgPEFqs5K
	 JqgZ13B5c74mw38WIX7Ddkxg6htU+Tt9qLvuhE0B/6eltzZZGJ2Mr0fBtbfH3oluBFqsZ
	 lai54UQiWTf+Q43lJjZii4EWS5nN9IECTmH3i0ScsRrUkBtXbjS/nMAPymFP2U353jOiI
	 6A5nX3r7/9OWcDymUu3lhR4kiCCiID8kT+6XhoxO4jvfYCKRerKd+Op7ptjL2oQP0bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fgtT2+a9TrTITBRXB1pk27WkIgQ+nxQrQ3NB1J1hYuM=;
	b=N53UQrvwjFSm45HMr5FAa5CdT5wEjPGLkxyORUtYajSIVMeJqvo8iP9XkJZIj1b0YKyL
	 gYRsNQX3LugaEqC0qxya0FT0VjJp/hpkKfelQFvnwJ3SCijzoLsd+WQYvjrFktOVTJMP/
	 QQRV++c56f1AXhLjwYhPpO/CEGcoho3xAuZXWamI66BvuQtuDLwBafgA1qnnaOT6NQ20i
	 2bpzSIbI5BWhw8uGldibygyr9Mt/yicBfw9iE8e0c1FZcHy1C8mVKy8/7YnZehnjYmoqT
	 +5acWHn+tVx6WC8gJnpSEy2T0YBHWFa3pXL/JOPjQfYikg2Gisc27YNb82nsHngqKvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KfoU/C5V";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD8606A33C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 10:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0BD8606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KfoU/C5V
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso21837405e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616455; x=1794221255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgtT2+a9TrTITBRXB1pk27WkIgQ+nxQrQ3NB1J1hYuM=;
        b=KfoU/C5VTwLgglWwOGIhOu2WjOGvxbM3LY2fCfJz6lShfFpPvqzy4ezwM/iMiYgL+q
         Tul9qsTFt++Vxvo5bj+KuUneF0k5khy7EkUtw3aga+Z2wW4RYU6YE8GJuraORD8x08S/
         aQtEf14PxG1LdsFtNKFgAq/Lpj2k0gGfugTqfojHwT01jomsA0iz3y0RfDCao2L/qmfm
         65mIOVntxKNAxTZzjP9b1wIthVOejEPTuUOOjULlkmuMz9/xT40F6sutVETL1s64XQqg
         0PPGjTllaw1G2DtC88d9PLKw6sF1RjF4k0+wdB5iPssFkdXmYpzHNeklTP2rebzN2zi1
         rHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616455; x=1794221255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fgtT2+a9TrTITBRXB1pk27WkIgQ+nxQrQ3NB1J1hYuM=;
        b=MoLMfO/2KnN6Dg10RbNo3bn7933CkfJfHItZ/vw7zkPU96oNNjIH+W6RDWRWCZUrMM
         OWJnTSIvofFzQCavv2CXTd2n1FDWpHwqIrrNuD91VmAv/7fWkN8EvPqLPpmUCzX+XkND
         dshGy6ie5sAW5B2hHbkkCS8NsoSKv1z7Thf/kV3XnedjtdQWxahII9bdBeYYlnC0IstA
         a6cFe5TgEHAUSl2nfB+OTQFUVQJL11x0hD8ZzyS4Zc/tB+xyMJp3bIQYvn7TE6YUuMpP
         /fb7Op3mgI7jq4dFflfprjtcDAmzA9bja/9y+w7rwvkBe5rxSJdf4YeiVtjyb01RSGry
         6r7A==
X-Forwarded-Encrypted: i=1; AKwUvBxYCuHEF7tGcMb9Q34/mJM6Tm4aPQrBH5hgBYNdr9Ndv0qvDGlLupvc+bh8UzxN6vZWLuLHtKOxARwYKIzJ@vger.kernel.org
X-Gm-Message-State: AFq9FYIMrG2vS1G8FO6QtnXgGj+B1GjoglxBtYOgIvpW5fHFYSsRQQD4
	iudpMcrCJszYasTCKb0L8N9BF7F4bIXSS/4R1mAv9RY+NB2tvbE6XIE1
X-Gm-Gg: AYBFou1z67CVI0DNgqpR5/+LQ1UE4Ict5Qlx+EKgAj8+R7+YkfnFRutjJgp6qr3lNqg
	IswLVd9MsXMjH1m+ow5taoKa3OTxGG8YQkA4D5KUva27o3Ol6zR0Y1Avqorhr6ozRKmaj4Zh4c9
	E+/APsjWaqi4KBpINBO/HCP5403j3KxkI3aXWTesGmid2hTf2kpXTH6pHGb210ctDuFjyRJUjka
	8q3Pw2nnNtfAqNqs7xnln5ZU3yY8nMoKIqgq3s1HFviAEhmUE8fO6iEgxaWm79Fq04Fiwqc2foO
	HjdK2k6bjp7FI4+L1YINvZ4QnJDGclnlo1MR4E2RziFguqYIuPWzeK+EIyOVVyUOqzcnsroTxnk
	h3Z7OeThRYD7V9a6adzmIM+1UXMVOnAsVdyeyY+r9IvZsmIw0PqRmkcX+2wCmrzbWg/qhdDe4bv
	KQfLqEEq63zVe6NN/1PImi4GpkV/AnlDKH3Dm9KPjzt8sC9kpvJvxlzR+NjXXSIprS7AzLagVmS
	QU6f5gGy+8Fsh1c59z22LpCwiqve8JxI8JPQhhNnesxJiY+pUcscCHcIEKHeduXP0UFMgJXdtOA
	HuXeVbaQBtR6+q0MyDellzz3XlfFpb/rYOs5aKYnbLsUTxV6n1ftYHAQNCPc9oth
X-Received: by 2002:a05:600c:6992:b0:4a1:a2c0:7b73 with SMTP id 5b1f17b1804b1-4ac18992c01mr220277725e9.30.1793616454928;
        Mon, 02 Nov 2026 02:47:34 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c7852esm248939695e9.11.2026.11.02.02.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:47:34 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH vfs-7.5.bpf v2 1/3] bpf: Add bpf_path_getattr()
Date: Mon,  2 Nov 2026 12:46:53 +0200
Message-ID: <20261102104655.70901-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
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

Direct inode reads can differ from stat() and related system calls,
especially on overlayfs.

Add a sleepable LSM kfunc to query a trusted path and return struct kstat.
Use vfs_getattr_nosec() to avoid calling security_inode_getattr() again.
Limit the copy to the smaller of the buffer and the kernel structure.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 35ccd98a4de6..97afc9659f1a 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -96,6 +96,40 @@ __bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__
 	return len;
 }
 
+/**
+ * bpf_path_getattr - get the attributes of the supplied path
+ * @path: trusted path to get the attributes of
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
+ * Copies the smaller of @stat__sz and sizeof(struct kstat). Any remaining
+ * buffer bytes are left untouched. On error, the buffer is unchanged.
+ *
+ * Return: Zero on success or a negative error code.
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
+	/* struct kstat in the program's vmlinux.h may have a different size. */
+	memcpy(stat__uninit, &stat, min(stat__sz, sizeof(stat)));
+	return 0;
+}
+
 static bool match_security_bpf_prefix(const char *name__str)
 {
 	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
@@ -504,6 +538,7 @@ BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path)
+BTF_ID_FLAGS(func, bpf_path_getattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
@@ -515,8 +550,9 @@ BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
 #endif
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
-/* Side-effecting kfuncs that stay exclusive to LSM programs. */
+/* Kfuncs that stay exclusive to LSM programs. */
 BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
+BTF_ID(func, bpf_path_getattr)
 BTF_ID(func, bpf_set_dentry_xattr)
 BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)
-- 
2.56.0

