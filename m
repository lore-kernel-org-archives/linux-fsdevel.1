Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988636;
	b=2CYqqg93YKfshKoLcVQD4rgnGohI5eGu7Bhz4dnxNX4rmiaQNZiVn5wGA+jvHnuFcm45
	 BDXwbtHmcDgDUiWQUaRP8uX9V/HzxpiCb42gujS7aqdmaw+QVcCZ9swGLM72EiLpSQNh3
	 N05BN4Y920nOwytF2SxDT0IG5MbLlxuxxPFr47WnSZzsH7j0KUrsaq4jguh6Z25y6W+jm
	 AGm3HzHcTPWPbeSjoIDU86YxNoegkoEYzQh1g9orlapLRo4fXdZLGQ7Yui5LMOoWsXi3J
	 5jttZ8EEToSnhSZ/uiJ4j8Y6qGw6t1Na43vrIKXL+FaO8Iz1kXVip6njCzMSU4u4w+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=srzoV+ideYabaTr3Mldr3P6lqUJLkQHddHcBO4S+sFo=;
	b=ObujpAT1gTQFWqV5n1xmCXmMz4xKbHCQdsauP2/oIvjk7yK+XffX2p695XnLCh/RE5tb
	 YFcTAVZNdnktRz1WQ7XmU0+ZjLKKSFIgv1RnNz6VUJWKq2j+SNb0dqutMwnlzky7Zzkp5
	 5JSiksgSTnOdMsOTe8Th8wmzEIJUuBv0YXbrXCvZJurcvzc3tnhscaHWTGFlToMdhg04V
	 Eqm7eD12u/UXHcz9uyQ99OA0NbTOu8GYfxnSI1Madmp4TpXoCXpSN1bN0uwrWV1wdnBka
	 5njOTjRGOuoZdnM6+Om26iNrMW3RLAIg3g+40+nk+//XOzIEBbzCUDbSKWrChsJHgfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BShUJPYf;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5B606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 18:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A5B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BShUJPYf
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so11828675e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988634; x=1794593434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=srzoV+ideYabaTr3Mldr3P6lqUJLkQHddHcBO4S+sFo=;
        b=BShUJPYfR6oc2gRoPqvXmoTtBY0FJt+yRk4EMOurIBf1Q7sAGmy0J47znQU5w+oIZ1
         ln0A5xuLTf8OKmdwFqm148fdKKveHP7B2cAN2OqsBORpfiDIMGyAUXBO3dndeyVkNJfP
         ueCJjolK6LBpTRfPymOWJIg+WhkTquwKHbWhlBp09pcl04F2UaiHZwGBmSMijeQK5CF4
         /Hu2rPwh7KmF/OBjAKgtXRLMtBUcTKu0IHuRXh2kWwLwccuITy4XxFwVqiYQQEgrChOO
         c9gS9olV2du+aeTohB2hDP9AXDtC4GLRhSJQWRAXCMaOzWKySDt8Kd85l5gBiJwr2LtZ
         4yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988634; x=1794593434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=srzoV+ideYabaTr3Mldr3P6lqUJLkQHddHcBO4S+sFo=;
        b=zPLV7QLsZXBfSS5i8V8LIPRs6hk5/9Z2CLHBPCYe+Nc1CeEd/CqZtfJvt3UEER20mc
         jH5tY55uTo9ogbNaVC+dgyoR//CqDcajAWvYEiQ+mP8yVCqiLhQkdKp85ubVOucm5A8h
         DPzBPly/dBb5KVfQNJ4y3+UcCqb6k63AP5v3KiL6GFd7a9LDXWTWxASWc8JWlspKkIH6
         /xLKoKa4YZNfcTXv8JbLFGgJlq8o9QLvFDLk9nTEWV2igfHj1weSjX46fL0KRXlY9Xcs
         7DbpnCKinwqqjWJDSkj9gbwLJXp8WXQycP6gCBrDqQNghG146U0aOdPwH5SU9vGsbzA2
         F++A==
X-Forwarded-Encrypted: i=1; AKwUvBzGHo1aeObKANoZKzE5LAgSUhnD9gILhil5Tyo4wioJbv3mDnpkXd07J9fnA3j0lgTVhYHAOeuzKQCPHaTC@vger.kernel.org
X-Gm-Message-State: APuU4Z/SP15GnF0Wa+id+oyPuUExvaDAsqOEwP6DRJ5zLp9CyNpsM4dt
	9xM60nTpl2tDzhB4K8ppHcql59Uk1hK6BUeHJFYIbjILdsKQTJFFY2yR
X-Gm-Gg: AYBFou0vTt1yiSu0XOI1OeK6kkzK3B4Wm9tXhuBlFItoToxJ0EiSzNtLXWYFA8Y2rxC
	0Niszs3kUaCc2wlvEqO2DlM16TXU9+kgIbaOnpUBoCE6It1NU1CISM+MNhojMiLLCgaDSX4DwxW
	pbe9/htHlr9KGIe4ChAhXFLpPwAdh3EV6MmbOi/hSYKjESe14vFi78uPV4gaqgfyJoRcQ0GQrLs
	n5/OiPcuBIXxP9SfEhzwEx1BIEJ9y66lnAXfdm05tUO1Fk0Y/IxsLICY8mNNBuM38uNIHRbGsBN
	zWIVvHD3YQfuSIWjxmA8FMu9+KWE5LtnXg8ewj1hzqom1XkdLj5GKqmoaJwfXkCMLe6oYO5ZvFu
	1w79H9P30a1hWN9yiUaHBsIdbuxNZpE1tI62O2rYFl/UrpP8v6X9RQFguhWL15OIK3ABhAuj69d
	GnUKwYXIwCT64Zh+D06X4gkpFUFLdC96VytNOvn9BnC+Z2Z32lTxkKRzhFGttzY1UKmzhMc/dgk
	i6hrH9UbSQrOWO3SfLccnUNp861Pw11ok8D4sGkKcmWZstFqk578CGnhf8t2gp+oX/ASmiQWawr
	uThiSja7/q6PU03rsRdqY8SFNFW++5vaXNTXScS9M4chpaPtme7/ldn2/uL6tSXQYvucj8uNhSG
	P/WECmaETw3C8PLOL33g47T6LJ5XygaUEXd+su6qx/RUN7xUScbFXzM3AefVA
X-Received: by 2002:a05:600c:c0c8:b0:4a3:2f35:38b4 with SMTP id 5b1f17b1804b1-4b6e5ab6ea2mr38781175e9.10.1793988633951;
        Fri, 06 Nov 2026 10:10:33 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([105.99.148.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d6385fsm4790715f8f.16.2026.11.06.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:10:33 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: syzbot+3e16980543e238b95bd1@syzkaller.appspotmail.com
Cc: syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com,
	kmsan-dev@googlegroups.com,
	glider@google.com,
	dvyukov@google.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] dm cache: fix divide error in too_many_discard_blocks()
Date: Fri,  6 Nov 2026 19:10:31 +0100
Message-ID: <20261106181031.1446-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
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

#syz test

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 1a5072425c4a..2d40d6047ef1 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2383,9 +2383,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
-	(void) sector_div(origin_size, discard_block_size);
-
-	return origin_size > MAX_DISCARD_BLOCKS;
+	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
 }
 
 static sector_t calculate_discard_block_size(sector_t cache_block_size,
-- 
2.43.0

