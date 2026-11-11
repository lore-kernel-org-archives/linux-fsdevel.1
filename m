Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411402;
	b=24PRJJg9QdnSDvaMENuuYPQk+8DFDFuxAfzImvrmq7Q8989lQBARNclZ+RRjRotmVyet
	 xhSqWnrgJb6Bt/xrDcJO8r97CsjWG88ejDduz9ouIL8B4x2KdRouvvTV9nlCFTJWpMttP
	 KHpH9cAMKf17TGR3DXYvPFPIdMaEQeReywaoAe2hHr4UGjTjx1OZFAy2uKHqRhzP22lKX
	 NkWRGMv9xV58bLkRgl2ivE2HysK2KXCcTYiLRZQledBlz7wk1fmDhMAuxiDJFGHLfZTH8
	 tYNP3254cGK8j92MwPIsA+Y2nxI1Q+xPXscpLJO3hfpEtFhCMV0PjgOtq7HoP/klF+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WLcBvS1wo6PalRepYxsgEvCEQRFCjKivXNWNUaVBAyU=;
	b=AeD1YrNewSp8WrJt1upxm9/kuQQX1ASrDQKvC4t6+qR3Pl7yYZrYoJPXvdoTdoL03yB/
	 FPnr6nO8EAWZ739gq6IJAFxykkSruxjPx+LFhbAo1GyNgxIPTV/7AFTQZrQ400TvAJ8M4
	 mNNZDP8hv5dzee59xjOlvrjEAs9DDQH0jOHqxggvcYQaQlirjBtg07zZ7wCxVKIvWF8SR
	 34dzZDAvqJ7iBxBkFk9MrBiskLyYFaURvHiAfNirc4xqpbUujO8qNcTHDOTizMAlITqOU
	 GuWsQAQG5yJCz/Nq0U78hSIyAp02nxKBDxEtrg9+/dF7GaK346RH5Ff6x+ETdtIpkoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=FwyL3hSU;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13E606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 15:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F13E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=FwyL3hSU
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214af2076so24531285e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794411400; x=1795016200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLcBvS1wo6PalRepYxsgEvCEQRFCjKivXNWNUaVBAyU=;
        b=FwyL3hSUGlNKpBaN3xRyuGkQ+pJi0VgUflF/WGw3DxF/+q9cxxBZ7lbhfpJEtzp3BA
         TUvQgTh9CTm8SbHSHz4yLrjjEUBPJqE1uiuKtgdJE258fpeX2Mw2zZCCZiO3F74KO7Yc
         s53kuaqhoKeZ4WAzIwJfarc+k9xnE810zCSo47bj9yVKImNlF9hlQ3HUb6dBJXe6xc8g
         TgTKJjx6ZsUoEuCrs8+7jACxCMv6+Of2pmqHbtjJF/OIci89SPJh7HEGrUmbqitlyKyo
         Xtx7Lx4O5UKsFZz+2HyO3Ku9s6bQep0PGcFZwPSV98BXAA1xviFl+sLoqo9qod9JCBAH
         N0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411400; x=1795016200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLcBvS1wo6PalRepYxsgEvCEQRFCjKivXNWNUaVBAyU=;
        b=DBCXICiz1w3QfPntBz5rLixukL86XQUKfZWqRujwgh6WA+rfzH3Zw6zz25w+TV0vgJ
         VUkK2hOsWamFmrs/ElYjPzDNtnC/T9IDXA7fpEuiKfpG7oh07ylkqr8XVYZQT7s7XsdL
         x6FB3yBLdq/imEmu/G2AHcQqkJNqV5KVsKSjObwS92xku295I1qRAsPwOxfWrab6lTff
         gmr42B/OUVSMEPPb96ac1swlO2CD4OgJS3L5UYaLJFB6Gb7W37cnrnxGMmTdANDcAnd5
         pOPkk5sXlbgjxU3j9wCl3e+eVwQgW+QqYx8sM6ZQpfnf1hu+GvZV/QzSCeNIJjmG00eE
         hVvw==
X-Forwarded-Encrypted: i=1; AL+hErGjUa665aSN9hr/NY5mBKnTDOkYYLia7cDWGcs2i7QCDdTM3PfFnpz61P1aC8IWqPOzb85oROs3blVI0vOs@vger.kernel.org
X-Gm-Message-State: APuU4Z9a9kuRVmmWCXqT9wGQ/lecbKqZXlm6j5eg6jEtG8O8eOQYErXr
	I3qv2LtcCKaKkrmJraaRy3wlH+TCoNSc0fRUNt5vy166VHcUWl+ZWoK59KvDkVoWaRk=
X-Gm-Gg: AYBFou0b8OKSIP626qWyvKfMLC1PIDDtR5T/P+LNJiRBshhdWN0jaMmc8tGlTf9ELBE
	JDkAwhl2njzrqMv8ty5ihxcxbjJ2YDxKxhsfrUO0tSnx6oWzYNDa6auuezkBwL1bWkBIyDwgv5V
	g6sFB5mPLCr02+lkG+HYuv5n8FBy2EXuV8lwCSW8Kp3fjQtNvCMZxQxYsRnuXNgaScpnxyCYM3T
	54gw9UdWfiYbnWd0LP+M5izQfFLa2xt/QBewWydZ9XwICXPEi1JOSBtYT7SFch0y/2M/OIcJY2r
	qjpVG3Fw88NB2KwvMEcBa6y151E52NALujqq/U8frzz/OvZMMep9wu8xLl9y/JAIh5EhGU8iw5C
	hgGdOPYHkGujac8Yvue4gaL82aS8d1JWP2tM7UPvfQ2OIFbw8/+hbSMZ9hVL5ZSP0Qemm7AG6YQ
	2MB5KHbU+9Gvm06w+6xOeJYZTPQKQWETCxOlQBgcZRcxSCfwVJVFnjZ3HGDgZwRnczX4ixMMoqt
	+eKa6T4aXb/hFxVbOzG2w7xARyYzS9Y+vlJQCpBVcQVm9RjjwmPWsMddBclVkeEyinfe7P5pL8O
	lxV6KfdO18to3lKBdZaWPjyrxM2bgPWkL+yEvzg+BfKqs5Y2XueMtspk5MAblgIShNJWrZ/AMiF
	n/HYLj7q1FJ47yzFUsxp/VsYGRRaZ4A==
X-Received: by 2002:a05:600c:1990:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4ba093771d7mr51927585e9.21.1794411399817;
        Wed, 11 Nov 2026 07:36:39 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a3fd2sm12408663f8f.52.2026.11.11.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:36:38 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: pack fields `i_state` and `i_fsnotify_mask`
Date: Wed, 11 Nov 2026 16:36:30 +0100
Message-ID: <20261111153631.1309838-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both were 32 bit fields followed by a 32 bit hole.  This reduces size
of `struct inode` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/fs.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77..9ab028dabc1b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -813,7 +813,11 @@ struct inode {
 
 	/* Misc */
 	struct inode_state_flags i_state;
-	/* 32-bit hole */
+
+#ifdef CONFIG_FSNOTIFY
+	__u32			i_fsnotify_mask; /* all events this inode cares about */
+#endif
+
 	struct rw_semaphore	i_rwsem;
 
 	/* Timestamp for writeback list ordering and age checks (jiffies). */
@@ -865,8 +869,6 @@ struct inode {
 
 
 #ifdef CONFIG_FSNOTIFY
-	__u32			i_fsnotify_mask; /* all events this inode cares about */
-	/* 32-bit hole reserved for expanding i_fsnotify_mask */
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
-- 
2.53.0

