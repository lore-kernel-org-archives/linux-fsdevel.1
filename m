Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891632;
	b=SQc5Mg3M8r1uxvyQ+OSgxz97kgvQzgRF+LDPr7fLPE+zFtZfdBt9sqViKZ0Hzr2EV5Y0
	 H7aTOw3EMSB+1hEc31Ntuq8wwzxWM+U/+XP6h7HbG/AMB6dxiLLG4iz7vEAjwRcIMHB+q
	 03t2IDsNjtNKF6ezkPyy5kXc88uULBDMoZ+T4a6TuI0OV8+tYE9I/IHU4mqOlMbZhNpjs
	 br3niEs3wpuvYYKjKPs2s0kiODK8WsqPDLcicYdkWHrR1ivIZdjShR8SDwO5MDsCXJB2G
	 68XNnk3c7FpVWHfMweAG5B4ZhfZEezsmiXXYUUGEy2QV85k4GbFLPXPThpspw+AwfJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=eD/U90elOlLuZ8H1ZNNelJtjhWVVGMS1O6rYfNflbg8=;
	b=hUZSR0JeF640hAIw30MuIiny/kY7t5dGVTwhBEzAerWFAurt778aKgLuVOSlpnTJY5Gp
	 B3X9LQzSTzF1Qd2X0VE8BO5+oWburctlPZOt5P08MeOIsopKKTIFe/b0VkrL4A+IvF4D0
	 0WOfvOr70iDoW+LKg+q03eliM2+rCWDjtNQgbm2q2zYeZ+CVNSOWTwTTo+hvH9R4QYHqL
	 FV/IjPHbu/WcfkMzfOjR7UPpzYpZRGAYOqswbjMESxcILoBBmpQfwGTK+F1VS71yr/sbt
	 9jHePYLOgUDLKuENDlp17AfEcJ0HVXZGDn5Ibg3h26/BdGUzrLLhOgdr0Jh/BJ2MZeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YaXOXgb2;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951EF606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 951EF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YaXOXgb2
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c1f548f87so30717966d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891630; x=1794496430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eD/U90elOlLuZ8H1ZNNelJtjhWVVGMS1O6rYfNflbg8=;
        b=YaXOXgb2LB7UJyMuzhPZqITboSOeaC2R94lnsrvcdpcgMGVp5opbkAfjwS5NyH9YVQ
         IhxxZAmVJGIjl3X5We14lSCXhHRUKb2XQE+2nj3FGdGOk+/o+KPQeo+OwyN6qpuKEXKR
         vvagzx+Q8NPJR1bTBTYTfq525CwCkrGyGeXh+MUmW7GI1kdK0RRDxjPxCHcL6ZAiLo3O
         qOnYF0HvER6+IeLjalRvvjES6TB+ECjErFeZkNgThhLMg5gfPm+s5EzZWhaBgpPIATAO
         CgXGMXhyx5T1rW4SVOxmjnGGtbFbCI924ubephgWgS0oncXsD3NGaMSnp6ntK8jl3ReK
         zwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891630; x=1794496430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eD/U90elOlLuZ8H1ZNNelJtjhWVVGMS1O6rYfNflbg8=;
        b=erXuCUaLjqMS3uBFA7bQ45bzFdv4xXH64SQ4VQilpdbGd0IGmq9bBoNzfBXoI2VXN6
         7YEwSjMpFRFdJiYNRsVwQG7t5A/uSs5v/ZyVZRYDP1qBToEE64NJcTvSDkZ645h7eeKL
         z9RTIKKHS8cubNGFshz7z0WsJg2Y7REdWa7kTVMPPSwHuXw4C05tgQvyHlKj39fb30lr
         VhMLpYVe1AfxhkKwIqJ2kKft7tCNmCqNfhJtuDH3K4RQ/prEiyoKew/soVNA7kVlzD/T
         coh5m0v7rq6ph9Oro0CU45GVbRy7Li4uamFa0pbmfTvhlq9jnTO87KnBUInanon+vFvv
         DZFA==
X-Gm-Message-State: APuU4Z8RKPy6gJOTB1Adz8OzW8dbjgs+N/5tN46YXCTGN9Ex1+fz8JjN
	JLVzLbRdZJy8V0xKF134SdfVOPVpsJs3srEt1Q4DbucM+iR4iUJT3oQggec4fMr5tI4=
