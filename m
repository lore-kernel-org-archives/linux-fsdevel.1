Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441C3A7F7E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306502; cv=none; b=QHTba4xvZfwEtHG2zA3tXU3Jqc6RytrrLgXysm6yYsnNg5e/BMRYfp227coN5M5RiNEz+7Rd35bH22621kHGLMHljq2jesgeDtrXEjlrvHBdjPqe+n4KhUg6NLfx9/XYAhnpRcq0PmaCK/H6WUUipWwHSO8qXDVTohUL0JaUcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306502; c=relaxed/simple;
	bh=684ISgQ8smHUyEZZTzGZngt64u/D6u1pEXkFQoQVAfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LOIlR5pYjX1/1HDeu93apC8OPuPqQEDA0VKrd0HBMOIA7sx+Y3Z0OLSZYzWNSB6fmdJh+ybb/Z5UCx+546GblnDrsrcf8h8QZIFPWmNlN8tjVACcayydedQzPPpB7/UdbhdyXWNEtS0wCB592spoztT0/Alb0kC6ubwWohfZJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8eXktWa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuIV5lZ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8eXktWa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuIV5lZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773306500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eYKj8TYhZs/mWZdGVkKQ790hFLSyw65FsP7IykSGsaI=;
	b=X8eXktWaoAYZlSac3sD5eAAB7jeO3Y5nVdnnQBbrQuB729DFfNk5xrFJgRsWlhVxHCDPM7
	ETy3v4h8eSb84dOe6akaQ3dIi0wlkrKJuNYi/kuJC28R/0gerDqXLW4x4YFKf//accfxuP
	pB1ar21M4Ww9fHfYMrV/nnM6RAEVFG4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-iHHE4aoJMFWdV5GFLKfS1Q-1; Thu, 12 Mar 2026 05:08:18 -0400
X-MC-Unique: iHHE4aoJMFWdV5GFLKfS1Q-1
X-Mimecast-MFC-AGG-ID: iHHE4aoJMFWdV5GFLKfS1Q_1773306498
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89a116bf0f8so9621686d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 02:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773306498; x=1773911298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYKj8TYhZs/mWZdGVkKQ790hFLSyw65FsP7IykSGsaI=;
        b=iuIV5lZ6ddw7IuVSOgb6x6rFNYZrf7nWtNk2eeG09YAEv2qbBDbITPyHMm6WU6D+FM
         Hr4RpbpIHf970d5IKFuChIIBqoFRmohkA01+7mUlEGhJuCNA4qLT8BAuFseWWM9DkRM2
         ixj+5Bs0z54NenkQFjKwBBHXErta1LtF+7wB7HZkUz6PpCLGiYJYZL26bY12unCQKbA6
         /F+m7mfWBvuJmQyeqgIouYV36m9irl8HAvj+7h2h8xLNfUeusdSGW4kq6J1VlbdV2Ut5
         06TVYt4G+KWVPFEcBzbtisS84GDnJtNUtSjoVbsK4EXjRoSv1HOkTdNmLvsWnVrEzRr6
         JfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773306498; x=1773911298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYKj8TYhZs/mWZdGVkKQ790hFLSyw65FsP7IykSGsaI=;
        b=bE95Na+vOZUwelbCspI0c87vI+XmRRykYGy5rNe+91mWW69lFmkeSi+nCkAbLs5bZk
         1NE/puCYiOu7DJi5M19/V2pTNP//eA/2qw5zr0Tfdu6swc4s2EvcHNWOJIaOI0wZl+dO
         eCrpE1+mwYGnJqjcZCWnefjdtioV/BmBQ+eLuqUFu8iCaaLVkEgek7PheeaU0khCUipb
         U0hBVJCEESsp0o/NPyR1y8fKtm4l6vak7PJ+MSOHBJcE45v1G92kT8Y+pf/tgtZBIn2h
         VTxYnqHvku3tum4N+bfIwG8Jjb43bTroAe14yikyE9ugeg/5KfxqH+juct+FC1XKYpCX
         MZBg==
