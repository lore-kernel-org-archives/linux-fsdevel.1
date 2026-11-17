Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923533;
	b=XOqvyPceYdbrku9OX710OSRaK7lFfOxDF1Rx5NTvEq7PiY4RXmS7B+5QSsjILByFPlxf
	 na8Rfs4a5aqF+gXDPKM7e5kmNZrRL8h2p/dVSUA9A2qeWXHs2KlaWDf/E4G+5teffriCY
	 +K1mxQkxO8BwghjehMk6IcpjNsNXnxlhFwdm7XDhmd92Igt5R7qBg66qhid20SmEp/0ot
	 gVf7ouWl8JNZ0Kr2IfT8gmGgZZbjIjneGMPV1oQd5wM9QC0++6M6gd4QX3yvgMGnQgrfD
	 w6e/Rh0qotZAIXOXK+Kha+XG3LPpDa+/YZrrhoFqdY8VeCq22midv69LQ+0qr13Cqtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X9eeST+DTiB0/P5zHssKOgXfvR+02Yq9ClIKmFNmHPk=;
	b=kK3fHKu1rECr1U6++fSfSSEKbqIKrUyMCInES94qHyd4xgXQ46FrOCzf1kFCDamB8d/V
	 v6WF4wKG1ieDh+J5IdDZ7NMd040WCGCzCTaN6lS9klX9VkexLMQ5lQRjwC26GoZbm/nqU
	 CAD1YyDD7fItqU/UzC9gb39j6QVqAjiwImACDWr9JztUCRe9lSEov/+lvv0kgHW0G2kJS
	 G72XVPmwhMjQ79DyEygjamvZmTG5qJqYwXk4VFP3ahEHMx/T1ym24EjKjyMrnUNXPUljw
	 dq8m0UQBiE5eJPnJ8IVJ7QhMrAxrj0PRa+/IpxAxzbkjYt19MaIKP0+Le4sMM+mwDGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vzy9RLke;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0D606A32F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 13:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49B0D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vzy9RLke
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so1976568a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923533; x=1795528333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9eeST+DTiB0/P5zHssKOgXfvR+02Yq9ClIKmFNmHPk=;
        b=vzy9RLkeCJKIEWkEHVhJCVUsJ/6sFeknsgnHsqgvE3UqZvqgGs/OtiRJsZtM83ea/1
         H6sCrwzmyZw7Dpx7VOo2A5lV82HGhIS86JiFmNZpHcFFygEpLLgg/0UpWopedKgqs4dw
         1WanW1oYKDPVyvcZdFipmynShUkjTAwlR4RRE+iZvSN1XVc/cgTXDOrQtJWWvhdhv/8g
         dmqt5txFPziJxsTKekhwhjpZYFm1a/rxCz4c4qpSUkp484a631OqjF5bYaq28b1DLjVx
         hnj88rC8+Xgf+yMoUqnOmxZ8goi790B+C9jcuEpUb2xs88n6kCITZjWgb+NPGp3kGVd0
         szbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923533; x=1795528333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X9eeST+DTiB0/P5zHssKOgXfvR+02Yq9ClIKmFNmHPk=;
        b=bs2GoPGOKtDEVNXeQsUN4luKDUxXh1jikhIkX50a8/UHOBPhqGgqpV6soZAJT4CQ38
         xSJvy8sxsQUh3L4BKYxTHPZDJauGEvs7c872+UX2/DI/59o5vTtZMF8vy1tT+Fe3XGRv
         PwEuJ4+Www/6gFrxuL100RpaNH7798Ttm7Fx80NAyjWGDHnEJe9GuRmndNeJqv4BZ//K
         UsAhMx0sFWFvT+mWllEE1JRt2gprUCESyKlGIQmnAayuRiOY22wwgyeI6pCewAGeryCF
         ZP3UpXnouHJO4EilAj0GeWzHKDZu4ZKj4dff0ybiTYnuCgt/NUEmgvQRMY3tSkNh+zRn
         DjoA==
