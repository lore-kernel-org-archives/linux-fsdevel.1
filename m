Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01544E1413
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533680; cv=none; b=Qd8VstzQhgME3WXpHuQt0nJ+BxP5Wgsg2brt9gD/m8uHo1vkUWeNpvtN4cwqXIQ1Vk6Vc/nDcbYhLI8fhnUoDt1zPs/pT3/W32frWY1zpY81o7nfFXn40a8jAKV9rcr4RnrudhrXCSLate3ledyec87tQ8YFi9ZvK/qT3S2TZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533680; c=relaxed/simple;
	bh=BoToj5o8PqZre7KOXTIXCd/pmWvmBwSW+UyCYhJUVPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvjMBAmHZ+6gunOilhPP3q4q06kWUnOagwpb5v8n7WTATrcOkhelvyKZj6ejoquJ2zxDEKn0YDkFa8h7t9dgtph2VTOjOXetW3WtUn+9X3OjQ17AcgnLgKP/sM7EoTJs/Xp0N63XwM8M79xODwz+2YTl+R+tslnZdX7x9uaxAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq7LrrBn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq7LrrBn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so10200775e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533676; x=1789138476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/JbBdz368b9964VnW5n9v0EGlaen6tXu6qawPHYWGBI=;
        b=Mq7LrrBnyLqd71OfFuLGy646HUZ2usMhGEIR81g2nApPu1yKjh0zmcQ1Y5jbj1pcPp
         mbn4hGmYlpHb5h/qxBS3xnO6xdBHVaqR/FDeHF7icqkRHU5z3zNxCbld7bYQDcqm2qdL
         RBZBT+VNmUKyqdg924bgpdpJ2oJrodu8uxQjXB28CpgZhiiYrCYxLL14nf+dhC6nloVf
         T7RdXjynd+Ax+/8kA40UkCDFeJ+QimFzmXpNs2LuskmCsC1WVDoSb3qsGXnH86zjqWdQ
         ogZj9rh9maHtPDzerSw5DgHR1l8D6Xtia8D/lWWZ06WybDsViUK/lMzJfVtcfpx0AVqO
         kM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533676; x=1789138476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/JbBdz368b9964VnW5n9v0EGlaen6tXu6qawPHYWGBI=;
        b=D3fRWCzjCWhRzOpGrsNs93QKULDjg4A1UEJJIWUfwzEN9sKoI62Sh7KQAfS3uTVTBT
         CS+Goj7H1YKA1F5Hdbbfi+xmkV7H9p1kHwkxPCLPh1vCCemFOywKgeB/veudKjIwyJXn
         wEx5aFsLs2743CljdlzVW6KnJ2ikTXRSoXBTzVw1ktPGoqzWOrbIi67Vt/lQfSwJe83U
         Q7l0W5Teln9As1BJq/8bvKZnfbE76Atv6LannLh7ITB2uve36xKIk7BMZf5rbTeZgEBR
         DIWFnyzO/YZiJu3a6wLlNaUbU5a+RCsjY0tKrpY0r+HMhbO0JrqupXnp2lE6fOVHu+EZ
         XASA==
X-Forwarded-Encrypted: i=1; AKwUvBzv7grsMq7dkevKCzvGzsnqkahTGRmVfTPb5xB/PAuCpO0Cn3y+TruoNJGtEzqRG9QrNf1g3xeSVFhBhjva@vger.kernel.org
X-Gm-Message-State: AFuF++nplMBpcL3D4c1rId+eJQVbX6xQunmrnzCyp1Lzhn5m+HD+w7lF
	zRyi9PwlV7lRiAz5kQ8G8du/9T7UUCkhI3C4HgSytoa2Hv3SV9AQt3Kt
X-Gm-Gg: AYBFou2SeSWpM486gqK8urZ/T3Ue5Tj294zFX0de5RO3bBfWfaq2gy0wLWmzLCoDA5x
	CeO3AVtIrw4qZVH3/kzK6N6M8THvGoS0/E/mfrqBNyhitajQaex0fY7wLVlJdOBn9UXXTgxIgtZ
	M1eZJw4hEJQ8Wd2YE+j5jWBi/47v1cYxTSEQpdGEzu0SCnBqonM3zqTMNR160sopLrs84b6sV/s
	m0jAXU0R3UPmruu010ctHgkM1khFoAokOYIqqmQQa/0TeFLlUM8+UHdY6MrrSVVRCOqfA1r2Z01
	8fkhrWHF0Zd9emNVPIn+0rToUjcw2nKatnfpGTst3ZFzTD8RQjzhXUpvQvafIQnnUHSz4RkfcFJ
	ze8ncxotYHd6fRltivPVoMS3adhNqAK/RR35nlW1VrP3YjBZGvDMDVYpK3uaQHTljPCQ1fFzNQX
	i16H7RoHJD7ybkQWuCnsxPAKmtKndIlbGGQX0iyqCc8C/DRfS8nJ3LB38gkT1+8XCEpPo+Ms1v0
	U3qPmH5/QGT
X-Received: by 2002:a05:600c:4e90:b0:49c:f3dd:e166 with SMTP id 5b1f17b1804b1-49cf826ca60mr61264505e9.13.1788533675701;
        Fri, 04 Sep 2026 07:54:35 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885cb03asm6802799f8f.37.2026.09.04.07.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:54:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 6/7] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Fri,  4 Sep 2026 17:53:39 +0300
Message-ID: <20260904145340.40212-7-tasos.papagiannnis@gmail.com>
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

