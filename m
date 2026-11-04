Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802294;
	b=qyDHgqx7XeGeUGh8X7Ef77fZKdTJBXlAxxCPr9kaOXD/WkFHffvdf3WPnL/QnxveCpMa
	 oWb2wPpL6a0pqWfLhJ64wjQjRLgPJeqsLAf9YLMXbYh6w3P4Gv7CQrQlQQUn2iklDD5Xm
	 /C/TtPqRn+aQq4k7fxCWiw6+VGDDoUg9EN2LdLov+ZbAqi1vfcdmpk3lweu3oEBrzBU0e
	 5+pNmb2rUF/FepBZfwMLgu0t8bQINg9BAckEBzoEU0wok6GIBP4LGuYL72L71rxfkB1sI
	 W0zZKUtt0zDTFThDb7hFNwBkBDJnar9Z4QzwOmgGq6gBBWA4vF7j2D7x+cab2mzbKLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tbK0DxpI15F/xzj0V+jS3/ZkehU3GJ2IwlLX3CKVARI=;
	b=P/r0jjdWXs4eLuXGqKffoslVsmr4RRyvlZykZmPCTAidS79DQ4pN3nF/S0F5Jl6/Xaoh
	 N5TRokoR0hH6rnKYRtO9b78WkxDr912Lp9hY1I8/oFs4TJEeabkT1COT1sTkOAjEJOpmv
	 33k4LweYsYvS3Zl8rm99m+h7tVEVqPA341RdmhZEalexcTCd8xhqBbLlWpw2Z4XTNAL5n
	 saMe8LR++zdPbKPIhUd/vNhLOuxk172WCCFrThPvTfQ/41CPv6dYltVMNSVXvcn8gNJvz
	 FSlb2CR5vw1w1/GEupfrjbe3HIBh8ZdG9TdX70QOlFDiSRjGgzDqj9O5KnUaCSxM1FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hMF6SFKg;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A7606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844A7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hMF6SFKg
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f2b8cf037so65625585a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802292; x=1794407092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbK0DxpI15F/xzj0V+jS3/ZkehU3GJ2IwlLX3CKVARI=;
        b=hMF6SFKgupujfQgIUunwc+ZsV+p7K5wU8YosMroXObR35CdjvQXy8TREQemqOnJYtY
         1dCDkZ59HfFzF4mcvyuc2vuzGU4MAueWV6R276BSN9mRHbUpSiEnKJJRFunpET976eYp
         aCqD0EH1qrZUmBMPW2kMFOy0VwSlYpi2e+6aHCBsXpiJSOcCwrzugFVt00x9D8pFQJjp
         u6PSEwFVESyp1u8hUFqDeQQPa6Np6c1wfahQt9Vx2LNr/aUxZURb552+ZlVDiEd+EExc
         4Y1i3zRV3SrKOC5QavSyPSEWBlG5PShSRafzWs2C9SWPOvNaoO4fLIsKjpx469FtbXpG
         +g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802292; x=1794407092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbK0DxpI15F/xzj0V+jS3/ZkehU3GJ2IwlLX3CKVARI=;
        b=LYEUECZAU1jrz5T7ZalcfyN58tmc92zG+dAPZWMfXLK6qDaQoBs213SBpIH0tIHy6p
         pfFZDF2QEyZOqLsF+41UhkM4mN+gyr8M2Mu/V+PxHEmXVNKgqo2SNXT9ddixzHAow2+i
         uFk5damDy2iXVQ7HNDiwOrGf49tMsbayHZXH5B4gC/7kA91XT8xwN63qFYFKRVu2RY/N
         2nX7ERl8+0yl3ygiOrV/Udlg0+ztrZOaNBbzYJWcjo0Fq3L/duLioqn5Hdb4Wllbo+UO
         gFHwIQeEuysPbdt2/syCfkn+mlFj7IVubp+tm0SuiCWiyGRILLCO5bj1hsF2c1q8Opk9
         HveQ==
