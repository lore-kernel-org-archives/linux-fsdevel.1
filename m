Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194A36194A
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683177; cv=none; b=IlohbJnKGi+Kv+cSpeJrD3/oV3k7piiRjRv1/Rj5Fva2VajtQU+Pu7rUtpqFWw/Ud8y8snAaeTkkf5FbY2FklK+gLtr/ypNTsc85urNZoTpUpYxb9qfBgopKL7+M6YJe85qOiQN1+0HAfAI5DqpGZfHeRQksZa4lUPx5yNtd494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683177; c=relaxed/simple;
	bh=Ns+udTpi8SWKloYkKMw8Din2oarGSCfqpMuFm48xRLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jd02+WOowcu6XX5fNMJORv775Y8OSoWgwln5bAOvGWf/cYEC/yB5UgB2fM+bj4SrXnxgEdLEqrbFcKFYXUFX8wN2amMh6Qf2XIUvF8YuRKkPtcf6QJ1+a9jqW0q/oQEh/LZPlxBjnT8UvPSBCMRzL1QlW2eLab5Cmql5oB3IYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIny9rHC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIny9rHC"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a17c7c3c6eso1735a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683175; x=1788287975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPvPgg8WrBS502z3EqfWF3DM7etFQasO/Hjw3jKjTbY=;
        b=FIny9rHCeTlRYb6dB/mMb0NboZ3DLg3scK8a+v7Rcfl+NY1ePYlW1uEqPbBNzc/XMZ
         W0JSO8Y9/MZ132kcuz0zr98QgSR295AU3jXrz0TJsshFdpx2j2K/Ht246ttPwpQzksRZ
         7KghSep0qNAxzRCJxpxSag7Dm8mPhNsY+yK3G6GDANRlNFUWhHoFxLujrQQ4nX222SP2
         q6G2aYlrxCuFaA8l8VvtpXbt4Gcenq4FBIN33yFhCY57UnlS/psHhke+HgjMB/iF2og0
         r0scXN6bA5mWRjkBIs5LjfD6PfvUoSc8LMzCPj7HHGbXxIIqExWo5FyDlBDbz/yOyCEX
         NjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683175; x=1788287975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPvPgg8WrBS502z3EqfWF3DM7etFQasO/Hjw3jKjTbY=;
        b=LWxf4+sFkfuxYR/TPDNDeGtiiXOh1UDEzna4ZcoygjGbbyhFXNYtfmXH7O3Zl29X78
         7OYxr7iAODZ3eiVgkrurppd1dlEMRaDCo0kiiBHTiCOaWSojVI5drIs1eYgYx74EyKuB
         vY45vzFEGPUZT9OL/cQKO4xb4wBJEWKSVDsWyeqk3jIkqXEOHQXOJ+W05/Ja0FJyciW3
         SppF9D0pl+41OaceNZW05GVHYLajEdbSsoOlZF12mfo5FV+hKYK4j5o0j3uGcxkiJnm5
         dp/JWDD5LXhq9yBP+ZaOk2Bjnu9adpxTJwBbWHeQX+9ef+7Y7jc0ARa80aoTHcnJ3AQ4
         oO4w==
X-Forwarded-Encrypted: i=1; AHgh+RotWTw79M4NNbwoaUar6N6prUE3aY6NmocnbHpgnPxUrUknWZQydwmRi0MB5Zv43qpYmym23//cp/V3sDHJ@vger.kernel.org
X-Gm-Message-State: AFuF++kc/DuZxnWMrUJO1z2eFFoZTQ2+yM3ANhiGlhC0214QO0/wEMF3
	u8aXzcBJ9v40POHRopQuSA/neOeP0EeQ5Z08RtHaQrbKfXidONTdJ7QZ5ad/FHhg6g==
X-Gm-Gg: AR+sD11gORjky8n17gYhxT5/9nCxfudio4DSnbSQ3f13UBFxtFo5X3ZjPXu5uOJrO/J
	yxZIMpl6F03d2kKM7r6ddstY9qRcKN2AFU7zZt5SQv7Vb3XSgnZxFKwabG9LpNXtA44fleiTimj
	A8t4S10ppxw99H3FXGBYO+ym1EunGfzqPJWoIbZykqtDNu+JGslPtwT6r1swMk2XxmmLliKUFBP
	y7Y0VtcAwJyvDcv3QsxsHhtDE6aKxQ6Ckrdlp5dqd3lmGbnZi5gXkN7Dvz8tn9iJWe00m4D2HEG
	v0YdDgf+gUSGyMsRqugzc0tMkKXv/mi68VreIoYQ8T6+ZM3DUnd7gaweIAytdR5LqmuKTO9jvcL
	dDCxsitG26NIuXZ1JzntU3uR9uhfuYl51axASkvNFpC7JqJtAmo3o/i+Dl0mN5jUU6M/x979xSR
	lTFPu8qwVx3ggo4RzETbglc7kJGJagO7Y6GcpY8BdFdQXqzpSEQ2mL8WuMPwrRA4mJ7uh0PWpc5
	ZHGVVzUv/XggCXFndGdiGARHQbhgZuTMnKKdYogpJ26ons=
X-Received: by 2002:a05:6402:2023:b0:67b:7d05:60b8 with SMTP id 4fb4d7f45d1cf-6a5c4a423a0mr72402a12.10.1787683174081;
        Tue, 25 Aug 2026 11:39:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:980a:b43:2df6:51f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a702c7asm82067566b.19.2026.08.25.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:39:33 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 20:39:19 +0200
Subject: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE
 introspection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787683164; l=2509;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Ns+udTpi8SWKloYkKMw8Din2oarGSCfqpMuFm48xRLo=;
 b=zeD7wBrHYoqhVh6HblaO+73EuAz1CQeVXst7AZwlAE/ssLvvQw8Ia6UL9q7TkXPnVftUvkutA
 EZh2GLrwyjZCNMAdQM0EcaCQZx1Tr+oTA0Tv+2dWEkEGth/XbX8l9/W
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

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/hooks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18dd28b2bb13..2c2c60e9e0fe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2157,6 +2157,27 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
+/*
+ * Decide whether it should be possible to read non-readable VMAs and write
+ * non-writable VMAs via /proc/self/mem.
+ * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
+ * triggers on accesses that are not visible to selinux_ptrace_access_check()
+ * because of the introspection exceptions in may_access_mm() and
+ * __ptrace_may_access().
+ *
+ * This allows a process to overwrite read-only code in its own address space.
+ *
+ * Creating an audit record on denial doesn't make sense here, since we can't
+ * tell whether FOLL_FORCE matters for the accessed VMAs.
+ */
+static int selinux_mem_foll_force_opened_by_owner(const struct cred *subject)
+{
+	struct av_decision avd;
+	u32 sid = cred_sid(subject);
+
+	return avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
+}
+
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
@@ -7558,6 +7579,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(mem_foll_force_opened_by_owner, selinux_mem_foll_force_opened_by_owner),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),

-- 
2.55.0.860.g4b6b3295ed-goog

