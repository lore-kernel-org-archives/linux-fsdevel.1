Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC63876A0
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344726; cv=none; b=UnDecTln6LssgJGaGDDqL8InSAvPcoxZVSs37ZOxamcjMO8dHek15YIa+cgD88AWQ71q07k6x4kUVsaIvJB5vKyqGjWR4uxO3VTlsaPwYUqeiWkVFD8oXffyt1SvHDwXZJZogomnBb7tCAQLqj0fsSK3VsibrzfCVPA8EYzPWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344726; c=relaxed/simple;
	bh=gHI7eJ6aXefjpjs/BTHmJSNhf/+IT4VrWxP0xZGTO4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5RS+DaXCPZZXKhUXJqygxE/ZPDTumTUtvEol02wQn0nEW92a5WkVuIQrcB1ABbG7pdtHY6EqENgq0YkWALiRxdVKTnKevMtNPUcnoXYH4t9yZcmo6kcArN+1QveII36PaEGlx9+1+XKmxT1LzNHW/umlj7yup38DcVmnSw8zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=qiSjNtak; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="qiSjNtak"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93ece7a73b9so205984285a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344723; x=1792949523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9DMRFJtj1v/pgDnB0otoEeuOQ35799cJSy/oBGV94k=;
        b=qiSjNtakVDct2v/qXSnmuVSigGNAm9YHsweWPIw6+8UMhM8PwQCyuFsNxvXf5/p1Xd
         j09mZ2dAN92QxkjiiHigMORRIC+Bc0iLVcOCBN6FrrFiamlAV5ZYuasBIgCBHqX6PVr8
         JUKEHYyqwWJbVb7F75doP5dnvL/qsPmQnkmfwL2HSM6eEfEuOoOPb2JoSkkAgOKYtSUz
         HfCGuWp9SpI6r0XFkp95Sau3fpoLWN2tAXf93VgtpUriImAwPnekEcyeJwziOCnaHLCS
         KmY6dvn9Sbgmndr1lu9+qRRVtZUR5c2qwHYCl3KN5bs8/4xwH38EifOn7gC4z2Ye0SWS
         iRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344723; x=1792949523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9DMRFJtj1v/pgDnB0otoEeuOQ35799cJSy/oBGV94k=;
        b=BlMtqR3GoVg/MggZXyi7PXda17RVzEicYg5VGTOb4IwCvqGTwTw9zjWJaY4qzOk71N
         JhUTseUpiwN01ZUE539Vbd37KW+9N5wyS0BDTUJGTtRhZ1wX2QMO6/x+KsDY/G3hOg9O
         YJ8tUMytoOyAWVccwvMnzD043q5ITCruARfSWRb//XCD9Cb0TXNxR6iSEeW686rk2tFv
         V3m1JXlmTbwzyMN/e/2S/r/sgGU+mTaXYBw/+f3SotHNgwqnjnqD+OMbnA/u885fxX3I
         YyqjR7Wlwzuhy3DZNTqgoaVjgNt9bTjdDwJ/6M5bKe7muSKrD+sZuzREdQTMsNOVaqnr
         lOLw==
X-Forwarded-Encrypted: i=1; AKwUvBxojjFoee240VQ9Uo/HSL9xxjHqsASRqEP4qkYEvbYWkTpLKEVnOQrnHptAtXaIUF6JP3tnwswmJjbQSglm@vger.kernel.org
X-Gm-Message-State: AFq9FYJgndJLPEUh7A1puzU0lrsUCs8VNczai2y1udjin37c92Zmo2bt
	b8uKALsjoIYLSrjtkyFUJwKq6YBu9oOuqZ8ZHeuq3zP/vTw642CgAf6EOf4ND8sAC5Y=
X-Gm-Gg: AYBFou3f+GQ/K08+F+gZNJasq1iz9Xmh5AJ8ZndROE3EbBXEqNykdcgBHWmUViOk9zZ
	m+3yIZFUI5rZoN0u+6k+RkrqdC2pvfSgpLoEPudkS8xGjl+rPSW+UYVnHo7l3avWqkEn9uXoBPR
	BTQO6KTiGfgdbbo8XMB4NwGrQEXoTx4Vu3gEnJ4KOkm1uR45S2lN0+/UxSJFmu7vOjx2a50lULN
	nqxZK1hIbzMcUylDCUkTfsc2CqL+8/2hjYCUaSnq8KV200ZHelIunEolDI5HD56Q3kdY1rBqrrw
	jvfKGGyWIlWLJtdLRKcX79b3XkRP/UKsRd/ix+pQ5VDUNY+NCB5JweEDOa1GWI/z3Jcsmzi14F4
	tI2w7HhCKT3iRzMWRkZSGSLfd4Bocdig9VceiBG9+49g1piZG5KJzTIWR3Dlhq9tHUrrASPPBnB
	z7YZjrNj1xtZCquKnJ2/OQ6HRsa6g6sMg91V8UeZy6Io+uFPM3MuAVFx2T+Jz524jGja6mIyKCE
	cRFB0E5TE7wCkA=
X-Received: by 2002:a05:620a:1a1a:b0:93c:7955:afd9 with SMTP id af79cd13be357-93f29d8d97fmr926748385a.52.1792344723545;
        Sun, 18 Oct 2026 10:32:03 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a18510fsm753031985a.22.2026.10.18.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:45 +0000
Subject: [PATCH 03/13] signal: use cred_ids_allow_signal()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-3-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=1257;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=gHI7eJ6aXefjpjs/BTHmJSNhf/+IT4VrWxP0xZGTO4c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEVNZAffAF7X38dSF67KaYGn28GTqbfoaAHsAIBWkVE6jT9Twlxr3b0mv2VKln8SmcgCajh2aXu
 9Z5zF8Vl0ng4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

kill_ok_by_cred() and kill_as_cred_perm() have the same four comparisons
each. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/signal.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e433de93b430..bdca8f9e0fbd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -791,10 +791,7 @@ static bool kill_ok_by_cred(struct task_struct *t)
 	const struct cred *cred = current_cred();
 	const struct cred *tcred = __task_cred(t);
 
-	return uid_eq(cred->euid, tcred->suid) ||
-	       uid_eq(cred->euid, tcred->uid) ||
-	       uid_eq(cred->uid, tcred->suid) ||
-	       uid_eq(cred->uid, tcred->uid) ||
+	return cred_ids_allow_signal(cred, tcred) ||
 	       ns_capable(tcred->user_ns, CAP_KILL);
 }
 
@@ -1530,10 +1527,7 @@ static inline bool kill_as_cred_perm(const struct cred *cred,
 {
 	const struct cred *pcred = __task_cred(target);
 
-	return uid_eq(cred->euid, pcred->suid) ||
-	       uid_eq(cred->euid, pcred->uid) ||
-	       uid_eq(cred->uid, pcred->suid) ||
-	       uid_eq(cred->uid, pcred->uid);
+	return cred_ids_allow_signal(cred, pcred);
 }
 
 /*

-- 
2.55.0

