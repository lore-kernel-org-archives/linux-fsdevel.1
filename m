Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD43AAF71
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814837; cv=none; b=bV6kcEnBtv77/yXJyFUZhj8MMtDUeYYnNqTt+xq1P7dNuZWU87NoFM7KwJQ0v3UpRqrUiWmzAzMF2B0iE8uITkQMcn4iCXVbfYH7qo9FaTKtyDvFlUTkmkZAPAtGFzzb1w03aX//UOxt9fMUwOFYRLG20K3LFfMnqMv/jr3iZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814837; c=relaxed/simple;
	bh=ADyoAPi4kZgirNh4gOcfqdLiEnc1vIBxWHYLFCTisIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dL7Hj4DTrzoDZ6gHiubvQtCaIAuYrXyc0kNSD7EZfDxTtktAQmQEkIi/MzfTf+rZEwEYxLvUGVu4D3PquL4qcK651OSjM4HO627qNADmQMt/1juA8Du4wMKU/nevvmXu44Gp/DSL4Bg3wPRfzF620e303ayQ9HG+qxLVgkLsDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmm7PLg9; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmm7PLg9"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cda5e048fso87355e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814833; x=1789419633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRnXHx6VgGnMv74R9wDnVfN6U71gdwk07y3Ib4uyqeg=;
        b=vmm7PLg9zMZuqTP86vpaKW6P+d0KOrG07Ym2I/EFwNeEx6cmWhpIqheJGG1uxNKT9V
         8OqTdL9GDiHvG93iNOyVDYR53TlsXhh6DxWtk1HCgYsSct0lM3bbi6nQhwOHhmgLvd8e
         3/NmU+eXYX1I9q18R6GgOB6zRkAcLHsZsC4zQq9YrxpH7mQ3SjiEi9glURRjhIVVcGak
         jg5fc+BCDEFsRYVLZYtL9e1dD695AUqccP+OQdCDVdfsnfxXo+kdq237mCiq388LmEDR
         rBDhVoZRBmaE7SNK335rs1tKEHwZHNsg3stLPFUVsoi9A8TOQDXg/p33vCxcXiOZERCY
         wCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814833; x=1789419633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRnXHx6VgGnMv74R9wDnVfN6U71gdwk07y3Ib4uyqeg=;
        b=XcgrnmCeqd8mPHdoQ77AwVkNtu9s8gMTfcXzfqqEhxRWNeiB7Hw2yEDfF7vC22bPw/
         44nAyImXwE7Njjfzwu7oF/mhgDq3FVxm5apLiBcwTb3TKorijd45/Msa19aWyq95rSxo
         UThRlTAvX5t3Mh0vf+mZwvCxh32XxOn/tV5FslaRrX1kTymqyR9jQK39RW0zQlQmJU20
         g1V+ZMWoBkji0X0fj053PL/BgTNYjaJTi02acRmurXdh1pK/A3cmUlCxarkvJfK9u3c2
         xImN5unSGUS1H+KvdiDyVhrQkDEtNONb7zAioa1oXYv24NvACulHR4TPFdLkHk/x+OjK
         Zmfw==
X-Forwarded-Encrypted: i=1; AKwUvBxtJ52aIhbr0jBR12IkTNNtJ3gecl/i2CLZtY0w1ybgIxna+Mwh9Li9qDy6VKs/evd3YZJiGHUAjRI/qp+x@vger.kernel.org
X-Gm-Message-State: AFuF++mVQj+CTqW1U7zRQKtvd9MNOWUYG8BFAT2P9qSqwDxl6XAGkGez
	6q/2tJaLT+VlfdG3gl/WCQHqpcj78FOGyjl1LxDuL0mNyfHL7RgiyKBmtz5YOYtRew==
