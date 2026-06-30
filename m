Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909473C0A1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833342; cv=none; b=kNTqy0yjJ4zD8cLoiKwexsfktXPZVBLfJ3x9AGm0Rh581EZJlddDZ+EorrNWe89AAvFfPnL9vASHCgf0BGxIFhmILTMIy1L+7kOK7UJFDEZROhN9rC/G8YgRFkA1j/F60LxNyvElD5CK2GY0yvmLGGNjhwww0JHh8A5cVp96wM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833342; c=relaxed/simple;
	bh=2M9MfY4H1H/0HOYfmt+JcueUOSRO8TvBT8BHq19qHb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKCIgMkUbZsw0pYth8emY98z5kMAuCI7UPBuKD6rblveFjkvQ7GyszxctDLeeLdDGA1orRHVSRGKK2IQi2W+uKEtPZvfqhZa4Bg/MnCRasWg6T7HWPYv266rtsX3lOg5mvEX8oJaCdDiYt0Pcc/g/VVqRElq2CBYrXfsWgKgM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDW5CNQ8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDW5CNQ8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9f10fa7a3so23512185ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833336; x=1783438136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieZ/cbQKHK2F/fV/agCmqPxTOt3w91FfvE0jZzlrx+4=;
        b=MDW5CNQ84fFkHhocKYme4NT2geGMu/9H0dsiQaYydsJdH6piOgWwHOcd9U/r8l7vm4
         kzxKUC/M/+pIMBmMLrP18Xm0spNVoaMJiPSbBtTTgBBezyk+UcuI5lkKWH2ec5ta47h0
         OoYYbz5LlD46gbl4rFjdGCRHZIEvhwFztPaKqHJWIt1C4tEIQxdEKF/jQ/kMbW/R1+lC
         fdO2FKzG8PX7i5mpkxM9OA41UEixW/m3YhR8QpnBEmHUj4IFRW9/Z17qIDoSTBwEW0Nv
         UiqaJW6txo6I3fFQv1dCR1N6Gdd7ACfA6hYm2B+l5K5mNAWMmhR8vm5aXMaRx9LVHThd
         eMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833336; x=1783438136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ieZ/cbQKHK2F/fV/agCmqPxTOt3w91FfvE0jZzlrx+4=;
        b=S9/8eh5qtAZZSSMAwB8IEpTJgqeKEb311+fqnPF5KsL2Y/yd5dsIzTF1YsodwIhwra
         bRJja4M+tEMYEDIxIvrtOI0THqemXoqB0nECfp9YpxmZZmdfc/wbp0sCHRk1ks+GDGcT
         4vAvMfikikQBjSO9PDm+BIui8Ud0ftzhdk8B1o4xjXrrkeB75p0w0b+R4VKQKpqlOfDv
         YPNJ76KYO3klzbWrHscHnGU6DBMq9V7sPBXaKVk51/abNNhbh17+SwbIKNsylhh+0NES
         i3wj8IfsiS6iJxurbR9aWCmi+xdId3QF/8EbqgLNZxOfVGbE9hxA8tL5vpHsKFFIuPNp
         cIGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZCiLbSuyrzLpyoMO9wZggj1YZfgXobfZvfcMWmi0RITMzBGatNFnqOfv9COJvwyArJl9/SDnrfhlMi0Lo@vger.kernel.org
X-Gm-Message-State: AOJu0YzN7yCBOMsiwpOPNpkFlKqQIhu5OfFPaMTeaHeVqoQdej8VEmc5
	a8v3m/AkyT5BrjBxrA9SUlQe+orFtVXI38b5eiBuWAWVEdw0mfoAVcG+
