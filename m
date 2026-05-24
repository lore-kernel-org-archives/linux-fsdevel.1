Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3438D017
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779601371; cv=none; b=c0y0HiTmFpHiBthHIiEH73dvmobq8y7qiQAgYcS+lT7HtcY8/nc2ddlQytT6YjE4XUEO5Veb/tQY5q0YQw35eqfSBqsW5hqMHDgLfVOqj3Zsj+BM7lrx1djNu4bSDKHY8+V0NMXY3Ugq3KnKHCQsVZzXhFtcXZKMNVpbf7PYPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779601371; c=relaxed/simple;
	bh=dd8kh+7Dnfu3DNvlUlRWZjRhDr8HIGBBzmgPH10vHtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on/yPCGvYvYVbhcnZ3+lbH09huWWXWJUDZOeMXsE5LyLlhal+bFo7cBUQstOFv4CD4Z83zNznLAhGCo4vHRQsQxMypkeVMFqkfkCZh4S0yZM82bAvp/MmDVqdk23nReyCwX9OdKN90tBPbRu7Wc6C5H1JXHgRBFAYVAJfl/asec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoYsvvOA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoYsvvOA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8015bdf1b5so777332a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779601369; x=1780206169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0f8FTEg8jprF2Xg1CZCQ7/4fR2DvKFq//GzNUFZM4k=;
        b=BoYsvvOAUO2GhQbLwrLBf7BxzWN0gbWKwooDstu0hc6ghHCsbxGs/6iqgSDMzp9gw5
         QYihei2+XPnLTKBZdZE0fLpF6WagRPAGt29O7IE/98Uj6KN15nNkPKZb/2Rnf6LbZIhy
         W9+RPNVx/4xCP9UIdR1vWoQW0K9GUYbhAHW57MYMacGkzz7dWABgHfaQWrqgl1qmgoBv
         0VFkpw53EQWel3uiaYff/63R0m1NY6phZ7YZSX8RZZ2MJveYelGoTLTEVFgO/S1Eo1Es
         UfxLY+L72dn2UghBA3FJR0v5P5N9Rl0qZUbiaE28+OECgAN5TeyXo9vU8FRHpKZD5L8h
         KpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779601369; x=1780206169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0f8FTEg8jprF2Xg1CZCQ7/4fR2DvKFq//GzNUFZM4k=;
        b=bEOHZMa1PYCLmpJykVNaGbHQYZ8cH6bH0EsaUxhVs0+Bvx8f5t24bpYIqcnIY7EFu5
         8uqYqmTEBC5TElSa8ryhW+JykA4/AOusjvvRo5fOl0iDsNailR5q7j+o80Th2yUtwsH1
         wtQClNs0Iztn8mC4Ce35fMIPFCl15r/yaSY90nJ/DFZm/2oLUHCuqOpJxQvjAdWHzIbp
         Rsc/xzAyeEOaLEGs+ei+MQdOA8gfDl76LxU/z/OVr7oygMf5FCFaHJRjyzzqwSp6ZeUx
         5Ue7x13b2cxo6Ym9J9vDyyYjPx2gqFMwkvX6C3ETRJUwGQmkCf+IL/vDcZ9IUFgIjcDW
         oHUQ==
X-Gm-Message-State: AOJu0YxrT/4IghufI4jgDoUvAVrLOHYX1VHghQ0wQpgW3kATAAnJjaX6
	L39Dv9kqngRg+lHIGfOSSEW3hzvRto6VQoAHo+7RJy9sbrCGdoMJy0Sx
X-Gm-Gg: Acq92OF3z4UeNMX9Q2Dw/Oh4WmiIa8ptvbvtr3d6d8BZOmHUmrWdg7/tKbR92Sqt508
	au6L0BszBNEobLku30bwL6Y+8wtwV9ciyIHjgC+SSoVMz2GqysEmZwugUp/2HdqQadE4eXIINMP
	wi9iDZ6qMxF/Pkcs1eetxjgyM5iwvEdBiTDM5nAqzy2DPFQqH+atx9P9jq2lfGUm37YYZnaN6Go
	o/ccdE0hNyWsCivXv7GWY5ayqjcYkLvksbePHPPw4DVq3jlQCg3SI0nhInL+mzY2dtBniLjKTmT
	H9V+wzKMu2yL9yhoWcYSHaZ+HP47L0e/Q2ebxwDREo6IZJ6kuLCaN7rchlJEYcn8wJP8BUCEkkX
	+qNM9of1IpbDE1j0jdZvSeDNyzjkmN1lMDeJOVpQOyqigiXO/frCyH7i9N6l8os78jRlYRXRztt
	nnWEC7TZ93+dLEmAXS
