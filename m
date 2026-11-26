Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710708;
	b=Ayz0oyn1e/wrYlkqMUa0476sVOYaf+od9ff3LdKK2Bl+UQ2bhKa2fCI2c0mdVRt2w/j/
	 pYLjJvph43kuPYFDjutO1f47pE0nOYwdiJRJ61SobeZkhSvPEpFdhFeF87v5EenBPKpeo
	 iqiJwqAV2FII02Mo4BpBaEi/5Qf/crxGwwwNe4Qj6thWGdDryKLENRQvGih1u8PKp1SfW
	 4KC6Bk2MacN2khIzqdHT6Tmz1qPN+CDTnKuZvZ/L5ra0vfjTC6diQQBy5qfbo3PXHd+q0
	 DR8Sy1zQ57ie44C/6Vpuf0CUzYVgA52v0HfNk5hy2KhwviExe8Lq9tRuATIFmqaLomQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mfpEhfbyhPi8fEOS+N1QHzNJFz4cU/NZgKWTwuKYJ+M=;
	b=B+u8TANIRMeqVXigc+8wr4BvPl8PF8+Y2tmMf4Cux4OfoKNdSWqiJoLzjCMHxdCJhb7u
	 b0mflVTF9vgPRASb+f+qS1G5FBx5LgGu4JvubB2uioCgsPSmIceh9ogjiF+ZxUbINt5c1
	 KWQphfW8qTWltThDa1BP6qVrF/ePit1GJ+gGOv5BNy+wdWDwveu7PFUrjAhC9CRF0pggI
	 z4NgDdl3bsIRBZMxBYDCULMMk5/IgmOpR5RAbeabOTBEe8dVNonw9gcvDBzotsawcTz6P
	 fZk4wbNY9HtbK2jpeE8kuRwczmNS8hSSE0n5qyuozHVgNKNr7un4/yKvAiIIC9ju4ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xc+MkwdP;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B6606A326
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 16:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 400B6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xc+MkwdP
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so73940855e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710707; x=1796315507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfpEhfbyhPi8fEOS+N1QHzNJFz4cU/NZgKWTwuKYJ+M=;
        b=xc+MkwdP2qSHhRJs8tqp0gJVAbhLaJGgxK7Lgcrjfgi+poNIcrpekreyQIw8Wa2ubw
         JTYEYjzBQHqXA+RCGlkMim5rWjlpg2Rc8MJ45f9iuFGrYnTeolSe9vBS2bLSeX5T5fZf
         SZX2nx4eSzWBYUFb1yi9O/TFdM/MA3MAnAw6/ApHrCpLQQihkBD0TTWOQKPnQ28uZTYE
         XpRkIhDzQqfntphSLOtItZuJswRxPc5PSDPlBmuNOaDHAcf8EMQ3hdeMUxJAM4CSuDyL
         mqwH8JHptswvYdfZEoqv6ChJC6m67PYPkI1mpROJ+wyATfnVNkfzJA1ri8ZRyz6/FKyk
         ZCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710707; x=1796315507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mfpEhfbyhPi8fEOS+N1QHzNJFz4cU/NZgKWTwuKYJ+M=;
        b=K4D6g37WyzK6iYhoDy7zFhftnztSdnCA03CmWcgxrEqMjWaX2RpaB7R19QdtIaayE7
         9UxdXt3urbnIzm4zDKBv6wdFX6n9rJkFM/bqdQo9UAisM23dU5IbOEppLk8/nxMvTf2n
         cfYTuKBEIUTcSyDqd+hBELMZC3jXtS57e2Z/LizuaFXMDpnhKgbTLJdHfGqEVXXw1Q/P
         x99oZFd+J+lZh/uIHILVcUFWEmdOBZjpO4tApbKEX712DIMF3r5VseFsVxiD7lXaXIFU
         RF0y+t87DI9irAlmR/Y38/eN+J0kKAGToMv0/H7RYJZiNuvA3AeZ4LkaVjt/xfsWVHIF
         n2BQ==
X-Forwarded-Encrypted: i=1; AL+hErHO1dEMIoDk3GVZ/Vt3GPm4ATaieqdxaKBWRlUsXfwARh77lTdi0uYvR3Ta3vPRTLt5FEM/ka3w3HLdi8rT@vger.kernel.org
X-Gm-Message-State: APuU4Z867MLDKHyqBtJlLyl01DugrKAegQwbBGZNUG++dadsdUgLg9iB
	O0SEwlbi4UoNDoQUxsOJINDZgd+7gtM1Xu+bwXBxvRwv7sZF1ffpoT2H