X-Forwarded-Encrypted: i=1; AL+hErFLnNMLhXEnUk1BNMXB23REjsgEtoptbPZlVo56jPNLI1bTQVLiRp4E8TcBNgelrIHXp7EvkxJyGrRjjKvo@vger.kernel.org
X-Gm-Message-State: APuU4Z8TFVcNk71XLYPx3SOfKL3eT1TT8sae+NO0NwIII6luzFK3cVzm
	/bTBXwGIsMEQRH3hSyDTf5QWdJhp3IoM+R97RRml1mfHGa0/v8mcrMH+
X-Gm-Gg: AZFdTZf+4Kkuj4IQVQe5JmvAFZ4DF+01HjmjQ8M2/fDvcH0Epc9mQ7KedZ/cpQ5s82H
	Yky9Lch1PBwVSLJuyJXrehShLBhQAdkPIHxyPdM9uggrLrqvinLbHM2FyDdaYI59jBMuOhCZuPZ
	25YjtpPlRXmjsZ1q39VxuLqI6SDGSuAkyLDw4sz5dRdWpc2JTLulqEQhA4eCu1lQNDIilSEiU4H
	NUrmW5puBQGTXoc/V0fquQPoJyx8jJj+HnzM9/h8EJ5rFW8kSpwibLrjmwZjy1QbEw/wBRzT9HJ
	bk+NLF10vSEYI6tPB2BF4ONhHFJVKQF0NuHiyyEO8fcwaGeVdQsbwjOXlvZrcW2d4WRQ889lhPm
	/qVtUbTrexWoCjrbbd0tDlFRVs2rxB237K31fBzDg5Y7Gsw9hmFApo74/CyszIGHJ9nuLz7z2pl
	h+eSsXW7/wegIgzi7nNMb9rfKLTR9MP3j8btVpeDpCan7hYRI51e/INQ1jf6bXCD79kbtSJ1mel
	Buk9LKI/RMkfQNkDekxm3FenUWzq3GOGX47zjZ0v3jzQQznKW2Hg1mLdD6RqQI63inukht2RUS5
	fFX3SEXzP7W1SM0wdoQOtYPLboyqtxHWbpNSP27mRVl/jn7gF+LZ18gRUbYaxfcIVDM5iCY=
X-Received: by 2002:a17:903:3845:b0:2d8:d4cd:dc8f with SMTP id d9443c01a7336-2ee0da9892dmr141649045ad.18.1794923532596;
        Tue, 17 Nov 2026 05:52:12 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a586c1sm15937035ad.43.2026.11.17.05.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:52:12 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] inotify: copy full qstr length for event names
Date: Tue, 17 Nov 2026 22:51:36 +0900
Message-ID: <20261117135146.3174252-3-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
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

inotify_handle_inode_event() allocates the variable-length event via
kmalloc(), reserving name->len + 1 bytes for event->name, and stores
name->len in event->name_len. strscpy() stops at an embedded NUL in
name->name, leaving the trailing name bytes uninitialized.
copy_event_to_user() copies event->name_len bytes from that buffer to
userspace, leaking uninitialized kernel slab memory. The terminator
and alignment padding are zeroed separately in userspace.

Use memcpy() to copy the full qstr length and write the terminator
separately, as __d_alloc() and d_path() handle length-bearing names.

Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Changes in v2:
- Use memcpy() as suggested by Amir Goldstein and terminate at name->len.
- Copy only the valid qstr bytes to avoid a one-byte read past name->name.

 fs/notify/inotify/inotify_fsnotify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 6e3af6452dcc..ecbfc9b4e99c 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -120,8 +120,10 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
-	if (len)
-		strscpy(event->name, name->name, event->name_len + 1);
+	if (len) {
+		memcpy(event->name, name->name, len);
+		event->name[len] = '\0';
+	}
 
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
