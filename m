Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092478;
	b=WekjxVQXtJBP27rh4IXzrSSrRS7keXMsWz8TE+w/ZNfqBbXyNz9kiNvZ+o/MhWCDgfD9
	 gM9gV+DX/u8JL28KozgZx+TSWJHomYYSFs5wXC1w4x17b+DOUDgNPROXHd6Kh2ohnQi6w
	 54R6XkmgQOA+iPf7fKwe0uGvGpIvxUBOVHY/qKqEhRBD4AMCzkXgB7RuU3Y/w80kFrl0W
	 oEa8ozoJgpJEvjQ/GQbwINyyKrOWJEI1laG1XNJIjP2EnUfzuBzgSBCxepmwYFm1jYMKG
	 dDLaHMpJt+HK+KAUVsVSJugBdONvSDYjn29BxjvLUuRzGBAD5fvx62hkY+IlUP5Uv1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FdRV4XTc4pYPAaF+rtb7+DdwwT3YYcSdn8k9Rp0yoGA=;
	b=aF6Gz8Z3JJTp6H1Y3N4MahSelxmDD10kwSJCNdLzA/QfQU/Emdcf527qmZEPotShN5L5
	 /K0PSbEAL+1MP1q+FuyWqs6X5flcPvfnAKIeEVm+0J43ClROp5Gl0LtfZiRAyDPWrKv1k
	 NLrpb+myT/AdoHWURARU4cFudzHYqYVy8NOMjU0HyEP52X03CoDG23NyomOnobNQ5OsPJ
	 kUU0BwuhhYbfiYQfVznGK+fpprGEWdW1SKGaw+mL0jFXRLEKdDUCDPJIk62RgkWtXb+en
	 9HnUtVVi0N6XRaoDSII732gEM5FDzwm/UCEhxUbGGIC5MYSCp1cxTkWvCZHkWdvNqYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="SWo3d/ti";
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E4606A31B
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 09:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 241E4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SWo3d/ti
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-369ef2c6802so371078eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793092477; x=1793697277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FdRV4XTc4pYPAaF+rtb7+DdwwT3YYcSdn8k9Rp0yoGA=;
        b=SWo3d/tiozvEWBBHsQ7PjMe5nNsCKGVdewvzmFzbZabM6YLj8YTmqP9+wG3BUJ580Z
         JtuEIRYCoWYMLee+a5RGLcXId7J5Rwr/3c0rE/9jWSnVpLrvZPHsJtL7jjncrCqX8Ht6
         vZQ+JTtUCJasd2M1gn5J6Rs21nRgeLyWYZOcVWqm8xGjeLhNVlBroctj3wlazd1AeV4c
         wCKrEwUSDC8wg3+1dmpu9+u3XCO0hAB5m60+ONDpjwNJqW6Zp3gKmE+lky6CgViDgn78
         JQQe5q0GReaENrS8iY/wuiBk0nAMb0sPrdxFrOnc7YTyhDc2wFwX8TQTZqwmjzIA5TT+
         uaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092477; x=1793697277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FdRV4XTc4pYPAaF+rtb7+DdwwT3YYcSdn8k9Rp0yoGA=;
        b=uRtozcN1dAPUsQBCFcPtiQlHgAmD0QDt9aehSWNJaQoed/9mr0vvfAwReXyLZhGQ04
         XVnQlp5Oo0wpAMCxr+9mU/z/A9va4D1Zg88xsMfewpcQY+qAdNf1VEG7m3cCOHW3vvJ5
         /aOga9pye3jbt34OreyqZCTOg06yAQbIhX1CfT1AwpREH0TdX2LNMdFL0Bn8nIL0ktFH
         McPprLXgbPAMshj2V5WcEuf+i5Wo7XjJJMtgPRBp+d8gsmO8gqIfc6ikCDMPTuXGVNfU
         2LBssMeroSPojo9mfyAaBCbWz2DgNCcceZmFze/zmi7nC490ojTQCbcXLawwDNrEgA+K
         Jj/w==