X-Forwarded-Encrypted: i=1; AJvYcCWFZU3E04BaLEoV70SgUOJ/A/M+heUUTJovTXjQ1hOqFZdYo17N+VGB9l1i5o60W9MDypkZh72vN+RR41dd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+aT4CDF453fRVmV50YF2lY9xOAwa2JWHikOCwSZREujuLkzWG
	SgvOZv4u7Ad407GK9nkEbyPD59Rr9hNci0q9vsUtWa5qHkexnAEJHVqFi3ThtK0Rl77oYnZPnm2
	7kJh0/5dCz4ma/7xEfYk39rlYKdmVCzPOOzUDXLs+QscA0SIVzFjidZJb8b5iajhibp2d0DMBU8
	tRIw==
X-Gm-Gg: ATEYQzysCN8mxB12Gs9hJdcfNhzQG6rMZ78CO7LHNlP4wPb6Mr6OvHyEOxrZbztVber
	V4ZpXByH7GQYjTUnqSv9V0ht4e279AiTy8WNmmERw6DIAUBI9PwXIFvUfirQtXeDJwUfp6kGymj
	P6cH+crKAmH91QqWO5PakW4FXYSUvjTx6W5Ml+YHMj5xaY4fDdp37qWmVgcXGg45TWQYrVDTvWB
	OqCEf6bqL7+Iso5aKo9x4WkASCTjBqPoMpJP3IMu3ZqMaLJMMIJ0uCBF9povi+lAFOS28HIAotE
	41Ou9EQWh94eTh1WsCFioDnZYxBv863Mj+1yeY+p5oQrIKdbV4trJ4XSTLqYByrl1Gqx2DeTIpi
	xduTt0KJH+NceuZ12
X-Received: by 2002:ad4:5ec6:0:b0:899:e8b8:8744 with SMTP id 6a1803df08f44-89a66adcc90mr72412036d6.57.1773306497947;
        Thu, 12 Mar 2026 02:08:17 -0700 (PDT)
X-Received: by 2002:ad4:5ec6:0:b0:899:e8b8:8744 with SMTP id 6a1803df08f44-89a66adcc90mr72411796d6.57.1773306497533;
        Thu, 12 Mar 2026 02:08:17 -0700 (PDT)
Received: from fedora.. ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cffbdesm30780086d6.41.2026.03.12.02.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 02:08:17 -0700 (PDT)
From: Ravi Singh <ravising@redhat.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: jack@suse.com,
	cem@kernel.org,
	dgc@kernel.org
Subject: [RFC PATCH] quota: allow unprivileged users to query ID 0 default limits
Date: Thu, 12 Mar 2026 17:08:10 +0800
Message-ID: <20260312090810.1145908-1-ravising@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Default quota limits are stored on the ID 0 dquot record and are
applied by the kernel to all users who have no explicit limits set.
However, check_quotactl_permission() only allows unprivileged users to
query their own user or group quota via Q_GETQUOTA/Q_XGETQUOTA.  This
means unprivileged users cannot discover what default limits apply to
them.

Allow any user to query ID 0's quota via Q_GETQUOTA/Q_XGETQUOTA.
Note that this does expose ID 0's usage counters and timers in
addition to the default limits. This enables userspace tools like
xfs_quota to fetch default limits and display them to unprivileged
users.

This change does not affect Q_XGETNEXTQUOTA, Q_SETQLIM, or any other
quota command -- those still require CAP_SYS_ADMIN.

Signed-off-by: Ravi Singh <ravising@redhat.com>
---
 fs/quota/quota.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 33bacd707..8b21f3c1b 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -42,6 +42,9 @@ static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 		if ((type == USRQUOTA && uid_eq(current_euid(), make_kuid(current_user_ns(), id))) ||
 		    (type == GRPQUOTA && in_egroup_p(make_kgid(current_user_ns(), id))))
 			break;
+		 /* Allow unprivileged read of ID 0 (default quota limits) */
+		if (id == 0)
+			break;
 		fallthrough;
 	default:
 		if (!capable(CAP_SYS_ADMIN))
-- 
2.49.0

