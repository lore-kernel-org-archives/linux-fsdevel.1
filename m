Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970DB382365
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307176; cv=none; b=QGkMTbY0clu9Tm3nVyQyZGsABMjJHyyiktRfPJUxpRsv5bVFlPvH2jgQvh84hpTJx5XUcuK1ZrKjMYoV9+Hup8fR3phwIlkJwATfP8+9lRnjQgzqLgbDi5w4Gf47YlpAcKaeIiPcLo8H2KcUj1DOY/cFl3O9oU677Wj1Uib6/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307176; c=relaxed/simple;
	bh=0iDZOjepnYHKbwUNptbhXbh2gt66eTQ2spfZriwBAiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6Vz5dLplIoplKlBQ/uYUWDjbd5sz5aE5OYo8mV+UftfmRz29cWryduGH7/QgyyKJ2CnTRYKYy9b48TPuO6Dx08mn6lxin5OOruk8yxz5Bkv8kNqVpLRzgP0qnV3pbOUrXNg2j1XFSrVNva5cfZiSEE+z0qGfoMe2pV8mKcGdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5xz103r; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5xz103r"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b95a78a11dso4217265ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778307175; x=1778911975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFcSdFJcr0n6ORD4bjAB2j+Li1vLVOxo6IRxDvRQ+ZE=;
        b=f5xz103rkTMajunazNWYd48UvvJR6qjefoD7Z64k5lSdGgwiGyicnItwgMU6dvXCnd
         YAlDaEh5GoJozdDwpN0XrcOeXNXZy5CdbKV5VUvI8vo18N1lqNuxHzBBqxeGCue1hDvM
         K4C50pGZJvrFo40euOkKwA+R4sIe04krWRrqb9hpapfdhQM66RrYCP1l6eutaaqtSGow
         5BzdXrF1gDkI+Fw3kiVmzYemTeU4kbEr58zVbSt46pyBsjBkPRguQNDZ4GbhwTDHF25w
         PtywGr3knIC10WaRYV08TpXclyXkD5O8LRgAsoTs24nTaXa8ULlp6tBjEj7KG7jZo6bi
         wVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778307175; x=1778911975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DFcSdFJcr0n6ORD4bjAB2j+Li1vLVOxo6IRxDvRQ+ZE=;
        b=V+A/osOGwjRnMiJh8r4hvLqkOFxpKh0v+sHfFmrAoI4Mj4x3fSeeedb9tbrgwNSyYF
         a5M9N9dSYPr43hRBXFv+8scEmI3Ak5p71YPDpDtudsnMQqV9eWvs3YEk/7LZeXYvjhdH
         3+SWEXTQ81jOigWwUooVjvOd9I004JgLvomPLKfUKC3ORqE1fqMHGRLaNwGBTVlNAsC8
         0vD3nftnCfhFHtwaMIvaJovMMSADP+69JvdfBX9zhYc/Z27EhuiCdnEh20kWujQdX03u
         ddPwD1yRdHK+T/BxZV6yfu0FWZgAFZ8z6eaZ2BlkuiJ4HD/S5MqyjZrJ0w9q2Gahd3eq
         SnLA==
X-Gm-Message-State: AOJu0Yyc3/vBiBWP8BNbkOZnfm5OUoKoIks43cforaxYjF8e3LpCs+59
	ZynsgScnHjKyCH5MT6rVYKnyNrMny4Ku3SQWmg20JT9TUjqLqED9fP2y
