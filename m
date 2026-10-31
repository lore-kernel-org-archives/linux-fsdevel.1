Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433498;
	b=Z1QaIIYGtfD1XCxhDs7vhMABrxCB1AsiWIgb3DKp/dR/O49AqPRCqBnHkZ1DyS1AE7B0
	 G4BeZOiy+Yz1nR4wme/z9TTr535nzcwRBm6y+3dHDLdzal3gHsFMwUsL9cXUjXmbCC7u8
	 C4BXEQVZpEHILQNBTbQvzMd1O5q5mEpxDwSLTjg43Ir+AWYoNtysoZKfWXION+wLqz2P0
	 QfR66ZXMxxf8a45ry6g/YyflRu8KoomBFQKAAr2F098szL1UW8hO0nScp2HFdwYs+VNUu
	 LdZCSYgTsQ2hw3symUiwqJZmfqHeysbIrXYdcqX0n1Aj/rAFfuqcGBgLqRXBuhspTQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3H0+VV/AZBdEHlcibiOOrB1N8yScEMjvqj7EU00SaxE=;
	b=GkUgMYiSuHtDSEuDS1QQIyqSKhB36xBZuj82kM6yF3JOm2IEx4sWvRJ+lZeVyZcUJQKC
	 mg4JLd3no/EOfq7fcGs19EgqgFz9XqehSIYMD+DH/pmtZ2o5+nHIyeu25KikMN97422Kh
	 6bl1iJNDClzsiCRpIVeuMyqFaJtLaFcjrcNumvRM7T5yrXF05TeZ/KNX09NR0B3KDeaX5
	 9zKXJKTFVUN8VkrZInpsb9bQ7tRH9JmdIq7jqFzDkJrGyw89v3/BHD05ZKVFjDXtQ13h6
	 XUpm8wWvy+iUtIUaZ1fcAEQ6rngCNZhqMGx/7AcanDaFDLNWWSrVKUY4TOOCzlXSdhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfowcpjm;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55526606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 07:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55526606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfowcpjm
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so15843325e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793433497; x=1794038297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3H0+VV/AZBdEHlcibiOOrB1N8yScEMjvqj7EU00SaxE=;
        b=mfowcpjmkN1ixqsM8t0ZFuysKdsfbcq443ZRQiXTtfckF2AivptqiHssl+pnEfiXHQ
         2LYuCRpoTL0FAzFgvonf1i6kjtUjz3PnAPfZ+ksL+N+U57D/5swViZIlYabMWy6k2fKW
         ir9++UaNkyK9MnZyWmmcbGOtpNDzodcih28PKopsxs1oxDqwQqpWGtE2B2b/D+VKPuEf
         0xaZSPFICcjUnNQKcUjnQzFwgutYQbz7Aqf/C4/XuK7DGxsNNlYLazmKvjXPzeOSrMvW
         FG+dLXydrh8t6OulGTyRONDUHikQ0JXdrE/NvPqWtgO/od7b4QwqgeQkrROlYeUpGEq1
         0ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793433497; x=1794038297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3H0+VV/AZBdEHlcibiOOrB1N8yScEMjvqj7EU00SaxE=;
        b=fUJ0NSkX2JVDRkeKYyw1oA9chPCXCLot7RbhDrct8MFc93Mijb6pkYmhTXQhBhFvoP
         2xvXv39P094KCyTMlHU35tEwnkqmsqeQ+TkMFYTeoShY0nNWCeQyR3SqBmC3ppxKGM81
         Eldxn+tOXFGVXHKv61h82YKX/DIKXhAPRikvHlG3dOn2GTZOtK0ucafSJtdWJ99BYbnT
         i8ahK4vpiEmWWCvtiflmluWxh7pJBaiQqfaLF/VvIYXBFgqrOLeisQ7hzyZfUwQsZdhY
         R6h2HL5Wpe5x15h/8XAhW1GCuuBd5j5qjuq5pdBLeg+Ay60/CmccjL1IfNV1FAIeR8ZW
         XKqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmEAdXrYfe5YP/mn/uAS4ZdJuVMsFcXWwzG6h/1rJ6wJSDnhf00M0dMt1ME8UpbcTg7nbSMoJosTUzDcc6@vger.kernel.org
