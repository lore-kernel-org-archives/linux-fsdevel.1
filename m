Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96074381B1D
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154943; cv=none; b=mNbEfrd6HEmbuZrdm8IUik/NWNunVu9RNddjlj4Aa70Ppki1zq1WdjF81DJBUStk1RwLutjhN5wrT/r+xwO4VNek9QO0TTiO9+xuX6VG6BQ1V7ETk/8P4KJ4h79BXg4eI9FNuePCI/HFzGpB0pOF6VCb2NuEMxldOhqLQ5LtXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154943; c=relaxed/simple;
	bh=bPeySIzvwdl59bI8ZI4Nv+mHr412k88Uyp1LoSfzrgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nK1/VlCmeN4xabJHpXxp3hekRndv0gshl2P8Wl6o7G19ip8E53c59huqkaeeSHvftrKMd6sttKMHlqpzjV3bVi3vbX40E4KlxfRn0BbXyOLiaYIZ1vaF3htJSu1Xnqw8OHIOf0LdAzKUQe/QwbDqrj1Dx9MQjUR2Q3pcAHJ6Zss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1aMH6j1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1aMH6j1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso74340475e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777154940; x=1777759740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjA4suJY50P3hL0eg2zIeJeFSvUg5EcOPNDUedPN0Yo=;
        b=T1aMH6j1pRhFzmOiZfLxKTGirNYPR2MbKZyoQgBGdDCuBASDFPL6JqKd8E/MrhXUng
         CpczMJ+2ePsqF8KMc2kBv8gs8mXrBrsRd64MpyFQyzYrq/OLVo371m8X0WVkQ54GeA+x
         PmymDfU8PD47sOlyH5Y/I+QjHRzpUZUrM5LTbVW+H2nOyaCOuT8T2d01mByskmKxcptR
         lp6cBdeYqlalwGSsQmuppDVMyQl8AhLcs87bgoKj7ydvOOV+SgXF/6XYfXsvtC2SofvX
         /8+cNnzrNLhY5GxZS9ujaGRPDD4SL+iq65tMyDFM1mM0A1s7wEp04gPlcsYu5LXmzuEB
         cnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777154940; x=1777759740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjA4suJY50P3hL0eg2zIeJeFSvUg5EcOPNDUedPN0Yo=;
        b=kCYPLmJR+cR5Law7hG39e+/WLdlIO24YiANjyvIYBEd9sligYGxC87fzjJv/E2hAZT
         qfS/Iwxgg+RxLAlz8EcpFiQNR0/SOqN+KSwniGd6KoqDvFS03HOzuUjkHvsizKxhcDRj
         psIw8nE2WC0dso8UhhAp87bYBXN8b3J0Wm8Uh0ccDe74G+5+sNVwH+Z+sLBnOs2TeoF0
         sK4z6UX55l08p1OmxImZIu3EHh8rutBtI6in1d8VoSYZauBR1+QbhUbfrmmZPxoCebpb
         W7diAJtHN7+Vk/Q9b08oT3GjBTxSPAVU3QOkOpMq3Bx7WZrd5v25UucdD6ahJnSbkMv2
         hTGg==
X-Forwarded-Encrypted: i=1; AFNElJ9y/jjLe6unfkfbea7JVjl18zEFrGX2I+4E4tIgM0ora4mVyEuQ+0nYQTSwUSfYiawuz11zfo9QM4oBAl1+@vger.kernel.org
X-Gm-Message-State: AOJu0YybpOqf/qpHC+gCMa5guR79kdfd+Cko0kD44TRESIZ9dNtZoKQg
	1HrnIjbAavQm+uw8rTauo0CKOEBpFE9NEYew0vlF+SXgFjBCg/3MCYXO
