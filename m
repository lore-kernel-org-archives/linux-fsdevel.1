Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9892765F5
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774222024; cv=none; b=qfKa8sUFGSdnlLevSTrhc9SWvWdtzB4+IWNgYtBgZ91q4rBHIp7psGDQHHc3OxkQ5ISa2wD5K6dDTbstjsTXDHLqYJWdGfhPTwtkktVbnGSygT3I3GXVT9D1p39Y8VeFZ28V59rjkAL5Pu1m4mxeRX3SyO/l20Oa+XdAPk7YPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774222024; c=relaxed/simple;
	bh=W/yF5lL7zNLB/RmCqoV0rM+9jBDhS3izJTYQh0pbg9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGgvn2Pd+d9gflA2gX3aPydvx5rqT4WfpoahOb5JRZZFOuH2nRkYUzZcxZThy8Ee3p4w0crqoeKzY3i7kDh8PErPzQej8HuwrAWxL27CxwvmSMs90PVfSLqwU61TzKI7+K/aUZaULCqzGbofyZGAGlJLGhstoOCPqGyzFNeLzG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euCh2Dz4; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euCh2Dz4"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64937edbc9eso2034210d50.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 16:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774222022; x=1774826822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79irvevPis3NJOuw3eys97iKO1lUPGBxfD6xP3kvDIY=;
        b=euCh2Dz4Yy1g217Zm9nYhnofrAdd390pEnStmcUoQ/PvdZat2PSilLNGnm4FKSlgUa
         2ePLLoO02M3t+8dZspAVo12mNrbM3VZorIinPySKsrVnNoRGkkf8540Nr6dMpNCsoeKm
         wDT/IcbPBSfQilMJxxdUtiuo4fXpbYjDJrT6FSjBjEayJAjjmiKhfstnEunT2kwttVko
         pQfyKsJCU336x9E/kTqIkv/NY5RoNxGOFUwtf9GzwhRAJkvLzPMxYcTWfr0BfsokmIzR
         gbnRsM+t7JZOGvUXDICAwDN6yCcj7JOhnsmcOFMkmdz5sn8Zddpj+IW1v9U34b0P2hir
         6SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774222022; x=1774826822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79irvevPis3NJOuw3eys97iKO1lUPGBxfD6xP3kvDIY=;
        b=reAPablAsbSN0I+2ubO+w4KV6lK2ba+kVP1EJVJZuH5JQw6rmtVpB4wK01QL5Q6ORG
         NwSQeuBJKlZAsDX4OqG2J6+YjY5OmETMyBV0OdrQwopMBsCct5iDbIG8QQfsiuYE8SAb
         qK0UCj+VhJyAFWo7IFq6VDO90j3YxZNPRBjYdX6s7h0qTxGKKYvdiIvrwUHH3qhGzcyz
         /bxFfB10RIZsciSmkCoY+vb/2mYiOuspH1SFAmnqfbTdelsw9HSPptMOWoMEG9LBfFVs
         5WoJnopwBlk661I2PhsttXiXdwEjBxRx8vOS/vK6k1k2wkwLPZMDzR25ZEPZkPtoOoGJ
         snpw==
X-Forwarded-Encrypted: i=1; AJvYcCXAPgetCi77l+vjjP1vi+Vh4gp3iltiJNm4zGWBOxhNxfNxx1CAXBZaOhOBv9gT9Yspixi0L4hqJP4Bkyxl@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcL98VqfePSUlFce7hd2RZ2BG4BeNJZARiTZDWg3AVGBlCFB4
	SWmE7a7hbmbMco9w5HBYNHeTQwKTDVfDGq6IgIwplL49+aorrrDVZ3M3QBXC9hCS
X-Gm-Gg: ATEYQzz0f8JY+jcVSZ8xW06XiZMuQwlwKIR5jrQUnHH5h9vDRrkP/WMCnGOnR5iFt7r
	7Kqjie7Ml9mSvc7uVsSFdjkeNJimOVW5Q2ndfCuE7Du6NqSxcLlRrD1SWFRlsgW/dKJfHW63K9+
	sbnCMq8H+yy/mEI6pAKtL1zTKtITVAmOkjDPZV5mZbmM8tIOJA2ICifbvC+k7lM9abkiHYrCjl3
	WCY7ghm/u68g+h/93xZyKdt7ECy4Dsdt9KMUv4+1oR2JCbBxDJP2DarZn0Xj+RFOvmuD/32wnhH
	uJAETKJM09G4FQSnpy6X5lgmMW/hk6mht3GdnssFSKbvLPfWvJpD8/r/n7rh/p4dtPKFlS27cpG
	YlTVSPZGTK3dIrD0ASwV0L9g5uHxh9C98RmHYbzjFGTK3R9VRM7bf/42iJ5pfmUfIutOYpIlcPD
	bqRv3ZJqkq0XqZK3OYhK0ZTSeUHGvkV96d3vZrUcSRT/WfZyJrVwWB7AATNlm26kb1QRrmtSbwO
	MhHWCgUQU2Bq7WMO/xl0Ix9
X-Received: by 2002:a53:e184:0:b0:64a:db1d:2d57 with SMTP id 956f58d0204a3-64eaa69eeebmr4054217d50.2.1774222022375;
        Sun, 22 Mar 2026 16:27:02 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabe7e343sm5337755d50.11.2026.03.22.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 16:27:02 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	amir73il@gmail.com,
	paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] backing_file: Fix error code swallow
Date: Sun, 22 Mar 2026 18:26:55 -0500
Message-ID: <20260322232655.1164614-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro WARN_ON() returns true if the condition inside is true. So if
there is an error with vfs_open() 1 is returned.

Capture the return value of vfs_open() then run WARN_ON() on it.

Detected by Smatch:
fs/backing-file.c:52 backing_file_open() warn:
passing positive error code '1' to 'ERR_PTR'

fs/backing-file.c:77 backing_tmpfile_open() warn:
passing positive error code '1' to 'ERR_PTR'

Fixes: 7ea30795d6b7d ("backing_file: store user_path_file")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/file_table.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index e8b4eb2bbff8..0898b1816c14 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -69,8 +69,12 @@ EXPORT_SYMBOL_GPL(backing_file_user_path_file);
 
 int backing_file_open_user_path(struct file *f, const struct path *path)
 {
+	int ret;
+
 	/* open an O_PATH file to reference the user path - should not fail */
-	return WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
+	ret = vfs_open(path, &backing_file(f)->user_path_file);
+	WARN_ON(ret);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(backing_file_open_user_path);
 
-- 
2.53.0

