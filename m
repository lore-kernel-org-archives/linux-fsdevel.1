Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB434D8D98
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533672; cv=none; b=kS1O4YNpm4RJJk7xwaqw9/qoDPH9IO6NeDavdbuHUZxk5ETc3ntTrEKR51L7G+8IJYGf9NhTigasMdVrg8mS4J1/9f9zBtlZhm5vYHQTTbrg9UTjrrh6Y315JbNdAINsdXTKOlAVbhbzkv/DzM1IZ+YQ9D4unb5QzuWkVlxRefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533672; c=relaxed/simple;
	bh=MpokLl5CyyQMTIasgPBtHRcPtVgy8CVCZmAYa4Qjsxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fifrvNdo8IMJ2UgSBFM8pBQGuHe4bln0E+bdMnt/yaHYmHTARPU+0DDSN9V3aQ4DMIEsJSa9nxT9/iKXqYwSbLp6ngh8HqJLyLPJ8KuloUs0i+m8p6p4DHgXCrm1CVyoEzduA4sPd5fHWN9qEVk5xn621cDNaJHOAzccIkhhqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckVNCvRM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckVNCvRM"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4858595f997so705362f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533667; x=1789138467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TWn588bvPgkOg4s+MpXI1REAHLgHCTvpnRnhLr6d9ks=;
        b=ckVNCvRMf9fz/rUVaoVnVLEBzt9Ewiihhn/eMLivyTnUAAtw/k4pgzGYWslnvW4aSD
         3bNaZDVUdnqhQ+/X6Fv7PQ6M54JGY//hLtO8CBmmgToS9hLMq4yBmeOgKbNWelRO6ZxV
         N936rpgIExv7uTld6eomtDVA81/tfQX9vJZ8jmHsgGKScMl9iLeI8c9gYxENwHq03Sao
         RgF9tBrzhaDfydESFNNEhWbFP8fjyYljty3STRX4APgsvAutcCY3DyZedA3p5aYS55+T
         zzg7cdPNGBek7/atx7TN23zig47o0HiqU8qxlhfmsIy0uYP3B88KnpK7vsCUgLZQD1xk
         X16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533667; x=1789138467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TWn588bvPgkOg4s+MpXI1REAHLgHCTvpnRnhLr6d9ks=;
        b=ch8NY35LToo3iz3O0PU8pqTVzH09zXZWQnRmXecGuZFP8nqkkkYucigIkaex5/xhIe
         txKtR22NjoYtdPlUEKPOAU6Ff1yPLAtqMqqt8ApQpERIL4wgxgXa7yrOcQ8tnE3uQj2z
         KNsemI9viaX6pQE0ttTvGiQLoxqgCuwC2XwCzBqOwytOFrIrXdMyQ3OqDCF30TcwfcGy
         pjI0gyzkQAVVsBXe3BScgERUbhE8mdjeBwJMw+EpRMDy8mfkLdWQ/AeRYIPQ6HUtwg2a
         /3pFqb7FuqktgxkLP9CY6VP8JzLPtCqLe+Rm0Wy4Fbs2rU/ZqCW6YMFWamq6TF4Qbw6a
         2c0w==
X-Forwarded-Encrypted: i=1; AKwUvBwTv+Kds6qr5kfog9LzkpHxKaP/6kCyOjWu8NDAQnPSUSioUEVIMXe/Rw9CsGSvHK/nRgWnuOXUG4bJ4vvR@vger.kernel.org
X-Gm-Message-State: AFuF++lD6isnG0lYLY+GHhQua1gkh8GQaBQVMrvtSLmeyio81YaTdKXh
	gxl/Cj800bQMU63UTESpLmJiWLw9hQdsxdWJj2kQPO+PVvoOt5Vh5nXJ
X-Gm-Gg: AYBFou3glkkyz9ZKHR41+URW1dBUxdFl7+p4tl+ZvYP5Ozd1s/lEkDN7eKJA+w8yGj8
	hR++VfRQkQVcM4TsiCEQsxZxKZ0Yp2Ori2yXfhYOTrIz72ZOSxSvfBswyisyVHi4iXpdqeYONUe
	HEI+2Roajqjfd+3iZ9tJRzdE5qyeJkYVubaLkkJWYJXK9oUINVkbkCI+IdiaWIZD8VYHULbkoec
	Hs56A9nTgEtMz8mCW8wj1faqVG7x7nY3TXsBS+IAlYbFT1vTcQ56RQEtZXJemOZTZB8WkwOdjMT
	S33hBt/SjJBY05fiJu/drW+2cl+3+r56aK9svSAnotw0jQZqIsxTY4AIWg8zSSbO9dV4kvzHpaJ
	U2zWONB6iox99uJLwbVHIuBFbUJMi389pS58n5cKHIAldUFu5u7NlwYcwucUWVTtD8WRifKoZmT
	3TcfVUYGtoQ86me0RGV47rbEJYd4O3i0qvJqWSsdDIKSBJkZ/m7hyAquhT6TIAO/v+0isDhAkmv
	Q==
X-Received: by 2002:a05:6000:470a:b0:485:8101:dc40 with SMTP id ffacd0b85a97d-48587057037mr5818648f8f.9.1788533667239;
        Fri, 04 Sep 2026 07:54:27 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885cb03asm6802799f8f.37.2026.09.04.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:54:26 -0700 (PDT)
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
	utilityemal77@gmail.com,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v4 4/7] bpf: Allow reads through trusted-or-null BTF pointers
Date: Fri,  4 Sep 2026 17:53:37 +0300
Message-ID: <20260904145340.40212-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
References: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
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
index ae9f606539f4..d3d7254cc1f6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1326,6 +1326,11 @@ static inline bool bpf_is_ptr_to_mem_or_btf_id(enum bpf_reg_type type)
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
@@ -1333,7 +1338,9 @@ static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
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
index 8f585ceb2cd5..386401fe051d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6116,6 +6116,15 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
@@ -6591,7 +6600,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
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

