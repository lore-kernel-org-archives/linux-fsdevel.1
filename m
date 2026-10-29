Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306130;
	b=3ExaPyC8r7qVHi5lHSPsPGID9BQkVMDXVRas/PW8V/sFLGzEZY5VMYoMT3zXE72QbukV
	 q+0nfVXmtVuFqI9EUNZmI0+6pSwcvPAiYY4xAWK72idIA5CeFtmZva6Og+thi4QHLny5B
	 MeCGfiz/6War5yy76VjI2VH3TGiToVor/6XMxa+YlzYxeFM8SNSy3nH9xXXm0ysiiUECb
	 YFMSPRgHlQEWP51U6b63ILEPufECfEA7/PAg+Hq/wH8O9Gr+hsLbkzil5jPWleaPCS3jg
	 MAtgJOz4U47h3f2107hBIQAvthMcO1Q6wkldlSnYwO2WyPnao1hy+JCuxjxAyxQeNtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QcJgrIbiHATKK/40hSI/RITxVRqGHCvmwYIWBjFMRA4=;
	b=S4yMJurf0H73OZU07RYHROjNDFQPc2mfXtyJLlweTIdVx4MC467f0zUDHviCmgtm9u5b
	 7cy9G7jVduuTn1JlpD+s7f93qyMEdmz9Zy2KmbyjnGwh1UDqJa/LxItt40U/M0HZYzefo
	 vuwK2u77aG+2QqUVwhtYYDw/Irjds0aJ5OLHpzRTAwYZnEqaEy6ixrBRwE/lDBqTEd0dl
	 T0NFkANwmeSZgq12H+/5BkpygeDURMmR4WMZGwzh/dRvQtJMB+thmzUShrMEICnH6+aLn
	 ZQhzVrGn58Zs1cuU8AeAd9lduRyp42qUVEkWsYv5JlsCdnPbl/M4/2yc/+FvmjhhLIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfElnprs;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3960A2618
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 20:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF3960A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfElnprs
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a1e794908so16761eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793306129; x=1793910929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QcJgrIbiHATKK/40hSI/RITxVRqGHCvmwYIWBjFMRA4=;
        b=zfElnprs3bd8FJhhaiq9y++DLA1RQ7UXviuuuoo6gneNaTe5X1ECba6IhjI91/y9fr
         SI5F/bLYM6xs/u+ranyBHtEL/Y02GuyqZ1NDX5DnozaJmIKv8u0OBMtjIKq4sRLkfYqf
         12iei9PUsCF9KpCjXoM1ATY94bdG5xBns6Zi4673UvqnJBCPZQUnkKRbQaVcecqQSPM3
         WkDN3m8FI2Wn8+LwOdMhpeUup8rnMzTMBAe0+27yRNKgQV13RS0bSmPW1MZCFKmbSz3f
         nNNHBiy9eus2WfiQrWNdeyu9Vy6IyRrhr79ZAGLxtD/3MtAdd5oI+YQCkPajibZNocIz
         EwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306129; x=1793910929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QcJgrIbiHATKK/40hSI/RITxVRqGHCvmwYIWBjFMRA4=;
        b=Op/KrHE+P8xravl/Kn35grIPa3I+4qgo8KNrulxfqXBQYCfRaCEqO4BRCwNgjjc222
         ihAaETGFwZrR/sbTi5+BpE3d/UJxFRe//2jcfSkI4zeNBdFNNwC3tr9dC3iRbCnsmtP4
         HuVy9zPy+pmjDhj5IpITNWFo6KMgiryeIMm6l7zjhncifIycBDoQZY2cxgl6XJbbgGsB
         vKJmwkoIoTTKRY8Dk/HhGwlNTmAGJZiaKih7dXGcBVWvWyboNbbHxm+nH5z9b+95RloO
         hi98ey0WIeWrMNWm9H/VAJXNPslybniwAlRgrfTGi8B75Da1r64SE0Eyn49+b5jgTaI2
         FjFw==
X-Forwarded-Encrypted: i=1; AKwUvByhlr3V/UVwzuE+CSVji2htxYcgVUKHlKmZkJgwpzsUpYjXGL2a4P6V7FL2miZDC1vwtr9/lRov9bRSAujs@vger.kernel.org
X-Gm-Message-State: AFq9FYLWz4m+qeDFojMdEWzwxy8llk/V8WbBXTDwDLPmRNO2GO2U9ESb
	7vY2KFCutuuJuyQklwv5rtMBNwoRNt2Gc3TUtrRcKw9rRUpwKJMGmBjOcR703FTzCKQ=
X-Gm-Gg: AYBFou2VCa1XBzKDxoIfK70RnSSt0DgXS/sOtanS05+rbBW/6eMQtaFwbfLg+vbwTCh
	9MpjzIDUe0x4nPwkbgJ/4lqxGuHE61r6+vISSGC/llF9MwJURWyqeCWV2j1zRxZ4OnvGfBV4O6z
	tE0U3UZ+U3FdC4wPvmq2WRpAzTAIg6DEx6W61F9AsnUHtKr1peSJS90mZrp5cbV8Mqg+7e+f4JA
	8E2iV/e1noicT+3bpHesvnJErsHS7bvzXOAR710NYs5WNQITBvTWJx+tL2ULr9skv4r2toQtKA1
	wzTQ3Nmi1tohfkRehg+gVa/OtrjnLLr8gfJt6o5+1CbCQZtFTBjajnyrzoqL8/fZihTtMNIdlcv
	rBcrNXJkVJrvkfpnuRBXV81Jc8q6JGpGh4ERiN450LZsjPxLoCT5I/ACOs5HlQrnAH838w34Dbc
	gpyvWPJuHOonceSCVgp6fPjGx4FJjuNx0INoSOCMDk3lsiajEuJSqUiWFmFDPbtSmyoz+eS1rJ4
	eOyeInDe7bQMSxX2qGoxmBq4dJ+jwDT775Gjmotxci8HNxqabAXJkThtPmmINxjl4ZqvDfWAvwO
	XHYZd2SQKf3Gll5/eptSs3Bi8d/Sarcq19VusWU288XRLQmH00fThZBlKvdC1RJFTzQNtb8rVid
	olw==