X-Gm-Gg: AZFdTZeOCVaJ7vvPemY7Hm2YNGVD7RNUYpaPFybnkpwJq6kAiDheGvw8Aii7Xkft66o
	/ONs9qoutfE7mEY6w0lyVNt2DF0/ytQrNBXAcHBwCloSc1JdMjRTo6+HY1HSE5sApfzcykW6BCD
	os7FTHiXZz1Nwy+7pnIqnVROyT6PEk+8x/5lrmQD6GVRfBuHZ6uUNx9Kdv4JnSNt6Ui0Tax1mZI
	+xKiQz1VqvO0n0SeE2PvmGwzFjRqqmAVyY3xun8mICQCxMuk4qC2ttYtQvnp0XCpcEPXMWT86Yt
	D3XlCAChB5qh36KZo5UQf6PyQVHWXv2Z7NcD2/NI+eKI9TJBNfFI8vgY4q3RQ7QE+SAxkrsOnF9
	RzZifXm9reKZI7N8xWo2xm+G7sYJqlNT9jfNVAImywIscKrhPnKqIb27JOdCdBRG0a00Z1zQBeY
	1USY7TE2PaTAiOruoE9qKsdaT26DOAYSU8FtL+3U4Ayi2AVWyolW9PKr9NaLVss0epI1SoAy9Mk
	dwdqOqT79lZ6mrh1bbNfTbmZbCkn/8COG0izv7jSzBUlpi7DLEh+J/NwSYH3pTmDZCUovJbVkia
	xWyYm09XsLdJona705NL/jVh
X-Received: by 2002:a05:600c:4e0c:b0:4bb:875b:f23f with SMTP id 5b1f17b1804b1-4bb88827f0bmr416764955e9.33.1795710706373;
        Thu, 26 Nov 2026 08:31:46 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm721964995e9.11.2026.11.26.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:31:45 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lauri Gates <lauri.gates@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <dgc@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [PATCH v2 1/4] vfs: use goto out on error in vfs_fileattr_set()
Date: Thu, 26 Nov 2026 17:31:11 +0100
Message-ID: <20261126163114.403846-2-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126163114.403846-1-koray.fra@gmail.com>
References: <20261126163114.403846-1-koray.fra@gmail.com>
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

Switch from using if (!err) { ... } to the cleaner if (err) goto out;
in the main body of vfs_fileattr_set().

Signed-off-by: koraynilay <koray.fra@gmail.com>
Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 833e03810b24..40d6518f1d8e 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -285,30 +285,31 @@ int vfs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
 
 	inode_lock(inode);
 	err = vfs_fileattr_get(dentry, &old_ma);
-	if (!err) {
-		/* initialize missing bits from old_ma */
-		if (fa->flags_valid) {
-			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
-			fa->fsx_extsize = old_ma.fsx_extsize;
-			fa->fsx_nextents = old_ma.fsx_nextents;
-			fa->fsx_projid = old_ma.fsx_projid;
-			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
-		} else {
-			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
-		}
-
-		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (err)
-			goto out;
-		err = security_inode_file_setattr(dentry, fa);
-		if (err)
-			goto out;
-		err = inode->i_op->fileattr_set(idmap, dentry, fa);
-		if (err)
-			goto out;
-		fsnotify_xattr(dentry);
+	if (err)
+		goto out;
+
+	/* initialize missing bits from old_ma */
+	if (fa->flags_valid) {
+		fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
+		fa->fsx_extsize = old_ma.fsx_extsize;
+		fa->fsx_nextents = old_ma.fsx_nextents;
+		fa->fsx_projid = old_ma.fsx_projid;
+		fa->fsx_cowextsize = old_ma.fsx_cowextsize;
+	} else {
+		fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 	}
 
+	err = fileattr_set_prepare(inode, &old_ma, fa);
+	if (err)
+		goto out;
+	err = security_inode_file_setattr(dentry, fa);
+	if (err)
+		goto out;
+	err = inode->i_op->fileattr_set(idmap, dentry, fa);
+	if (err)
+		goto out;
+	fsnotify_xattr(dentry);
+
 out:
 	inode_unlock(inode);
 	return err;
-- 
2.56.0

