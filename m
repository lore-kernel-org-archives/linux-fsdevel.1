Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237803803CE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592163; cv=none; b=Y178Q8cU7rYD+h3TVQcHf6/WoUYrvdAG5TgXnZQkfu0i6h3jgyT4xuhna/EMm4xyYaMe0Ggin2TkEM8yULZ5omlrjKffWathXqpzqDq+2hJbi3ahyLBbUBG7zbHrDB/nA8J+FcMu+3pQ7tjJXZmIpwjJ/I1AO2YeW78cAVQr0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592163; c=relaxed/simple;
	bh=gVNxQNlmrNpqLDCY5JDdEWaKN3Ea1LpqggVDjFURMJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECbwLFq7jvqz7W8rMDReMtJZ7cNI2TdH3VhW/h+ZldAvDCGL8P1RvmYa+cm9maWCX2DN0eLZwAMl1x/ncJEnXD5/24Vc2ceUgtZVD+uWkHy4n26jaZwAE1S+E9DTnSxv9Wv7NRdlFMSraX9JRC+RlG/JxafaO1yEBwh9Xez5lOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhSyMzX/; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhSyMzX/"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64eee7b83cfso4379141d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592160; x=1776196960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9ku3GPB6bFwaemZLbl5e5kdGQm1EBbT7DCrdV6VHPw=;
        b=lhSyMzX/BypT3IkLcz4XtxywAllYQmzqo9y2QsKEVqfCqLiK2MklYX4qK274TMMQgj
         nwOhTAA5F+/+MpwN67rg6MxrixumoP/4wMZEq67wKDd8VkoJoZ6K27rZFOTpqCIKHjFd
         AWIfZzK9CU30nqebPKFIHGO3zYZ5GJl33nFJfqcQzoH5FehlsLE9vxhcDUR7Sp2U1utV
         MzMRoBlUs+ouuV9ToXfp36+eNax2j+JnWe41yfunxNGoN9dvFlufT9LEURYYlS0HdNZw
         /VE/2zUJgF2tZU+p2DGgBhFQoiv5fbKJKTfYFcoqR5S6K/sAZK9IXyL8yEkUcx237At0
         AGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592160; x=1776196960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9ku3GPB6bFwaemZLbl5e5kdGQm1EBbT7DCrdV6VHPw=;
        b=O9mMwrkRDC8Vx8vIwPd8jWZGxry8A8SeruZlhYRJ/mvp4IXj84FMsLVjM/KrqNsYft
         9gBN5WYzs9q7AvFEiNN5bIpCFNeJ3qyBa2OhSxbEi/XcZGphrOuec+HPBqHIAQ7N1cPn
         y7qC2lggTKIWIPx3WQKsmIiYg17YAwhMSDDRHMtOb4Rk8bSSEh71noLRz8sCTy71Jtn6
         +aAHf+U0//tS+p/xgD2TSged0NVEKveqi65WJY5TYVKUxhdGndWNmSwlxSe1Zako/HKf
         rIMweIM3x83aB79M23+1144N8TF4cvgjKu/v7m3BrNHnurFuWYRIlYSZtgJPovZK9S2x
         TX1g==
X-Forwarded-Encrypted: i=1; AJvYcCVKlUXZBTdtxtucxHbFnbWYEXT6XbKqp7Q68KN80+w2DstwTLiegO7CA0sHdjdLDvDBhflgmd7NslcdAt2H@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWsSO8HrXP/lyQEJm0Z/bWt8UTXoRyzm0hqyNMF5sCIyog4AA
	PNKvYMGbelGEcrpLc6XgX260SgHhZIQupHsahYJewRCvJGl4T89VW8xh
X-Gm-Gg: AeBDieviKW9beKNvbaNH0gh/O2nO4RMYoA4/0wfvI4VUR8DUMF2QVIFCaabdxgMfRjd
	jzUtHwB3o2lUE0sgeE4GodsIKcnR7AcUmayJNZhbTQ8gvIvLrHeWn0xfdJUs86HMxAHVuUWxt64
	emgStRjpP12WPUMWsPJT2vDDL3bo93husElkFYWVaQpXvGdlwHsVUID6NOBlIX4ArDgfX1+2SUW
	maYN3WPNJxAK+wmXtMgRNM8nFG+fLdOqvROnXuN5bMxk3s7aNCUJIb2Nxq7hp+0Tce0sFKdaCOw
	D1H9okVqZNjtL2Aqp85rxFr9/29lASFNmrZ1GjiJiupXXkUTUAnqnkFU7490CwHh2j2dHb+3+gu
	HgFBlcrsQXva7V8R9sR33Gy69s6lHdjYTsQU05c+5i3Ef2qrrWJGEhpklE0vIih/Gx1XaKhdufp
	31WLuuFiRCqPbjoJslqqkZG24eiMlZvmw+RTMtrM9Nx/BqLgA8qXFgf0kZoz7yeMRrsL06rN5O
X-Received: by 2002:a05:690e:484e:b0:64e:8a5f:2f1c with SMTP id 956f58d0204a3-650486bf970mr13046607d50.12.1775592160273;
        Tue, 07 Apr 2026 13:02:40 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:40 -0700 (PDT)
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
Subject: [RFC PATCH 13/20] selftests/bpf: Enable Landlock in selftests kernel.
Date: Tue,  7 Apr 2026 16:01:35 -0400
Message-ID: <20260407200157.3874806-14-utilityemal77@gmail.com>
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

Enable the BPF selftests to build the kernel with Landlock built into
the kernel and enabled at boottime. Existing LSMs
(SELinux,BPF,integrity) were moved from x86_64 specific config to be
built into all architectures.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/bpf/config        | 5 +++++
 tools/testing/selftests/bpf/config.x86_64 | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 24855381290d..8eca3773e968 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -115,6 +115,11 @@ CONFIG_RC_CORE=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_LIVEPATCH=m
 CONFIG_SECURITY=y
+CONFIG_SECURITY_LANDLOCK=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SECURITY_PATH=y
+CONFIG_LSM="selinux,bpf,integrity,landlock"
 CONFIG_SECURITYFS=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 42ad817b00ae..8a6d2af3805c 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -126,7 +126,6 @@ CONFIG_LEGACY_VSYSCALL_NONE=y
 CONFIG_LOG_BUF_SHIFT=21
 CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
 CONFIG_LOGO=y
-CONFIG_LSM="selinux,bpf,integrity"
 CONFIG_MAC_PARTITION=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_MCORE2=y
-- 
2.53.0

