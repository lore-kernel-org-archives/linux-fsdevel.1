Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794765845;
	b=fP3zZNAg1xzWPlvkGAzeKlDG2G8C1tVsPJItJai01sI6V2F+F/kc/bDTsJyVvGBotdoW
	 lmU6K8mSPHp1uBQIdMs0GIruRqJpnV1u5+VLyQpVnTHqYvTIvmvQIp5nLJRUDauWuIICQ
	 gKHEm3U6Ub9V1ZKh5uSM7J6/hHBvHeFsHxPrIkEsNB0t8x8IJUOEjMycHClUmI8hh4L3M
	 tTlahGg/TUQPJG+fDmPLa2qJC43SbjRqXEBW0aNFr6YhS4PyQ7NdKCjKMhrZuKPTYfkZG
	 2DRHLZQHQdWE6fpYm+CDZur/aPP8RMPzB9mhJoBqGBb7klT4ACpiDQEA2hojhQXKTnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794765845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jCob8yxVUbZMrzUJynGorNZ6cDsRus7pIoTivcXFIek=;
	b=wUyRpKsxZW8jWOr82WGr/5eaThynn3Se32RdcfAshyeQmMsjklo1NotC1aMv0GJY11wM
	 9uM9t0tEX5Ri0VfVAbSHroPIx+IABZo7iuq5Z/APmpKDqq3E0EjQFt6HcTge90GkbplNE
	 yRlIdyEd8qqcN45jJv7MeJs+bLEU6SiPAtysr8xFzwNVY73BAGlzP+utNhDPHeAbYiAaY
	 AUf9ik16u34r7njt3rHtzJnmUEFcL+F9TGy1pTxpmidPGhPFlg7tLbm3EHIp4Mt0DvcaL
	 eocKY8JfY6AsI9hFcsUEFxmf28WWXz+2o8wMRxIXy6TrCuF9CSnnlr6czHcXFsDf46w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IBD9fQPZ;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388F606A8AD
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 18:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5388F606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IBD9fQPZ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so1325986f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794765844; x=1795370644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCob8yxVUbZMrzUJynGorNZ6cDsRus7pIoTivcXFIek=;
        b=IBD9fQPZzDEKg2bdACsPtBrqMrB7RpYNzqy1KmrygLKNqfGgfMBRaPWVmtSMny9Uyo
         zZZXZUcxGun91msLJSPue4OSf8KXgtednCc0ci+LHlwiRCT7BYfwj6SD9fUlUIoUNNdM
         HjfCIWv0XLZodUGxpASoDy920nowWC6vgr7iHYUYL+7eC7K2ekWYt+yxN8xnL5lTbX+/
         iPXMXBJgcRIoFjYblNIEP9XDiGpFeZaYRykIxOLk9q0/b6fE1AF+H2k0K17e9FL8HjA/
         bPcXWcQ7jEc4YWkcaZbecSnNezqq4f/KgXnLXzb11BA99Sp4jVEommfOUsdvdRwp16i1
         ptAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794765844; x=1795370644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jCob8yxVUbZMrzUJynGorNZ6cDsRus7pIoTivcXFIek=;
        b=kobJ6ZzByPT4MaEF5iGoJ1XeuDqRezkQqb1gmjZSV8cOqGtTD4cCmrJ7iMK++hvqss
         WlYRsFX9yYBM69kRJv0v63LRR4g5pwyBtVG2hoh7ZCLJPxshJy4voLSbuUTxeTaGNDJC
         o/+uzCO8+dHWvnt8OFI9EX1m1KpJvsPPPZxFCNc2u7yHVxLVlyplht+Dts/VpLTorbQR
         cX6y+4VimyO/04T9g8nltv87pVeVVKdfEDd6q+8Klr5GcJShuveOBtYCmFR7UCNvcv32
         JeZndn36Fh8KAi+U9r+wT+hitfCKjSwuf7kZ4cpVQtoovFwt9XhBiRuY4GXOzX02PhxK
         UNXg==
X-Forwarded-Encrypted: i=1; AL+hErFYvKmqvbtMeMyQlesVW4ryG0nUyDAjxo20vaSBmXl2SgB1XK6A7f9nXPeBhZqiwnka34eJjhYoJuO5zFiZ@vger.kernel.org
X-Gm-Message-State: APuU4Z+xxXxC4DaluwZmx0vLAr89nj6LlOxUJMdNOiu3WVXlXRCJuBke
	A3Gi+5zXvaw6cZDFJp2zSnOKBp1XmF84g0n6v/vjKhKgFRMYtlzi2VPe
