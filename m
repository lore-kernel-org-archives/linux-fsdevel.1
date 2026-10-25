Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792970594;
	b=M3rQKtid6RSJvOG9lDtoGOQQJ4y9VmF2G7uf6kJfvhBul8IyhZAFRqJ9x5yd7zFupdtA
	 dYlRDgIp+npV/cauNtKMkTpImA/G6OW8zdujfq+23KMIp7ViCfHi7LWvf1k0/ldJWQyFz
	 I5tCBJradpOR844m4e+hPGuCfynzsKmrrU5TFNIZzgzI2NgyJRZR+jpq816bxGIJ0iBKU
	 v/cU0iJtdQUoHE8wA0INJTiejKXXCQJ/CsZ/Rgm4rl2EEzw4PfCGId3rxpXGXjaQsTsGZ
	 OuS2s4kaIEMnsJ3v/mMyfZW+uDp+PDcFNjnvmEQSXuu2KJso+YTLssk5sdcmHOpr2Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792970594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbxeXuBz0HfqP0KO9f4xM0kuKsTU2zW3nybw3gTAZ8k=;
	b=FjM26gt98WjvuIXxU50fpGk3KT1czPtGAF5MkSM0L4HZUYorsJYoe64OT8MOpTxlAo4A
	 Z/wnydzAFEzYLPEfyrDnl7OJBYNl6zHD+UgmbroqU5LfScvZNJDGfkNa6Ry9HdLJr6gcq
	 RXrsd+3TXwCmnTJRH08cTZuxdqR0Lj95SJCiQuEShXU7jJT+6gAX/A92bUe+qLRVmnKgD
	 NgiOTWDvoGDPFDKmTt/jQPoQyTpehMGyVWcsswtgLlaX6oukQjQF4kjDDMVV+MpiO8fqD
	 kp5/Rg4bziyE5lMaGLUEi7nAIAr5t9NuAr6rpzwAgo2NQCPTWiL3JzKDP77NY4VlQlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wis4iWFU;
	arc=none smtp.remote-ip=74.125.82.194
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A39606A31D
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 23:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A39606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wis4iWFU
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-35d0be18c71so4170083eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792970593; x=1793575393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbxeXuBz0HfqP0KO9f4xM0kuKsTU2zW3nybw3gTAZ8k=;
        b=Wis4iWFUKqony/2nLAbnNxcXFaNVTFQODKiBbbtoENDWsu32+aupxpQjJD9UUG+NuR
         Oghoo9542qR6F65e17KWCS2HHrQSzM4OXo7iQBna3zw90l0IxaZXHG8W5H/3kBaOzo6O
         DUhGgX+di58mLwtx/Gzk71vykUIRgLzuOft1b+MqLFfDJV5GZ/9xflpbFaa1n37kh+q+
         fl8gdjfea50eIgCwd288k80V7W4qLnrzXUjYtDikkS3vgzwoqnmB+/msDR0jVXxVc4Kc
         5fhzOFxvwlHZR9aYDYYUibvLs/XoP9f+BxRfr896ek65JJiIi1fHrHd9UxclX6ZoSCH7
         FqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792970593; x=1793575393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbxeXuBz0HfqP0KO9f4xM0kuKsTU2zW3nybw3gTAZ8k=;
        b=YIWp7QzyHDXUbz6s1JoRLE45C0UhaDIFsO7O1SAYm3qNHYSOJ5KJjKuv+hl1LQFVu9
         w/jTJNZFjjY2vYh2e/IGx5I4NNrlR/bMB8thDt55ZkCxuc+4KUZn3J27LdmR36ZYfPmF
         UPhzKYB/AKotHrwDBWduTBwfJSWwk/hF8D3h3CqkUVX9PDxyN6+vdImUBoLqWSnQlad/
         6PIMNAM4bznm2jbwa4o7mNKMIMoHmndzjQun6MsdfVrv4l25vubu5HMFHYej4I/MRHSk
         GVx7pfXN862vmeiXc5Q+2zjp/1Riu1mCI2wbVplkR5wcjtHAMl+VSg7GzC3GpM3z45nD
         Be/w==
X-Forwarded-Encrypted: i=1; AKwUvBytkbkpf6eSBDrgMx4eExqrQ8gkHF9S0xEDo5usqemmj4/9L1gtk8fi6vnj3W0t5pG2+nZI+gcNEaTh3e/D@vger.kernel.org
X-Gm-Message-State: AFq9FYJcEKMFJqQygLAuRSTUfPtbMysF1QVQsAkOhhQ7PeO8E0mau9ST
	MkxA8W6K6RzIRbCF3Bd42/2EmnzoacPTtMVrqCKKcXcEbJXcJKhZrCwA
X-Gm-Gg: AYBFou3C0nT4/xCHdgeU9qirHc94xAxpXaIL3yYI9tHwoU1a4e6f3F9rsnqFp5DGc4n
	YTPb6PleGBC6UfWwJRr8oPglwRmjm83H4Vdk/4smMHrIGBrFhs9V6r5RnHWkd1JYp2f0Nl+25hy
	Et5hYxLhyfWlnfg4Zz1rnOO1lHISpdAI/ENk2GM8GJArVgJmC+2qaZ2gc2wutMPzgXlbxY1o95b
	hiHIEpcs/N8m43qYL5pRzG44XU2ayHcew5670LCNj0tXxES9PGkyKcU074od+4jAorOr592/bUF
	prSEp41W7JVlssGUBjRoL1X/G398C1eoNJxFrWJInMOp+/ZcTkRDmEs4NsxLs+fnckFF6bdeA4P
	OpmqHEdxqfmIk58QgVTtxM95oGFt8SZVtCer/YLn2lbPljq2ufnnjaOLh+qIk8Vduv2Q8j2gS07
	hdIqn3j6vzSOQdTt0wqlMAEVxdewoWKf9Z/L6RXOdgjREF2xv3IvDynrdXg69+nZWqDNvOsqQlL
	mVUEaLBGWC2GtA1kFkVh+KYyj5xbbAO+E+vF6KkkTPjjjob+6R2eym+kR9kwBC5xvgYHI3teqqr
	HvoGWGE=
X-Received: by 2002:a05:701a:c919:b0:187:5a5f:3b27 with SMTP id a92af1059eb24-19935be804amr6867724c88.17.1792970593173;
        Sun, 25 Oct 2026 16:23:13 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2eefbsm20118741c88.7.2026.10.25.16.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 16:23:12 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] inotify: do not coalesce events with different rename cookies
Date: Sun, 25 Oct 2026 23:22:51 +0000
Message-ID: <20261025232251.58252-1-dennylin0707@gmail.com>
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
renames can therefore lose an event even with IN_ALL_EVENTS.

For example, prepare two files in an unwatched staging directory and
rename each onto the same pathname in a watched destination directory
before reading the events. Only the first IN_MOVED_TO event is retained,
although the two renames have different cookies. Similarly, coalescing
distinct IN_MOVED_FROM events can discard the cookie needed to match a
subsequent IN_MOVED_TO event.

The original inotify implementation compared cookies before coalescing.
The fsnotify conversion lost this comparison. Compare sync_cookie as well
to preserve distinct rename events, while retaining coalescing for
ordinary events with zero cookies.

Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 7c326ec2e8a8..6456d9c0e408 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -40,6 +40,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 		return false;
 	if ((old->mask == new->mask) &&
 	    (old->wd == new->wd) &&
+	    (old->sync_cookie == new->sync_cookie) &&
 	    (old->name_len == new->name_len) &&
 	    (!old->name_len || !strcmp(old->name, new->name)))
 		return true;
-- 
2.43.0