X-Gm-Gg: AeBDiesFspeXpx2QipB9tL7nK7pffyYGjYTx+OYq6Ks0S8ocZkIUjaXm5Z2MQaYa/tY
	DqX+KPnjFoWxaOktWEZJmR050TAaGe2j2Gca6Gx/uH/q0PFrX47e42pLpnXBoFhIqK6byZdAxSR
	sAQM0bg6/CJjCLBfkbCOptxHgzvKe7Qil/ungA1eYhYshi3s2T++r9ijGWs36+klqDxh1Mg2tZI
	eyABwxhS+fN3Cwjdj9QradC/2AomAT5ElsP2ouJ2vY4d5Gp2zzRpk9RreAqJK3v1JheEprbe95H
	tj3NVuCa8CS5FGDinGGPwWXZavscZo+ngu+P0fBoOKYeyHXf7AanD+w5HDVmH2ojea5QgESJccG
	G6C5dwYoFGTY0vYq4YYwlaAf5dJwXguZeizApQUIKZ0QaOLzOO3MpMJa8DOhbgGL0S+ZTHauSH/
	zOrMRUfiIc218WPtcQoXqVXnEHHza7c1zp3OZh/GTKtz5/ilGvmTZCUoe38bFwcAeIlKO+4oWW6
	x1G1q0MDvny
X-Received: by 2002:a05:600c:4593:b0:488:c120:480a with SMTP id 5b1f17b1804b1-488fb78bf05mr524932765e9.31.1777154939987;
        Sat, 25 Apr 2026 15:08:59 -0700 (PDT)
Received: from f.. (cst-prg-93-232.cust.vodafone.cz. [46.135.93.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0b4c85sm651984545e9.0.2026.04.25.15.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 15:08:58 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	adobriyan@gmail.com
Subject: [PATCH v3 1/3] proc: allow to mark /proc files permanent outside of fs/proc/
Date: Sun, 26 Apr 2026 00:08:42 +0200
Message-ID: <20260425220844.1763933-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425220844.1763933-1-mjguzik@gmail.com>
References: <20260425220844.1763933-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Dobriyan <adobriyan@gmail.com>

Add proc_make_permanent() function to mark PDE as permanent to speed up
open/read/close (one alloc/free and lock/unlock less).

Enable it for built-in code and for compiled-in modules.
This function becomes nop magically in modular code.

		Note, note, note!

If built-in code creates and deletes PDEs dynamically (not in init
hook), then proc_make_permanent() must not be used.

It is intended for simple code:

	static int __init xxx_module_init(void)
	{
		g_pde = proc_create_single();
		proc_make_permanent(g_pde);
		return 0;
	}
	static void __exit xxx_module_exit(void)
	{
		remove_proc_entry(g_pde);
	}

If module is built-in then exit hook never executed and PDE is
permanent so it is OK to mark it as such.

If module is module then rmmod will yank PDE, but proc_make_permanent()
is nop and core /proc code will do everything right.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/generic.c       | 12 ++++++++++++
 fs/proc/internal.h      |  3 +++
 include/linux/proc_fs.h | 10 ++++++++++
 3 files changed, 25 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 3063080f3bb2..497561ee3848 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -845,3 +845,15 @@ ssize_t proc_simple_write(struct file *f, const char __user *ubuf, size_t size,
 	kfree(buf);
 	return ret == 0 ? size : ret;
 }
+
+/*
+ * Not exported to modules:
+ * modules' /proc files aren't permanent because modules aren't permanent.
+ */
+void impl_proc_make_permanent(struct proc_dir_entry *pde);
+void impl_proc_make_permanent(struct proc_dir_entry *pde)
+{
+	if (pde) {
+		pde_make_permanent(pde);
+	}
+}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 64dc44832808..1edbabbdbc5d 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -79,8 +79,11 @@ static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
 	return pde->flags & PROC_ENTRY_PERMANENT;
 }
 
+/* This is for builtin code, not even for modules which are compiled in. */
 static inline void pde_make_permanent(struct proc_dir_entry *pde)
 {
+	/* Ensure magic flag does something. */
+	static_assert(PROC_ENTRY_PERMANENT != 0);
 	pde->flags |= PROC_ENTRY_PERMANENT;
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 19d1c5e5f335..dceccd27a234 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -248,4 +248,14 @@ static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
 
 bool proc_ns_file(const struct file *file);
 
+static inline void proc_make_permanent(struct proc_dir_entry *pde)
+{
+	/* Don't give matches to modules. */
+#if defined CONFIG_PROC_FS && !defined MODULE
+	/* This mess is created by defining "struct proc_dir_entry" elsewhere. */
+	void impl_proc_make_permanent(struct proc_dir_entry *pde);
+	impl_proc_make_permanent(pde);
+#endif
+}
+
 #endif /* _LINUX_PROC_FS_H */
-- 
2.48.1

