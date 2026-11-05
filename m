Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890716;
	b=QZx8/axf9o7h6jMJqhKG+UIQGoNNmE32Tm5+do6nOtWtt1EVNwjFbO2MMoa8GPXhhtL2
	 f54K+Y4uqnHePnIscV9yVyThfl6V4cI+Z4nQ3bOwJr7Vmkk1I3eMPYhv22YiMZ89hN61j
	 NHyzciL1dqIxzqomyP83uOv39J02d0F3PGWuIn1W20m9iunXwjPKvjT0vW1YMg+QWYlFW
	 uKPXbqr8PQoofJjtrWYGPEXIe74yAMyeBK+ncECdS/1q/z1aGZLsgPcCzY0g6gPxCRGzb
	 aUzWu5WcfkN0/vDavqYwShI2luwqSYkkgF6S7k5gykROu3Qzp0w7yP91P1DwKOrs2mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=wNn/hkKgF7gP2pmTvef/IRMHIXPvMFLFwDwyb0gIb98=;
	b=45LwVUMIOp2FogLMhfzOz7EopVfwXa1xsSGf1msQQcYV+z+FrVPArRSGq4hVtNTKqGVP
	 E6l8u+5wvTBe2tFOgtljfkR02kEQBy4H3MLXKFpgJ5tEkzFtOT87bjY3BTV8vhjpnayaq
	 II+LlC1oIUT9diJDz71YRcE+kdR5rYtvRqYs9IaYPe3tJqReK2nEAP9nfrc7h3QhVqdLk
	 wyjkL5a0PCtAjmLOJ6JaTc0kEgkR5L94IWL/+dP8HU1E/Yiy7uXu0eJ//DJAUr9Qnw2Vv
	 hq4PoHDhbAMUnVwBhLo3LaxDmlSkszfcMsXe/M4EmkIplhic0VZehI5YDUiPMDI3G6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KSs1pLk9;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13560A381C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA13560A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KSs1pLk9
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e635220b4so186553985a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890715; x=1794495515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNn/hkKgF7gP2pmTvef/IRMHIXPvMFLFwDwyb0gIb98=;
        b=KSs1pLk9IWZryTUYiWbpfpzAJbqNtYjaSMBC7AJbr3EbYbgLRfKZmAeSxMj7GY7ZcA
         54ht5If/LkpKzh5yJqBhBFv2CRsiI+1+G1IbbGSvrqTV1BHLogl62XEiyS/KAFucXcdv
         raquMIYXaDmYPBk+d+2HO/GvTBWwpagCTH+fM1LMT44QLNm+/dy3sbTW0PGj8ZzqxdSV
         k4FpkrqteEidmMMf+SEDMaTDg9r+X0RXROT1k7WXeyHO3VWoDRUcj864vpGvO6pY/C6x
         966xJ1QuXoazRxjub2NmGHH33eTcTxHZxJZH0bBrp/L5w20NAYi1+Gjf++xJkXruJ9EZ
         fwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890715; x=1794495515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNn/hkKgF7gP2pmTvef/IRMHIXPvMFLFwDwyb0gIb98=;
        b=gaFO+p6TgxLp3p4B3wpzUHt1KWD2osmmvYiuJ3o1sYh/mplBavoSPLbViTSieXkC4T
         ETZL1ZbEV6Gh9K6HVGfpJanom1GfjtlB0D0lzVg4W9lmAIuA3JnSDHkOLZ6iWJ7l68Ps
         uzKJjf3umZrQEE7cIjAgMKD3RshF6UbJkES3Eu5lv1mxkPk/Fx65aTzy13NPIKZ7inYD
         URNcASJTcONV6kZBy9kXHctDbrlCkKN4nJdWtwiVkMRgZKpHjr7xvFoQE0e1/Xhq0PUt
         wWnz+d2JP+6Q/gQikbRSPJW96gQMoH183AiKLe9ud2zFfCeFyC38XYCaiMTrb5KlAHpY
         meIQ==
X-Gm-Message-State: APuU4Z9l5J5+PBfBHg6zEy/hkFFTkLlBfQ0wLMvP1zNfgau3F+opBGAP
	/jQJVHqbmlBzY/cl9AqsvV2si2dw/hjxilnc6DZgpTB3D1YcZ37QDsFC5wjPTgU6+Tk=
