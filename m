Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0F3C9440
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288447; cv=none; b=FLJTA9TQl055Iu0AX4amntkkNg+yE0TrnrzUfBOF12LyMh0h10Tvm2aZ30nePF/A9F9Pln6vSO83r+hehWhz3J1WA2AaahPGXt3T9Bdi9Vy8wHJqrlnUUkkX1N0yX5W7j1jiiPgcAZgohc6e17oFkxigZkx4lggIHAgI9IP594c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288447; c=relaxed/simple;
	bh=wiZBFK4qXH25jZiOk6ppSpqqegoRmcuyypAI5viwsM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYjKs1CCnqJZagANnNJpJk2gI6otGBhHVkD+7/LqOE0KuYHUDfCMd53trqJ/tTPXBwS5xobd/LMkNUMseO5DBK5JtZwl2axiiYWItI0gZZvECxfF9SJUoN0JTfbCIhF5ARqaU2uX2q6HfGVE8FSt6L1jJnxI6ahIo8MhhIKm8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5D+84Bt; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5D+84Bt"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-67df391509fso6626724eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774288445; x=1774893245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvFV/sENwdGTW4IuMAnR3v5SRp3rVtVMFXWSWmq9Pi8=;
        b=C5D+84Bt077pL5hmkaZb0+hA3fcQus9KpCw2KdguTHGAnoOSll3iQDIkDnrHLx+/Ex
         HhAQyPxVN+eyFi2akwYrJiLFD80iI90uW5ZGGyViIxXcS4ebnj4ZaSh0ijnVXXa2xMNs
         ro5CXJq6TixblU02AoquIigpI2JiHMIrDr1QL7jnIf19oSTQLr/H5IHyLaE6pED4kMeV
         YmTwn77M5z5pkkN/cPUfazwC+ZaHmcXOrPfKCvQI+YylG8T5cTIMaiOSFR5/IuqsJLvI
         7Lo8QP+eXn4m76u2y2IiOBuMrmgzdAC7j3JCjGnVkfNzoJGpZOqjQ8L7rI4eGmoKbtIk
         LLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288445; x=1774893245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvFV/sENwdGTW4IuMAnR3v5SRp3rVtVMFXWSWmq9Pi8=;
        b=T/Es8gA1vt6PbdL/vUhHyE9Retbn6GOnYycKk+uVV6mdnuNVGy7BtXOh5OEaERKNNn
         ys+5R/MxKGWfcSugU3ujoJQ+5IMzQg53lHsTkCDIp67jS5CbkmMM+Ndk07MQpQsFWEe3
         B/TeT2ngarAYYTVZ/8FzQ7rFakwTT3t1Sb6EWm9YS6pCuP82RhxXSYxJ8NplohqA8YV7
         UNy/+0HYiL4CMduVJczIsZ7NSv2zZrHYJmDX39+tvl0WrjFyTGf0LWAwps8yxiM9dMKB
         xBOlNGN9gKm+C/96VXLzcKVPMdN/Mq7SPgCJL4yeF1d2QeaOAcSVzak6/I3icqAVvhup
         PUvA==
X-Forwarded-Encrypted: i=1; AJvYcCWYfFk1iBKazD4iS8ea5wmAgMZQYpRQuL8pwCU9QXPLohPp/VOLbjdXRNfy6re1DC7pki+cLW8mPQSjIuKL@vger.kernel.org
X-Gm-Message-State: AOJu0YzqquAWmB0uGV9jIR/J8v21Zi6OH0H1SwTLzyydNuCXlCL3Mq9e
	isNRCuGjx7E/W4Ch1ll/tZavioq5Duf5cNifm/9EVwPPxvumF4gtz9ty8NqU8Btvzw/0ZlsjykL
	eazluJg==
X-Received: from ilbbq1.prod.google.com ([2002:a05:6e02:2381:b0:4f8:6375:8930])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:174e:b0:67b:d754:9524
 with SMTP id 006d021491bc7-67c22f4ed5dmr9551868eaf.36.1774288444594; Mon, 23
 Mar 2026 10:54:04 -0700 (PDT)
Date: Mon, 23 Mar 2026 17:53:38 +0000
In-Reply-To: <20260323175340.3361311-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323175340.3361311-3-avagin@google.com>
Subject: [PATCH 2/4] arm64: elf: clear MMF_USER_HWCAP on architecture switch
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Koutny <mkoutny@suse.com>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

The HWCAP bits have different meanings between AArch64 and AArch32,
so HWCAP inheritance is not applicable when switching architectures.
Inherited HWCAP vectors can lead to unpredictable side effects.  For
example, bit 0 in AArch64 signifies FP support, whereas in AArch32 it
signifies SWP instruction support.

Fix this by clearing the MMF_USER_HWCAP flag in SET_PERSONALITY and
COMPAT_SET_PERSONALITY if the architecture is changing. This ensures
that create_elf_tables() will use the default kernel HWCAPs for the new
process.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 arch/arm64/include/asm/elf.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index d2779d604c7b..2049d42e2e6a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -160,7 +160,10 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 
 #define SET_PERSONALITY(ex)						\
 ({									\
-	clear_thread_flag(TIF_32BIT);					\
+	if (test_thread_flag(TIF_32BIT)) {				\
+		mm_flags_clear(MMF_USER_HWCAP, current->mm);		\
+		clear_thread_flag(TIF_32BIT);				\
+	}								\
 	current->personality &= ~READ_IMPLIES_EXEC;			\
 })
 
@@ -223,8 +226,11 @@ int compat_elf_check_arch(const struct elf32_hdr *);
  */
 #define COMPAT_SET_PERSONALITY(ex)					\
 ({									\
-	set_thread_flag(TIF_32BIT);					\
- })
+	if (!test_thread_flag(TIF_32BIT)) {				\
+		mm_flags_clear(MMF_USER_HWCAP, current->mm);		\
+		set_thread_flag(TIF_32BIT);				\
+	}								\
+})
 #ifdef CONFIG_COMPAT_VDSO
 #define COMPAT_ARCH_DLINFO						\
 do {									\
-- 
2.53.0.983.g0bb29b3bc5-goog

