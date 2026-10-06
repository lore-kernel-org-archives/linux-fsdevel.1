Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A625EF87
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246042; cv=none; b=lBlrM7C/Ws5YViaRbF9mbk6jMNmeirDe2UqmKwVFdIf+mkHdXpBJf+WTCwm+zDigAPX0MArklBEKseGbHj65iSuU9kjEIEih9wItcPQWJEAUa7nclmOZAoD6vh15fDE61ZG3mPcxDHJPjxHm4ZQhvikNQYjDaqOrA3FcGvKTQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246042; c=relaxed/simple;
	bh=y13XcqrXalvPlyqorK5jhgilk8EVXf5xHNq9KHtHVwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+Zxk6+wv28em/ygLUtKPj7FyhqGXjsOPQpj6vWlo+n42aPPLTXsU0ZF3kSGFZgKH2tIPe2h6gRysxoYqglY0J+MqMPIbYiKjDfhsnAheC1XU8urquc52incFqkSHxMyhpx/eyeR5/kV6ZCGBd4At512Ie+PP72t4MEMXx6k7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6In4wK3; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6In4wK3"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8acf578ba66so8727707b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246040; x=1791850840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvPSFgeEpLGLZYk/CFPoDi6u2PEbfv8+Riz8KF6NXE8=;
        b=f6In4wK31khh7gR7nKf2NLpHJ5j0hMSZQntP6prmgra1EnOaaALBJ000wWm//logde
         2MJDXyO5Lj4pFD2ggilYnI8XJAYOyDFVk2lbO8s3Lme/tq1mqQD1AvGDsp5oi09HzGlR
         pWMNB4MxYL+SZGQ/E9pHrvqHf3F06kKoQtRPAbomXP1aw0o9gUzDOyHuqCraPbttfo1C
         hWaODzLeVzCJvcO4OWivKsLkI4C0oE991grBUQbhQq0ZVpTRwpKEgAGIokFAYXcSF6uL
         zTshD+lMGuM6X6EnRkeHloGwgTpJ1r0KuDxgwCgdh77OfweeKLcY0Xgm1c3J6+PRzHOu
         Muuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246040; x=1791850840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OvPSFgeEpLGLZYk/CFPoDi6u2PEbfv8+Riz8KF6NXE8=;
        b=Momq5aMnUoS1Qoyz6/88qVTmtbPQ0/mlptAgL3PMQ9oYVnL19rZ3er/t5r9Y0wzhsL
         AlbMsoCx7FL4ml6Te4mdr7CLMdDyCJRuHbPexw8PfJF/qFpGS5iS63n4seoeBmJuAXAq
         hWxQ9HK3HOfH//5W6askgQt/263pbO7BLerzLOHNcsU4lRQ4D68F7EFy6n6HKNOpDom9
         hKclej0o5HzZxxBUQ3iVdiG9VVkygSJvrU1axej7EefUJ+QQyTDQmq83blL9trREEE92
         2xTtUhdCL56Zkz1gc2T1bTy8Op9Cx3iNp8p8wR2LTXyJv6sZxRJwzTEWrok4B45fZXs7
         R5Ww==
X-Gm-Message-State: AFq9FYJ3VSGGdoHcVafn1avSnMFS2tMmCu+LI0MkzXQu2FVJ69dWMibD
	0kR0vbSKPcy+wYU7newympW6eNTOIpc32bpABlQBkyaB5i/qDl1TPx8z
X-Gm-Gg: AYBFou2mtcKJ+Xv4CiiJA+6mb28PdIJa3talzcKtR/o9QH4feOLqbmCDE/Bgn9uqu/b
	uoGkWiwbjIoZkzRTDVbjmr5PVsqx8rdRJ469Jbkld9dVQyWsaH8+htX/Tbqvxdc5gPmKcfKqtz6
	ooIRh0yq4rTvFKz5IgL1F77dN521nBmn8JhoLdlGDEAvpIZ6IrfbiTr+ES/9qiD7I+q+YE00aoG
	jgvoZxdTrQFfQa30klhGUhq2nUBAN6t776/VGSEobtBF9iiVygBvzN52Y8yr2GSkBQn5wYwoAtz
	mOF+k3cxfHPSH7FrlIYACu3Q8JNgH2vedi+AYZ9fJZZmVta51UA4x/O6bvY1tjuanAbHZ8tpNjz
	cTg1l8EVI/9Z9y4hXAJQ21u1lI1EgkYtH7reJdJltfsaOYQljRx+zOqNZ9JoKHlwdTUIZQDFMT+
	Tt2GwF4Lh7VTOew9s0UgezJ15TNw/B+XTgMBN52Nx2O3YRnrT+JHNolL+uT9uL60kZUlwaeCH/y
	A==
X-Received: by 2002:a05:690c:5809:b0:873:5c6b:a327 with SMTP id 00721157ae682-8af71ff15a8mr3855077b3.33.1791246039798;
        Mon, 05 Oct 2026 17:20:39 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:39 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH bpf-next 04/12] bpf: mark struct path trusted
Date: Mon,  5 Oct 2026 20:20:11 -0400
Message-ID: <20261006002020.2890858-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006002020.2890858-1-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Walking a trusted struct path yields a trusted dentry - a live path
never carries a NULL dentry - so BPF programs can use it with kfuncs
that require trusted arguments.

Signed-off-by: Song Liu <song@kernel.org>
[justin: carried only the verifier.c hunk of the original patch,
 trusted instead of trusted-or-null]
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fd3c0206bd67..24ec4b037de7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6300,6 +6300,10 @@ BTF_TYPE_SAFE_TRUSTED(struct scx_sub_detach_args) {
 	struct sched_ext_ops *ops;
 };
 
+BTF_TYPE_SAFE_TRUSTED(struct path) {
+	struct dentry *dentry;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
@@ -6352,6 +6356,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_cpu_release_args));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_sub_attach_args));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_sub_detach_args));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct path));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
-- 
2.55.0

