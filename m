Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802317;
	b=Hc1JadyWKpsj8w4zOvUchMWB2q6p66noVG9XRGftDvRGDncn60jGY+tQvPBAdu+1Jodn
	 NvbTQSlhdhaOTarQtIDasD0BAdr0hCQ8H9J9TVhETjF8FiLK4t6VoayPE376bN0lx7sAw
	 3xu4oC60VzIS8lTk8MslaYNKrWo3KbxXu85XKI0uTLsQkDmP8o1ejtd8aex3jFogkA3kQ
	 P4GFboN3b7jk/FR599mujdUbGWXExOtlYLRczONkY5g21tEeL5G3U5YUSUcyG2tS2SBe+
	 wzQTIdY/rgomYWgfIPRKNI3hM8F2wX6ynC7KPuk1VjULE+s/2vYisaadQRcuIuZkyyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=XZBBh+YtyvQM0pdcafD44t8IIIPhs3RkrgdBT3qDgR4=;
	b=SgCLYlKLQ6DFZHKEfMU/0EEsUj1cPq7fOwHL7YA0SBP6XiAZgQBCjMTGOkWrDHAXvYHu
	 TcOKVUmVqCNCASFdgTz5gxfpuExSWc1pMiJXt7gkkhCvcbTGTQZ4dlSPn75d1Mr86PTxV
	 paV6Hp3MyCSJDtQaGlUt409aZmxDs1GMWmKjDBkC532i/xewXZBN94oMcKS5WFXctAlAZ
	 dxBrpuxRoKgbXk6ztBHiDz8OJC0jvELfTWOb6Nzz7kIuC7YAlsVfZnuaRrMZdtosfhT0H
	 aT71dM0ASycP59tFGOEc15hnY3wN9cs3MKChmG7ZPfsGNjp1lRc9vbi1s+JIjaC1OPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Hg3tCNnl;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624DC606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 624DC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Hg3tCNnl
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c719669a8so8299626d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802316; x=1794407116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XZBBh+YtyvQM0pdcafD44t8IIIPhs3RkrgdBT3qDgR4=;
        b=Hg3tCNnlzOc+NfSRMJPD9yjsGgSrDOB/iGXeOelBVQQ/GjiO+hL4fzWBeDcqmKfnt/
         McwYJR2yfuvJVvm2Pc3WbbsWF4UGkFzg01gBA6IN48KxeeLovLnRgtCzVoSDHFZrqiki
         4Rx7jcgMv8LDokJ2c+CRCdiINoQE1vs32GjvO27sX6auNg3xKQj7R8iVWL785kNDCek/
         FJX5V4Y0ga0sL+OEfYaT+umpMi1YgKtqb8Xh134VMEF2COSWKH+wvwDrSw2vHZr0zKDD
         q1Z8Ku4DIjPuSEG6CZfVeGiX1tUTnQMK78XQwUbdRzdR3dQ6FyaAK8a8js4zqsVjTDz6
         ZHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802316; x=1794407116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZBBh+YtyvQM0pdcafD44t8IIIPhs3RkrgdBT3qDgR4=;
        b=XVkB1MiV17lS8EhguIG3zMFcq2f/FHVtKBZur9FVJWdrR7+LGe5n4A28UaM2BdFSSQ
         wNbr9yUzw7zBjvXKfHJ3pVFHrzbqhpjRUcC5PnIwvLgN3kjyOiSGWCrncEvgcoxA3dDY
         b4HJdPYEnKFmlHNyNp732GfZU5ZhM7zFyvw+XHGNmhwQvcERnYVS9JrC261GKeYH2ucY
         UhO7yOjnMTtAc0AA+FfMLCdtia1B7B8UpBOfBda5cHDQnMmag3DwZufRbnMQ36+cpTuZ
         h19SBL16J93p1G7AhCpjqDICMDntSNGCdu2TxBbJzpYm24SM6tgaAA99uh1c635FYMbe
         RdZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYKbhPUb4sNfgxBAGhl3Qv0lX1iPqSoOgErP7hjAVjtyZGSkbKO0VTo7SK46KxQbE6Eab/GDdbsxggGIG8@vger.kernel.org
