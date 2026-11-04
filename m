Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802315;
	b=YRik/x7G4Qu6lCMacuDCRga+0GUrYVp5fexix8aQRqWwZJ5U2R3Yw+t3qo48QjBO5Skg
	 CysIPfRhBg86abB7SErNF2Lf6oYzZUGbx3HXM+3NCw/Bz8WsrTkYcjDECpb6OCxloBMse
	 kEmEqeUXQn8suBnXaWmgsN/pNCTs74t/weRiP1pSd/grvfwIH6xpHIS8GMLlt/E4ZwBZh
	 KZLGdZQ4G0ExU8dTbGQFhkzoF0GxG1BsF/XqR3ubtIjPq7UE5YYTMXIzzKWBI+L9hQ9TF
	 3c5d95U9z2WbYjpTzwKZ2mRTh3a4KtRZmiJo5jBxSNtkX5thhjFKvVk88fpD3wJ1fbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8SqVqOor5x0swrcQlWs1oXfTolSQ94eqY4/417d2g/c=;
	b=Y/xfoM9R822R3pdNkqUkj9Z8d6VH6EtOg+p6a0RSePgrjP0gRdtA3WpD7yfdZWb5Cdig
	 U+O9Ww/vWDQJOfh6FCoa9DON1WtdAcRcJqrZ5K5nJXKUcD55gIYhLhPfgG8/veSSrHd00
	 CScNR9lcRSTxYDOAErjA1jtL2lIqY/aWbnMY2XmOpBBOzXx9VTrDjsS7320qFrZ4/1P1p
	 5dbQcxCc5hNv5tyDlVwlY+lD9gGHRqe2qjNeELaWQNSdkIp4CGL45ig8dtomivYooNTuU
	 mxCRB7ZmQqkwew6moLeHFyvMyPWEMPJMSX+0pjgjJPdsGTeSpw9EF6pSdcMGDzsvX8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TIBS42R6;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CD606A32E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007CD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TIBS42R6
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f22a8515eso74986385a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802314; x=1794407114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SqVqOor5x0swrcQlWs1oXfTolSQ94eqY4/417d2g/c=;
        b=TIBS42R6gagObM3Y6q6MqKNHybNEVYTgSyBBZ65hsLXrQW7m17/l1FXh0IIMSaRa9l
         2HGpeP60Qr2rWKIaivxQnGpJ2JsFRfb8oplb+qL1Bok3a9S46wuu0sB0ajj8Ukged+Jd
         pb3jkmdT76RsMMoxdonkRO5TInvbhhS03LbId8qazKg9pgvhGuH/Fbdpc5fOMQ0g4TtD
         Ms5zGTB4+J6EFElTLuVGl2rID9ixM4XTaCljd2CBc8cfVmmZHHHtmz635XElcGJVAwN1
         7Q/a+LL0kxDgaUSgcLMEiGvh9cvtdtl0UdXCcut04sGDifS9aZCL9SpIo8BCiykFGyIV
         V31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802314; x=1794407114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8SqVqOor5x0swrcQlWs1oXfTolSQ94eqY4/417d2g/c=;
        b=Kc+nQeyzaWixPSpRGqvcpD3syoHEkmCvw3OFJ5EZ2R2Dr9TY3PwPjpyCdxn0KMnDO8
         70nv2eMyo6FiGFvFPjqIpZGB7oLpcXiSYwxrjl43pRl+DRWKvqg7U3vcxB13jcWJpyFY
         v9tJEEX+f7k8Q99bqyh+3wIxst9LoLrAKy6IV0Mw0QyEcfydQLmjpQcBz8bPDjdjm02N
         03ddLtQxGCbI3lfTJOd9ZR9P0/0NDHEoLSDWp0MQ8BkxUs3zBIg5yCmKZMbchQln+Bcy
         ekl0t2WfyFWvvfWF9aJbzu/Yzt4jB5D/qeP00NC8+2bBou0E9rtKF3D1JA4z1lo40Uek
         xoHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYk6h+fpqBM062TzbeWY56f+BbLfLj4yg7kcjWry29AOX6QNKf+DO4Vuy1fLwf5043DCPOGqs1JN12e7Up@vger.kernel.org
X-Gm-Message-State: APuU4Z8sv1Ppz6EFsAKcDwkZoK7YFxh0DtB2Dv6NyMydTjWFXsN5HRIB
	PA+lB+6HTnu0hQY2m5nO1qwqwHZP/aNMYrhJesCgeGARwVvBLdNGG8fd2Ri6ScA4nrY=
