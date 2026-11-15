Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777004;
	b=qxyj1W68EbU6h5ym2Xi4YogaCwa8ppH9Y99NJZ/XMVaeUM8tLkl7eEswKzNAR0qjsilY
	 owThw5Wp2G/P069aAW+YzlYNmkeIigEwNVuOv0aKOXjs9YgRE3QRx5gmhglIUEC7vgn3m
	 WJodTAc8ATt43cEzjb2t7+BSoAOcuhybWo0FHW8tJO8zc0GFeaa7hzxbsPmHROplClPAi
	 ezM1TFEhcXivtWPMg7M9O4ckq6N7esQTbnBfX8rmrXDsM3je6y7jYUuseCbM4Kw3KaZa+
	 FNMWzY7mxyzi1bEA1+T+JoX2myyyjtst6Gbi2PGz+MZ2o/oslsvaxNItO7r7R9/I8pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+9JW7J5HjIZOKB44W/FdWPu4us9PkTChnS047FJOEoI=;
	b=axYjQfcDBBvYoevITSg3xeXL+IU3gQ3hNo5KJwA5OZP57bp4VTWTtgsTQiwGVygvTRP2
	 tuhsC1d8f2NAErbSAY6H1DXDDJvFKn6fdzUwVTzdVJQZ/eHoqhof4w7GXeLpjx+/I/ChO
	 GntVsOcC0MZeNqHoD+Rap+iqXAz8mMAgc2BzlYCzQkn2cCappOR3DSmHDegzr75bbJ3sB
	 efck/g1yt7YRO0TSMxdGC8SVtKDE4SPOiAbqCU0t0YzAHNDJ0Nxd4qgJDOSXAXqQc2mbM
	 pMisQwRToWDVAJWBP4CRbxlmokfEK49RfDAIdfe0QpOyWehCM98VAeElvMOFhvjCzew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwJPOjjH;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C35606A31F
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 21:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C35606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FwJPOjjH
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b5efadd183so1597268b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794777003; x=1795381803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+9JW7J5HjIZOKB44W/FdWPu4us9PkTChnS047FJOEoI=;
        b=FwJPOjjHvrLaPG6Baz9Fuotuorj/J8ft0QxQAijmzxYs9d8Jwk4+cFB1Q5vhcQYEKM
         O44N8cyMLQPPkcyOVhLnv6jTxGvrJt9Pdki9LTFvmV68PCsVjNbHxM/swxSklM/FiYym
         4PUrX0wKqG7sX+ZTlyiugh4bgxTF8rh0YeRGGWs1+CfcDuYIpUqWmoNvp9WV7uc/Afnb
         Lv4qFrhptW4pw6W48q+jdfX+lVzwubXcsi4VwJmHkJQbWct/P/ijvONiJu8WUGIbrwQV
         ejwv8mEQiK8W49qICSUoseiqTnTWCaCxFHsXFbugdIN/EXtDLNK1hmkGreZGZdCeKC6H
         BciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794777003; x=1795381803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9JW7J5HjIZOKB44W/FdWPu4us9PkTChnS047FJOEoI=;
        b=jNtKtfj+uXKNiRWrWKpawk/v9mJl0tquk+cMrLsyD+5S/k6oxVmKa8NGwroLJetUg6
         Y+/ra83Sd2JclNcFV5zAehpf86231k7mIGQt5krSrH9Sdojz088ypHqnh1A0sXsskSTx
         JZEajZsqqiZIXhUMDiReyQTHGVRfs+o6LlCQv9mMWZ7OonBZPnLP829JPkz0aCuqV7ho
         yuMbOj+AsiuMatshYXNrCCh0weW0nf7H0kttjJcxbdo3ukhd2xIUmQInb5ZLiuvxQQvg
         ffkH8H0d0zuNkEEAXlwfmkPB97tBddSn7GPda1GYqdp3QWhcmOUgG4iT4xxza9dYqcIk
         LdWQ==
X-Forwarded-Encrypted: i=1; AL+hErE3MUH2g6h4tzYkQsEEpbccjM3RtQxikhDpCLJFzwJrBh/IOSmo4EpZ5Di7tcac6Fmq/YUam4t752gYSa9x@vger.kernel.org
X-Gm-Message-State: APuU4Z/QuTErN069qvVFa5DT3aW5Iz86smILNVDdSHPsxQmxQ2xk2VMo
	gxr64ZeVgagTU66kgsUsbR6xw9kaZw9PDSAutJjq235LK3Wos+RpdaqM
