Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0A3EF642
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168240; cv=none; b=L9VIIPRc1zbGQCvGGpPu/ZCMrNRDuyDgGmkSOEP1VMIAwcrr2SLUWoQmEnLOJQaJYtWVrWk8hTVVN6ahFwavof6oPrqaKwAiti9KH4DurEZqIKhwETOgz0Fu123W7VNT8/C49zlkAuTnpPnkPfkbcrqA92pDNBo2WONaOtF8OPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168240; c=relaxed/simple;
	bh=ny8/Gs7FMzc8WbloXN305yxNtUC/v7SjWkG2BsK5NEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3tVQGJqrdExfFR+sjeVDKCTGm9/INTu8c9ARK3ViboBB4WwYGb1cyEQcYZuNlir0hj1VgOiZp53NS83mOeAw87Vgtc0/Slq9DRXEynRhl0p82s64G1v3UEhqrnC6j9q0EOVwjAgOV18oP8n1+/RP/vbKio3pO2xolcBWL+QABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkkdncBm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkkdncBm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso21645435e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168237; x=1788773037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+K9xBUZV2Jmd3T8roo1dKtbVqBUblSh726dOO5UJPI=;
        b=dkkdncBm1PRV6nFUYMlWgWnENg938zB2PisjOq44ytVBqHRPt/d/0onDsv10OQSa9g
         mW4vq3AYdRmOmNwzRpMTTQRKUQXdveuXnM1nb1yFEHUR0AnmYAKo9FMvAf38Drq22ACa
         KTNMqWBOktOZUS9UARVSTStWPpg62AQPzGw6LhgrS8UFR/WIdXSwicpLY7vaSaneNzBy
         XS5mWG+s3uBOux0nVzxJNgB+MhlpxP0gAcu9DDakaRMUXT8hiT5bFWEbfPM6lxzcdA1G
         gEU5OAX0PL258LjuXwRkMSvHjawvwpvb5JE4FRfMT3V2PRQecBtj8/d+YeBfV+kRhldm
         9qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168237; x=1788773037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+K9xBUZV2Jmd3T8roo1dKtbVqBUblSh726dOO5UJPI=;
        b=CVTh8yJTBKOiOXX/UMjBBLxdPiNi+tDnnngOpr4c59Cownlst/HoPgXFSWZCXzidC0
         GZFWhSRKkrYwHcLJPypi7g/p/oXy5LOPsmmLwQAU3Phi+e29f2wmZ5SrfZOLad7Xx88J
         IFtRaDhDoJmC4a6gmc69PyGVoVQJdjVQQ0x2KGs07xFGxLQxc7xW7Md9/Q0XgCzc9tNa
         7xPCg1kZKbsMCg4BZD5bYAjkIPnO8UA+hIHGwJX0q4hGJUa6J/QVt5QRKAdlDk+cx+D8
         XRokMKIoHb4MVeJ32a+lP3ZOj33FB18vdAGEhvNCl3o+6XwIn3MQI/vQSD8GdCNuysuS
         mSlA==
X-Forwarded-Encrypted: i=1; AHgh+RqqlO1lag5W4QE7jUGZPpGII3htFfVHPjUEkisWdTHKjLlMXO8a4rdIoC+J7HOHhytmreLpx0um76n1MDvi@vger.kernel.org
X-Gm-Message-State: AFuF++mPzagZwCLWJSA4xpQ/62JenM8ixywSWrHbmHuAonWZXhbH5L1N
	znT6sJyIr3yhSFY+2xQVXuiMMdx9X7tmWM+lpQsDqAl9y9AeKOpHv1vm
X-Gm-Gg: AR+sD10dZ9aOi4Iz5/mMsaVHda/GcEpr68hqtNhvCWMroYbMiThjHulpGgrlrdbqPDk
	4SXLPQG8gOssJIpC5PNi2ASY5TeKFY51hPhsUejkCOmYjfnaIhCNVWljNXaJwlClMiqK6mEPrnq
	7KkQYbzX/GGMA5z1qU4pbU6dm8xgO3Mgw5bqYREry0z+UC/SjA1J11suFndX8SL3hTcup6sXP10
	lY9PVUCbB8lx401dsXokT2p+cYBAd4XBzOAnuz+CKZGuoLzyWsFfigfEmR5iFoYm5nQwcy03oi6
	CGq0qCwN0j1ajOPC3r/1vYtIYT6tDb+57J5mNCp84G8zQX8JVCMjLnFxgQATbHM5uQiOoXsgTJq
	QHncjgq/Rj5M3pLLxnMCTdWdYk2Vi2Q1KGwcbI90F6miAndSJTvwZ0QuXUgSPniYaxsxRRmzvu7
	FmP6dlbGFD3dIdpsedUL5E7a5axgXkU99ZH4XNXMxgmZBJZc5RVgWtFSLDWxFcGbVOYdryKYOC3
	w==
X-Received: by 2002:a05:600c:1d08:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49b91c2e145mr372213505e9.1.1788168236596;
        Mon, 31 Aug 2026 02:23:56 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm318248155e9.9.2026.08.31.02.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:23:56 -0700 (PDT)
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
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v3 6/7] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Mon, 31 Aug 2026 12:23:04 +0300
Message-ID: <20260831092305.42062-7-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
can pass it to kfuncs after a NULL check. The linux_binprm owns this mm
throughout the bprm_check_security hook and clears the pointer only after
exec_mmap() installs the new address space.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 386401fe051d..584c79326b9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5958,6 +5958,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
+	struct mm_struct *mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6012,6 +6016,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
-- 
2.55.0

