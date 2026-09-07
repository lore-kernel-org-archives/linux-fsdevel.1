Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D551E423
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799988; cv=none; b=QvTDtcxjqDEsYsUUo16D3+urppkuxVzQoWTkdk0URwO8cF35nmwpiPhc8+eF0qTKvDg51UZu94Qvre+XQ2QudPfnZG8t4s0utIoM1+l2Sj5WTTyhCT/KpBQudyK8MdfWVUjKp1hGHKpD6vbblliv0r/JnSwY1O/xPpcJmOc9Kf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799988; c=relaxed/simple;
	bh=R3NKE8VV7/HGFaVaAkyaFS//KWA1lQPQoXgESTqRSFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwRnoQjrCqmnAnC6ZmAOGpc2iF/hpdZv2lvEUFhc9Pg9MMb1zwFgOUeDf0uYCzwi2gKDax85joOnTQ3xyRRZJxw52DGHmeZflqA6wVFe3N07r8dUG1JpZCHjysmGY61Vfdih+fEWfWxsKM06EWEVJJxrFlfNNIk/NLJ4liZHHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQfgxVBd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQfgxVBd"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48436216a98so2557327f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799985; x=1789404785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAeQPdPGwWZkycRcbqHqvUFSglicl66turt58h60TpQ=;
        b=qQfgxVBdYHALDM8ysUetakrcOL/+wv44doC0iXNdGiWZ+YeOeYKW1cU0cYuhF7sQ6p
         5G+R3jnC4IQIsn8CLP7ChtEvJiKd59FPO7lCdi74pgxBOf/8IyoxAtnN3AuE8r15hOjh
         hzXllWXyex75czpT14rftxHj7A2YDKDV87AWWNuIknMAkViO7pKno+8npEqiOBi4usQr
         wxX0T7twXd/9BuIbreM3NqQT/0luxObM2+VtTnXB899GSLyZsub/8vPfyitpOX6tTdrL
         0NCaWIeQ2CyO7BI2pJRW48vhoCpEv3zBythIKSvMPF6rYPIvyoZELWyuFISiJitzvgAT
         JqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799985; x=1789404785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAeQPdPGwWZkycRcbqHqvUFSglicl66turt58h60TpQ=;
        b=Rckv1DBJEd4eUgFwzfUeEOZu+PsQSiAn4OxIdKLCkWZczX5oUtmZT6Y0e/R8ZUgqVK
         cb+y+eNIHXRBQO6vPVYsChU/IKwTt6faLvEQNXuufXwtSZvhtqMbHtVfkVpd/DSN2mkT
         EXwFXwVbcowyCsdltYUz+WSF/dGaud20M9xhU09+mAGPJ8cjdF8lOnPVRC09ri41efVe
         iqZrwLeR35+ZXsLqyrs32BP42x8L2q5MIdx1oOlPaaPmfxwvMZPjUUOz0xpX8cq9+C1V
         UA+7XeOMooQBL3N+PJzk/p6rJTzGyPzDMIQ5Ldk/5kfiffWYXOPjTi5/ihqwa4gv03M6
         1gJw==
X-Gm-Message-State: AFuF++nJ8EYwodQai1RnxEL+/rjgRV2sFrZ65ks2ZZnJL6mxPeksKVkI
	egmL3uWtWLwi6tSAnQ8cRr6jZBUKZ1HYUcmKOxquegJv10nXTYvlX4X+
X-Gm-Gg: AYBFou1XnnaMwqMMfx8pIifFrDTH4MFAkley90Mm+2ehFKNvN1tnTAGRgn1dZ5s+K/n
	9EW7PEERmy4sjo1YHSSRtbxmZOuQqt1MyyAjsDH678jvtL4AWHoPKLaNz55TLqTqkHfDkZyp34Y
	pt25LAcaJ50IqMfEUSle6cOD5pejx0FSUifvgYHIPA9Bfw3pXWZJBjxmCe3Zor8CyhHcnoAbdpA
	Itd7GT7ZV+KQxSaJnZQ3KR9Mnw5WYnug19nUMBcAVJNdIeZkQ3HuS6CWG6YJMt+mQU4YN/r0Vva
	hZ3du3oBiPIJ3nF0WZT6R7Ye6DQJ2H50KB940YQPlfzZwVrGzxE6yGgVIA2BJMcHvNMjYuceGh5
	jiyGP3RWS/eOn0Qbno4Zxn77zNvAemwVa0kCD3SU1A6vgeihvLeXJwZJ8fB/qhxKLOO+0DmTQEk
	HJ6SmC1efmdLgQ8S+ZWSA+N1LHOcVuICZ8wKzcD5SbNkWjczxr9SGFKs3P8M8nNslXwelwA8jYO
	g==
