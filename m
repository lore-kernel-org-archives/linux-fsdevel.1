Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890693;
	b=eZUrySn8YWjToaxwkC3VXT6yIb0dR2pG/6G5y+HA6Md4b1X5KTwHqE1EqYgvUxYoDkZl
	 M0d8ItAbOIJW4ubJho0d/WEiubHt2wtBQRtewD/4OpZPrZ0VxUvWB4+1SqkcQeanZmPVE
	 0KLv29XdK21n9bXhcz3qdQ+QbcD+hEC5k9jo9Dx1Bz6ds24IilQjKsiGTvzvbt47uA9oi
	 wdMKg9NFG8z4x8k1WOqZ2wiWNRwldg6OaY94CkzGKRPxvOfTvv4RQEwtslIgOEjDcvr40
	 GOhjBZA3vEPW4t0/zxnn3Yx4LJ5+w24+WgrTK5dGrDcgZ7wxQUxg1B8ZSgLKj4t6PAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hn7DIyqNuP2b34oU9g9Y7BteCnzfw59mx0fOP+oR+Qs=;
	b=HnOYURUbwQQNb8AZJdddTMhhO9cKzP7C/w5cE8EjPlosX26rMK6+fvHN44lEitYyD5V4
	 TePxJbCZivvQQiBcFRunNbnCr+Z+Aio0LPuhGvqiq+XPvTDAedLFlYNUL9SYAtRLjIG4m
	 6bMEpNVJFkRnxTsmoguT8KupP+MWDERGcAiptnKRwFoX9LWex/rIXg/EQX17uPWzLFrQb
	 XlKuT9elC420WFxbIO9GwnpAN8BLiFN8QVZOD+cyg5E0LNwOByaS96mbVF6EvJa2dHETO
	 aoyIi2vuK6tw6bnMbHeTODbQEGnjl/eeCkH87CCrI/fV6PbYcFBBu0CRGrmxAIeznaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=r6sqVUZX;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF36082BCC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79BF36082BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=r6sqVUZX
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-5642e0910a3so1015666b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890692; x=1794495492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hn7DIyqNuP2b34oU9g9Y7BteCnzfw59mx0fOP+oR+Qs=;
        b=r6sqVUZXivVnJbefEQtEiFNwFztPYbz+vit53xzJ32f9GuGRyifwNbUPnmJjDLg1pD
         QOGCSejdWpaM8j+jlYeCdOmoZDOVsgYq2nQMkjhsr1xBQkDA7UN0Y8wWz0J3RTUb/8nd
         sGdF7/j2btMMS30JuXyo95RAo5FCzkMhHPoul3ZTSHqZXl47QRESYXHW+3G7cjh0ewy9
         Hmiun06Af9rgjJtSPfAVnxa4qNv5KEgihX6U2sNR+x0K05jmJ82ssN9H5Yod9R2LMlS2
         R34jic2/N9MWqpjVEklzTQ0CFsXcnvL4ZzHH+d0Q9B2Gk+h844HLz+CF4PQNg/gx3KGE
         BdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890692; x=1794495492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hn7DIyqNuP2b34oU9g9Y7BteCnzfw59mx0fOP+oR+Qs=;
        b=L8UYUi8BSqWhodANZy/yLcG0xsxvRIeNIHQK1BQjfvccq+LXvJa7lbI3scTnPMHOg1
         gzi2iJBrXh5so3uPQ9jyJoLQfwaQ3+ifwmMMexNeAjZuFSh01+uYcAE81RyNmf8CTiXz
         CS0Uu/4W2B3NsfNf2yHSdF3e7hAyboY9PhDcCX8DJ+l7PE3yTnx8z3xu7WI5LV0IVbmI
         bYLx+4h92mdvyM4e/Ty6Bgt3P1DJtOPACBzYNN36GO2XqotNweaGKJFAykofONkxL76K
         EJ29eA+W7EG40FAOm7tSDW7vKv8zjkSMCEx8fx9f2eGWz8WGzyyliiKlAI8ZaRVEmheh
         Z4GA==
X-Gm-Message-State: APuU4Z+WegNyQxITnCfyAuFNZ4Ye3CdrXWq6XYEKq2ooJzB2giFrAKKC
	QVIWgpD6GZWnAdCIP5pjpfPaC6uiQ4whkhZDkx4jBoJyP1kIu+X5xg2axOSRME27fw4=
X-Gm-Gg: AYBFou0XdE0dsQqkTNOuzSsn0aCXJy3sVMMcn62vcYA0wTEP5zcDuF0L9Cm9uMYvKa0
	3Gx0Pqs+71lj9QBiow5B348fwggnZqIcAGz/5IDdWtjLWb35bhgp54xafPYIfzmKZ0PfYulk6jT
	DcLua9UdGiiO+8Z3IU1F5kdIKnlme/7Tlk71ZvxLuVIN/nd047RXzzltdSJ5G4PsLBbG/KBLbnH
	pz/Xz51Wc1kHFzGtTJfI64qpFeW4xvwFbXrVyDp1xTNEQU21XagPSkjzNViyEurIVZFyHBvZzdg
	Iaq8TwJwEmJNIg6ZgSS4tl2AgniRXOLQMDwQc2Fn3+GwuHNF3Gh29M9MQhrcVByYwy5V+OfvMbT
	d6uX3UOMI9+mKBy8AaL0fTBcfv3el+MlMmjNYmpkzjCfpmdenUcvEFTlbw7Px61hHoSCQivcitt
	GQyog3sCM7i2ePTfD/EnkWjyoMu7xuf4oO3PNyWfjGuFT253r30WjbhlNG2pRzTEgIuoGDYi7Pw
	sLtcuBFpuf/d+FIsAM5cjsks673VtbBp97RyuTvNNB3i3h/IgWdc8ityl17ppvxdotLOYrAtXUr
	47GV+DTrqZ2rXOMjs0pKGWGlPQYy+0WIjmp+coL8o1riuVeylncsiSs/jDMqHbSuM3s=
X-Received: by 2002:a05:6808:bd1:b0:4ca:8d6f:4258 with SMTP id 5614622812f47-5640de8c633mr13324711b6e.37.1793890692296;
        Thu, 05 Nov 2026 06:58:12 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567ab6a5270sm4310420b6e.0.2026.11.05.06.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:00 +0000
Subject: [PATCH RFC v3 09/90] user_namespace: keep legacy maps out of the
 window
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
Message-Id: <20261105-b4-cells-v3-9-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890669; l=867;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=3DNbAiv5YY/0l971ScuuIcWBF9qKpzQCcQBZsUbf/bo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHsThy1r1UYEjK3Ww+H6ETzMdfrQly9RwMuJS9o3wIin6wDLUFrSpakc0HOSoVO8JGNh8l6VjEK
 gdSoxZMjjlgo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

It is safe to hand a block of ids to an unprivileged user only because
nobody else can hold an id of that block.

Refuse to map an ordinary user namespace into the window, no matter who
writes the map.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 4155e2e77497..5c2cf3dc02c1 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1230,6 +1230,11 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 		if (lower_first == (u32) -1)
 			goto out;
 
+		/* Those ids are the kernel's to hand out, to cells. */
+		if (cap_valid(cap_setid) &&
+		    cell_range_in_window(lower_first, e->count))
+			goto out;
+
 		e->lower_first = lower_first;
 	}
 

-- 
2.55.0

