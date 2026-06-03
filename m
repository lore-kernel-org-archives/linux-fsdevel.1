Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655B223DE9
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445751; cv=none; b=RYbxI3paj7Lw9rz0ZznpBRj2cETerFIThpSexIl5/TCzkxHioxmR3bHMTU/bLtX8jq8sRuRcHKSACSJRyKQKt0PMjtb5dB0tezRE31Vqhe3d3jG/GTEBA1aYjDX/2tNenIXC3sffBu2kEPg2Uu45VzR6lo3ZPqT31YmFyEKc8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445751; c=relaxed/simple;
	bh=RAII8uf5vXZDzGDv43KJHEi4ttduXQEmEi0GBvJ2fP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4O/z8kgys5MK99Ff2vteT0ZTCDAm2sQx79zkd9inz84Ce9LLfNPHPQwMKy18QkHcu3J9gX+yoFeCbOR5ohUDPVDEspf76x4Ipqrq/C4eWZWDSVaOi8tLgoDPLGsQry0ym7cwVRX60tHocg2UI5E2lJuXtBZOP2BMJljm1GmPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcJ7XPHE; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcJ7XPHE"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-304ec41197bso5119987eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780445749; x=1781050549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nd1qlp3StXzhHoHvmBNDlwVf9iOQtt7Zdy0Ey8CkHxE=;
        b=AcJ7XPHE+trVAMKeZix7QPO+S5pQ6SPhVBRokgb6GXsYWyqKmFDWkR7LNKFW/ydHXw
         fhWahSo323ViLe3bmrpYnI/dQ90GbPzN2E9ORiyRhRyYqiDBaQkSQfdjAjGyyAFiRejN
         9W+AX6Kz0655uNm+x+3lq2xCXxcZS9Ge5wgvdbPpldCjdmFahygLYDgDOU35PYjPwl8j
         SJ1Zi+5Fo2c2px2XtI3jeoF4j48ic0exJM3d7omvmPXd0kFmNs5c+zMNaSWlNn9CUGqX
         1BAWdmOewcaFU0JK+f9gdlU6xhQ80e4fJzm10auiZOcMHc/zifRB0b6Fxl+yMu3+ate8
         M17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780445749; x=1781050549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd1qlp3StXzhHoHvmBNDlwVf9iOQtt7Zdy0Ey8CkHxE=;
        b=Q60ZkSHy/MFKgbsY78HcG5gfUBAEOCUqMEzMaUQUQK+rtdn7AQA1vv56p1dyKr28Y3
         67JJTuruPKpKlkJyRIQROioqimi2E7wmXLWUn7oQ5mqpUKRxLJ4KicdytW+0eCk7VGxc
         cft/xr0vOp7FHUfXUVvb3JTS8lrJwrdxHUhRwLH2Tt1jL8652arOTMBFXjwYEVQYVOkr
         Lw+FwWCZZusZxRmR2bhCllCjAA7HUizlT3Yf+5XHddC7gSXGf9Q+HNiZIJuPA2nvenxZ
         G9S1medGOWAr7bHt/67/5zegKPGuXAP51MoMjR8A394Ci8q1vPZEcd+mKaGmYmnOQWyG
         oAMA==
X-Forwarded-Encrypted: i=1; AFNElJ8yedSKkdpxZkNtYmnZJDJDjdiq+SQJluxyOxtS1ZZCd42fFxKREsq6LS41VShgTVSRYwd5IfQPHyi0gBxg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BCypf7m5eoF0a7xiaIsqmFe3sDEUGxjpnqx7KE0ZW5hpG7mm
	QG8aP3XKTiQPH5ucGH0ki6K8KK9gnWz4k8mtUwAqsflU0YnB4TO1Ghpa
X-Gm-Gg: Acq92OHudFKWMLH1cCjhbL0BkXrCPYqduCzqHEllIZQmhBQb1yIqUB/gN5UzxU2h+kT
	WYJoHn/SGwO9k5cXMOOhxPTdzyjMwWCUVpOwX1RzhPM+er5g1I87SH5qO2MHajhV9jmZx1q3mD0
	XVI3PEBhK3yZYzIDaA76nzuPSvxyjXatoVAdyTEJ8xLbrSmIi5VZcS6WfMCjt46efUdjuNJW4hp
	Ccqr5JnkG/CfJjaqPXSdp4q7+xQIM6jSjLdNW7C2k0CO0uxwty8GfFqlN6eIMmimZap+5/hOmY+
	l9rZpIxhZgHW1DbS6KgrSeORSMvUfTY/xf/4jSHh1580ABdxRePrxW35a7hDGyRascsNzw2Z50H
	x6zVXpvJYwviHNsHQb9TKwjQPEwyPjjem/3Y/VVBD3s29fGqcczp2Nx5vniSB2UOQCSjyvSzAHa
	9XvjwWyxKZTz7q932mxy/6HjOjNFVtpA==
X-Received: by 2002:a05:7301:5f8c:b0:2d8:7302:d3d with SMTP id 5a478bee46e88-3074fa64b1fmr563586eec.8.1780445749252;
        Tue, 02 Jun 2026 17:15:49 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcb98aasm829069eec.12.2026.06.02.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:15:48 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v4 0/2] fanotify: lift pidfd reporting restrictions
Date: Wed,  3 Jun 2026 08:15:14 +0800
Message-ID: <20260603001516.26234-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pidfd API now supports pidfds for tasks that are not thread group leaders,
but fanotify has not caught up yet. This patch set lifts that restriction and
allows fanotify to report pidfds referring to the event-generating thread.

Additionally, this patch set allows fanotify to hand out pidfds for reaped
tasks by registering the event pid with pidfs when pidfd reporting is
requested and dropping the pid_has_task() check before the pidfd_prepare()
call, as suggested by Christian.

Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
Link: https://lore.kernel.org/lkml/20260602-patzt-sturz-segen-f1f305d61b75@brauner/

Changes since v3:
 - Make fanotify_alloc_event() fail if pidfs_register_pid() fails.

v3: https://lore.kernel.org/lkml/20260530013732.50811-1-anonymemeow@gmail.com/

AnonymeMeow (2):
  fanotify: report thread pidfds for FAN_REPORT_TID
  fanotify: allow reporting pidfds for reaped tasks

 fs/notify/fanotify/fanotify.c      | 16 +++++++++------
 fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
 2 files changed, 17 insertions(+), 32 deletions(-)

-- 
2.54.0

