Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802309;
	b=m30pCM8+eKXR0vOgC9K1xDJ8Dmom3qCPzyBoym+SHC+sxwZ5SWyUIJLQmlN4+DmAODTi
	 1u9HSm2aIMaF0aT8DwwDgz9s+3XuXWWzu8HPoV7xDa+SGORLMXm5QgcCsRPAhX+Y/+dlh
	 1tSxxbJeEJWm4xLRLL0Huwdy1BDcndyGVVr8V3TRd+lgje88RPGOkYK6AOP5fEulI0e+T
	 5kyRuJ0T3zbV8KhCfGBCblFmpjRdJgvxxcnjoDVzFZaiwMMdkL+RGzGGSKnlEl1T7fyTi
	 PrJubXnAoTV2zobv9fn3G10/Yk0mB1rVPtu/R7AradGgDyuJayaLxDA973+Cug8rwzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uU0ZmbKgtbpmyh0NRAjEO7QIbv2AN0GiKmF3kwfwG1Q=;
	b=H/g7ZcIZD3Fbd3bWE0qWWIOoNT7akTe33vTnH2QDwI5j5e0o1wcONA2NxRiEJvhWCaNx
	 MyFNa9LizvVmVmk96KKSKhH5wLJ6aGwGVIufLU49QawPShXRilkS/g3Gh0jJEpWrddYyJ
	 Uwfkwt+kjo0WIYrCbjeaoqzq4hFY3tjDt29vuopFBt1S3hJy8i5/9EcuYd5ftLJB03vkQ
	 /CUTybpxJ/gpeLqe3VsgPTaiNFVEp6FUID4+jAvKIPjJM7vmABF4UZa6xBcqDiiK+jvD/
	 HhxPISp4rdUgiY9x47GhsGdnETN91ZugWGA6RGSJTzubPZNhTTLqo39INDQ6xFJGdsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=oEyxWkjV;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69D606A329
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D69D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=oEyxWkjV
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-536717a4d83so6162251cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802307; x=1794407107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uU0ZmbKgtbpmyh0NRAjEO7QIbv2AN0GiKmF3kwfwG1Q=;
        b=oEyxWkjVmoeJkbuKHHlBXaO5pE3LeLoAki3G5gy/WAL+wBxujZDWIIP/j3syzdlQnR
         n4fkTqUY84Lef9XQZgD2YYjFx/RW/8Q0f3yTPmhwl/iU7ssJRgTwP0V2whXDd3Adbd7x
         Ps9ZCl228Mk1kuFjUZa5tHOcPMG/fd8v9LtSSnAMyRxcisxsQqz9HaEpcDhOvIFa3wan
         2r5LQhm0CUSsRliibxwDUO2afRj8kmZzXYjorcbiRjLAzCEojByRljd28Wu+CMLrgMPj
         k23FmT5QIFKYZAFI30apeCJuQEGHTFniTbC2meeNwbY8rtYrbnTuEAvQqc6GsuIMSa3a
         FoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802307; x=1794407107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uU0ZmbKgtbpmyh0NRAjEO7QIbv2AN0GiKmF3kwfwG1Q=;
        b=sjLWlN3SZT5mj847qBAIITReW5AjQzL1/2y+CKotukb7F1RXSwBOicOeMonVVJZk6v
         k86bi5alnxkKdDJZ3e3xncSi0wnrOddFKoosbofPHL2FokzrbVcXTIv7W+dMpIn8Wmx9
         iFZgsDbwL6YJkJyd8PkqMKJZxGkf7m9H5Au4uQb5QHQRdR7NfRwCcxYZNUE0aUiJpdx2
         gaDjImwFUAzgzoJY62Q9Wlp2lV/okckf7TXs3Q14/koqi2vTHI+XsLrknT8CL3agmfB4
         bDxTmsvfnLyMDVkBfaEdBcwBj6TFMYHJzPZAy0THnw6431p0zL+eegkr3Lc+l/JK0/vE
         +OkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjfs8de05QE+BlaIgOpiRg/+d1WoGqx3xQZT+7lUJ7WWqby1hUOiAFayK4lqlWauRJV8xe3oAsjyGfcSA6@vger.kernel.org
X-Gm-Message-State: APuU4Z8IL9eSKvvb4hZm1K/YZKvzBtmnUR3WQmt/exxsQpw6a/TCSGhk
	EtBK6wKN9USjix4oM0eb/IcsSmxf2DC91OvqXdLn03p4LMLJiLh6vzazqowBfxQBs5M=
X-Gm-Gg: AYBFou1355IwRexhhUhhhCkZWQ1tviCvzLv5IhMl4RqcJwAxPgBrLHfAZQ5iYYvUy5Q
	v8i6uCg8vfYeA9kYv6utLZoUb8IjC4739ei7gjiQ5uFLHwhNFgimMjUs+sx6yytwJFFRpqBQZCM
	yYV0jJ7mAHHemcd1F4+t3nPMj7bcFU+sDFyo+rLMcIuT9B8l6wD8SNeu1aa7/SdJyC/v7NBqSOJ
	tzUoLhZJv/SWNNaqeubKc+kG3fWtifM5y5iQ8suJesNLOial3aCi55LPl4qUeAbjalONsJ/bOIy
	uH6zlBn6RPgmNszBQHDhZ9BaubwtJuXIOBwFb3UMdsH9MbOxkeY+EchZ/gdiKex5xsan7yyOKWQ
	eZh+qir/FBiXBF68V5jK+oc2XcbmIc+8+gTjWtTyAGH8z63DjEA6FYjltd7hE2Ew/TjTN/cWPt0
	pUTd4XrV5oEj6+HDss7OMw7EI7IIh7fJSYwqymYM7Rvg3dz2BfP3w4rZLIxNQT2Jsy8CGTMkrP5
	jj4l/gGGKg/W5dbKLDgT1BbXAA5ednzwhfBj4+r13WEa26iOrunNnfy5HmICSdaXwTGDa9z18Uu
	qW8uU/cIQ0EZz/aHYIKlEcqOj91uQGUratYA270Kc5EjnA==
X-Received: by 2002:a05:622a:a15:b0:536:3463:88d2 with SMTP id d75a77b69052e-542b6a72b11mr270017251cf.22.1793802306837;
        Wed, 04 Nov 2026 06:25:06 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4c4f3sm25077861cf.22.2026.11.04.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:36 +0000
Subject: [PATCH v2 09/13] block: use cred_ids_allow_ioprio()
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
Message-Id: <20261104-b4-cred-ids-v2-9-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=709;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=HCkm3woz1Qj/8S1BhSv5R6Rgu330cZd4oZfznXBked4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOBqOKRK9z9065uB+rXEY/3ytfPvmwrvE+aNV6nps//9u/bgg+IFqePBtmuCmppOJHYnoAL8E8C
 lW40Ek8HG6wE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in set_task_ioprio().

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-ioc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..80e1ed2db8c8 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -248,8 +248,7 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 
 	rcu_read_lock();
 	tcred = __task_cred(task);
-	if (!uid_eq(tcred->uid, cred->euid) &&
-	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
+	if (!cred_ids_allow_ioprio(cred, tcred) && !capable(CAP_SYS_NICE)) {
 		rcu_read_unlock();
 		return -EPERM;
 	}

-- 
2.55.0

