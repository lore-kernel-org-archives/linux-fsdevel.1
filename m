Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAE37AA8A
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592157; cv=none; b=tsflOgKRn0dDlcffMhXjxaaN17AI0jS+Yqk2FBG4XYKGSqqnp+wI6yf8aTxcCHC5d9ecZVg2E4OJkQfe102k0gTkkKaC5IrRlmkmVV49+VriJOPNIV+RWUNare6vdGjvggfBDpGlSuguiazSJte9jeO3uYO5iPK2YK96P3+IBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592157; c=relaxed/simple;
	bh=969N04GJ63B6j3UvBpT8Xq+THHPJF5melGvVjbfv/jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koQnrbJ3HPlfI4rizqaL8fT1xVsG9+gCc/cGAccCCKSnFoJssGa20+k+Uod0Ne49qArVJ7KJyIEJyEf5ITui1OiaSOb8wunNcpDdzs7OlqLcXQZBX6HnSAF48fdW1onAf6g5wrkD4MAejve6AFvERkuuD/pTh2mLqKrkdS1KOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spWqyiDj; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spWqyiDj"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65006c99d38so5987185d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592155; x=1776196955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh9HwIL+CvvpNMQ+fa0HjatniWcHatd9mVcMTjGbHyI=;
        b=spWqyiDjKcQ76GvS9Qi99Hn61LwzbS++wKhAPzlridqIFzKfA1ld25/YXV89n4mg22
         xmzPYZf9KjaoFVvry1OHp0MjGXcgHO8L+9LGXczqji417tU5ebWeluzX1ao2Vi0Cmjuq
         4t5WCv/a5mBZyjLy5jNzVvc5MLqUbsFRwWwF03E4g17tGkZpZGtSmxp48dw4dlROoE7y
         qtDwWJjaRnYVM6cKu5rgmCHRAlQfPtgPqpJ7Bku1ML4XOEqRh28YhG8qG2LF2b9UloOv
         esMDjao0zUfe41Dm27hlrCUL/cJhuh0Mk3RXdAzZYEIZneuK8xxcNmrgubNDox51uhfB
         RUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592155; x=1776196955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kh9HwIL+CvvpNMQ+fa0HjatniWcHatd9mVcMTjGbHyI=;
        b=BKTFR9O1QO8hfP0STuI8xgM8PE+wGV9Duh9L6lyC7/ixTDGp3MiqlKZENNNhfqrUSV
         /EhHMDCCBY9eoHVycrKivVaCLQvaslU3CStfPF6a5ZWxc/RtCiXSaeCXtqRRuHBtk+ze
         p/SlDP1Jkanj4s2UWffLWkNCBhnoI7jnpts+7U+SClkl+ULJQgIOclJSTJ4PNSgMmLlB
         zekn1GUaw7YAKEXsilGzKdTb+HxYGIan6TND7O37KkBCmSs2ZH1ewvAU/pLNgcdsRipo
         8f+iK+9OCEOFCtikZYypZdzEaMaqEuQrwboOBZmixctpf7lxNsg9OXg1vFaqNVlTvIu/
         2uYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmcBtWupbDOPFQvTAIcFQYdZA433KJ18CMJC4e2v/J4TK4YYoefV7v92Xgr7NwF+1fnHn0+mtR1Bxb8qOh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+p2OfeVnnc2fzIh3Vw5u++pgo0EZOlmi2OrN5LTMHFQ7dzQZP
	G8ixYfYsi7ImkOjx1ziy7nwN3MPlPvUtOF4gJGHDPB4qhqRQDMsiduMH
X-Gm-Gg: AeBDies3i/Y4KG+NXWf9FApLoCwp2GXzDBw7PwX9uz9rBTzX98YAMTdrmLVtIe4CkVb
	4/CWZU3jlv1m1PGlnhQEyuAnW/sgstzUWld/qrevfoKNeBVeaKRqZ3/SI2XT3dK3XTeTahyMgvP
	qkbhQfB7apqSFea7j9+MCbAhZql38eW7Vq4enXZwHBqUqHGoc5NdBnozZtADiDmrnOnxr8SSuz7
	XGtJE8QMYGs3uBwOBE0xKGJKbe57bfewt1DMMUGg88TEonPDRXjv/ged4FmQVvpB6qgW6gqRzhr
	7wlebIjfb4m4QIGnnxc5bu88YKsmbut/7bVdXp0XXhgZoq8f3Z0dhQyDTm/IaEuxMP65tdk+1H+
	XSsqo12yoRHcpdCA/9peQ+g9NYVC2OR1OSufgLJn46YYUDyDPihUEt6020aTPIQrePKS4iw7TNL
	bi+APCQzszZDB0iS3bG64jJj7Lj7xnJnYfuuFQeJx5fXqFSK3jHYjVYlQsoW4Gus7tG0rDfWu3
X-Received: by 2002:a05:690e:4812:b0:64e:c641:d06b with SMTP id 956f58d0204a3-6504869ce58mr13854064d50.6.1775592155586;
        Tue, 07 Apr 2026 13:02:35 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:35 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 11/20] selftests/bpf: Add Landlock kfunc declarations
Date: Tue,  7 Apr 2026 16:01:33 -0400
Message-ID: <20260407200157.3874806-12-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the Landlock kfuncs to the BPF selftests.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 7dad01439391..00f2b337a232 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -79,6 +79,26 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
+struct bpf_landlock_ruleset;
+/*
+ * Description
+ *  Put a Landlock ruleset obtained from a Landlock ruleset map lookup.
+ */
+
+void bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
+	__ksym __weak;
+/*
+ * Description
+ *  Modifies the credential of the passed binary parameters to enforce the
+ *  provided landlock ruleset on the new credentials. The ruleset should
+ *  have been obtained from a Landlock ruleset map lookup.
+ * Returns
+ *  Error code same as those returned by landlock_restrict_self
+ */
+int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+		const struct bpf_landlock_ruleset *ruleset,
+		__u32 flags) __ksym __weak;
+
 struct dentry;
 /* Description
  *  Returns xattr of a dentry
-- 
2.53.0