X-Received: by 2002:a05:693c:41c9:20b0:36a:15ee:c20e with SMTP id 5a478bee46e88-36a42430362mr654438eec.33.1793306128640;
        Thu, 29 Oct 2026 13:35:28 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm982137eec.18.2026.10.29.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:35:28 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fs/ntfs3: preserve colons in symlink targets
Date: Thu, 29 Oct 2026 20:34:57 +0000
Message-ID: <20261029203457.59990-1-dennylin0707@gmail.com>
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

ntfs_nls_to_utf16() parses colon-delimited ADS names when the ads mount
option is enabled. ntfs_create_reparse_buffer() also uses it to convert
the complete symlink target, so "ln -s foo:bar link" succeeds but stores
"foo" as the target. Following a link to a named data stream can then
access the unnamed stream instead.

Add a parse_ads argument and disable parsing when converting symlink
targets. Keep parsing enabled for the other callers to preserve their
existing behavior.

Fixes: be310476e886 ("fs/ntfs3: Add basic support for alternative data streams")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ntfs3/dir.c     |  5 +++--
 fs/ntfs3/fsntfs.c  |  2 +-
 fs/ntfs3/inode.c   |  2 +-
 fs/ntfs3/namei.c   | 10 +++++-----
 fs/ntfs3/ntfs_fs.h |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 14ca54e54578..be3c6a7fc57a 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -173,6 +173,7 @@ static int _utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
  * @uni:	Destination memory.
  * @max_ulen:	Destination memory.
  * @endian:	Endian of target UTF-16 string.
+ * @parse_ads:	Whether to parse an ADS delimiter.
  *
  * This function is called:
  * - to create NTFS name
@@ -182,7 +183,7 @@ static int _utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
  */
 int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 		      struct cpu_str *uni, u32 max_ulen,
-		      enum utf16_endian endian)
+		      enum utf16_endian endian, bool parse_ads)
 {
 	int ret, slen, i;
 	const u8 *end;
@@ -239,7 +240,7 @@ int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 
 	uni->len = ret;
 	uni->ads_len = 0;
-	if (ret > 0 && ads) {
+	if (ret > 0 && ads && parse_ads) {
 		uname = uni->name;
 		/* Find delimiter in range [1 : ret-2). */
 		for (i = 1; i + 1 < ret; i++) {
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 97c04ab2763a..b06de8566a72 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2668,7 +2668,7 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 		return -ENOMEM;
 
 	err = ntfs_nls_to_utf16(sbi, label, len, uni, (PATH_MAX - 2) / 2,
-				UTF16_LITTLE_ENDIAN);
+				UTF16_LITTLE_ENDIAN, true);
 	if (err < 0)
 		goto out;
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 5a8d362155ac..d883c4b47e83 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1315,7 +1315,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
 	/* Convert link name to UTF-16. */
 	err = ntfs_nls_to_utf16(sbi, symname, size,
 				(struct cpu_str *)(rp_name - 1), 2 * size,
-				UTF16_LITTLE_ENDIAN);
+				UTF16_LITTLE_ENDIAN, false);
 	if (err < 0)
 		goto out;
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ae88cb66fb7e..ab9da0faa104 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -45,7 +45,7 @@ int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name,
 		/* Convert input string to unicode. */
 		err = ntfs_nls_to_utf16(sbi, name->name, name->len,
 					(struct cpu_str *)&fname->name_len,
-					NTFS_NAME_LEN, UTF16_LITTLE_ENDIAN);
+					NTFS_NAME_LEN, UTF16_LITTLE_ENDIAN, true);
 		if (err < 0)
 			return err;
 	}
@@ -82,7 +82,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 
 	err = ntfs_nls_to_utf16(ni->mi.sbi, dentry->d_name.name,
 				dentry->d_name.len, uni, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
+				UTF16_HOST_ENDIAN, true);
 
 	if (err < 0) {
 		kfree(uni);
@@ -437,7 +437,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
 	sbi = dentry->d_sb->s_fs_info;
 
 	err = ntfs_nls_to_utf16(sbi, name->name, name->len, uni, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
+				UTF16_HOST_ENDIAN, true);
 	if (err < 0)
 		goto out;
 
@@ -496,7 +496,7 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
 		return -ENOMEM;
 
 	ret = ntfs_nls_to_utf16(sbi, str, len1, uni1, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
+				UTF16_HOST_ENDIAN, true);
 	if (ret < 0)
 		goto out;
 
@@ -509,7 +509,7 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
 
 	ret = ntfs_nls_to_utf16(sbi, name->name, name->len,
 				(struct cpu_str *)uni2, NTFS_NAME_LEN,
-				UTF16_LITTLE_ENDIAN);
+				UTF16_LITTLE_ENDIAN, true);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 689151fcf993..5475eaeb49fe 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -540,7 +540,7 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
 		      u8 *buf, int buf_len);
 int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 		      struct cpu_str *uni, u32 max_ulen,
-		      enum utf16_endian endian);
+		      enum utf16_endian endian, bool parse_ads);
 struct inode *dir_search_flags(struct inode *dir, const struct cpu_str *uni,
 			       struct ntfs_fnd *fnd, u32 flags);
 static inline struct inode *dir_search(struct inode *dir,
-- 
2.43.0