X-Gm-Gg: Acq92OGI0zDaFLE/tclhEyMUTlLpPD/JGr/Mvim+EFUciTT+RUlpjZzQHwM3bvYmQng
	zDhq08mwURwFcjBNFIeX1Kn65zHdHLoJ78tDootD2zIs1xCuG3OSdj7z7G7zEOx+mrWCW2GCPED
	R7DIL8TSdMfcohRAxsNgFE8MqaERiYu//KcxiE/b0knlgRgLku6kJ+dOM8iOcZ/67hs0MsTnWWq
	BH4iHMtm8LQWPh+tlue3m0kLo4eAC8AJalUwVLNteW8K8PSeJzEaf1FP5X5v+9njWIj3ObVWcSg
	5BL0dA40ej+/u+gJjn5y0U/C+V7q3pzPagexcAYj4zxjwM7H6SEiIaEuQRQ1qNNwB99F6Q1Xu9R
	24GScYThoyS++rcsLIXurtRARtgMe3h2oqHlV7NkOdn6CXuCwxtP5BYxwN4H9fbj19eQwlABfs0
	HFP7wD7l1KQ3KWRGlSd/2WTmn5fJE=
X-Received: by 2002:a05:6a20:160f:b0:3a1:6a7c:dba5 with SMTP id adf61e73a8af0-3aa5aa8a08bmr8415806637.6.1778307174930;
        Fri, 08 May 2026 23:12:54 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659487afsm13380429b3a.18.2026.05.08.23.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 23:12:54 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 3/3] ntfs: validate attribute name bounds before returning it
Date: Sat,  9 May 2026 15:12:37 +0900
Message-ID: <20260509061237.3233714-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508153410.2624801-1-charsyam@gmail.com>
References: <20260508153410.2624801-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_attr_find() validates a named attribute before comparing it with the
requested name, but that check is currently after the AT_UNUSED handling.
When callers enumerate attributes with AT_UNUSED, ntfs_attr_find() can
return a malformed named attribute before checking whether name_offset
and name_length stay within the attribute record.

Some enumeration callers use the returned attribute name pointer
directly.  For example, one path passes (attr + name_offset, name_length)
to ntfs_attr_iget(), where the name can later be copied according to
name_length.  A malformed on-disk name_offset/name_length pair should not
be exposed to those callers.

Move the existing name bounds validation before returning attributes
during AT_UNUSED enumeration, and write it as an offset/remaining-size
check so the subtraction cannot underflow.  Extract the converted values
into local variables (name_offset, attr_len, name_size) to make the
intent explicit and avoid repeating the endian conversions inside the
bounds check.  This keeps matching attributes on the same checked path
while also covering attribute enumeration.

A small userspace ASAN model with attr length=32, name_offset=124 and
name_length=8 reproduces a heap-buffer-overflow read in the old
enumeration path.  With this change the same malformed attribute is
rejected before the name pointer is returned to the caller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 97b660eaa00c..1a0e1f9e0853 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -672,6 +672,9 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 	__le16 *upcase = vol->upcase;
 	u32 upcase_len = vol->upcase_len;
 	unsigned int space;
+	u16 name_offset;
+	u32 attr_len;
+	u32 name_size;
 
 	/*
 	 * Iterate over attributes in mft record starting at @ctx->attr, or the
@@ -699,6 +702,20 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 			return -ENOENT;
 		if (unlikely(!a->length))
 			break;
+		if (a->name_length) {
+			name_offset = le16_to_cpu(a->name_offset);
+			attr_len = le32_to_cpu(a->length);
+			name_size = a->name_length * sizeof(__le16);
+
+			if (name_offset > attr_len ||
+			    attr_len - name_offset < name_size) {
+				ntfs_error(vol->sb,
+					   "Corrupt attribute name in MFT record %llu\n",
+					   ctx->ntfs_ino->mft_no);
+				break;
+			}
+		}
+
 		if (type == AT_UNUSED)
 			return 0;
 		if (a->type != type)
@@ -712,14 +729,6 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 			if (a->name_length)
 				return -ENOENT;
 		} else {
-			if (a->name_length && ((le16_to_cpu(a->name_offset) +
-					       a->name_length * sizeof(__le16)) >
-						le32_to_cpu(a->length))) {
-				ntfs_error(vol->sb, "Corrupt attribute name in MFT record %llu\n",
-					   ctx->ntfs_ino->mft_no);
-				break;
-			}
-
 			if (!ntfs_are_names_equal(name, name_len,
 					(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
 					a->name_length, ic, upcase, upcase_len)) {
-- 
2.43.0

