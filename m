Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128841;
	b=WLQnLFLuysV2jcJHRdS2APw8d6H7SaiaDWaDuQfoOPf0dHuFiLTr6zLGoU+UbKVLiNqT
	 b2qpGNEvRv+zvJUH9GKRNGpYA3CMDx/XX83JTAXAFiWqnzh/dZyRtPb/KI0q/6nj5K5p7
	 Crux680R+/DfuVqjz698kOGduN2FyybNxN+qxkqzRttSiy4N51aZIdKcy1EJYnwWbvf8m
	 f7sAv9kKRsKIJ3KS3jeai7qEjVf1m1MnGWoIWC80Y4yi9KAgduR+RY8TRcdo7LdX/+21H
	 fmb6MZCGQChIG/8Sp7hNhwHGkQRhk7zagaSpizke8zrR6qiDclouUewlyzp1b1vFUlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hk9/0T79qmJBx1+aBaKaGLqZJw/M/AXieWp8XrsTCTg=;
	b=AYjN5x61NrkdU8Mjh+cAkkqvqXpYOuZoEpDOfP+8TQmGpfEGLUpil2/ASoWIUZ4pudNG
	 XCk0Kzd4uYCHGncS04U6N+h46ebRIfVREguDO3n+ePVB+tZCO4RcdNKtqg+QbRer4kDZW
	 IFhiua2prtrnxz5ddPP1WcP3F8WcYY7RUcYFJ0oXHmex70cmXlH7Gub8BSnqzoCG0gwQy
	 RMN2AaZdrFucAFwvcZLIC5misvHwEyQfqOqX2Y/qSB0w0+h8ZNVEljsx5nWq6vBKUTmrp
	 w4gzHB+2rhPR0q3b2SYB3p5gTCMTkWkKRB0ykncSQincX+vMfGeMwtsBtLKOYHhq9UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QQkLR1g/";
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD302606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 19:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD302606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQkLR1g/
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-19305bcb6d5so25192c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793128840; x=1793733640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hk9/0T79qmJBx1+aBaKaGLqZJw/M/AXieWp8XrsTCTg=;
        b=QQkLR1g/+aSDG22UmIZXQnpCRa4u2Totc+OsjxD24KKdE44CNN5+V/iXKGbMy34KE0
         9J/mdrs7iGN6Cblm4VspbDP498gyj0tj6d9hyieE0H8p4MbZE+EHmO6GiTSdTWP9Ujw6
         xw96k0X6QJCDIXUvebMzlWbB7Jb91SoAcZd73u4N89bUACIqoSnmxiihSVjpw2GbKCln
         noZFuc7jG6N7ev7Ayl68F9AuR36yDmAYpDcqJ1RZf3/VNORZWW/bKDsqLmgjqtIcCBZn
         Wwt9m6d/4ACkqxnabKNpCc1rZC4TIZ5SxWFLlim33XkZBEGr2fnPTVUEVuUKDAFmP58j
         oyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793128840; x=1793733640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hk9/0T79qmJBx1+aBaKaGLqZJw/M/AXieWp8XrsTCTg=;
        b=amK9g4MnAjBFzZpIzzb0ylrjR0xsrYESfWHiGfXTTCaAIrvDU63Heuc/b+ZQ63WgjP
         OnyEycLSka63Wngr4TUvaG/hL/P8mB7HwNLNjYZkXWqpHt7tgQrFmFPDk0UHey99ObGK
         Xl3VghLaI96QyQLV4RvCxAIf7OX3GjrRPJTCcTb6uBKi7t36OxwlqL+v7RDJ0x1swjkI
         r/+fpbYnpvIEIcTTeQ+r7FlBVtUKV4szPlCcB3n4RKNgWvYoWAbslQ0r/g8hez5hPXgY
         mWsxAydknuS224Px/2SH3VNcR4/pEoG1EPHcQOpfHEzZlgNrxmLwepLoor7uqkUxet8j
         Azsw==
