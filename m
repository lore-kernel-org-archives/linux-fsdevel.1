Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891497;
	b=tQ9PcrAl0GJfD6hMrf4DFai58RsJyY4173ktu+6ns47C8YDGtIrHFSYCWwKmNDOHaXeT
	 kR1hYuH/r6rytgylEiDfF8NVAZFyQwZgXgSdjw6kO/9FMRmGtFy0/c24ifVkXPD6ri+v4
	 5xR2BjN8OqvCck9aGJo97O1NzYfbW1/LVa9xueCLP6v/0Xo9UfB3tUPEy1evaKTY/hSu8
	 bH4ExvWFmlGPUB16kp9Na2RTYhhLvoPSwL5gXGJybut9C143hIWerde7AzEdt17iJSduS
	 2Kx9lADJ8WnrxbGrFXa/YV1VSRgJm7A51l7Jl9lGTFtwRQf4YvSZpWrV9JBvnOBhAEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Z4cDAXNUc3K0ZnV8t9qeV2IWpTEwGu9zEe368I5KRhs=;
	b=p2fAT2nf5anEiDdWVSyFyyQlSlbjgqMnvr3FrUK6cKGSSWBDsDNpDTiWF9qlkGZ5Y3hw
	 kQJjvG0Ktk16g3mdiX0YJauSSKSlUQvvDMq4GI59D3Oo7lZDGcHjtuaPLFc1rFThzlAiZ
	 8lWNJKQI/hoeEnGZ72mErR+bEqmCrJNn1D81JihTSiRr55qMa3Ydb8u5kkQRJexntVNAc
	 Qex2QFuXWpFKqZtV1WiQ7Erj8ocgawbc6J13tATTqRfOmKPCsnPJ2TLOn/4MIUUlC5c5D
	 49RHkFIo+hDUb0MNWia3O2ZXEUrw6ii3F0xWwKy4PG5z70GVGIo1S/1s08RUpgeRVEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Z7hjdC7K;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D4606A328
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C00D4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Z7hjdC7K
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679a2297c55so2641108d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891496; x=1794496296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4cDAXNUc3K0ZnV8t9qeV2IWpTEwGu9zEe368I5KRhs=;
        b=Z7hjdC7KFLenFl7FXbc8/a/MApH4kHG/F+vzQLiU7jpzn8lO6cElu0doYGbj7zW6Ol
         XiRFd3Qemnk/gzEpyoVOu+MXDDyoiLakMjm41/IcyK4QOo8WYNBP9K7fV3YkU6Yd7wS3
         r3GVJMcySopCMpbM9zDGo2Sa6pNH4YpltbYwPugZWWrF/k07jhUbs+7HhB1soUccTi2/
         RKHEP6tc5FUIRLvbzFWsr8YiSks4Ckpc75CQcgQgfcILuk9oTJLfNGYps+QifcaWuYn0
         3xLycrA6gF6zQP4paYREno/oc7XHNjgHNrV0ApYL9YQbM/wEi5FwIa7aRlUT2kHEMPz1
         Jedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891496; x=1794496296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4cDAXNUc3K0ZnV8t9qeV2IWpTEwGu9zEe368I5KRhs=;
        b=x9NysLckldyZYDdxx3C9skwvR3/lUVV4hmgE2+L5/0jRtQfd5nP86KF8lyaiZBDOjl
         B+5Cusb4bTuJVyACRoMetFpnqdjecPcde/USwgWQv9ydEMgotD3tN9Sv7cec75dLzwPh
         HtKgFAx8/i+6yo0nB/Fe8Uw1b5yISpwj38eTsrlYFDGAiULa2ljFWZumI9WSypcHiOO/
         uXCgJacOjAjis4iH5y9P2t6YE/iTLmSsVi6IMa75IZlpNRoGTulgiNFXIbdxIFYjsJA8
         /hvsvw7U/OJHCNL3yWnsZPz1ThIcrweK72xrLV7hrugYKGesU32qt+XSAtKjtpS0yB12
         IpKw==