X-Gm-Gg: AfdE7cmbjhUTU4KAJwz2ZpyHF9D7awsMfY25tdSyKAQNsP1+27JoOGXD15u8Y45Z72I
	+5xWzwG8jrmSA+jjotC9Pd4w1f6i4Oja4hCeGZz1dN2dpoifm1lr2cCaQtZHPSF1YzXnEsAqiB0
	lzwFbOcBrkn20ozzL5qEHI65RKZPJQxH4wi9IDlcU/4iR8H3R/qpymIsIS3T1/z+H4g9WqRlmPX
	sNnJD8SA4WRUFTCvXtKc+Is9AZetPKZcQC9Aqoxq6rnm7sMzhDeU6Bd5xrkBYcrP779YfHGvEjC
	lppDvTrvp9aBygI4p5iK0FcOkJcd7rpFlPgwxAzdFdpZiSw5Y9xZ/T5djx5sLSpV56jfg3Z3xsO
	33ydK2phsy8Eh6z6K4+txFoTS1BqMJAQ4TmxsSVqkVqZufdYywFJn0QGltUUpKPsvkGGmp8VA61
	1xWa85x0L/pL3LQFc9bG+eWHjOv7JIJXONTk6RYM9BFgg4O/UEN7NDio4cOfVatfBysT5F2y5hK
	xtpyerxR8apcfFRRAnyf70bc1dYK4BJkIVfB0NaVgxJNon9+uDhu70rtavO2HH9cBifGG23xB6y
	D7V+O5yMTSC7+Kk5AaY2+ZXE7A==
X-Received: by 2002:a17:903:291:b0:2c9:bd64:8c81 with SMTP id d9443c01a7336-2ca5a58544dmr7912625ad.18.1782833336338;
        Tue, 30 Jun 2026 08:28:56 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-b.c.d33bddc1d573818c7-tp.internal (126.60.158.34.bc.googleusercontent.com. [34.158.60.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca4bae1e2asm10501645ad.73.2026.06.30.08.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:28:55 -0700 (PDT)
From: Aditya Srivastava <aditya.ansh182@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Tao Ma <boyu.mt@taobao.com>,
	syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH 2/2] ext4: replace BUG_ON with graceful retry in ext4_write_inline_data_end
Date: Tue, 30 Jun 2026 15:28:12 +0000
Message-ID: <20260630152812.1706-3-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630152812.1706-1-aditya.ansh182@gmail.com>
References: <20260630152812.1706-1-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>

During a buffered write, `ext4_write_inline_data_end()` acquires the
xattr lock after preparing the write. If a concurrent page fault
(`ext4_page_mkwrite()`) converts the inline data to an extent after
the write_end handlers check the state but before
`ext4_write_inline_data_end()` acquires the xattr write lock, the
subsequent check will trigger a kernel panic via
`BUG_ON(!ext4_has_inline_data(inode))`.

Replace the `BUG_ON` check with a graceful error-handling retry path.
If the inline data is cleared after locking the xattr, we safely
release all resources (releasing `iloc.bh`, unlocking/putting the
folio, stopping the active journal transaction handle) and return 0
(VFS retry) to let the generic write path retry the operation safely.

Reported-by: syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
Fixes: 3fdcfb668fd7 ("ext4: add journalled write support for inline data")
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/ext4/inline.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 8045e4ff270c..cfd591dc1d9c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -812,7 +812,19 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 			goto out;
 		}
 		ext4_write_lock_xattr(inode, &no_expand);
-		BUG_ON(!ext4_has_inline_data(inode));
+		/*
+		 * We could have raced with ext4_page_mkwrite() converting
+		 * the inode and clearing the inline data flag, so we just
+		 * release resources and retry the whole write.
+		 */
+		if (unlikely(!ext4_has_inline_data(inode))) {
+			ext4_write_unlock_xattr(inode, &no_expand);
+			brelse(iloc.bh);
+			folio_unlock(folio);
+			folio_put(folio);
+			ext4_journal_stop(handle);
+			return 0;
+		}
 
 		/*
 		 * ei->i_inline_off may have changed since
-- 
2.47.3

