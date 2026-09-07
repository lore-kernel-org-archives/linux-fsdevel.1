Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6351E42A
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799994; cv=none; b=Tly3FvBDiE2XXGhdzU+O++zlYm+I4XDt/5+Z5ibTMGFrHnUOfvbCBBYr+QZlcXsLyZZwLc9yIlbLhoVV6ciyNnVKZsudJYVKKVFcSVFQ6B2u37Llz1Z8i8pi9ZQCmPE8Hd4HQL5VIs1xSAIacYSv3k1ZhRaHWIuXtVWa1djAjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799994; c=relaxed/simple;
	bh=37ZkkZNqxkhdoz/COm3n2Pon+sMf3f11UDjmNND0D2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/ijtPMwyROtd3VmsjGXrvFapInlTOIMEOXn6WrqxQZcfwzBtKRIwOB+PLt9Rfld7ObYbLqrEGFfX1hd5IU561IuOtarBp+ZmZkQ0eaGyWt7+O6NcZ2JeG8J7QN+wle2DLm4B1gsZA+1U7LkMTnIFhU9mIgTbERnUMM5LzdS82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmw1WqJC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmw1WqJC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49557167508so45587055e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799991; x=1789404791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXEATw0LCoNw3+DI3xDTgsz8l5QDzPtCPOwXyA9u26Q=;
        b=hmw1WqJCHRhE3G87DR1g4BeBvh/68di1WUMzePtbbPNHpnNepsaWsyTZ058+17dMhj
         becWdVE0tzS8gom2LRDufMLM68HqVeOYy5QQI/HZMHR6X+aRPgZK/IKqGpMBiUpHgJ8G
         ghckD/wRZpeyY0vw/6wij58gXw0sDZ1t9uVkDQDnKbQiCAh98PxeGMqfES4xWaRKeBur
         MIxWCaHT778rCG7i4VkFPENR+3Y8fQFZOLkL0lUrRu2lcOVaW4j1zjTkKrtULdtMvD/d
         fyLvy13dXZXB/dftz/kymru7gvQ0MsKdRpXePwQ+ONRQ6BOtKfu21Wb0DFV9eZtq5DsZ
         T/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799991; x=1789404791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OXEATw0LCoNw3+DI3xDTgsz8l5QDzPtCPOwXyA9u26Q=;
        b=B0/qIxrGyhDn8BS8TzgNND9zhXhe/hP/5H7ikAuxo0046FJayJ5diK3LaynZfGQcdy
         /tmuT+zkyLkZBcwjr5zvr/Xy0VjfRp98joSbLHZ5oEvl4r1t1mwfb085F9JY/poCILWe
         EqRCa36T4bJQ2c4kqNcWXG1k6ymbxUbCkabaQW4QejqEaGK/6kdEiE74FSm9BnpLeR1A
         DMBaPt5Zmw/jf6XNYiwkwUcIv/Zr7fJZklxxFQ/j8XSz975LxEREDo/wofAxaMZKrNsY
         RYvCx+4EgwTnGIsg8/kTvOIk5sd1dVYpfRPgT7W14D5B+GhpjQaBO3ksCVvPaLwwMAIp
         c9hQ==
X-Gm-Message-State: AFuF++liUW++43bvpjUnXyTPwodqqVbGrc7mKTAX5Ca7dPlQTH/QHpm1
	gSRC5wpA8NWCYQJ6cIyjDM4+8gmL+W2AUIFEaDuo7cDacvAoXdtEufA5
X-Gm-Gg: AYBFou1eMvZ1+98U1q5vyHp2EZbgWvSqxpqQqQWz765QwOCnYAZSQVb/aFlgyojqYWf
	iwzWpKCLh12BaBwxPkkYfwWaCPW0NY5IjHlpMcC0rBwBpr8OrJkGxQPEwS4ogOvjOEKPsytRSQZ
	ekVLyCCCzBNevkYg6S1Y9JB4H8GEOJ1QKU4iIK6ymtncrO4/1B1bH86ENSK7kdW4jXFNjunmsYo
	3Tu4VX7wqaG17qtLaMmf8nGju7jkM3rvEt7jE2KFx1tU/HHuldLEOpn/w1eCwWG6semYK6p7qA0
	Q3gUAL1nV97HNNCLFW+JSC3Zss9QBWl9ABViCSMWJKzMvH/SUbRrCSjRpxEBO5vv8p58cHGzqsI
	/eiS6WK2fGDJLjXEitUP0QvQmon6b8O43dj09QEAf6vvlCkBti7F/0kR1eUbwjfS8JoN3LKNu5m
	OwMapiUqdNyWT5VRyRFAiwcKYkMuYA/UkW46kvexrU8IT4tlSegVaCOnCb2fpXFlqaEOOXqYYAX
	g==
X-Received: by 2002:a05:600c:3485:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cf825c119mr525133835e9.16.1788799991022;
        Mon, 07 Sep 2026 09:53:11 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm233022415e9.13.2026.09.07.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:53:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 6/7] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Mon,  7 Sep 2026 19:52:19 +0300
Message-ID: <20260907165220.52431-7-tasos.papagiannnis@gmail.com>
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

Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
can pass it to kfuncs after a NULL check.

The field is either NULL or points to a live mm_struct whenever BPF can
access a linux_binprm. On successful exec, exec_mmap() installs the new
address space before begin_new_exec() clears bprm->mm. The bprm_mm_init()
error path clears the field before mmdrop(), and free_bprm() clears it
before mmput(), as ensured by an earlier patch in this series.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b5186e664aea..6799d9e080fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6004,6 +6004,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
+	struct mm_struct *mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6058,6 +6062,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
-- 
2.55.0

