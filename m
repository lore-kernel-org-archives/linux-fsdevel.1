Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802310;
	b=Hi9uqNZZ6JMCx3sijL1FsJNy3mnCGBPD+PQNsdhNBN0iX9v14yXLhe5oG+IdrVWLroGW
	 S12m5SwANQ57tqNrNe6e6jp+qHqG39Xw9ErZ9arVca56bKrtSFXfL67en/QJmkpvU/nD1
	 4JQPpP/v1Bzf35mX3M8Ubr3Rj6FWhRZ3osMcZ3pqLlddojnkCGIF7Z3IcckG2zDeR9efe
	 sU1nRr22Ts4i7NXN12MFbyuBe4tmJuaqAsaNLmt8lwbccTVl6FrdkwnevqtHg3wIwB+LM
	 O9I0IkYl+rJprpr2+d/Q3BKzjN5ZBzWqvcmXV9Sb8Yps6ORToilUR+C1PYcj6XPc2rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tXSVOWbTASTrx3VWAw2GnqycsSMwDyX6sPcpsk3+i/o=;
	b=RXMj5tDRoey7aQEE3eyPEBBUTWvEqRQUo2Q3Wz/yFwaf1hzWN62OBcWI8lgt5XYDC8cE
	 9lP6huPNpz7bESKOy9m2J2k5M9PFtNqekoPY6dfs9gdgZv0mQJEqMM35VYzXXQ4aDtoF3
	 +NcvmABlnrpdC+DTNxHvj3hleWZqC0m97kS5uvmbrcmhMRuDqsdGeEnMafvzCUjxXltJ1
	 guVM6KzY0ctTN+V/4rbtT3RDKgI1mECxPKlCZ7K2MtO8vf6F04DIhbqon/Ltc4h74/hyD
	 3nWLCxxrZ1yugZAir5/GVEyII4NCjJcD6ldLLjjCavhX6rKCz6zQ2gH3Y1bXqHxmd3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=V1W92qgg;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A8E606A329
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A8E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=V1W92qgg
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53bb57f1310so7435461cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802309; x=1794407109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXSVOWbTASTrx3VWAw2GnqycsSMwDyX6sPcpsk3+i/o=;
        b=V1W92qggbYZSKAJCPGsrdYUPj4V7bLC9pjgO9f2qlaofm6igVAT7h0TzehwC5LPW7o
         suT+f/VRGIgcfonqFmV0UN89XIj8ZMg7afvw1be0humu3G/SVHZui+J7EqAbq8D3jVsv
         /ZUGWTT6zdgyTevlcBxI5ucdfMasHCX5w/l7r07U+1TlSgv/YbCCtjiactJ9Z7q1zHSD
         pXtAs14Ww6E8d1+zuMKS+eKNc+89r3OT/upqvBw9PQuKoERQSgCrl5qSFOSN7VUj3C2Z
         r7r2/4mc7mcXCaJgHQjBpiocBKtuDF+df/ArC3I3lv9djbvQW4cfasiiHzt0lKaBA8yq
         yvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802309; x=1794407109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXSVOWbTASTrx3VWAw2GnqycsSMwDyX6sPcpsk3+i/o=;
        b=2ycPdTbdlh9r2sRsnKrIMkPllwtbtNYqiHdLrhqpZZ6HnzDgS/44uutlrTJ9AYhFKQ
         +SeaXjDrGV0aM1xstWvULP2dSMZjh0uW9FSvG0jQJrjOS+SdQ8IVLeVvKSditm1XTazU
         aS7YE/Zh66j83xMbyZIzIj0YqnCk8nr16h6FNyv+W6RoEek1YanoEg56tUIxrQhUTY2R
         SP6LTqHKoIv1ZZ+M8BAfpYPWRXsdPba8Dxshny5nh+mib7AJDGerUYPXUPsHIxmhBeev
         SGHoLoeLDoXjOkV34+WDzJ0vTuOcGeNTzuz4z2N/BWC1dnMWwms5KpylL/lzS9tc7neF
         oO1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwAXUNxks7YY67V4vG4mgU8qO3E72BbCx0f4OklqNtRSFqqtZ1e0+iat0uJeTLA5ZzAqCiXpnTuqNwKxiA9@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z7QybNYgX62mwmJ3j0hWPILHDHAgCRtB7cjUXWG31CEESnewN
	tgEXnQ0QD9jIU15/77n0jlG0hZf2+/67Kn9++GbhUjcVCgfmeFKWcXGxY67xu3CtMb4=
X-Gm-Gg: AYBFou3fuEa9BOmTQ6/5owLpW/gFWd6sHsVl4ONGu0x1tKBc9SDrnW3aVYywRS/k4TQ
	aGJ0IUv9a+FV+ldzP0h76PhE6TVGMSWArmWzpnDPR6c5k0ZEwDRoPtIbhfJ/vCStstukiLVfw+C
	ndjD3Y1EUlwmQAdvWs5w+0eT83smRrR1J5h6XffQs6EGH9D0mwxGwIShLiUlR2qErQjnFUedmbG
	GGVWbiIYLwciHBmbLH5ooZQYTbM/4VZpxXYFGcvdNrtsCHkEFLq7vv6dETKYk4/3hyru4LWPjrY
	ECSYt4o10QF1pu0PFUA8dGQtRf+JDSPNz/zWw3lmFk8gEOyntzLVeotAE1Fapil7FKXzKLkq2vV
	iLVJWs44MDyT+xplo+D5MzgADwIDh1nZGAD2dhOJvclOfNPqAzmQQVziNMUVC/d8lAMr30FvmrU
	BmG7q3m039kVZOtGtPlPmLfWiVTpWI7cT/0dqhkJ8sqd/ln7Ne5gDJ95mUijq+mIWH9coPkj0Ij
	Wlk5XqhDPj8Zt5SjVkcR8HLIn6aClhtSbu5s2P4UyPOUoR455VPZQbFKQViCN6s8GOeoLtTYS/l
	02Yj+h/BA3rTwEyqlWn2cmd3S3xRSosUqn8eXCsRMWmCiA==
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-9442178fc95mr2431154785a.82.1793802309425;
        Wed, 04 Nov 2026 06:25:09 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d482eb96sm212222885a.23.2026.11.04.06.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:08 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:37 +0000
Subject: [PATCH v2 10/13] cgroup/v1: use cred_ids_allow_move()
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
Message-Id: <20261104-b4-cred-ids-v2-10-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=834;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2GqVTJZoW+5QW5iLTOH/2OThCJUTSIt5jDc9Dw7O+kY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPTBmC9zKa3anuEfG2w9gFULzvnccPiFkknC+4fFymZXCOg9EHFh34w97JqgtGlrXApZa/nsl/p
 IW4jGufbWggE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in __cgroup1_procs_write(). That euid 0 may move anybody
is part of the rule.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cgroup/cgroup-v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 7f55a7bc8402..216a2dcdde86 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -521,9 +521,7 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	 */
 	cred = of->file->f_cred;
 	tcred = get_task_cred(task);
-	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
-	    !uid_eq(cred->euid, tcred->uid) &&
-	    !uid_eq(cred->euid, tcred->suid))
+	if (!cred_ids_allow_move(cred, tcred))
 		ret = -EACCES;
 	put_cred(tcred);
 	if (ret)

-- 
2.55.0

