Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893B3E9C3C
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344735; cv=none; b=tl5jfTnITO6HIFukY+ph6VvYcy4qmAZfMSNMSqGLmkDH/tnQZbV1OB7iqcCq384yjtikQePXVQifQW+nw6hUUjjWvmqO3BZg7Mb6ggwdHrXkCUrq/Gl5iPI32jZfdBwPqjV6ZoSCJJIDlJa/Y2k99Pr8wa3II4HjNFOgYQywfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344735; c=relaxed/simple;
	bh=ygQVGiHSjT3tlHXRhpAp7oFN6VeF+Ph6/YpTvlB2qao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLoUMZXZzrx+AJHLf/8tCN4oVer8EXXWmyv2lazwzXFTbcZJsKVHZcBnV6ETcwFBYBm9MkBkN1+vpwOvQsaILx54lEJJvUsPyYaWefSG0pkYG+3dD5Go8O1V+c/si/1U1rD6SwSiLRScEZ/fAtOyeMCgdx06qhS+XTq9SxK+GMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=jRzxDwpS; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="jRzxDwpS"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e64d52949so143339185a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344733; x=1792949533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lvj9KPlOdCKDh2SaywkpdHWEJMa5bSU8/Juqep2VFU=;
        b=jRzxDwpS4QFIeNa3t3r4R3g0dnYHcvl1oMlcY7guyN59yF2ifnwE2+yQFMCnptaF2f
         FMOdUqKpmNqodKPgfE9aeIlCst4ypWNReve96w2zidoNsoMgvlrZ62tDSAZkoAnUkHrS
         maZKVMl9OB3gUHfVTABLM1WlwFr23O5Vr6i3uLIQOPgxQD9AoqAZeHsqsExVRz0BHegX
         U42B/Z/pIuznJgk4dtOw85ED5gyGs4QLxQ/UDDr06Gc8MFVB8/zNm1nW9Wy2FCjtfi40
         gX5nTSKOIR794rD8+bjyIpXQuVQz9XvIxPNNFa4TogJnhOcylSKe31U8To8ibZVlLIJ6
         kAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344733; x=1792949533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lvj9KPlOdCKDh2SaywkpdHWEJMa5bSU8/Juqep2VFU=;
        b=sr2oCUEqk+vpY2mvlRzlXSs+l9RFLQT1pNLdFFdG9nD1pGHl+K3rfiH4Ifx5E2jQ89
         62nLwemtjniqig7Dpj+FfDxMgruCTgxkp8dX0ful+BtISgtAzSipPZ+uSILlR2X2ZNDU
         k7FJDRTJMje4DTdbbNeMSgFqa4467NJIkl+65U9F+bbzaw6eaXHIzcjsowO6QmlN0Y4Z
         cwlVV57sG+rDZtKd/wsZTSMjSbabgSCOGawaKxhcvThp7gBac1PRq6K3u1rErufK3QxY
         G1W7yaA77mij9PQhHLwMSPkQccNe9F5dtmiK1+bBV+eQ/4TAzfJXPpmr2tUTaiAcosZv
         kG+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxvR8IuZvUtp3YhdNjwfNU2+nc6/yjtLwnnU6Gdf1LjsylnCGQvNwLxbAX7NwqiUvKrH6FPNikRbsEQc8St@vger.kernel.org
X-Gm-Message-State: AFq9FYJqi+ZfBRLJHzhsvrLfXOVxaTHFvsseNUHGAHAFqhPS2vBlewoo
	QDiDyAmQg9m2ZZLW3UhnkKlNTVCROa5wBKbj5Bt2bT9vqHerCtbCi2EDNiZqz06FRp0=
X-Gm-Gg: AYBFou3QtuquESOBG1ZLMu0IjapA79AYSgYnt+tekuklseGiYX4sXttU8f5Cphn5+ho
	X5AYmyZifi5HRGmExKFun7RpcakUroi3YF7HjtA5R7ZXoOHW9Kmb2uOVTxiAmSLN5WCoSQiS5ll
	TGrUr7yKLNmGOTdwE+HgR1j/Yln9QdnZWbHbx0MEegEzzWZObEL7dxdgBe2n4y0mU4JSJlxjK7i
	Hp5DwBZa9uaHF6AMxR++e+RP7paJAdnD/SSZ9SZ+draqoOZX5aa6V9nnRbCaUjMvFX4MQyEASpd
	7WV+Rb4G9Fd0v3qKIj1dqXI6p9WV1dEWbONfp92at+g4Hw/V9cXbNredkp3gJOywoAQjfj+cUpW
	ze3x7+a9nRVc5jzxklXyYjWu2fopOE67VNK5tisGNiqYGRKfYvxYEMd3dCMT7rMMqbtjSX3ODoL
	vE11fl9Uv0elNaZWEpBgJ+b6mwb4tb2E/1Hwf7Re9fcaa5XOWtdyommmvuPm6Fjymd19+l7bgsh
	/WETqriFMdxPNk=
X-Received: by 2002:a05:620a:450e:b0:93e:fd69:9a93 with SMTP id af79cd13be357-93f29ce0b58mr1042282785a.31.1792344732608;
        Sun, 18 Oct 2026 10:32:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a192378sm750188085a.25.2026.10.18.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:50 +0000
Subject: [PATCH 08/13] sys: use cred_ids_allow_control() for prlimit()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-8-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=1001;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ygQVGiHSjT3tlHXRhpAp7oFN6VeF+Ph6/YpTvlB2qao=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKizJZferVr8QroxUhZYbmb+lrebZ9hLX+lZnG7QE9fBnd9BWETpFl17MgWZUR/JeH4CYTm9yy2
 jgPxRds7m9gE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

check_prlimit_permission() wants the real uid and gid of the caller to be
all three of the uids and gids of the target. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sys.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index efef06240a8f..5cdfb6b8e485 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1713,12 +1713,7 @@ static int check_prlimit_permission(struct task_struct *task,
 		return 0;
 
 	tcred = __task_cred(task);
-	id_match = (uid_eq(cred->uid, tcred->euid) &&
-		    uid_eq(cred->uid, tcred->suid) &&
-		    uid_eq(cred->uid, tcred->uid)  &&
-		    gid_eq(cred->gid, tcred->egid) &&
-		    gid_eq(cred->gid, tcred->sgid) &&
-		    gid_eq(cred->gid, tcred->gid));
+	id_match = cred_ids_allow_control(cred, CRED_IDS_REAL, tcred);
 	if (!id_match && !ns_capable(tcred->user_ns, CAP_SYS_RESOURCE))
 		return -EPERM;
 

-- 
2.55.0

