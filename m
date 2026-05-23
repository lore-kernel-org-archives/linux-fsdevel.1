Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B4243956
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509715; cv=none; b=PEgxoHfNBP9HoAg917MXMZlB/ybgx+8i7l+px4RNDIcFojCmGrq3zSKgm/lRkrW0tyah8n/LoTJPbTotKVFUYPtPRytCTwnge1Sp+zpF5PcLEFZFFVZb+pwFWUaO+aq9BrokwNVwp7Zces4wEiqNCDQ5inKv5JLk444xCMMx3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509715; c=relaxed/simple;
	bh=HqQecYhKN0ZfkC1p2kK45n+IQIFHeJl+F6L3+ooWb3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKCtt+3b46l6tSQvUMefQvBKdKLnI3dfGQWDnRoIPwxtNqGCNO6fvnjuVzkHdclIipMYpnrbzECCo0Q7a4sbYKpeUa55huqaaa1vSLmrkz9soTQcbkgjezN3hjuxab4WpA51g5vOFqwZzA4WlY/Vx074DJk1atsIbgOHPq/3IdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX0ZF9E5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX0ZF9E5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba21d32776so58738715ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779509712; x=1780114512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhzaN7BWimOMiqEoiQNjGpOIY4nGflNoP3vjImK4R3g=;
        b=HX0ZF9E53nSCx4qMVhBocRYY5tL9aJkW2QzveuNxJgl7B0i5Odrwwc1lGrAXDlwv9C
         ZyiF3XJaslnjSsyb+SUPj2rJ4n9CNqkB8zs2AP7EGqPHRPGJ25+DpPuftn2kmW7ndRmv
         I7ATIqFDSutUdHJ2ntswnqtDVYkgFILyCwU/akprtQ1khnT3siidbW78obBrDPSQb5mF
         J6jBm/UoHz9dQFzKyUMvq+4v14xBnXatm5nV8H0bMYQFqs11gkYzKTPVAElnlp29Xji2
         yAC8vORLXBA5xBSPg9C/9HJm2NpIuxHz+DWvdP1O8RP5SuzxiBILJO/2QmR6LQecKWG6
         1ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779509712; x=1780114512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhzaN7BWimOMiqEoiQNjGpOIY4nGflNoP3vjImK4R3g=;
        b=lvo7uZufQY4o2tgOUBOtdPhWkycMdH8uITHsP1vPGfPl2Uu77AfyJVj8wrBs2uCF2B
         41NlQSwhzn61fSJI5duHhUpmsHIS2ZAeIm9068S8Nzrw8iTmT+aMG+DolXP/nFYJSX/s
         X2e4lvE787jDbsnbAVXODvXLEyBPmvRfh4YK/T9RFZcLme+wsckqfBVGBMWbBZ+zMyYK
         VCG6CkcjirR1+r24i1kBz7iZCHsElg9eJBQrNOUacKwqeo9bNX3hAXKoS0wBjh6EoV/g
         z0ik3Wh6Rca1fUQ79PzVVtK7XklsSXvYC17Peopgk/q5sp3IIC6XPjpYOByT1GY58ftF
         laKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8R810VLCfxOc+8XaUXVcdgCR6KLn9rnpHF3DJav/Gfopu479QdNbnxv+jVPgYFfMzz8L5EiiIJqK5z4RIb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5dEelxuxNxWK4ZnNMsOykbgmM8NC37nC5qwxUvtjfrTFNq2l
	saIYf3PaqZrSHEu3H7cC3Lf+LP/jZ+ihHeonSKVi5Kuw3LFFkRa4ICxuh+iwIg==
X-Gm-Gg: Acq92OHDtpRfrqWbOuTYr3riMWhiV7Ntj2hXGTSaesZjlWxAta6C6qDy7Q4e/TPomCe
	41ZFXeF7il+ADPz8iHbjgJtal/uSXj3gUWKZWuCFswsa5SplLFh5FtPAdcn+YLCI7dTm8xit9HV
	OiUqez1jOdwC3GgEHaj66U0FjmNXNfNNS++lQIqnwELcWJeQA0TnK6DE1WZmwnkqyaqKEUYmuqX
	GDsNV3cmecswFOmZFzGqQ8XOUtOe0fUHlRqJ8CKy47wyhHBsCaCxbOkqLvClupHzxjvV3e+ISyy
	yV3tFcRkQF0VtfYMYt1G013aOX6giGP+E8jqeWHxKHGausnunIFSyzPKUa2VT+C/DXe85Cb4yCW
	QzzA5Px0jW/w+6wVOIKPs1V6A4AgybJrBFJ+BUmeWYqR1kAKTxwTGaPFSL33A6Tvzq+V5CNW396
	dckUdA/4dlHOQaUoULrFGS7WzQdOp4pQ==
X-Received: by 2002:a17:902:e88e:b0:2ba:839e:15cb with SMTP id d9443c01a7336-2beb05e306fmr70544575ad.27.1779509712129;
        Fri, 22 May 2026 21:15:12 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591a277sm31887675ad.80.2026.05.22.21.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 21:15:11 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ntfs: add bounds check before accessing EA entries
Date: Sat, 23 May 2026 13:14:23 +0900
Message-ID: <20260523041423.2726275-5-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523041423.2726275-1-hyc.lee@gmail.com>
References: <20260523041423.2726275-1-hyc.lee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in ntfs_ea_lookup and ntfs_listxattr, this verifies that there is enough
space in the EA entry before accessing the next_entry_offset field of
the EA entry.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/ea.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index c4a4a3e3e599..0cd192752b7c 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -53,11 +53,11 @@ static int ntfs_ea_lookup(char *ea_buf, s64 ea_buf_size, const char *name,
 	loff_t offset, p_ea_size;
 	unsigned int next;
 
-	if (ea_buf_size < sizeof(struct ea_attr))
-		goto out;
-
 	offset = 0;
 	do {
+		if (ea_buf_size - offset < sizeof(struct ea_attr))
+			break;
+
 		p_ea = (const struct ea_attr *)&ea_buf[offset];
 		next = le32_to_cpu(p_ea->next_entry_offset);
 		p_ea_size = next ? next : (ea_buf_size - offset);
@@ -479,13 +479,13 @@ ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	if (ea_info_qsize > ea_buf_size || ea_info_qsize == 0)
 		goto out;
 
-	if (ea_info_qsize < sizeof(struct ea_attr)) {
-		err = -EIO;
-		goto out;
-	}
-
 	offset = 0;
 	do {
+		if (ea_info_qsize - offset < sizeof(struct ea_attr)) {
+			err = -EIO;
+			goto out;
+		}
+
 		p_ea = (const struct ea_attr *)&ea_buf[offset];
 		next = le32_to_cpu(p_ea->next_entry_offset);
 		ea_size = next ? next : (ea_info_qsize - offset);
-- 
2.43.0