X-Received: by 2002:a05:600c:474a:b0:49c:e42b:a4ac with SMTP id 5b1f17b1804b1-49cf823f60amr212091925e9.11.1788799984684;
        Mon, 07 Sep 2026 09:53:04 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm233022415e9.13.2026.09.07.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:53:04 -0700 (PDT)
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
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH bpf-next v5 4/7] bpf: Allow reads through trusted-or-null BTF pointers
Date: Mon,  7 Sep 2026 19:52:17 +0300
Message-ID: <20260907165220.52431-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
References: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a trusted-or-null pointer
(i.e. PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL) has to be checked
for NULL before it can be dereferenced. Marking a field from
PTR_TO_BTF_ID typing to trusted-or-null can reject programs that
previously dereferenced the pointer directly. This is useful as we
need to mark new fields as trusted in order to pass those as arguments
to kfuncs.

Allow reads through pointers marked as
PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL without an explicit NULL
check. Treat these pointers as potentially faulting so the reads happen
through BPF_PROBE_MEM. If a read produces another BTF pointer, clear its
trusted flags and mark it as PTR_UNTRUSTED.

This applies only to reads. Other cases still require an explicit NULL
check. After such a check, the pointer retains PTR_TRUSTED and can be
used normally.

The unchecked read path has two consequences:

1. It uses BPF_PROBE_MEM, which is slower than a normal load. An
   explicit NULL check refines the pointer to PTR_TRUSTED and allows a
   normal load.

2. A faulting read returns zero, which is indistinguishable from a
   legitimately zero-valued field. Programs that need to distinguish
   those cases must check the pointer before reading the field.

The next patch updates current tests and also introduces more checks to
ensure this change does not break anything.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 include/linux/bpf_verifier.h |  9 ++++++++-
 kernel/bpf/verifier.c        | 12 +++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9727df5af83a..4f032ad83c67 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1339,6 +1339,11 @@ static inline bool bpf_is_ptr_to_mem_or_btf_id(enum bpf_reg_type type)
 	}
 }
 
+static inline bool bpf_is_trusted_or_null_btf_ptr(enum bpf_reg_type type)
+{
+	return type == (PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL);
+}
+
 static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
 {
 	/*
@@ -1346,7 +1351,9 @@ static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
 	 * protection, that is, the ones bpf_convert_ctx_accesses() has to
 	 * turn a BPF_LDX into a BPF_PROBE_MEM one for.
 	 */
-	return type == PTR_TO_BTF_ID || (type_flag(type) & PTR_UNTRUSTED);
+	return type == PTR_TO_BTF_ID ||
+	       (type_flag(type) & PTR_UNTRUSTED) ||
+	       bpf_is_trusted_or_null_btf_ptr(type);
 }
 
 static inline bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e79750e2480..b5186e664aea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6168,6 +6168,15 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
+	} else if (bpf_is_trusted_or_null_btf_ptr(reg->type)) {
+		/*
+		 * An unchecked load through a trusted-or-NULL pointer is
+		 * fault-protected. Any pointer derived from that load must be
+		 * untrusted, as a fault produces a NULL value.
+		 */
+		clear_trusted_flags(&flag);
+		flag |= PTR_UNTRUSTED;
+
 	} else if (type_flag(reg->type) & PTR_UNTRUSTED) {
 		/* If this is an untrusted pointer, all pointers formed by walking it
 		 * also inherit the untrusted flag.
@@ -6644,7 +6653,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) == PTR_TO_BTF_ID &&
-		   !type_may_be_null(reg->type)) {
+		   (!type_may_be_null(reg->type) ||
+		    (t == BPF_READ && bpf_is_trusted_or_null_btf_ptr(reg->type)))) {
 		err = check_ptr_to_btf_access(env, regs, reg, argno, off, size, t,
 					      value_regno);
 	} else if (reg->type == CONST_PTR_TO_MAP) {
-- 
2.55.0