X-Gm-Gg: AYBFou1zG40Z0YICj6fFewPPvZ6kt+y1E+x0JqYLBl1MIjeeKCKMJQT13IeIhj1mOVH
	yimr25LWuKY+fTakC+U2qkQKYFo80rqVLT6fK/B70657Qoig2vOhVFldvn+VfnIowT4YA+yqH1Y
	TRUmSpQuOLnmLdWH7yGnpCs6waWedvVu5ghUt94TQz8f653s+zHuPwYrgzoYoxczj5finEEejrQ
	RI9BAnZo0oG4dwTIROZhZfyk22L2gj2TL/bPuoyH7gIFnwPwuhzIRHcKdXfgrRckD87bUHv8AaM
	PDqY7lAZ/XYcJlZA/I3J0xGzK8RqZwwWO4gHBFu0Ho20FpXP/o69qJVMM/moLsIIxaaMt3x2cKS
	vbLgcmdHPaWPbmVG4KXfH441V6idAd+Gs5bEL1zDlDqU69GsFLr3uVipajtjO+Wz2SWTj20ZdHS
	UVvvD1mb3hO8S1nP/BnDR6iWdm7E7mRNhm+Pk1CSTbhaObh+mCYG/lqTkGbavGijEmpgTWszt7e
	2ap7+Sfm8hrZ2tCc3Gw/skfAd5B5L+JlVWKaGXdEsZG8thCqy5clA/l2a78dcb1wWvu4vbtzT+z
	oCTUJlqdQrBUAAhEXPJezGANWPfB67cm8BRAvYraUHiUqQ==
X-Received: by 2002:a05:620a:414f:b0:93e:9171:b83 with SMTP id af79cd13be357-944216970c2mr3290481885a.43.1793890710900;
        Thu, 05 Nov 2026 06:58:30 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4813a6fsm480460785a.21.2026.11.05.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:30 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:10 +0000
Subject: [PATCH RFC v3 19/90] cgroup: add cgroup_cell_kill()
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
Message-Id: <20261105-b4-cells-v3-19-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=2413;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=lrXR3eWWfGFuCEHq20WRo32/lde2D/wq5xCJx3XPUN8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAAUw7r/Z8aogW8tutRr3DqJtm6L2omqesHEDbkUMtyrwHdgKy2KT9c65OWJjDfhJDMUxDlaDOP
 czr6ifynkYgA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Killing a cell means killing everything in its budget. Add
cgroup_cell_kill(). It does what a write to cgroup.kill does, which
includes forks that are in flight. It also reports whether the cgroup is
still populated, so that a cell is only reported dead once nothing is left
in it.

It uses the populated state of the cgroup rather than a task iterator. An
iterator skips a task that is exiting, but such a task keeps its cgroup
populated until it has been scheduled out for the last time.
cgroup_destroy_locked() uses the populated state too, and it is called
next, for the cgroups that the cell created below its budget.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 4d9baf195f1e..57a4037671c9 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -155,6 +155,7 @@ struct cgroup *cgroup_get_from_fd(int fd);
 
 struct cgroup *cgroup_cell_budget_get(struct file *file, kuid_t *uid, kgid_t *gid);
 int cgroup_cell_chown(struct cgroup *cgrp, kuid_t uid, kgid_t gid);
+bool cgroup_cell_kill(struct cgroup *cgrp);
 int cgroup_cell_budget_put(struct cgroup *cgrp, bool handed, kuid_t uid, kgid_t gid);
 struct cgroup *cgroup_v1v2_get_from_fd(int fd);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e5e6761522eb..75f8367271aa 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7199,6 +7199,30 @@ int cgroup_cell_chown(struct cgroup *cgrp, kuid_t uid, kgid_t gid)
 	}
 	return ret;
 }
+
+/**
+ * cgroup_cell_kill - kill everything in a cgroup and below
+ * @cgrp: the cgroup
+ *
+ * As a write to cgroup.kill. It closes against forks in flight by kill_seq.
+ *
+ * Return: whether the cgroup is still populated, as cgroup.events has it. A
+ * task counts until it has been switched out for the last time, see
+ * cgroup_task_dead(). That is longer than a task iterator shows it, and it is
+ * what cgroup_destroy_locked() goes by.
+ */
+bool cgroup_cell_kill(struct cgroup *cgrp)
+{
+	bool busy = false;
+
+	cgroup_lock();
+	if (!cgroup_is_dead(cgrp)) {
+		cgroup_kill(cgrp);
+		busy = cgroup_is_populated(cgrp);
+	}
+	cgroup_unlock();
+	return busy;
+}
 #endif /* CONFIG_CELLS */
 
 /**

-- 
2.55.0