X-Gm-Gg: AYBFou1GIJcrzug7r1t5WSitvpdXeW5TpbHRfdzvlcwaLiQi8e7we7RiVX6ThhRMy7I
	52gE0IZ3kSk+NQ2DhbVnRhIRiyzo9twKOtvz5aehqG3+OpsNFHMFm/1W+oueqz5l6pz5lcYv9/H
	ynwU2Fb8yLeJsK0xBgWI8fZrgiC3B3Wvatmr0BWWjcxjvs8UBqAc7Ll7fxvyFBG1Hj//4BD1Tnl
	Woamei1UIr1jVEHGk4pg9fWAIHRkZisuJKeh/ZHjQifFAnLFyWuTk1++VPzhEaEfGrW87ry12hc
	apixbfbO1ifiXz7fpBTXpGu3xppaefIIRotIl6O3WQDvPUcUDqaaKKO/DfZOiSaQ1ZlehYER6vJ
	6OSYZE19Q1bSDjH64nWeN62UHfiCTpHwqQo7P9Cimn8YPSaIl2VocnjW1pKCIl3IlaXe+TuiNV2
	5+0bGlzCNgIiUbklHF2gUUGrMjh9jAczL57YWTR2807VA9wEUNkx7Y4ZCaZgAbdfW1tGOVKpkyv
	lHmkgGrM8IV3ZhNmZsL6JoAT+6shtx2RXvc+stscdrnXT/h5K73ko/kxnWdZ3sp4KR3pPmel8ZI
	GUMKkrApF17SadLh9OPa5RlkgDZgrgTsbqzucO/dMJ7Liw==
X-Received: by 2002:a05:620a:6497:b0:93f:5519:5e87 with SMTP id af79cd13be357-944214dc4e9mr2928442185a.4.1793891630501;
        Thu, 05 Nov 2026 07:13:50 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4799adcsm482767985a.13.2026.11.05.07.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:13:48 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:29 +0000
Subject: [PATCH RFC v3 37/90] x86: give a task without an mm no user state
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-37-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=4121;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=AzJUK89H36+a6DZkLJfb/bsDi6+Ma/W3G+ZrG4Bu/+k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOvh7eMY4P2VdmuVqh6BApfDmksMcmre4B9bSmm4fmjaNCLtAj6C8hwekw8TooCQ0iCvy2Luk72
 VQAXezGMcsgI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A later patch creates tasks that have no mm and whose first action is to
exec. Such a task has no use for the user state of its parent, and none of
that state should be left in it. A kernel thread can keep the state
because it never returns to user mode, but these tasks do.

In copy_thread(), clear the segment bases and selectors, the I/O bitmap
and the shadow stack state for a task without an mm. The registers are
already cleared, as for every task that starts in a kernel function.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/include/asm/shstk.h |  2 ++
 arch/x86/kernel/process.c    | 24 +++++++++++++++++++++---
 arch/x86/kernel/shstk.c      | 14 ++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index fc7dcec58fd4..fdf43119c2bb 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -16,6 +16,7 @@ struct thread_shstk {
 
 long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
 void reset_thread_features(void);
+void shstk_clear_thread(struct task_struct *p);
 unsigned long shstk_alloc_thread_stack(struct task_struct *p, u64 clone_flags,
 				       unsigned long stack_size);
 void shstk_free(struct task_struct *p);
@@ -29,6 +30,7 @@ int shstk_push(u64 val);
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
 static inline void reset_thread_features(void) {}
+static inline void shstk_clear_thread(struct task_struct *p) {}
 static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
 						     u64 clone_flags,
 						     unsigned long stack_size) { return 0; }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 346c438ac880..d2be7a9647ce 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -219,9 +219,23 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
 	 * update it.
 	 */
-	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
-	if (IS_ERR_VALUE(new_ssp))
-		return PTR_ERR((void *)new_ssp);
+	if (unlikely(args->fn && !p->mm)) {
+		/*
+		 * It has no address space to have a shadow stack in, and what
+		 * it will run it has yet to exec. Nothing of the user state of
+		 * whoever created it is any of its business.
+		 */
+		new_ssp = 0;
+		shstk_clear_thread(p);
+#ifdef CONFIG_X86_64
+		p->thread.fsindex = p->thread.gsindex = 0;
+		p->thread.fsbase = p->thread.gsbase = 0;
+#endif
+	} else {
+		new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
+		if (IS_ERR_VALUE(new_ssp))
+			return PTR_ERR((void *)new_ssp);
+	}
 
 	fpu_clone(p, clone_flags, args->fn, new_ssp);
 
@@ -258,6 +272,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		 */
 		childregs->sp = 0;
 		childregs->ip = 0;
+		if (!p->mm) {
+			memset(childregs, 0, sizeof(struct pt_regs));
+			p->thread.pkru = pkru_get_init_value();
+		}
 		kthread_frame_init(frame, args->fn, args->fn_arg);
 		return 0;
 	}
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index eb690ba90180..41d77efd7952 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -183,6 +183,20 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
+/**
+ * shstk_clear_thread - a new task takes no shadow stack state from its parent
+ * @p: a task that is being created
+ *
+ * For a task without an mm, which has no address space to have a shadow stack
+ * in. What reset_thread_features() does for the caller at exec.
+ */
+void shstk_clear_thread(struct task_struct *p)
+{
+	memset(&p->thread.shstk, 0, sizeof(struct thread_shstk));
+	p->thread.features = 0;
+	p->thread.features_locked = 0;
+}
+
 unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, u64 clone_flags,
 				       unsigned long stack_size)
 {

-- 
2.55.0