X-Forwarded-Encrypted: i=1; AKwUvByJ8T5D6feJaoNM2zbBP1qvZGvKngI9BU4Lj6EL3MrzAAbhEHecQOfher/puf8cZPj1a2OpL6bY6kUM9f+c@vger.kernel.org
X-Gm-Message-State: AFq9FYJGN+VGMULr0vLAf7ZxAvFcXH0Nhs8Mj9ZXr6EucFAtDV4A2sp2
	hwmjge2iOBVJMyS1LrfVgc6odKf4YxXlMWtceAokDm5Re6YwS41phcw8
X-Gm-Gg: AYBFou0Pdp+LYBzzyMkf4uHN+8JT2k4SpfWwpW8iBiqNROuISowlEcWim1hpg6/OEZe
	WDOa8O/NH3LopDvSJH/iozklj2pstyMAuaohgcmbbFi+pfWq+TesjdcvQGFSZIAfefj6YAbFw5k
	rG4ZEpV566J32ubKCNVOxRTxhP2AIp0o/yNCZWBf1Izs4Wwp6UOmP0biarRHuRG2+R3FxPsPhHf
	8Fx10ee+EIukZaLgNtpp7owjXJOdANq5dJwJAP54Ekp4T9LTbild6fudk9qVkdM0xt2RLENeAKp
	6xj5ZridRqndL0KHe9MHjM0tao/m3kIhNqMY613u6BYgR59R8+3z7T9zc4ieQ0AP58lBwbWqtKs
	byF8aZNgylgvvnqI2k9wndf9+zUoXOoldjJphESxYCq2hkesi/Z8WkE36T0S4Y+t9LE5UenXLH5
	dYMbfrwUBTWIRkYjruqFnBDCiT7ozOjYSRLzOr6nBdql03MPDmzL17xhLX7BTOu6jy8DpGb/anV
	QCCIjtCfDsAVFi8waN7FTnQhnvYp2Je+kLHA+zu9yrhUKZnV5yex+DrC2DBIKxaNs6rqzroIfmi
	Nuptnw4=
X-Received: by 2002:a05:7301:2411:b0:369:fdae:c9fd with SMTP id 5a478bee46e88-36a201132b1mr506995eec.13.1793128839731;
        Tue, 27 Oct 2026 12:20:39 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7e73sm35948746eec.20.2026.10.27.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:20:39 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] inotify: do not coalesce rename events
Date: Tue, 27 Oct 2026 19:20:27 +0000
Message-ID: <20261027192027.8617-1-dennylin0707@gmail.com>
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

inotify compares the mask, watch descriptor and name when coalescing
adjacent unread events, but ignores their rename cookies. Distinct
IN_MOVED_FROM events can therefore be coalesced, losing the cookie needed
to match a later IN_MOVED_TO event.

For example, watch two directories with IN_MOVE. Move an entry from the
first directory into an unwatched directory, recreate it under the same
name, then move it from the first directory into the second watched
directory before reading the events. The second IN_MOVED_FROM is merged
with the first, while the IN_MOVED_TO retains the second rename's cookie.
Userspace can no longer pair the second rename's events.

The original inotify implementation compared cookies before coalescing.
The fsnotify conversion lost this comparison. Do not coalesce
IN_MOVED_FROM or IN_MOVED_TO events, which carry the identity of their
respective renames. Leave coalescing of other event types unchanged.

Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Cc: stable@vger.kernel.org
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 7c326ec2e8a8..6e3af6452dcc 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -36,7 +36,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 
 	old = INOTIFY_E(old_fsn);
 	new = INOTIFY_E(new_fsn);
-	if (old->mask & FS_IN_IGNORED)
+	if (old->mask & (FS_IN_IGNORED | FS_MOVE))
 		return false;
 	if ((old->mask == new->mask) &&
 	    (old->wd == new->wd) &&
-- 
2.43.0

