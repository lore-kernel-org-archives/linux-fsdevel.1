Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578B4B7A35
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722696; cv=none; b=GhcOiaGLYgIn4eex5lfleQRguCwykmgnMntqtkp2/EppusPdoEAr2WMn3/VXrffAgooF6B2s/P5Oqb5vAET+wxP/ZimbPA7d8HpeXWxUcV4U16QMTPNiRXS9ZzdnyOreab74NfEALlX0hQ+Vq4H+ot1dpZgazfoi1njCe4f25fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722696; c=relaxed/simple;
	bh=FiRsDZdzGXAipkwSasDiwYJgNjGQw/oWZmESPlkGMAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvhtG5dt4cwpy6H3u6MMHLsDyPpqUI0Pjot1bchtBoDBxP8AWbiHuiUerqhsEyMFAt/zKgzSNtadaICQ5RPy28aDIZTk/528bqtlDvxSIrPsuWtpU7rnki+HL3TMU5KPjYCIfU+0HITwUS0UbW/J4z/nWbvjdHc13zezp1YiDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2rE5pUD; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2rE5pUD"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so3078505e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722692; x=1790327492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lk08SIy6DJ+jXcktdOiUfMwYrHwPBwEtrnZT5485SRQ=;
        b=T2rE5pUDUz9gW62Q9CEtdygORMnmqJzD+vHMPUpMBghWky+98FjqdE0KI+JQxBKuwZ
         AdzaGmZgbDdEcQWiqzLzysFYe3CmHlGVJ1/kCNXCdAR7eA4+2cxfuI9EQg+XiW1kX6oe
         qQ0AkGX2fK3h1e997cDE4Byemv5PbRoQwb5mIo0gnZyfduvu5n0bg49w8iXtLHEyVjPa
         9Dq8lisDk2bGiygJF/V7MG5Vv/b0jvkiEDOT+jXjVR9z4Gv2mUl2w6hujT+ZvkAPygnT
         t5qTDbk5BW4e+QbbL66WuTJuAuKaRrSPAqM50+bTDzD/KITm5W3bXJf9kXEm543AQMTK
         RK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722692; x=1790327492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lk08SIy6DJ+jXcktdOiUfMwYrHwPBwEtrnZT5485SRQ=;
        b=GtLxZQvuDsBEnL4nla7rXv2CrFR+s4cYUly1oRNxH2IA2oFqVlmBlt4Hb92KeH0kDv
         ftfexRpDMX3HX6E3v+coFZazsz6b0PYzCMCjosIXApVdYlDI4HE5cqd3ZByZOI1/0Lc3
         m0e6P8D8+i5BNg+hsQ8E431rlH/hjRQqxreKKziAaduMhYpDI1YBR2MN5BoJP0ltNOgu
         AlcB7uYa8vvbVwW2fiAWZOTNOozmw3YrwtXjh0NsMK22lX+YwdTfpqSHC9EFlrBMF3Rg
         PCfqyjX1SVlsSx+m1766sd1Hzp62hztnacWtXaRUEcmeXIPECDd5iu0MGVs18/hT3bmJ
         EYHA==
X-Gm-Message-State: AFuF++n6NxGa2J5Kt5x8fRJRlFbIhdl5sPMAhzwHVeFVzCvKJyqbiU6V
	LTqesPh9h7O/nsu/noBbEw95dR/pKpDdief7LBqEC3AKc4NLWjVnI+OW
X-Gm-Gg: AYBFou2ofKNLorRSxRoGvfxbhP4U728GDkP/6ub/UqZZqn3vSdTw1CuYBKNsTisGXSL
	oBnFNpov0FHbbqcFO5mwwlLxN798RGLnm0Ah3PlloqjG1F7QiGuQhrSCHemADWBbYJsUxi6udeD
	6GKx+jbISBVa9NRJb62UhudklwwKr/J973xqX1slUafNi5d6vvNVX73CCVgjemhC7yak8EYHn/0
	qlH9/G8GtvZjhFgYPN4e9S1aghWTizcrNyOMyJMluUfr7CgiD65EuE9OCWwXL+Guy2VzCQtl0mI
	3dikvRrhZc/ypQqBA6tk9MXENAKWtp4N6UKyly1kGU+w3XApx2qerSQpdYQxnC9c81bbE/sYGC5
	3Cq/80V/iiWXWIpiXqrgkdalZxcT86zs0a//674O76Fzc35SNeOsAlKz4DwVZ0wdc0ZGfjUpM19
	0BX1Zq/kXGzj5+NttCitgklzzLhdSyXDInZPV+jbzP7u0IynuXU593qRR/nCcW+jKzYejxIYxA6
	Q9QkazXV3U85Ixo
X-Received: by 2002:a05:600c:3b0a:b0:49f:bd3c:bc20 with SMTP id 5b1f17b1804b1-49fc573b7a2mr19145175e9.27.1789722691708;
        Fri, 18 Sep 2026 02:11:31 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm138774275e9.2.2026.09.18.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:11:31 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v8 4/5] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Fri, 18 Sep 2026 12:10:57 +0300
Message-ID: <20260918091058.297740-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
can pass it to kfuncs after a NULL check.

The field is either NULL or points to a live mm_struct whenever BPF can
access a linux_binprm. On successful exec, exec_mmap() installs the new
address space before begin_new_exec() clears bprm->mm. The bprm_mm_init()
error path clears the field before mmdrop(), and free_bprm() clears it
before mmput(), as ensured by an earlier patch in this series.

Update the existing LSM selftest to check bprm->mm for NULL before
dereferencing it, as required for trusted-or-null pointers.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Reviewed-by: Matt Bobrowski <matt@bobrowski.net>
---
 kernel/bpf/verifier.c                   | 5 +++++
 tools/testing/selftests/bpf/progs/lsm.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..3539a768b921 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5997,6 +5997,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
+	struct mm_struct *mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6051,6 +6055,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 7de173daf27b..7441d66c080c 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -113,6 +113,7 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct inner_map *inner_map;
+	struct mm_struct *mm;
 	char args[64];
 	__u32 key = 0;
 	__u64 *value;
@@ -121,7 +122,9 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 		bprm_count++;
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
-	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
+	mm = bprm->mm;
+	if (mm)
+		bpf_copy_from_user(args, sizeof(args), (void *)mm->arg_start);
 
 	value = bpf_map_lookup_elem(&array, &key);
 	if (value)
-- 
2.55.0

