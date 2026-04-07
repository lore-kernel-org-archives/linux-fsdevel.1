Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9D37DE84
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592154; cv=none; b=PLhOohqTPnMs44ULS+BzkdyeDNqKOnWEGxvNUrGxo9oka7mBFiFIHxL8N3qWFhwp7afLfqItuUq+FNTv1CIL+p4D7vpd8rgxc51ZIIhaTneqTc/qH0ilLM0Y5H1GZHTkBsTroX2Xw9kodgVTttWoSLdI+OoTMg6xEz94af1USvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592154; c=relaxed/simple;
	bh=1YZm9Km2g/4He2abMJUbVPzWzEAy6t/GkzsPI6yRllo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEQS86OP+rJN0IdXCX9YPNMH/thf4aFG6DiupQWPBAynhoT073G6Y3NVcdkjXERuQUUGEsu8tVKGbMTq3rB0dVwP3JxZmP/OK0Oor+j7ss0O7ZZ2VykoACIlOoKj/yWbAkDhTCxEIPYJJuPK3Wwvpb0J4oQGISv9N89AIrmQjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1hQoGnJ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1hQoGnJ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501d32b04bso6088936d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592151; x=1776196951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxZmDGuH+b1o7aqh0lLdFfHGJTB8lb/1qma6OWy6m8U=;
        b=A1hQoGnJAesUcu46FkkvREJrsSP0xdvxPZWVSTNQMtU+QBo2g2ipB80ZEfn6/DmDvM
         Ss8OT6KR/dFarp9R4VpnYk1MDCQRby5EdKwqmkbnci0tyJ600mg+ukUr+K24w9L88nvm
         z4h3xjBPycKhxntAnL64ShztpOeGpAkEoPcRCc849Quc2SjR5xSeGGJLA1tAYloTJdxT
         /+qFrAGOYNToFQH+Bq/8/d1HxyfLk3x36vGZNci1vjHYM7RnUVCc6AwIzpw1fgBs697Y
         X7EIO4TDmrtpFn27qsGAZAHkskmnnJeL2+nyISBp4XjW+NljueNapKnLdq197PFjf7aJ
         LIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592151; x=1776196951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxZmDGuH+b1o7aqh0lLdFfHGJTB8lb/1qma6OWy6m8U=;
        b=IftHClMDF+oaDNCz4v4O7mRlwR64MKM0Cj5NK83iCQOrvShIU/a8fhLSIybZs2wLsG
         kpLSTeU4F8B3DleV8uqEJo8EO3+dDWSgWAnsIWfH9aw6RTtH9gCJxVIb21yE2mKNP0xf
         lXoU9jxwKWwzRj6i6x+ofc2nzw4NoXKPozboGuXYYLj5LuOls1NfxTszkiYjLmJ5rZQ4
         HzSlVETukBK2TikXBWwPGLK7AZUf90YAtHDhqEaK7+93Z19q4Rx65NNOe9OlQ08XH617
         aY8tl5n1yVWSUSvY/bXnLlPpLhWqOQa6KM1u7tnboC0uUYyViTp0FyyeVWo7HEZ4jn6h
         uwjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJifj6Xcssx6cl7S1+YzWCPYXUJ1SxkkaPSiyuDZrrH8QZ2OSEv7ZZcLaPpBMMSZcJXAcvLmjN6hUx5PlW@vger.kernel.org
X-Gm-Message-State: AOJu0YwGT4REkJzhKaRJ3B41Pw5zYEitGTbgs9cPm3dhgTGNr/tlbv7G
	Wiljudgs6A/qgkOzNr53SBhHVh352cDMxYCcK1FTy0Dbc66e6SRhaIoH
X-Gm-Gg: AeBDiet2D6ORd/6APo+ZySCtAQI9AL+F75SIdYlKhQzP7LpscX/D6eU3JJAS/0o4Co3
	W1T/npINLPE44bRb35jDkM2gcS3SwtuD60RK20aSuOe2I+8S51zmp6cCZ1N3xFNaIfQyMiqPRVS
	hQJPIr7dylh+H0a1FT348K4G+37+lZHwDEBvknWD+Dvtd3z2pTQn4wLXzbLSk6r1Nb86xOLvIcO
	WxxOmuCbuCy+tqwL98aMM4WlDaKYMSShXiav04lVVQhYlX6639M0X8T6mtUDnmFAKZobNzmNvg0
	aWsVZQ/mFpMTq+xh0iqyfrV+p57RGZBqj2sZtV50tdz0dc8VmU8pJhPEOkHfyfDcuCgrg0ECL7b
	ihY4lyhM3GlkxW28DwKydVgLJMvAk4FsMvd9d1vjTjb0iyyVKTQAGQD+vPgMGDM+yye9ew2E9bR
	ET1X/M75niusYm2yS8QPqibB9WzCDhTkGe9iRFQ9Mki7IGWL2n0BAKYV776DGvbvSm0SEzmGxh
X-Received: by 2002:a05:690e:c49:b0:650:77e5:84e5 with SMTP id 956f58d0204a3-65077e58678mr6105788d50.25.1775592150185;
        Tue, 07 Apr 2026 13:02:30 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:29 -0700 (PDT)
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
Subject: [RFC PATCH 09/20] bpf: syscall: Handle Landlock ruleset maps
Date: Tue,  7 Apr 2026 16:01:31 -0400
Message-ID: <20260407200157.3874806-10-utilityemal77@gmail.com>
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

Allow userspace to create maps of type BPF_MAP_TYPE_LANDLOCK_RULESET via
the bpf syscall. If CONFIG_SECURITY_LANDLOCK != y, these
programs will still be accepted by the verifier but return an error at
runtime.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..e885451b64a0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -48,7 +48,8 @@
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
-			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
+			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS || \
+			  (map)->map_type == BPF_MAP_TYPE_LANDLOCK_RULESET)
 #define IS_FD_PROG_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PROG_ARRAY)
 #define IS_FD_HASH(map) ((map)->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
 #define IS_FD_MAP(map) (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map) || \
@@ -1488,6 +1489,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_MAP_TYPE_CPUMAP:
 	case BPF_MAP_TYPE_ARENA:
 	case BPF_MAP_TYPE_INSN_ARRAY:
+	case BPF_MAP_TYPE_LANDLOCK_RULESET:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
-- 
2.53.0

