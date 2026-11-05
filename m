Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890687;
	b=qNk8TvmoPuBmycWpGdm8VNt8OxocoHEY9QiBAKJdwJp7niOYRbH8QD0dzhsZ9MXtXdlU
	 YLcxgc/y/nFHReBu+39VIedRfe2dRkmlf6A9cJcQfWnMMUXwbIXn94J85Gc/CNh91wl1m
	 bMWS+dGBVx76TYdAP49vuayoQpgYGuQw7MeK6kG+J7+1UayGgV1NJOGpEPF8IrVjHPEyK
	 XivDVF44NSb2fWKgp/7blJ6m5xH7DZGWM0Sf3a4iSd5vwNmbnrVEAhpa/Qjp6F01Ok3aa
	 J1uq/YqvuLaMBrxo2PW5K3pqpocSTDndOer0R9LJJyaGMY0a2vpo3gzRzm77SxJaqIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=oO16tYxG/j6qjYE7/Lk94eKyL+WgFynqYQ6ok883GDM=;
	b=B8VaJRdQkmK/6YPykPwXXZWLtpXoM/0v/SYzx9KSJawvKJAciN6jfvmOXvM6W0at4WMq
	 sDqMZtlqA1LFKtScW/BK5GlpXFd8MSl9OFRxMqksFVVaGsh4PRG35wBYP0ZAG46mrVH6z
	 Mem7FdnXgQvlv4wvGVUvL9gQQi/+Y9AW5HXLwEX+wDG2yPrUe0aqv7RVoYYYS7OuxA1hE
	 HMkpNI6Y2a+R9tGalJzjAvSu/7AMLBUedjZTNVcfgkqDx+g8J4SvouvXONnKqwGYMTTo/
	 iNfz8408cdPaN8D4erUbx1lC1kCCifciZjhZgd/rKN6MsRFldSTDpJeAS+2bGP7M22Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CB1RAK+h;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F55606EE89
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F55606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CB1RAK+h
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4f55a53898cso1039521b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890685; x=1794495485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oO16tYxG/j6qjYE7/Lk94eKyL+WgFynqYQ6ok883GDM=;
        b=CB1RAK+hBV43O1TDJ3uk1Wdt7UA76x2jg+AoFoYcramvlyycXJm09lvfaBB3Brdp1i
         DTjlhBM6aLOW0f7J68sJu7q93geRVZoLObNnRpXnCxVoaGXM0P0UhFmhZT/V2pavjyZb
         bofXWtOoqOFIJ1Ckp99Qh53b60k0hPHoUayvMQjYcWwqahAJEXXxFjJfNsNffmCHMepL
         5cep+MgfklG5Zb4zqAkP0Psr7DP3mbZIr1RWXzUxxHB9OkGUSSCQ6DBKNcLz+OObAw61
         0KCeGDVwv58ZJFRcOZVUTOTPq2bz0eSPXmZ2O78t2JYE80Fnme3NwCzSvSpDr0mEy8D+
         5wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890685; x=1794495485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oO16tYxG/j6qjYE7/Lk94eKyL+WgFynqYQ6ok883GDM=;
        b=VjDeVV8LPjlu9vUNyP2/p/UEnrZv+5RoK7Xs1zutTJcvH6bb7pS3OuzpTnpRImYfCV
         mqARhvhY+kp+rFhEFE9TEX785iA22+Qhfd+TT76LbjIdFAm5ONEIkaE3FWOITujdb/BO
         oQZzzn6wWBB9FM00qN0hzj+j+Q6/uOhni7VV1vW4fx8gTgzoV2Q2qfo1p4WMuuZaobCF
         M/sii34vZFt1294ElOxa6Hd1BcI6Iyo+8v5fPbSdHkONAPQIAM7EDoBTtFfE7pocjWfe
         sua5W86mEV/5eH7hEpZup0kW9fbvrwO8OcDG+y30I6d+XdFmPVFLQE4xOa0Dadp1CIxt
         vHkg==
X-Gm-Message-State: APuU4Z/NkOe5769MIkczoRJQOCBTTKjnDKRQjtsy4zIK7nU/M7EfydOq
	EWzvzOZ7IVdgyndJzOjDn1TWADcZZnNeoPTK3Xr/QebHHi8aLlZCC4F3ZhWWDr+/8pM=
X-Gm-Gg: AYBFou0e7dMeW8fzSFpxiQq3o3ziRwypse6/OOum/o5/5Ip4OFrCY1F9dwUvqklK36+
	n4AR1H7lnxR6NRVNc44n8cq/xM7hcScgPDZRypQcGRGXp9hxUixvG71Hill+MUZnSVRZlTEv7r6
	QG35wYLlgmKWr+wWPXhjO3vwkCRpCS6b9lRiRvziQNgAlWHNpv0riZBYpIi8eLYFB5L+WVy1jSQ
	tnr+ONgPIGS51Nc25+aclY01DePMUXFttN5bBFdFwnFDo7ZW6wlLvKCC6RAf0ffDi5KSPVuUAku
	aUEqjEjXn7p3jDvjO3/dFIXCVr/yy7s04qZOqsOpnXYiU3+0M4XnWALpH79QciZuJIEaGVi1GF/
	CwXK/cm6XVprO4BAwuA3IED7pkyywonD0m0qmXeHbQt7UN2xZgo3CZLn3VmA1QNsHfBXhlKkmQp
	2iy0H7+2RAVFgFWDxncrNLkMw86zpC0iHr0inrU1T5QhUkEwZDZf8qdNBUDgT/GAbpzDBHEePRx
	hEYR2y99gBHnDcqBZ1sG7hE43hXToY9Xt6LOdZp3b0LgmtVrEj71h3A52qF99fhf0sqxxd/BKf7
	uag/2ga7pMi0vn1dzsRUl7nqMPurmdnz/txQqRnm8k63yg==
X-Received: by 2002:a05:6808:1813:b0:53a:65aa:152e with SMTP id 5614622812f47-5640ddca9e2mr14528848b6e.35.1793890685493;
        Thu, 05 Nov 2026 06:58:05 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6436sm4440554b6e.4.2026.11.05.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:56:56 +0000
Subject: [PATCH RFC v3 05/90] user_namespace: refuse setns() into a cell
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
Message-Id: <20261105-b4-cells-v3-5-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=1005;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=oeHv9PDYaQdozIDgTp7q3k8e/SGqvaatRSU+LcY6LLE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKJ23l1/eRpiN/QFD6DBSyXGfgXNQ7bh2H4Pq7xCGtr9Qm3+8Q1dfH501o/Xz2gXUHThvaBpjW3
 pTNWleP3mQwM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A task that enters a user namespace with setns() gets a full set of
capabilities over everything that the namespace owns.

A task is born in a cell, and no existing task can enter one. Refuse
setns() into the user namespace of a cell. This also applies while the
cell is still being built.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 9301d0d41cb9..45699a0a0bfd 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1437,6 +1437,10 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (user_ns == current_user_ns())
 		return -EINVAL;
 
+	/* Nobody enters a cell, not even while it is being built. */
+	if (userns_is_cell(user_ns))
+		return -EPERM;
+
 	/* Tasks that share a thread group must share a user namespace */
 	if (!thread_group_empty(current))
 		return -EINVAL;

-- 
2.55.0