X-Gm-Gg: AYBFou1VFt+lTLp7cyp1icRiS543ZWSXRa7vOQBvNtjP+fKft9boF783TMuXNfrAmn8
	9h5XTVfDAxf9cv074/PfTtGJ7LXkTd66uwIOvcxgXAqBZwZkGhXYMsljr8EYPjgNDfZY4hULVmr
	3fThsn20WW17yqP5XoyPV7PXymKuIOelgeCOOehi01LI7TGZDEDG+qdJSbnLazEJruiaulmCz6U
	IG0A2bIhu5RByGtjCEIQ0/jgfT704GNsFU0ujyuLMqWv7EDqtQnQpZWOzNtbCkdFrOqtX/hASaQ
	z2g5isI5f68p75TsA6xSC2sOKomgzGWx4vW4EM6FidUCGWrHnLGxh8RpbDMD23qNecLHGUm2YIB
	lwVHwW/tNuvmv4w1tcy/iSanf5BwWV5/4ITJJNB2G9MqzueQ9QYKIXbAl/gCJmtNbFdSvC7fXRZ
	GNxuHWUJ4QKnJtDHeZhqP4QI5kMciZ3eI10rjHAqJMB6Put7YzveaTNjAj6SIONytslQy1J91en
	PfYPh9tkOZF7xK2wMP9dOHygOIGWRAQ4gN4J7hwqSYDz+P7
X-Received: by 2002:a05:600d:8495:10b0:48a:623c:8859 with SMTP id 5b1f17b1804b1-49d01dd5cbbmr1672455e9.7.1788814832694;
        Mon, 07 Sep 2026 14:00:32 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:437c:9ac6:4a41:e58b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce831af89sm296356215e9.1.2026.09.07.14.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:30 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 07 Sep 2026 23:00:18 +0200
Subject: [PATCH v3 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE
 introspection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-selinux-pokemem-v3-3-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
In-Reply-To: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788814820; l=2962;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=ADyoAPi4kZgirNh4gOcfqdLiEnc1vIBxWHYLFCTisIA=;
 b=/+BkX6CIIRykdm9LzWh7SeoNJjuZpofKO51F7SP8VrCx38snRk5/Dg7OkyREfcDhgHAdymDNB
 IscJXoiNDc1BcIlIo+7EG1udczgI6vImnw5htcwkQTKyUUdVlbw2zSG
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
only create anonymous executable memory via /proc/self/mem if it has
PROCESS__PTRACE (like when using /proc/$pid/mem of another process).

This closes a hole in code integrity enforcement that Project Zero has used
in a remote Android exploit chain:
It was possible to use a memory corruption bug in a service without
EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
/proc/self/mem, which made it possible to load and run shellcode containing
a kernel exploit.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/hooks.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18dd28b2bb13..45ead18c8f01 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2157,6 +2157,36 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
+/**
+ * selinux_mem_foll_force() - Determine whether /proc/$pid/mem can use FOLL_FORCE
+ * @subject: credentials using which /proc/$pid/mem was opened
+ * @opened_by_owner: whether checks on open() were bypassed because the opener
+ *                   has the same MM as the target
+ *
+ * Decide whether it should be possible to read non-readable VMAs and write
+ * non-writable VMAs via /proc/self/mem.
+ * The @opened_by_owner case only applies to systems configured with
+ * PROC_MEM_FORCE_ALWAYS, and only happens on accesses that are not visible to
+ * selinux_ptrace_access_check() because of the introspection exceptions in
+ * may_access_mm() and __ptrace_may_access().
+ *
+ * This allows a process to overwrite read-only code in its own address space.
+ *
+ * Creating an audit record on denial doesn't make sense here, since we can't
+ * tell whether FOLL_FORCE matters for the accessed VMAs.
+ */
+static int selinux_mem_foll_force(const struct cred *subject, bool opened_by_owner)
+{
+	struct av_decision avd;
+	u32 sid;
+
+	if (!opened_by_owner)
+		return 0;
+	sid = cred_sid(subject);
+
+	return avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
+}
+
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
@@ -7558,6 +7588,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(mem_foll_force, selinux_mem_foll_force),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),

-- 
2.55.0.1003.g10538fe699-goog

