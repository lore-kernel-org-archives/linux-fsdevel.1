Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48E3A7F46
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858479; cv=none; b=goOkUgitWbk26IJZOWuT2PoS4gv2H3DcsT4AZr2aDWyyKbPX/e0i6ZyJqRfNIX+5dYWFtVLnciFmLHbf2H67gxVB7YhDV5zGRKIpSjvW1anyDq0YT7/T5qTakJsTLz7NvOZtPVdR/ium2TjkJDWXxwHmO/aucIIWgRmhdC5QQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858479; c=relaxed/simple;
	bh=uQc7o3B0d6JZctTo6WHJR1OhocjVNCHR6/DSXcehs9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyVyJXNxqWW0XFjn7U3wPvHLiQRO7cnV75f2ShTw94lzfg4xcn2UPNZ8+5DXxwF+cZ9funv417NCtqvG4uCMipskiqLJlWNv1kUs25ImyZcz35fN6FJAZXldDB5h9JsKuLI8buRiNY8/4A6UuLaS6zGJMsBNEWIKTZAOXP8Antc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/G6Jkk5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/G6Jkk5"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso1437404f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783858474; x=1784463274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+sx4b9MUqxuiZRrlltzahxnxgeGhnIGeRIQ3PCtTNgg=;
        b=N/G6Jkk53omDBML/WIRBmGY2COdZis2yp3HyEMFVLM4QzS3dU5B39u7FvzwmSy1oeH
         ElQf1O4df1ars2ZF9oBfylb0fUhXOWswHYlbd26QNUfYSpYbclI2+Fg/aiPVvlErq0Kv
         x/oGcgnVzVDuB/XMZqYB5AJF7C+mGi6gqopSxNyTEdMOqu4TYuEZUEOLlTRHqAxDsaCq
         GjSATeuz/xPBsp0HFAEQJ80LKAjA2acekF1wCy1gaRvOi+KL5gde+z0degt7gHl/fSV2
         tjYZMQnR+I20KZPZo0I68ZJzLfofX0Z6Le1ol5Ks5uo8r/ptPrVed0AUuFBAVlLMkHSh
         HkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783858474; x=1784463274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+sx4b9MUqxuiZRrlltzahxnxgeGhnIGeRIQ3PCtTNgg=;
        b=Y6Wx9QF5F1T1f9OTjm4EjftSX+Sn3sc3qsvc4+O568yHrOlspVSz8QAaV0lFnurjxK
         MpmDKwxRncLQVadlGX1zDw5KKVxk+uHxnhugwcwtsyJ8WOpU+0W67i9UPvehG1WYelYU
         H9PeYGASpaeZhAklF/xarXv60kGGPQ7uJM7ewT1N6SPQH6uupQj1NvBnmP4d8iT6p0WE
         /1a0VOiibI6bjI/TxcPLLwjpAaffgXJmMUS61KA2P6U9pOAp6uYdtVi92ngh8aUDN14e
         2MSDm6rZ9X9k8tHlh6aEH5OvQTnGb5CDRb9eQ2ieX/SqeNQYB1JuBlo5I0TfM8X6gSzh
         CVXA==
X-Forwarded-Encrypted: i=1; AHgh+RqzzP6FI/4Vh3P3A8D+Di18s7GRXD/F99gZAj2SnDAXnWR/eP3uYchO/TDMuTMKd7e/U0VgBv90VMCtdntA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JtFsiagHpq+JkBM+azDxTewUru9vkQaoX1ZPZ5rrfp4zxv9M
	OuGmzIpL9PUUdm4tjeKLLkLKb0LMdoW5odmmqUh59TSuTnnKItzfagzC
X-Gm-Gg: AfdE7clwJdghX86aX4EzY8RM1XlpSvcPRldkiNr7cBzmEHRF/KPR6W12m5T7BGeY8YE
	kx4QbvQN1al696tQR+GspzELPRi+4qhybWWmOtMXvWhl+RH8isv6YDrtcWIaqJvkYQm19vZMyVU
	YD2S3H5PUJWwne681NvewS89OGb4UKQxnkQ9u6A7hUB1efxTPWxAUBswPTKvmDLYtWeKHcGvG0I
	4Vezjq2XTuMk8OsL6ho5sJqBZcQn2uolcuw1HW6MUouETlc6zCMCu4qgvQ8v7I4XnJvAwjxJWQd
	cm2gAYxgtYnUgI3QPF0x8+VGJZnVD4iF42PbrcQr609dS4hnXA+7uWbqIrtLP4BV6CemiRG+BZN
	L82cAUGZkjZwXZ9e/uOZVHGWKCJnv22pxSvu3sqisPbFJFSXKYsKFZWspAYXagG0ItszC5o5r9g
	1qsXE4eGmQr2SR+Zf0o8t6KiHIFQIv4BuiMiwwSFg1
X-Received: by 2002:a05:6000:250d:b0:476:82c:b869 with SMTP id ffacd0b85a97d-47f2dcf4962mr6201615f8f.35.1783858474209;
        Sun, 12 Jul 2026 05:14:34 -0700 (PDT)
Received: from fedora-dell-ale.Home ([2a0e:424:a465:0:bdde:db24:d709:ef36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm74515699f8f.33.2026.07.12.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:14:33 -0700 (PDT)
From: Alessio Maroni <alessiomaroni0@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	ojeda@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessio Maroni <alessiomaroni0@gmail.com>
Subject: [PATCH] rust: fs, hrtimer: replace read_volatile workarounds with atomic_load
Date: Sun, 12 Jul 2026 14:14:20 +0200
Message-ID: <20260712121420.25179-1-alessiomaroni0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the temporary FIXME(read_once) comments and replace the
read_volatile implementations with the proper native atomic_load.

The generic `atomic_load` with `Relaxed` ordering maps directly to the
C side `READ_ONCE()` macro, providing the intended behavior and
correct hardware memory guarantees without relying on pure volatile reads.

Signed-off-by: Alessio Maroni <alessiomaroni0@gmail.com>
---
 rust/kernel/fs/file.rs      | 12 +++++++-----
 rust/kernel/time/hrtimer.rs |  7 ++++---
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd..63f309f5c 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -335,12 +335,14 @@ pub fn cred(&self) -> &Credential {
     /// The flags are a combination of the constants in [`flags`].
     #[inline]
     pub fn flags(&self) -> u32 {
-        // This `read_volatile` is intended to correspond to a READ_ONCE call.
-        //
         // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
-        //
-        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
-        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
+        // `atomic_load` safely performs an atomic read equivalent to `READ_ONCE()`.
+        unsafe {
+            crate::sync::atomic::atomic_load(
+                core::ptr::addr_of!((*self.as_ptr()).f_flags).cast_mut(),
+                crate::sync::atomic::ordering::Relaxed,
+            )
+        }
     }
 }
 
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 2d7f1131a..cb1b5a2ae 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -576,9 +576,10 @@ pub fn expires(&self) -> HrTimerInstant<T>
         // - There's no actual locking here, a racy read is fine and expected
         unsafe {
             Instant::from_ktime(
-                // This `read_volatile` is intended to correspond to a READ_ONCE call.
-                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
-                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
+                crate::sync::atomic::atomic_load(
+                    (&raw const ((*c_timer_ptr).node.expires)) as *mut i64,
+                    crate::sync::atomic::ordering::Relaxed,
+                )
             )
         }
     }
-- 
2.55.0