X-Gm-Gg: AYBFou0p/z4dnUJnvJQboCcR0lgggj1iXg+xHjPUHWs9Z2f/ZFyTVkhOsLnhtMhJrBM
	uEJN/HUT8TmFLCb6oZrkXCLY4wVjTwKoYQn8R9TvraOLzkKRN6Dsur3F1V5f4M9TBsyvMYt+6K+
	jOQ8aDl+GilbX5U9iLWPscvQM8V85pu9zz+3pPBwvYmOwyDb/P0qGG5FlU9x6z0y5SkrjPjuAau
	OoVuIOcdoQc/pPAhD23oaiVSM+PO4z38c04t7Lz1xcVqdeiCnmBcnhcVO62yfHEDlTwmLmAHoKZ
	dMolFJLaBUAU7NRzc5lETFXDr4S2Kc5k1tFdWVKeZxVT2Sndy1nFbw/YI2hgifoLr1bNkJXnzmw
	reQPZlku3iydOn2fpZbKQo9RL+ke5FaVaNBfsoKeG0jrN4Todo3uWxeKdMBc+wFXBw+qnCu1z/q
	ITfSlvB0qsdxnNHRxYnMiUByOzokt3uUTroPOzqx+sSWrMcNm2usDzQNuaArjUGzOP6Howbaki9
	dGVL1seIo5nuR10JjR9wUR93dG+vJmb5Jr7nC4FU8UZCbiXI+Of0O5OBhGXW1p8LKfcVYdmMlG5
	G6FJVfPor2aae/Aqgeo0sVri5MKepMicDriZjMbBq7mBsg==
X-Received: by 2002:a05:620a:272a:b0:93e:c35b:2332 with SMTP id af79cd13be357-9442184e908mr2661347985a.73.1793802314009;
        Wed, 04 Nov 2026 06:25:14 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4898a06sm209917385a.42.2026.11.04.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:12 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:39 +0000
Subject: [PATCH v2 12/13] ptrace: use cred_ids_allow_control()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-12-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=2045;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=9DmbRYL9nHbIrwEdqslR1HfoLxxnNGAAY3s4ZuSx70k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCPouo4xXV/GVLy1uelleQqnw8GVnO0OfsD+sD2IlkuRSz25DloSK9u/PQ7MJcxM5iQ+V8UcwcQ
 YmSXy3QPcJAk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__ptrace_may_access() picks the filesystem or the real uid and gid of the
caller by its mode and wants them to be all three of the uids and gids of
the target. Say which ids it is and use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/ptrace.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 3f2fe68ccb14..8024d80f82e3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -305,8 +305,7 @@ static bool task_still_dumpable(struct task_struct *task, unsigned int mode)
 static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	const struct cred *cred = current_cred(), *tcred;
-	kuid_t caller_uid;
-	kgid_t caller_gid;
+	enum cred_ids caller_ids;
 
 	if (!(mode & PTRACE_MODE_FSCREDS) == !(mode & PTRACE_MODE_REALCREDS)) {
 		WARN(1, "denying ptrace access check without PTRACE_MODE_*CREDS\n");
@@ -327,8 +326,7 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 		return 0;
 	rcu_read_lock();
 	if (mode & PTRACE_MODE_FSCREDS) {
-		caller_uid = cred->fsuid;
-		caller_gid = cred->fsgid;
+		caller_ids = CRED_IDS_FS;
 	} else {
 		/*
 		 * Using the euid would make more sense here, but something
@@ -338,16 +336,10 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 		 * used a syscall that requests access to another process
 		 * (and not a filesystem syscall to procfs).
 		 */
-		caller_uid = cred->uid;
-		caller_gid = cred->gid;
+		caller_ids = CRED_IDS_REAL;
 	}
 	tcred = __task_cred(task);
-	if (uid_eq(caller_uid, tcred->euid) &&
-	    uid_eq(caller_uid, tcred->suid) &&
-	    uid_eq(caller_uid, tcred->uid)  &&
-	    gid_eq(caller_gid, tcred->egid) &&
-	    gid_eq(caller_gid, tcred->sgid) &&
-	    gid_eq(caller_gid, tcred->gid))
+	if (cred_ids_allow_control(cred, caller_ids, tcred))
 		goto ok;
 	if (ptrace_has_cap(tcred->user_ns, mode))
 		goto ok;

-- 
2.55.0