X-Forwarded-Encrypted: i=1; AKwUvBwnQ1g7GL3jD3yF2rsJd0DzrTaEdByMJckX+QCEHVc+YPUM6aMAEBfkutFtQJbkwoyccwt3UDSh4OzMBUZh@vger.kernel.org
X-Gm-Message-State: AFq9FYKpp1DNMvwXmdwsyfLzp8mVBSd+gq3SB7LnQ3mOF6bDxo+oSTx2
	m0/5xJ/RWLEO1/OajFeqIafnFfSV8t2FB2Qyxdw+t9+OOYu0+TykyJA5
X-Gm-Gg: AYBFou3P6ZHpjVQ3AEB/Ri35Ogd2QAT4zfQWotN+HrVJs59E99kr3+GcEQikdGeMUGU
	EOcFxaPA+exCa5ow/cXWRGSaL6YrslhjuDe67N+fhLcDsZccQ4CPq9tTlFRiAn1SRi+dynuixOZ
	OxmWdZ/mIKtwGfkBJ3xbKYYL4fch+JB1D05Zt1U/iIOTkF+LrriuRv9hH9C3q6hleslKA+nXep4
	FdLlCDjp7ZccVXudB3VQfpy/skJELUZSGIIxYnVdf72RdU5cCyUEjUsWFZAwlk+atgHaWAhMFpQ
	QZsC8/0ymO1GqSdpG8NUF1Qx6G0+/h1nKgPk+hwZhPNA71643xdhDYf20/CvYD2G373LewjzfDg
	dwDMtomuojFRBEy2R2u7d3D5inWQD4eqBFliu8XekQiWUqSsC9hUSOvjnY5NxgBunVWjycLilPP
	6qBU3B/a04s4fk4TJbPyKG6nNxVDOJdL8b1VQ4kgsZj469MVDGhD11uPKoNXJJulkInr4d824sB
	bkr0XiFsp+mevi1U0FF5jnW84XB+Vv2Sjz3guLj0sGSZ6yxBuO7ip2i9ypiVurMvNmYoh+1vixo
	vq0JY3E=
X-Received: by 2002:a05:7301:5383:b0:369:f644:fac0 with SMTP id 5a478bee46e88-36a0f55dbc6mr2798061eec.8.1793092476796;
        Tue, 27 Oct 2026 02:14:36 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ee72c0sm48508417eec.29.2026.10.27.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:14:36 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: linkinjeon@kernel.org
Cc: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	exfat@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	dennylin0707@gmail.com
Subject: [PATCH] exfat: preserve creation times during rename
Date: Tue, 27 Oct 2026 09:13:53 +0000
Message-ID: <20261027091353.74642-1-dennylin0707@gmail.com>
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

exfat_rename() resets the destination parent directory's i_crtime after
every successful rename. A normal mv within that directory therefore
changes its STATX_BTIME, and the new creation time is also written to
disk. Moving a child does not recreate its parent directory.

The function also resets i_crtime on an overwritten target inode. An
application holding an open file descriptor can observe its birth time
change even though it still refers to the same inode.

Remove both creation-time updates. simple_rename_timestamp() already
updates the modification and change times required by rename, while
creation times should remain unchanged. Jeff Layton questioned these
updates during the timestamp accessor conversion, but they remain in
the current implementation.

Fixes: 5f2aa075070c ("exfat: add inode operations")
Suggested-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/bb698e294b0d4dbbbad4b94048693360010b8010.camel@kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/exfat/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 68ddb9c5504f..d01280570f70 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1293,7 +1293,6 @@ static int exfat_rename(const struct mnt_idmap *idmap,
 
 	inode_inc_iversion(new_dir);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
-	EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
 	exfat_truncate_inode_atime(new_dir);
 	if (IS_DIRSYNC(new_dir) && size != i_size_read(new_dir))
 		exfat_sync_inode(new_dir);
@@ -1331,7 +1330,6 @@ static int exfat_rename(const struct mnt_idmap *idmap,
 			exfat_warn(sb, "abnormal access to an inode dropped");
 			WARN_ON(new_inode->i_nlink == 0);
 		}
-		EXFAT_I(new_inode)->i_crtime = current_time(new_inode);
 	}
 
 unlock:
-- 
2.43.0