X-Gm-Gg: AYBFou393vkJ1npfzUoDMYJkwcTlawNOdM2I1lbap98wfcanHDoHSQ4EVhnIOOr+430
	kzpui9z2FSuISEHnipTZMqj6dPTKBPZRykNoR6hUcipL158Ct78kcRUOyvwycp8FOly3Bk1oAA2
	1j+u4EC0VEq1Yjd+UtWx/pnu4d8cTY70/shwmiAIDNrtrfBdRJc2Jd1eTEkDx92niZ+oq2NUdgY
	xei+wO3/Hyr/vjPnvGN6fsl86DoSv49VOILZ1ZNMXnitiTvQCnZjh5dHox0h3l4+bEyUwifMcKl
	R96WiiUSrPmp8cXwDPpKKuS2ndbc1pYaOiH5b0YM4gFLzThfz9rXocHjaBxjfvDexOD2pFui2pk
	LXknDoKjvj+50SUaDdX4n6YCAI5iyERRtpWXAyCizDeUSdD4q8Q3ne2hCeSVHZyT8MALA7GCIk6
	2LZDOC/guTyQsAkeZc4xuAcBMLGPXgn5tPnOLfU8l40B4PkGrCjInFQ1cK/TIYTp1nKkqfjCbQv
	9OgZwFYpErHv/kFiVDH/tJvbZMtYlD3SK161gDyNF5w4t48DD4PMuil0TD11JEQnlioEOfXDvWl
	YiSC/o/Df3epRKKupcVUAYyHPWK1uZaTqwu+r4ASsREyNsDCTA==
X-Received: by 2002:aa7:888a:0:b0:888:cf3:e4b6 with SMTP id d2e1a72fcca58-8beb7f0b151mr5424463b3a.30.1794777002725;
        Sun, 15 Nov 2026 13:10:02 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6e7f5sm2892615b3a.25.2026.11.15.13.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:10:00 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fuse, fsnotify: handle embedded NUL names safely
Date: Mon, 16 Nov 2026 06:09:47 +0900
Message-ID: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
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

FUSE readdir and readdirplus parse dirent->namelen without checking for
embedded NUL bytes. Through READDIRPLUS (fuse_direntplus_link()), such a
name can instantiate or alias a dentry in dcache whose qstr length
extends past the first NUL.

When fsnotify records that dentry name, both inotify and fanotify size
the event buffer from qstr->len and copy that full length to userspace,
but populate the buffer with strscpy(). Because strscpy() stops at the
embedded NUL, the trailing heap bytes remain uninitialized.

Patch 1 rejects dirent names containing embedded NULs in FUSE.
Patch 2 zero-pads inotify event names through their recorded length.
Patch 3 zero-pads fanotify event names through their recorded lengths.

Each patch applies and builds independently on mainline commit
23c62304dde2, so the FUSE and fsnotify changes can go through their
respective trees separately.

Testing on x86_64 QEMU:
  - 1/3: Crafted FUSE READDIR and READDIRPLUS entries with embedded NUL
         names were accepted before the patch and rejected with -EIO
         afterward.
  - 2/3: With Patch 1 omitted, FUSE READDIRPLUS + inotify leaked stale
         slab bytes past the embedded NUL to userspace before the patch,
         and returned zeroes afterward.
  - 3/3: Default FUSE mounts report a zero fsid, so fanotify_mark() with
         FAN_REPORT_DFID_NAME returns -ENODEV on the FUSE setup;
         regression-tested FAN_REPORT_DFID_NAME create and FAN_RENAME
         events on tmpfs.

A custom LLM agent assisted with initial discovery and reproducer
setup; all root-cause analysis, patches, and runtime tests were
manually reviewed and verified by the authors.

Junyoung Jang (3):
  fuse: reject embedded NULs in readdir entry names
  inotify: zero-pad event names after an embedded NUL
  fanotify: zero-pad copied event names after an embedded NUL

 fs/fuse/readdir.c                    | 12 +++++++++---
 fs/notify/fanotify/fanotify.h        |  4 ++--
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)