X-Gm-Message-State: APuU4Z/3QJh1u66lQzFSCG0y0uHzBDJkIldb6fuF3XN7pnj4NyjOI9uf
	dEYbtopp283meQkqJvju7KZwIdbaqrfJJebYsf/cgwSCS1CTcUHyU2DUYSrLv8GkiEM=
X-Gm-Gg: AYBFou0OEaRnQwVqhuXDlDSafxPioW8FArmwuUv+BJgCsFUIKRj4Ka593agTnQ2rGUb
	jOaxsUS2q+UoKjdvEvRx+Di5Vaj7zHXhK78+e2R1KtMTMpUyQpG9RIjtkpyV8t+JSzW/MPuGz5I
	QeB6Qcahk4+vTDnuWqJFkXfs5DXumUsSUZBSUq2mcPTXJ4DsZin1Enp4+QJa/Gc7///v93zw+mu
	2zO3GGsPWfsur2mM7A/bN3OccNVlZ6q1ErSdNjwod3Df/hp2fdwDMOAGJO6S4RPItjli5/neYGk
	AXJw81CPYgX+uwvtjw1B+2RQF9Gjaow3nY+Qt6ub1IEb6eoiV/VhqUKHIMbfsc+M+IZjJepSx+d
	65/39+0kPR815zYuDYi4bgMRqMmM5T+t/1sqGcGRnl/6zAEwuUMnX7lKvvUIy090YLRpojJaTeS
	bc+GkQNPHRd8WVq3HqWeY5qFWclWHrCaYS390qTzWEba7Odp9CQhf472+zKLll2V5SbMWi1kt9p
	MQTGdHGNLBNvQEz6fwGsbhB+haT8cAW9RAHqTDaabkWiOATd01VKST3Y6U+lHSAUazr8AQz+MG7
	u86wipDAcJ/rRdi46WWuGjwbOsOVGFtSHgikt7d7zRQoHQ==
X-Received: by 2002:a05:6214:c43:b0:91c:6388:a45d with SMTP id 6a1803df08f44-91ca49f1bb7mr266381586d6.5.1793802316221;
        Wed, 04 Nov 2026 06:25:16 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb8c99sm20129386d6.11.2026.11.04.06.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:14 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:40 +0000
Subject: [PATCH v2 13/13] keys: use cred_ids_allow_control()
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
Message-Id: <20261104-b4-cred-ids-v2-13-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=1044;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wU/wUNQ22CJbdsHXhdyhPKydSjViK+2b9lI6dkA3aJQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOAYiq0Qci2l7bb+IWY9NmqGqVlOj+7fxxp/4a8VZxK/LQUURR7UVV6elrGIGXXmHSrqT+zywVP
 V/5MpmjYNogg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

KEYCTL_SESSION_TO_PARENT wants the effective uid and gid of the caller to
be all three of the uids and gids of its parent. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/keys/keyctl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 36ffba0ebba6..cf963251a87a 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1692,12 +1692,7 @@ long keyctl_session_to_parent(void)
 
 	/* the parent must have the same effective ownership and mustn't be
 	 * SUID/SGID */
-	if (!uid_eq(pcred->uid,	 mycred->euid) ||
-	    !uid_eq(pcred->euid, mycred->euid) ||
-	    !uid_eq(pcred->suid, mycred->euid) ||
-	    !gid_eq(pcred->gid,	 mycred->egid) ||
-	    !gid_eq(pcred->egid, mycred->egid) ||
-	    !gid_eq(pcred->sgid, mycred->egid))
+	if (!cred_ids_allow_control(mycred, CRED_IDS_EFFECTIVE, pcred))
 		goto unlock;
 
 	/* the keyrings must have the same UID */

-- 
2.55.0

