Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF313806D7
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075139; cv=none; b=LCa0avrZrzTHQsBLiYJtzOxNRleWWiOKobe3Olr6bDL2d7DYziFuvDEWX42t+TDvMlXkHFw+y5Q6YeQd3KaD6rN3HfenCLyuAupSFakqk9f1/31/hq3nGFB3yF1dJIijcvH5y+wNMEsL0GyTYB7JJPOzc8kGcgTmzuDdEAJn75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075139; c=relaxed/simple;
	bh=kPRFGm1PpzKTojZpkl1fpPxcxPliwE6WJk5XhCUxa50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXGQg49tcI1NZGTcTxEwwkn3IiFwTIRfm1roQsuBkCcaTRvq2XjvyiV+BayCiT4vBg96WW0JOe937kbH2Jk+baHgJeuepdKBZM0R8LtBu6RIXpGsW75d06MRiLE/F77/NuQySxl/Kq0hSWc75jdezMV/1BEUAbbg3VmfcL+xFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XonvL2ID; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XonvL2ID"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891b0786beso94623675e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780075135; x=1780679935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ4vZVcUxh57FWknF9iHwYSifIVXpEFpUueO53nt890=;
        b=XonvL2ID72Jf20vseryt3U/cWL6sigpsbaS4/H0uOGkaflCi29fQAf8aFbmKUTncht
         4e6THe0bsCmM3mhph4+pRG9yFmBEkrBGwuvGnBaVPTc1B1ZhwkbdSDmTWgMCLeUM74ub
         q+u7c/q/DS+wVlyLhh/OSwPIM5wrw4KiqkO/lPs5aDNq4rtk/fWw/Am/p5l8wiUo9NPl
         e8/IhmYEVEYjiBXaPAa4yhZEYYXX6XMyKeARBP00qWOyaJTX6BLChSecONVEfl4uE4IM
         wFfGzDo40ufTWHAsOS06iMzbWG/xF0qjvGjDXQSIMjMxjgIgVmnZvE4O9LD5k86f3q6v
         HdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075135; x=1780679935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZ4vZVcUxh57FWknF9iHwYSifIVXpEFpUueO53nt890=;
        b=KQhW9prRg7fwPUiT8d+2f/HVtY3iKRzvTIvpI6cVQFWe4afwkJVBlL8zZe5nDltxSl
         v+IunjwxJhQswGLhFE6CbrrksNDVAAXrXaKzThcjPGgxiqWRt50Q+wiNoEDrgM0wdHBW
         klrPy8B/wZlwbzOcviN0kaZ9WMt1wIf93Tv29i9dw34W2IHkRqJ9sNfgA9TOjOMHoJ0E
         RzG1j6k+EUQjBeeel/W5BNb9XjrIPyU/Q700TgBAMGgbpz4tYV0RgFWeR8fxbE5/QQFy
         HqmpAuYx7lEmXrl5EIf0HAdhgbw3n/lvWbofDvP6WPJ8ZYCjjXSI08MmEogUF2X1AvPN
         0qSw==
X-Forwarded-Encrypted: i=1; AFNElJ/Vc9pYh/koTp2eDddLQqSqK22j4/JuzMEsFs9ys78nO7Hzje77xksllH5iY7N+6J9w6EvVssXzWYsAsC+f@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrzCLX5eKP8wUU/b50mpgfZL9TZi0DADzkL3ZuI51iNnxqx+H
	j7HajExxGHWN/HnPj06lffXhoXf1Y6Qo9Aj3/b+9LgvN3dfzsy4xmGXq
X-Gm-Gg: Acq92OGXL1Lynfosn88f7X6tqCmuZyzWLSGr0fzCo1fNemFftsdrm3XoifvNmA1KZq9
	Nx1f7RojMXlyKhRoyXzZ6Ee2i89b25y8o5fOsxNkZzdBXiaE0AQvvkvI+H2GyNXO85ysEgfiz/B
	0kUCqsYt4EBlh+UeuQADK5GIYcaEYljeS3bTNSGOsCl+uhasceUsKYaHuwfZfX1P/pqaFSIhzqi
	WUEBpa1s+m7jS7GpzIIGIcgpLonqTghNkmD9BOm0KdyRr7nq+kDynM7daGJfZ9bzzWGT1CscXat
	V/0BJYhr4wEYbbSf8ExBONAFPQXDYwGyt8sZGkn5MJxjd0HyYzzD9JoA1sw7Z2VNGLXsXr8lQKZ
	mjNk7pw/XHx6u5hYuaK52pm66XgbIKReB22vwqtRQFomDddMYXMw9uG3ouObUKhldQpurMPzekD
	nHvB7jHVY2PAsfC/xt92F7xluyrJizNckLUTaItju3am6R02nmXM/gbqECs43QlzRNsPcopN1Eq
	y9d884ifkgy
X-Received: by 2002:a05:600c:c3ce:20b0:48f:e230:2a21 with SMTP id 5b1f17b1804b1-490a2975173mr6658095e9.32.1780075134846;
        Fri, 29 May 2026 10:18:54 -0700 (PDT)
Received: from f.. (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7faasm56255375e9.11.2026.05.29.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:18:54 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	adobriyan@gmail.com
Subject: [PATCH v4 1/3] proc: allow to mark /proc files permanent outside of fs/proc/
Date: Fri, 29 May 2026 19:18:38 +0200
Message-ID: <20260529171840.2576445-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529171840.2576445-1-mjguzik@gmail.com>
References: <20260529171840.2576445-1-mjguzik@gmail.com>
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
index 8bb81e58c9d8..5f82c0b4a8bb 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -841,3 +841,15 @@ ssize_t proc_simple_write(struct file *f, const char __user *ubuf, size_t size,
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
index d31984c3c797..b232e1098117 100644
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
index ec123c277d49..96a22109a0bf 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -249,4 +249,14 @@ static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
 
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