X-Received: by 2002:a05:6a00:1908:b0:82f:6cd5:f6ff with SMTP id d2e1a72fcca58-8415f385903mr4788574b3a.7.1779601369368;
        Sat, 23 May 2026 22:42:49 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff7d80sm6726848b3a.56.2026.05.23.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 22:42:48 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 2/2] ntfs: validate resident file name attribute length
Date: Sun, 24 May 2026 14:42:38 +0900
Message-ID: <20260524054238.3129288-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524054238.3129288-1-charsyam@gmail.com>
References: <20260524054238.3129288-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_attr_find() and ntfs_external_attr_find() check that generic
resident attribute values fit in their attribute records and that
fixed-size resident values are large enough. For $FILE_NAME, however,
the fixed part is not enough: the value also contains a variable-length
UTF-16 name whose length is stored in file_name_length.

A crafted image can set a small resident value_length while leaving
file_name_length large. Callers then trust file_name_length and read
past the resident value when converting or comparing the name. This was
reproduced with a crafted image under KASAN as a slab-out-of-bounds read
from the kmalloc-1k MFT record copy, for example through:

  ntfs_lookup()
  ntfs_iget()
  ntfs_read_locked_inode()
  ntfs_attr_name_get()
  ntfs_ucstonls()
  utf16s_to_utf8s()

Validate $FILE_NAME before lookup can return the current attribute,
including the AT_UNUSED enumeration case where callers inspect returned
attributes directly. Reuse the same self-contained helper for both the
base-record lookup path and the attribute-list lookup path. Log a
specific corruption message at the rejection point, matching the
existing attribute-name validation in ntfs_attr_find().

Reject non-resident $FILE_NAME records too: the format requires
$FILE_NAME to be resident and callers treat returned records as
resident.

Fixes: 6ceb4cc81ef3 ("ntfs: add bound checking to ntfs_attr_find")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 421c6cdcbb53..5643a097eb11 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -595,6 +595,37 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 	}
 }
 
+static bool ntfs_file_name_attr_is_valid(const struct attr_record *a)
+{
+	const struct file_name_attr *fn;
+	u32 attr_len = le32_to_cpu(a->length);
+	u32 value_length;
+	u16 value_offset;
+	u32 file_name_size;
+
+	if (a->non_resident)
+		return false;
+
+	if (attr_len < offsetof(struct attr_record, data.resident.reserved) +
+			sizeof(a->data.resident.reserved))
+		return false;
+
+	value_length = le32_to_cpu(a->data.resident.value_length);
+	value_offset = le16_to_cpu(a->data.resident.value_offset);
+
+	if (value_length > attr_len || value_offset > attr_len - value_length)
+		return false;
+
+	if (value_length < ntfs_resident_attr_min_value_length(AT_FILE_NAME))
+		return false;
+
+	fn = (const struct file_name_attr *)((const u8 *)a + value_offset);
+	file_name_size = fn->file_name_length * sizeof(__le16);
+
+	return file_name_size <=
+			value_length - offsetof(struct file_name_attr, file_name);
+}
+
 /*
  * ntfs_attr_find - find (next) attribute in mft record
  * @type:	attribute type to find
@@ -705,6 +736,13 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 			}
 		}
 
+		if (a->type == AT_FILE_NAME &&
+		    !ntfs_file_name_attr_is_valid(a)) {
+			ntfs_error(vol->sb,
+				   "Corrupt $FILE_NAME attribute in MFT record %llu\n",
+				   ctx->ntfs_ino->mft_no);
+			break;
+		}
 		if (type == AT_UNUSED)
 			return 0;
 		if (a->type != type)
@@ -1252,6 +1290,14 @@ static int ntfs_external_attr_find(const __le32 type,
 
 		ctx->attr = a;
 
+		if (a->type == AT_FILE_NAME &&
+		    !ntfs_file_name_attr_is_valid(a)) {
+			ntfs_error(vol->sb,
+				   "Corrupt $FILE_NAME attribute in MFT record %llu\n",
+				   ctx->ntfs_ino->mft_no);
+			break;
+		}
+
 		if (a->non_resident) {
 			u32 min_len;
 			u16 mp_offset;
-- 
2.43.0

