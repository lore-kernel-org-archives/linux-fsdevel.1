Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802300;
	b=05TRJf8bcZBbmid8nSB611HXGN2Z2JNxeDVUsQh4WTRCSjrDnqVc7a7Pw0X+4uKskJ49
	 MTNgXmJ+pif9PXfVuSGG58w/SwPa7MZcOOY0wZLlUkoT8j6D7gEIqOsjAIPGScaWVByVM
	 pGbkjSoLJx8UhZ5J6B9wKCVRgqFt16MaRZ14RPABhu2mQoHt24JzWohGr/ant7qVFoO+N
	 c4qc2y91p1QAox27HbN/3Ms/w9kIYuKZZgenXjWb0g/etrgLTd0KuARUbEoMuCJkscdxO
	 FQ98gENfXCXDzfMDQig7HnFXJ56+1Bu9KLT8E+09lEXezHodCLPlHrGV7vkpn+DbLSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VU9CCWMXsMJDGUFdbIvPqLOpKaS0EeCZQGKXkHHjIys=;
	b=I1iS9QfGqVydtRjGw3MJqZrL9XMYA1ftPloLx/3Yezzo1lPilbpt+G8G0wYWkltHuW1i
	 xI01dk2y4E4ZflkdR8XA2N3NRHt9lCQ2W1DuouNeYaFusK48h6m7FTDFyx3L/4Qh1Asvp
	 g4F0YzIfnZQ71x8rhTB9y6TnWLkHXPjEFXJdzRYsBWviA1JpoBR38BBiKBoFyKTeKQcWF
	 WnEkr/CZxR3dxG+4y5Bxk127KnQ8MM7GfhA+34pO7s07Ag6FJIP/ONHhwZf0aZ9ceXUMq
	 R3OAgzviOrnSPqainoJ6O6vTuqQZabqSd78D9iuEJqePJ9iX5/vPaNO+5zUGnR58JDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kuBN1KIA;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2E606A329
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31D2E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kuBN1KIA
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c73c63116so9063386d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802299; x=1794407099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VU9CCWMXsMJDGUFdbIvPqLOpKaS0EeCZQGKXkHHjIys=;
        b=kuBN1KIAIcqWlPpqEM3FPjPIzWg6GGGhqXNWpgSQfbVY2/GpOhV60et09h83Hgzj4n
         08IbbUVbFuLSGT8N5QpxI139QFG8rZBQXOJ4bd6tvTAb2eas3lgjntlJED/6TvJIg5id
         gPWFf6Sqhc8Jy+aBl34beoBYJeP3yzCnoH2W8GL1i3woiSVXrNnxU6b5h+blXqiaGb/j
         RzVWfEVxLp9Tg6l2bcAYDna77PWcIm/gS/mPJjxEgcAf6aaNLKDJkvrFXCUoJ1ZMC+Dg
         LRzvuWDxvjVwKunkJhqjOsO5BGJumAf4WztIa9Ig8UR3NWQd4kO/nnu2xk9o7i2ZuTp6
         COVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802299; x=1794407099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VU9CCWMXsMJDGUFdbIvPqLOpKaS0EeCZQGKXkHHjIys=;
        b=vPnOjr5TJsbI7rStoHPNyEIN5ZplrWMqhFDaAOTQ3xaoj072Xu2e2Y7oiMOZ3g/3Os
         c25MlfvjrW2E84sJw/eT5jqA1LzAAgC1TI7bxmJrhpNRznve53frx5lRvxS2Ku5vHK7S
         VqtuLT57KElqcCdcfjM963bfR88h+HvxJCBxa/HVh59e+1Pei1WA3IrRVPFXwu6cM9Jj
         VmbHClc8mBi6lsXMBK3QP1kkbf8ESatwxArdgM6p7K1gxTGYIDoFYSKsSJPV1fxoPUBR
         DwJlX7EBrntcrLQhQe1AXIpDB48nSxPduY9EOpI3msCb9vILFoK2I3K8ub/3agV8q1lP
         SDbQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4mmZuG56o+oJWjTreW8kPjS1gCwP3/6e/e3TcxX8U6KiGGvzvfMyM/4p34i0Oq9SGnbrPgaWNY87FgfEN@vger.kernel.org
X-Gm-Message-State: APuU4Z8Mt5ZlZa9XuoRs73vS2hopycmZZZQ1+b+jprovBIUdyjYL8QIL
	LzCuF25PR152j+dTCmx5WpR5gxAdZrUn0lBug+fKQ8d7Z0ziJj15EC5WIA4JOGmZpdA=
X-Gm-Gg: AYBFou0jXumL/yXAtycVwx88R0bjXA5ftq2b+7FZN/J0AxEPqWHiaC3h7pIG/eziGch
	06yKLQvUi+Xl80E0nzWUWXe69wUnjj1dT+GeVePMliKtK5lY1xpsumL0G5IlXB8aNgLx58zKGJn
	FL9fGCLPvhm60vYAQWZ+mqEU/VaE0rpxLouvZ5MnyLWKK36tSRx3+L6KyGDCF0guEZ7HVKVpet5
	6nmzsJ7DyemeuYeGaLci+lPAwHbzO92Kwq9VJPdQ68rMnG8T4fAWCa/jSlOqvSWiSzqtYbOuikd
	xSfblS9BiZHV8+yeX9w6zvh8x+t/3rUujwTPzvACPC4SdFaxr8lsp+Cs9JkWdkxlKsYewJkkukx
	Obf8kJQh2R2Cdp1MC9SdXgmhGMmVQPyAWdtRZcjYCvrMYu81WMiEDhqyh0PNld0YGYDL+b7Io06
	5Doj1pUlgfS5k5smcxqnDyZy/d/oD6519ezTRRdw7D0R9A7m+rJaaBGEvtGrjyvLKErjKhI85SR
	ceeBQh6FcLDHuvh5otsjD8L1F8BKVfTC5SqHu/zDli3KkiDlKQnCY5HK6KWmJWrzxxueThakdLF
	ANyqziRelA5c7+IcBH4FaaIZnPgIe664r/81vx6/z/3S5w==
X-Received: by 2002:a05:6214:3017:b0:91b:8272:5157 with SMTP id 6a1803df08f44-91ca4a0c0ecmr246262196d6.2.1793802299117;
        Wed, 04 Nov 2026 06:24:59 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e70f84dsm19893096d6.32.2026.11.04.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:57 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:33 +0000
Subject: [PATCH v2 06/13] MIPS: use cred_ids_allow_sched()
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
Message-Id: <20261104-b4-cred-ids-v2-6-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=819;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=rd0qIu3v7XZa7hSGzj4TvDvAs/c98iDo6Z6DNJiUj10=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMBBsZQFNgRQhiNgIbdVe7nyilFEJaLVh1a+7/t9IHd9IVQMoWWgmknUBy9Z8Uk+sq95QEuIDDZ
 DanVJIvIu5QI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The FPU affinity code has a copy of check_same_owner() from the scheduler.
Use the library there as well.

No functional change. Compile tested only.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/mips/kernel/mips-mt-fpaff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 4fead87d2f43..1ac86a897956 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -54,8 +54,7 @@ static bool check_same_owner(struct task_struct *p)
 
 	rcu_read_lock();
 	pcred = __task_cred(p);
-	match = (uid_eq(cred->euid, pcred->euid) ||
-		 uid_eq(cred->euid, pcred->uid));
+	match = cred_ids_allow_sched(cred, pcred);
 	rcu_read_unlock();
 	return match;
 }

-- 
2.55.0