X-Gm-Message-State: APuU4Z8+gT2z8yIH+Ph+mWnVqPeGSV/oBMojNVvYxKM7bZqcKeFOmaWM
	yvtgdh6ntUdk/JdM2tcdH8FcBjMSg2Hf6elvVL4qbBqd+eTLyXx/sk8ftRqoVzEk4i8=
X-Gm-Gg: AYBFou1JAlr9xwakLW7b6D9R4eHZQ2Qr3VUV/mIQkOZG3GP58cWSKyR2FBFjyFdivd3
	CC+rUc3PxOuCK2GRdEOqI9RlPPCKhZGW7Rs6NJ4m5csfEN5c41X4P/07opQ7nmbXGjA4aeXp903
	r2c+C5u//5kR65a0WpeQxqEEZn6Ub093j2uJdAX5aMJ+OFVOfTZg7vsUFOgQXHqq5JXvlcIVpdL
	ehwQ469BiJO9W6ObLAI/wr2h3jwo7YmAnIiGFxdN3zzEQ5fejo3VaF2TJacMOKy7nB5u6r9MZ5X
	FpExltP0nU0b7OmHuqKzovSne0PgXNCueZ8YvficwNv8ZxmbdIsyZu1hN7mtLZ5x8X182vJJ7rL
	dDn1tTC9bSZJWvKeMZYXgjPWReAe5G0BRfs4fwC+IOmn/l5eBzTWJ1Pv/mQwYDoQukPpNqcNlDl
	1o0M74U22mhtkQDGM6i1khXUWaXJJP2277sYyJcDrAVQ6By6VdU+Bmjui71Qfb/bh7HhmuG3jWX
	nO06dMztLpwOhlnf7RwwsDjK50SmV7ICfv7yQfSQDPgdEK0KZUHyLvovmDBgo7YazRdR6Ew4kYs
	A3NfJdDF9mKecSlbY2QzHR3NMdck9chcl3ECpTkm6uk3AA==
X-Received: by 2002:a05:690e:140f:b0:67b:e21d:93d0 with SMTP id 956f58d0204a3-67be21d95aemr4949251d50.51.1793891495619;
        Thu, 05 Nov 2026 07:11:35 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee202a69sm3637395d50.5.2026.11.05.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:11:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:23 +0000
Subject: [PATCH RFC v3 31/90] cells: reserve the "spawn" slot
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
Message-Id: <20261105-b4-cells-v3-31-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=1264;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=gcNNSOpmtg4LFK/nczfAl3jZs/cLgmyYRarla2n4+3E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNtLSJl0XJSKcO3eClfCZfC34206VfWEtH0ipup14MIhs4/yc0YDmKjrvowwvtET2E6oAPELu5C
 lO+QownXUowY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A task of a cell can neither create a cell nor start a task in one. So far
that looks like a side effect of the fact that no cellfd ever gets into a
cell. Make it an explicit rule that does not depend on that.

The rule fits the model: a cell can do what its slots hold, and the right
to spawn is a slot like any other. cell_may_spawn() checks it where a cell
is created and where a task is started in one.

There is nothing to put into the slot yet, so it is always empty for a
cell, and a task that is in no cell may always spawn. This patch only
reserves the name. Nested cells can later be enabled by filling the slot.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cell/slots.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
index cc732c4e09f9..6ce8892f7908 100644
--- a/kernel/cell/slots.c
+++ b/kernel/cell/slots.c
@@ -165,6 +165,9 @@ SYSCALL_DEFINE5(cell_configure, int, cfd, unsigned int, cmd,
 		if (IS_ERR(key))
 			return PTR_ERR(no_free_ptr(key));
 	}
+	/* Reserved. See cell_may_spawn(). */
+	if (key && !strcmp(key, "spawn"))
+		return -EOPNOTSUPP;
 	if (cmd == CELL_SET_STRING) {
 		str = strndup_user(uvalue, 256);
 		if (IS_ERR(str))

-- 
2.55.0