X-Forwarded-Encrypted: i=1; AKwUvByAJBHROTLzitLlAWKQ3AcDWqVYEXJmHpNm6W7OYi8d04AhDwVNgogakAnacy/7mC3hm5y8oxH1JQ54X4Fw@vger.kernel.org
X-Gm-Message-State: APuU4Z8oJqkkzaiv341bQpSPX71ye+/7XTgpPjtf+EqmnIMhpe8HUTok
	DlG0gYvfWR5IcHlMeWAFzCUGN2PLytfCVgGNJeuMHCo3Id4T2uA/wtSiQf6vnXlbX2Y=
X-Gm-Gg: AYBFou2En/V46CwlRb1Mp3/TAkHXzqKaBdLMKYpBNgCyT+eMPJ7W6Q/LwUW1N3L0duD
	Fbl4XUdqucolEWEzTBrUh7+Zyovlr7G6egFkb+pHaowyCToUyt4nOJU4zphhyGoPY50doQzHtdK
	gwM88lg1ckkIDKEqdO7Fq7kHaSTdzNg0lODq8yZSuQ5n2lcrdOcyrSXFgyIli1P8vpRwIXv+6XE
	sE8a8sjrLZZDnWKBu48OYaQ2zA3DJghpWlZaIwprPMcNNlr2cgLDobc5wj5zmj+x0NSvhMm6N+G
	llH3clBYgEQClMfCKddc41WUMJ6dlPP352g+fOHINACBX4SLZvIAN19MtTCRC1Ud7yGENlxQUyc
	RD0Vb/eyBtzf/7ydYqeotcrQckINZ5Xmb6Rz6zDn6sny5BdkjWopxFQqbpfyXjc76b8o7rGKMvy
	zGa3I9LegafGApKWfTKVKO4FGgemnBUse/gI34Oso2fzERWsFTEXzM5MB+W1g0uyEvpA8RQkWrE
	Mxak8AkXMXm4pvjEqXcoNH9tWe2iFR+y7Ihyrs5UhT7CtB4Wosuo6YiCJfuUNbz3/P/UgxdKNqY
	jpNKAM1/0Yr2Quj8ULHREJ61dP6CMQrtURqI97bTpCgU7c8=
X-Received: by 2002:a05:620a:801c:b0:93c:5958:9de9 with SMTP id af79cd13be357-94421737389mr2553014385a.33.1793802292436;
        Wed, 04 Nov 2026 06:24:52 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488f183sm211426985a.39.2026.11.04.06.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:49 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:30 +0000
Subject: [PATCH v2 03/13] signal: use cred_ids_allow_signal()
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
Message-Id: <20261104-b4-cred-ids-v2-3-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=1239;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Tajos9jUkUopMDG175sSHwK/Ywn+i8f+s1b0fUOz6cY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKanLLbz8uAHSqS+hoNQ15sAnZXqr62P0wBayqZOWM2lg1Lh6ILOa7XTVDHuSJ+CfNbTfgJ4vNO
 0K9D8AzOMhQA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

kill_ok_by_cred() and kill_as_cred_perm() have the same four comparisons
each. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/signal.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index dd770e68faee..aba93b99adb6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -792,10 +792,7 @@ static bool kill_ok_by_cred(struct task_struct *t)
 	const struct cred *cred = current_cred();
 	const struct cred *tcred = __task_cred(t);
 
-	return uid_eq(cred->euid, tcred->suid) ||
-	       uid_eq(cred->euid, tcred->uid) ||
-	       uid_eq(cred->uid, tcred->suid) ||
-	       uid_eq(cred->uid, tcred->uid) ||
+	return cred_ids_allow_signal(cred, tcred) ||
 	       ns_capable(tcred->user_ns, CAP_KILL);
 }
 
@@ -1531,10 +1528,7 @@ static inline bool kill_as_cred_perm(const struct cred *cred,
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

