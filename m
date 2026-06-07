Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16385333730
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780804525; cv=none; b=FIviidKhDjP8DVUKvf2ZHMzWse6/FfGMO6DnBeSsBQI8oltmEJ/IEl+LhoTtsSpNejy9mjNFNfecDvG90E81kRcX/d+YeF9sUvspkklkMrD569fP4lOeBz/Q6xDh/l1ORcwNuDxixHTRJfdKLEPrBv+b9XbXKD+uh+8a3hZSDf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780804525; c=relaxed/simple;
	bh=U+1fcoqh8bDI9jHQwJaEhF1UlP6MvGcXiPsb798pay4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NX/NFzHYQyN2PUyzJq5TIFApTuvQ5Z3DNsaaKlkZHLov89TU0KEdz8AS4hNbWSTdSCAH+bvezBPy8R4aiYMm8AZM2YQXAY1BiPeQ4nL6EYdtpHt2ZUs+XDIe2Ua0mkotibEZqvOZDkyYRuJLtPJnyLjGXxz3ZwA6THjOEtSNsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT/iD9+b; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT/iD9+b"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so25848485e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 20:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780804522; x=1781409322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=heWyTWAleDiilmjb5uZVSaEYhk3Wuf3YFJaYtSyYaV0=;
        b=AT/iD9+b9JLfpATr8TQj0qE+yusJkVq3Fq/6KJS4O86eRcsgZK8QGAHyJD4q20TpDB
         Ghht5pGSYs9+xNZvjU9FsGejXRYZT+G71fab8VkjUHv9nOHqj9EUwOJCAtgb+CtdcOIo
         aT3IQZVNhwh/xOlBlluaLYNzxju1h+mcEYqj6uScIVqgU2UOF05dqjV93tETLDS65146
         nswF6VJTf4p40WbcBeVAIW9qaHnufxtbZOhePOOXN5/gzJ5gpXIQsWtpaaKPKI2R4nQw
         qCtPobq6dsalKeXVwt0Rqz7zSljHaha1RkgPhab2T/6IkNW3Yni8+x1SmZKwTQbS//RW
         NOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780804522; x=1781409322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heWyTWAleDiilmjb5uZVSaEYhk3Wuf3YFJaYtSyYaV0=;
        b=aoIKdLv4npZmNF8hTyQsjLNmF8C4Pz2tUqgm0yAyBbczUU7NVzLguvUOky8lsDoklN
         so9zSQE+S9E9w38BypdE2O918D27GvQMyPO+Iz/4mEIWy+n98ZQZzcBR+Y2tI3hy9X0X
         r2xxVkZOusKyzP2d/qa4p50ypflGN3MrzspGvUDHDAZi7H2Zq72DEZKWqnO4/ouj6M1h
         +SZhpbwoQMVSN7hMzkzxXabUcryR5YwnOq090JJeWdwbhehzNAEExo2A6H37/23erbJ1
         T6iO2mbRT43udfy21uBs3V3xf72Z055SoOSPD3KetKZ3qS3FCYl/eFzSazLShUH0jyVR
         ImXQ==
X-Gm-Message-State: AOJu0YysQbwYC0OoExdZ3I3d9PwON92zpmOyoAkikoRtrF+KuhcIYLU8
	8aITU3hxKt1imkZbLFbrNHvVjq2k+idDCtAKjmEuRuVSeNrt+FtxqJ5FH0BomXtxsjs=
X-Gm-Gg: Acq92OEb/oR73w632zhPoiFrqHKKQGTD7jLaSzk6yqJqnB2fDEd+idYL6vQvje1Ugzs
	C3V2v0tWKqcPwjpvEIV+GhK9cnZFkKAZ0IEntvZiFjApk2i7+j2TaUSZA5fq3ynbYsHnu4mJ822
	Un90e1V2py9F95OGlX0WEMli4svkILikrYS37qLum2+H3Dn2thK3McD8QYF/eZz9XQu9HEH6iBm
	0aRoppFmT+lYMp9QS507NUhyzeLad82qw58XU8dngqMn6GUTjKhy2/MPTESu2dkyECtcJNUsagl
	HUAlXJiCrB2u0Ab3ZcCq1cJ2ZE5QIGgDUoFeeNMHxSusGgHzGLRomFGf2Ei8JIvik8cmCekXCap
	0f5KZTpFilpU66Bx81S14bf1GEgomH7OvXjtU9ihzzl0k4ZRtXRDYlPwSnx5EyU+xtx3nKRCDJ3
	tE+prFUhOVaZpGsJje+X0k6vUdzuU9bN6lLFuBYal6TvBcD+dEDp1cPf5wNmEumNtJ/ayljAlPk
	S22ExXryuetmw/BeOW7uPZl1uGIf8jEzp277EhMVwQnShIhuDsDvJofeIg0FWrpfc+QTL7oo+D/
	mFaZ9fba6QWMxv2fqiAf
X-Received: by 2002:a05:600c:3f18:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490c2628f1fmr175472145e9.32.1780804522245;
        Sat, 06 Jun 2026 20:55:22 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm187854985e9.2.2026.06.06.20.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 20:55:21 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Subject: [PATCH v2] hfs: return -EFSCORRUPTED instead of BUG() in hfs_write_inode()
Date: Sun,  7 Jun 2026 03:53:39 +0000
Message-ID: <20260607035339.1015062-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs: return -EFSCORRUPTED instead of BUG() in hfs_write_inode()

A corrupted or otherwise malformed HFS filesystem image can reach the
default case in hfs_write_inode(). The current code calls BUG() there,
which turns an on-disk filesystem condition into a kernel crash.

Return -EFSCORRUPTED instead. This reports filesystem metadata
corruption consistently with other major filesystems while avoiding a
reachable kernel BUG.

The issue is reproducible with the public syzbot C reproducer linked
below. Before this change, the reproducer triggers a kernel BUG at
fs/hfs/inode.c with RIP in hfs_write_inode(). After this change, the
same reproducer no longer triggers kernel BUG, hfs_write_inode, KASAN,
Oops, Call Trace, or RIP evidence in the validation window.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Tested-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
---
Changes in v2:
- Return -EFSCORRUPTED for metadata corruption, as suggested by Darrick.

 fs/hfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 89b33a9d46d5..4192f660b64f 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -471,7 +471,6 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
 			return 0;
 		default:
-			BUG();
-			return -EIO;
+			return -EFSCORRUPTED;
 		}
 	}