X-Gm-Gg: AYBFou3UrXnkS+wkAfjZtCmsyfyIrFcOvfjzranKZoj464n56Bn0GqgJyoIxPMvOiwE
	OIh+MCI9IC6kFq+RwzrHHRYc2wCEIrwT7LJTTguspVf8vuee5v5hisyF2VDCHfBWAE+ph3M/6y4
	HEe8l3VV8pNhiTfMIRgKIDacUyDrfJgoN5KRt0dFbMicgZfOQ0B25fdcdgQWEQXU7aOSrxVBY3f
	tTMypC5z5pzIwMYXgAXHQGojNG+6nxHUB8lXMnXQxq8pKBiUOeDSPrulOF6z3OqVvnZZRChxN/x
	5C/sFm3ipTA923sPXbtHQxIDz6uU2mIOU5qY28vN1LrWIHMMimCVIY+QafGnfw2AoI2wLrKq1iH
	EZULBc5+fPV+FDoSzqYBcjgtOjCWpH4Ym9maRmnlY6KeAB+BWS6yED3Afk/okjS+dWW6gPuZafz
	Y4vMsRiU2n5CzG72UtKLsy0jTuP9Hw6bV9oE/MrQyubvUUSAjkDvZPx0Gh+NhGgjhkKvcz7oOl5
	uETPGJ8CbTQDMrWW+Hk1izS/Eyc9a9YEkE+RIgzdbhSn/S7xNB1nCIVK5jqitIEIYFhmVo1TGhK
	SsAKhXulf0ljXQGJYisgoyHi
X-Received: by 2002:a05:6000:1841:b0:48f:d7cd:a5ac with SMTP id ffacd0b85a97d-49c6b97336emr21325466f8f.0.1794765843381;
        Sun, 15 Nov 2026 10:04:03 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8c248sm17980448f8f.58.2026.11.15.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 10:04:02 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: David Sterba <dsterba@suse.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: Chris Mason <mason@kernel.org>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sean Smith <defendthedisabled@gmail.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	exfat@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [RFC PATCH v4 02/10] vfs: add fileattr_has_fsx_mask()
Date: Sun, 15 Nov 2026 19:03:35 +0100
Message-ID: <20261115180343.576773-3-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115180343.576773-1-koray.fra@gmail.com>
References: <20261115180343.576773-1-koray.fra@gmail.com>
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

Add fileattr_has_fsx_mask() as a helper to let filesystems check for
unsupported xflags while allowing supported ones. Can be used in the
same way as fileattr_has_fsx().

Also make fileattr_has_fsx() a wrapper around fileattr_has_fsx_mask().

Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
 include/linux/fileattr.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 42b92ccdc583..ba7ed3b387d8 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -65,6 +65,23 @@ int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa
 void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags);
 void fileattr_fill_flags(struct file_kattr *fa, u32 flags);
 
+/**
+ * fileattr_has_fsx_mask - check for extended flags/attributes
+ * @fa:				fileattr pointer
+ * @allowed_xflags_mask:	additional xflags permitted
+ *
+ * Return: true if any attributes are present that are not represented in
+ * ->flags or @allowed_xflags_mask.
+ */
+static inline bool fileattr_has_fsx_mask(const struct file_kattr *fa,
+					 u32 allowed_xflags_mask)
+{
+	return fa->fsx_valid &&
+		((fa->fsx_xflags & ~(FS_XFLAG_COMMON | allowed_xflags_mask)) ||
+		 fa->fsx_extsize != 0 || fa->fsx_projid != 0 ||
+		 fa->fsx_cowextsize != 0);
+}
+
 /**
  * fileattr_has_fsx - check for extended flags/attributes
  * @fa:		fileattr pointer
@@ -74,9 +91,7 @@ void fileattr_fill_flags(struct file_kattr *fa, u32 flags);
  */
 static inline bool fileattr_has_fsx(const struct file_kattr *fa)
 {
-	return fa->fsx_valid &&
-		((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
-		 fa->fsx_projid != 0 ||	fa->fsx_cowextsize != 0);
+	return fileattr_has_fsx_mask(fa, 0);
 }
 
 int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
-- 
2.56.0

