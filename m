Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498246;
	b=ErLlrwlLxaMQ7VUJpKlEXqTCMCW+Q8uOUqP8W9dLhvwF18i6/EJ4bqfdfWasaVG1KeJT
	 4tXZJm7+gDPKLzeYV36esdCAb8uRg3XN0TfHsvwXK0j0YhawwbRGiZDmklFLH8twhgGfu
	 wH3u53aRN7wE0Lo3KRRJUFBeojHB6hJT0vapNz4yWkCfR3Mmq1hKLcneU19JkWXmdM4jT
	 LRd6k/01lVj9zQoFkSjj0cqNfBlhfqW3TybGutwLCtlivx/ZLZ4C2wVgOUSwqw1BCMKs2
	 V/KmsRn8YQ7EwftK5ndwEsENkf/5ouQ2bO+V+jZ8+w1VKp0jirouqop6yFTA2lDhuPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9AHT+4uPvWe1t1h3zSSbp4rofXCcWo8UcjGq3mTB8UM=;
	b=0WUcLSXUKf/PKQDpcqY6c3x29bUBZSXMRCdfHCxEBhsszTcCk5fheZ8phQTohtacTyZe
	 Gd2kyr0KbMYdODAJ81LdkHRC1Qlbr97e+Kqgt04irjlMvSDA/+6u22sGrW3OjpF0yyIaj
	 CtUQW0AO7v0BtsTrNw5x/7ml8figh906WXGJjptMsmHxG6BTUDe33mQtd8ysEN15uRLqd
	 iHXlK6o5PVeK8srUKx3fQP24zb8zGOMaCWHZK4SYf0dIEBLc5lfp/rczLRfOLmL/QMSI4
	 heHsQ72ASmIvs08DdeddN92AJaB+OLf9OJovdpinPrQOORZPpDka91kcBWHpvQZxKcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6E9zXny;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7FE60A2624
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 01:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7FE60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6E9zXny
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so17480875e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 18:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793498245; x=1794103045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9AHT+4uPvWe1t1h3zSSbp4rofXCcWo8UcjGq3mTB8UM=;
        b=c6E9zXnyBd1dxj3QVODEevFQOkW9llb0HZ5WHJHiNOiNB9qd6qEdsxAiD88lBYRUhy
         RTD8dwAyeeMQ/P6e4XpBTyYr9CdHq1Z5ZoSjnOcQ43l0sSRRE2SU2bVaKSbP7OFiU5am
         +YnZ3xy+tatzzdG5jV5qTqox0i5Za2dg053/k5zKoz9m5X4KZjO30QPe4vk/Rih8omDj
         kkesHih7L7GwtKXoIlBExVUv6BuqM4MvhmN4pXiSiKn33VEAT1eS/KXlb8GZySTFSi63
         R6NVPFry/yoaz8fuwwf1PLpHwOl3hFTsQpXDci8LWS15HRCyP5IWZVyH9IoPaEqPzTYF
         IT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793498245; x=1794103045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9AHT+4uPvWe1t1h3zSSbp4rofXCcWo8UcjGq3mTB8UM=;
        b=kUN8xjhgoxMfUd9wgmmQPnzBPYRaN//vVUww3AcqpeT38yhUxT4000tzPitpAhWPRR
         +SHZY/Jy6NyHyGpZ6Lq65gtLdTh8L1saPWniEfrrMWF77aIk+Ht/bKNOC9/IBj4eMzVT
         uBsCwCuzNFoOaunujWgpH+0DKsXtYjwfMFjwwOd8Z2HqxCVQcChBk6JlzFCqRl91cZTJ
         2OgFJMiucgs5Ju5zcJx0DXb35UBIkTTxV0aSMKqJPs97u8jpzlgt6JU69hgq34q012Lx
         OQ4zkIXHy2Xpg5e/CO06R6uAIk81qZAfD4nf/nM8H7pPqZePDfGIW4hGf6ZQUrip10lp
         6kRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXBQ2aUmxaRz8WlKIUqrbz4aUlq1x/H+0jdVsjuOipz+RgPw8vjBr+Z9NdTrbcbrZ2uFHHAyDxaIw3vOW9@vger.kernel.org
X-Gm-Message-State: AFq9FYJo6Lmx1CbSYFfvprCvMMQXb6kMhEbg38uWFe8j6jp7199fIzRi
	D8NwzX5F43NVGyMAPbaXbrAZYRWM65kUFzkKyVAEiRHjuvfRn28rMh74
X-Gm-Gg: AYBFou07SIFsOjr9nlKTA1HmlQ4rLkDq+//5mQ1owFJmm2xy9Ls6T4+G3jTN16mz3kb
	74Pu851MxtOegN+gDi1B0IIdqOqWAVVEBEG8dJ1StMyKS+QwkrYbUN851HSfzFFeCWBTZQBE903
	92d3hMvuDEhbv8eBQyUWTih+HG3Ywc6xXp5cjgSODora8kgzEeTo1j1MLjGxbwLY2ZkhQOkRbVX
	oHSw9XWvfMyWl3m5eigg2t8SwjQR8pL+YMX+sIeLRfXXkH9TckEiSJvvcOzDwgIzn56JAOmt9XX
	iMRzJsx8luueTylN3WXetqiONex+RYrVmytAZAsWa4wEiwjbWlLkyDX/uvhUbHzFggbdNMkrC1i
	mSjGBOyKnLBwAQTgV/tGypYX86QVMWA2KIlwzIzj5omTczqmeoBEUUhW0W+rGvYl0NuTWsVoh1o
	yEliA1SSqG8sta9tRFYvDKucZ7nQDrOdRyqGN20MlsNwsjd/VRJvx0kQp+aw660KLTz4sGnP40q
	B5GU4yUUcJpL9Ki7+/T4I64O+XTr4lvn1DJfIFBFze+x+648ldYKo5LVTb5U1S1Bu21sAKKw/8/
	FF8E2IpTOE3GtOHZBxYQYyjp
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4ac151a84f0mr142228025e9.3.1793498244682;
        Sat, 31 Oct 2026 18:57:24 -0700 (PDT)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm273532835e9.11.2026.10.31.18.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 18:57:23 -0700 (PDT)
From: koraynilay <koray.fra@gmail.com>
To: David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Chris Mason <mason@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chuck Lever <cel@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sean Smith <defendthedisabled@gmail.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	exfat@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [RFC PATCH v3 2/5] vfs: add fileattr_has_fsx_mask()
Date: Sun,  1 Nov 2026 02:55:48 +0100
Message-ID: <20261101015551.786044-3-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101015551.786044-1-koray.fra@gmail.com>
References: <20261101015551.786044-1-koray.fra@gmail.com>
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
index 0b93f9609284..16acc61c9af1 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -64,6 +64,23 @@ int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa
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
@@ -73,9 +90,7 @@ void fileattr_fill_flags(struct file_kattr *fa, u32 flags);
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