X-Gm-Message-State: AFq9FYJgzJ4enXnPpwoLmzAYDuK5kE+AQQA+0FhDUjWHdOVWLHUfqLab
	NQCUVDD5F6waXxA1oNRyDa9mTVMD/zdeNm2AVSgp4XD63mTed8iJ1w2v
X-Gm-Gg: AYBFou3a2l+0RXin6i8or0WYJTl9/JKlo1LKH9EYMdH8fY0/QJkgU+4RkVzu/RXS5JD
	7Nj68SlFDUV67TrFu5x0j2Dqhe/D1K2w6JSDDbHnkBeMo+W8qcQ76lpg1y5GY+5/i/mxfgSbu/D
	M/0ZOgzx53kDBIWu1wPyBbd64H2agNEImznos8u8bC+w+YlueSi0mqUs+w4Tjhn75bOwPicP2uE
	9Tk1Z4VnfXpoWSRPlRkRYTgbtI/4FGXdGDVpP7RnqSEftRx4h4PKWHMQgvVlpsdxmk5HuskU28y
	Se25Rt97sgeVjBfIbywAK+is8fQHJ/LMKyIu1V1Yxy5ZolUabNbmQ6XT6PCQr4qcmfZkSFM1GRi
	S8vgEwGVIzUROMkERXxdKXSCGCTiK6hrF8Wnft2sDk7sBJONgVBmgi6y+SfkoOE/OeqyM8VT0hi
	zEqu3cGBnQfLFQM2FvFij5t6XJSgP5tsRJPA0MNFCLWP8wdUV9C5NFDAFwr0WRR1v7E6T/heeJz
	KK19DHidvC4iH7y6TC6AroiSiUHSbXr4aLmH+B4zBKre7gjGtR0l6cj1hmSpMVJzX1IkNyZvGc0
	ZXxl+4omfB7n2Tg8CVrvpYyD5zIVM7i6IGb8/aBVJysu
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4ac18993ca7mr103987265e9.32.1793433496591;
        Sat, 31 Oct 2026 00:58:16 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm119448035e9.6.2026.10.31.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:58:16 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/stat: reject invalid flags for empty paths
Date: Sat, 31 Oct 2026 09:58:10 +0200
Message-ID: <20261031075809.3173603-2-thnkslprpt@gmail.com>
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

vfs_fstatat() and statx() take the file descriptor fast path when
AT_EMPTY_PATH is set, even if unsupported flag bits are present.
This bypasses vfs_statx() flag validation and lets both syscalls
succeed with AT_RECURSIVE.

Restrict the fast paths to supported flags so invalid combinations
fall through to vfs_statx() and return -EINVAL.

Fixes: e896474fe485 ("getname_maybe_null() - the third variant of pathname copy-in")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 fs/stat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index a2e63c6c45b7..b75a411b502f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -371,7 +371,9 @@ int vfs_fstatat(int dfd, const char __user *filename,
 {
 	CLASS(filename_maybe_null, name)(filename, flags);
 
-	if (!name && dfd >= 0)
+	if (!name && dfd >= 0 &&
+	    !(flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
+			AT_EMPTY_PATH | AT_STATX_SYNC_TYPE)))
 		return vfs_fstat(dfd, stat);
 
 	return vfs_statx(dfd, name, flags | AT_NO_AUTOMOUNT,
@@ -812,7 +814,9 @@ SYSCALL_DEFINE5(statx,
 {
 	CLASS(filename_maybe_null, name)(filename, flags);
 
-	if (!name && dfd >= 0)
+	if (!name && dfd >= 0 &&
+	    !(flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
+			AT_EMPTY_PATH | AT_STATX_SYNC_TYPE)))
 		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
 
 	return do_statx(dfd, name, flags, mask, buffer);

base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.43.0

