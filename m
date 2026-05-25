Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D92D592D
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726781; cv=none; b=hkqCGR+bwew3kJrHYJcZNTzAGoCXr4bXYxgbwApsMZDpkEUQacMsZGld4iBcSdMTrWXpuCly9LegY9hDUgUuP+aJ64sSSl8xlT6f83bwQ96soIjSdcdt7W/LpE242uHx7PAbu1zRXQt8WvQ54G4i+LJE22rQaMLO4MxqQtI3M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726781; c=relaxed/simple;
	bh=9chFCJVkQfUv9IOHg6aT2DEbMxsdxlpxk/YTOkn74Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzawB+wmhmPF6K0voAhwGqpyjE5nYY5UYVqWif5LLDw72/CDV4Gy9QAd/8IouPtaxxli0c4/Vk3XxTz4Y6knNilE9xmudnzBSr4plSLTOJ8TLAQ2bsE2SuaWq09xbpULBznF1xhumclHSO3KXnpB848G14GOGS8O+UuWCbHQtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVB3XBJU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVB3XBJU"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3691a0a4e1aso1067152a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779726779; x=1780331579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXYIjjNTf7p0VT2d/kxQo1Swgf2FpjR3wFuBOuUxxkI=;
        b=iVB3XBJU0tS4+hoIJ187qEuw/6kodOlNVT2UtrprpMP/zoHjgT2TIRn88fbrPnJDVt
         qC6FKPATei0WluxjMSmid4ZSjCvkr/EWmstDhb/k98t0PMNONiKtUCoMkCc9mP7iT9Gf
         DR7ofC/Wc8Prn0MOtaexe+l5rYl19+jBsx6jig7CMvPWpqsixjLl9syccJAmXAVe9h7U
         NkL81HBzg6klWxfjsU7LrZIJFlyzenEmfUdUJ6+mSRewGFsA7hHRqYYij34Oapj4ixKJ
         0XdY539AF0QCdUo4J2ORTxtdZxyM55a4P86+zvhEnCXPjWiADf8MiCKTMlqSppuvwril
         xP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726779; x=1780331579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXYIjjNTf7p0VT2d/kxQo1Swgf2FpjR3wFuBOuUxxkI=;
        b=XylPLCXBpHaK9mqPjyhHhXr5BLuQqYGq/Dj+oWdcT/m1s6r1sxsktwEFpR1NqPLtqy
         +90ohNz9bt/r9AHqPeBNZb83vo+ANnOaIIrl/iWkUffYnbJ4NCueUSmw8gmw2x43G4m8
         CzJ3uNrSJLc+zoFHAs7cWhOaf6yCWqG71lANtB1G9dQWuX1Ucj0H9QJKN/CHKArab4tJ
         eeaMOfvPaf6TMo4xmjv6EXrZJkF+nfXlPt73VsfvmhDwEjMcy7YuRR7gkyOHIleXFzOV
         LK2bk6NkkVktnLmC0PbjyDnlKgsDjWBaaf0NUxh0gTNI0HMAckZLyyK8LCbDlQBUtdmC
         TtCQ==
X-Gm-Message-State: AOJu0YypUQkcOiGndqpd+SbzzyPM9Xw7DaZk/4IYpkDLtDb/dt2t/sxG
	IHEw8irW6AIXGO/PAoX/1SwoQJkVy/Zqv+UdWQveHnoUrUN1rZkUYzms
X-Gm-Gg: Acq92OGq1GtQBYYxkrzK+quUAqvHnTQXwI/p6I/ZPMJ711JIrzACuJngdWGInIfJKon
	fI+7NeeEtJ7jLeWDOcbBOo3a5ccj5eAWo1MQublR3LY0mcj3bTGXOUTcoQjDuHKlfQD/p4uY6HY
	1fn4KccEw7Z26u4C86ugMnXdBcj6XZnDqyQ5emB+zCLlJ5dzLhWEuZTBLstztgODTSjL73WX1p4
	9TovW5Jx4fjr4gMp8wMKzlJlT0wJYVTngL/iSPBkehIbtdiJdMTuhkvZ2+KSUlt8d8KiM+xluOE
	UJVM+k+9FmljvAwMHssOuGju+2QHul4TIq6gUwUy70UfvWqQz13RalCJYXQFdctZd8xR491JQu/
	52mLvsPfx0PZaDApjhTvDecx5hfWP6sdnPykrdOb8xthWwhznrqCGWkDneR2uOZBG1tpmfOJBpW
	zBDeVaMEr57Jbv0Kz1YDZUFlJvo8U=
X-Received: by 2002:a17:90b:4b91:b0:36a:5b60:553b with SMTP id 98e67ed59e1d1-36a678c789amr8073092a91.7.1779726779062;
        Mon, 25 May 2026 09:32:59 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4ca35sm10369609a91.9.2026.05.25.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:32:58 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ntfs: validate resident attribute values on lookup
Date: Tue, 26 May 2026 01:32:54 +0900
Message-ID: <20260525163254.240238-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524054238.3129288-3-charsyam@gmail.com>
References: <20260524054238.3129288-3-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_attr_find() and ntfs_external_attr_find() check that generic
resident attribute values fit in their attribute records and that
fixed-size resident values are large enough. For variable-length resident
formats, however, the fixed part is not enough: embedded length fields
can still point callers past the resident value.

A crafted image can set a small resident $FILE_NAME value_length while
leaving file_name_length large. Callers then trust file_name_length and
read past the resident value when converting or comparing the name. This
was reproduced with a crafted image under KASAN as a slab-out-of-bounds
read from the kmalloc-1k MFT record copy. The stack included
ntfs_lookup(), ntfs_iget(), ntfs_read_locked_inode(), ntfs_attr_name_get(),
ntfs_ucstonls(), and utf16s_to_utf8s().

Add a shared resident attribute value validator and use it before a
lookup path can return an attribute, including the AT_UNUSED enumeration
case where callers inspect returned attributes directly. The helper
validates resident value bounds, minimum value sizes, and variable-length
$FILE_NAME and $INDEX_ROOT fields, while preserving the fixed-size
checks for attributes such as $VOLUME_INFORMATION and $EA_INFORMATION.
Log corruption at the rejection point with the attribute name where
known.

Reject non-resident $FILE_NAME records too: the format requires
$FILE_NAME to be resident and callers treat returned records as
resident.

Type-specific format validation for $VOLUME_NAME is intentionally not
added to this helper, even though $VOLUME_NAME is a variable-length
resident attribute. Existing callers such as ntfs_write_volume_label()
treat a failed AT_VOLUME_NAME lookup as an absent label and
unconditionally add a new record afterwards. If the helper rejected
odd-length labels at lookup time, the corrupt record would stay in
place and the caller would append a new record next to it, producing
two $VOLUME_NAME attributes on disk. Caller-side cleanup must precede
any lookup-time rejection of malformed $VOLUME_NAME payloads, so the
type-specific check is left for a follow-up patch. The generic resident
bounds checks (value_offset / value_length / attr_len) still apply to
$VOLUME_NAME, and its entry in the type-name table is kept so that
those failures log with the attribute name.

Fixes: 6ceb4cc81ef3 ("ntfs: add bound checking to ntfs_attr_find")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Patch 1/2 of the previous series ("ntfs: free link name from
ntfs_name_cache") has been applied to ntfs-next; this v2 contains only
the remaining patch, with the resident attribute validation reworked per
review feedback.

Changes since v1:
- Refactor resident attribute validation into a shared helper
  ntfs_attr_value_is_valid() used by both ntfs_attr_find() and
  ntfs_external_attr_find(), and remove the duplicated inline check
  from ntfs_external_attr_find().
- Split out resident header/value bounds extraction into
  ntfs_resident_attr_value_get(), returning a small view struct so the
  top-level orchestration reads as: get view -> common min check ->
  per-type format check.
- Validate before the AT_UNUSED enumeration path in ntfs_attr_find()
  can return the attribute to callers that inspect it directly.
- Reject non-resident $FILE_NAME records: the format requires
  $FILE_NAME to be resident and callers treat returned records as
  resident.
- Extend type-specific validation beyond $FILE_NAME to $INDEX_ROOT
  (entries_offset / index_length / allocated_size bounds and 8-byte
  alignment); add $INDEX_ROOT to ntfs_resident_attr_min_value_length().
- Type-specific format validation for $VOLUME_NAME is intentionally
  not added; see the commit message for the caller-side reason.
  Generic resident bounds checks still apply, and the $VOLUME_NAME
  entry in the type-name table is kept so that those failures log
  with a readable attribute name.
- Log corruption at the rejection point with the attribute type name
  via a new ntfs_attr_type_name() helper, matching the existing
  attribute-name corruption message in ntfs_attr_find().

 fs/ntfs/attrib.c | 182 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 151 insertions(+), 31 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 421c6cdcbb53..63b3b0d13c45 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -588,6 +588,8 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 			sizeof(__le16) * 1;
 	case AT_VOLUME_INFORMATION:
 		return sizeof(struct volume_information);
+	case AT_INDEX_ROOT:
+		return sizeof(struct index_root);
 	case AT_EA_INFORMATION:
 		return sizeof(struct ea_information);
 	default:
@@ -595,6 +597,144 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 	}
 }
 
+static const char *ntfs_attr_type_name(const __le32 type)
+{
+	switch (type) {
+	case AT_STANDARD_INFORMATION:
+		return "$STANDARD_INFORMATION";
+	case AT_FILE_NAME:
+		return "$FILE_NAME";
+	case AT_VOLUME_NAME:
+		return "$VOLUME_NAME";
+	case AT_VOLUME_INFORMATION:
+		return "$VOLUME_INFORMATION";
+	case AT_INDEX_ROOT:
+		return "$INDEX_ROOT";
+	case AT_EA_INFORMATION:
+		return "$EA_INFORMATION";
+	default:
+		return NULL;
+	}
+}
+
+static bool ntfs_file_name_attr_value_is_valid(const u8 *value, const u32 value_length)
+{
+	const struct file_name_attr *fn;
+	u32 file_name_size;
+
+	if (value_length < ntfs_resident_attr_min_value_length(AT_FILE_NAME))
+		return false;
+
+	fn = (const struct file_name_attr *)value;
+	file_name_size = fn->file_name_length * sizeof(__le16);
+
+	return file_name_size <=
+			value_length - offsetof(struct file_name_attr, file_name);
+}
+
+static bool ntfs_index_root_attr_value_is_valid(const u8 *value, const u32 value_length)
+{
+	const struct index_root *ir;
+	u32 index_size;
+	u32 entries_offset;
+	u32 index_length;
+	u32 allocated_size;
+
+	if (value_length < ntfs_resident_attr_min_value_length(AT_INDEX_ROOT))
+		return false;
+
+	ir = (const struct index_root *)value;
+	index_size = value_length - offsetof(struct index_root, index);
+	entries_offset = le32_to_cpu(ir->index.entries_offset);
+	index_length = le32_to_cpu(ir->index.index_length);
+	allocated_size = le32_to_cpu(ir->index.allocated_size);
+
+	if ((entries_offset | index_length | allocated_size) & 7 ||
+	    entries_offset < sizeof(struct index_header) ||
+	    entries_offset > index_length ||
+	    index_length > allocated_size ||
+	    allocated_size > index_size ||
+	    index_length - entries_offset < sizeof(struct index_entry_header))
+		return false;
+
+	return true;
+}
+
+struct ntfs_resident_attr_value {
+	const u8 *data;
+	u32 len;
+};
+
+static bool ntfs_resident_attr_value_get(const struct attr_record *a,
+					 struct ntfs_resident_attr_value *value)
+{
+	u32 attr_len;
+	u16 value_offset;
+
+	attr_len = le32_to_cpu(a->length);
+	if (attr_len < offsetof(struct attr_record, data.resident.reserved) +
+			sizeof(a->data.resident.reserved))
+		return false;
+
+	value->len = le32_to_cpu(a->data.resident.value_length);
+	value_offset = le16_to_cpu(a->data.resident.value_offset);
+
+	if (value->len > attr_len || value_offset > attr_len - value->len)
+		return false;
+
+	value->data = (const u8 *)a + value_offset;
+	return true;
+}
+
+static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
+				     const struct attr_record *a,
+				     const u64 mft_no)
+{
+	struct ntfs_resident_attr_value value;
+	const char *type_name;
+	u32 min_len;
+
+	if (a->non_resident) {
+		if (a->type != AT_FILE_NAME)
+			return true;
+		ntfs_error(vol->sb,
+			   "Corrupt non-resident $FILE_NAME attribute in MFT record %llu\n",
+			   mft_no);
+		return false;
+	}
+
+	if (!ntfs_resident_attr_value_get(a, &value))
+		goto corrupt;
+
+	min_len = ntfs_resident_attr_min_value_length(a->type);
+	if (min_len && value.len < min_len)
+		goto corrupt;
+
+	switch (a->type) {
+	case AT_FILE_NAME:
+		if (!ntfs_file_name_attr_value_is_valid(value.data, value.len))
+			goto corrupt;
+		break;
+	case AT_INDEX_ROOT:
+		if (!ntfs_index_root_attr_value_is_valid(value.data, value.len))
+			goto corrupt;
+		break;
+	}
+	return true;
+
+corrupt:
+	type_name = ntfs_attr_type_name(a->type);
+	if (type_name)
+		ntfs_error(vol->sb,
+			   "Corrupt resident %s attribute in MFT record %llu\n",
+			   type_name, mft_no);
+	else
+		ntfs_error(vol->sb,
+			   "Corrupt resident %#x attribute in MFT record %llu\n",
+			   le32_to_cpu(a->type), mft_no);
+	return false;
+}
+
 /*
  * ntfs_attr_find - find (next) attribute in mft record
  * @type:	attribute type to find
@@ -705,8 +845,11 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 			}
 		}
 
-		if (type == AT_UNUSED)
+		if (type == AT_UNUSED) {
+			if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_ino->mft_no))
+				break;
 			return 0;
+		}
 		if (a->type != type)
 			continue;
 		/*
@@ -747,24 +890,11 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 			}
 		}
 
-		 /* Validate attribute's value offset/length */
-		if (!a->non_resident) {
-			u32 min_len;
-			u32 value_length = le32_to_cpu(a->data.resident.value_length);
-			u16 value_offset = le16_to_cpu(a->data.resident.value_offset);
-
-			if (value_length > le32_to_cpu(a->length) ||
-			    value_offset > le32_to_cpu(a->length) - value_length)
-				break;
+		if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_ino->mft_no))
+			break;
 
-			min_len = ntfs_resident_attr_min_value_length(a->type);
-			if (min_len && value_length < min_len) {
-				ntfs_error(vol->sb,
-					   "Too small %#x resident attribute value in MFT record %lld\n",
-					   le32_to_cpu(a->type), (long long)ctx->ntfs_ino->mft_no);
-				break;
-			}
-		} else {
+		/* Validate non-resident mapping-pairs fields. */
+		if (a->non_resident) {
 			u32 min_len;
 			u16 mp_offset;
 
@@ -1252,6 +1382,9 @@ static int ntfs_external_attr_find(const __le32 type,
 
 		ctx->attr = a;
 
+		if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_ino->mft_no))
+			break;
+
 		if (a->non_resident) {
 			u32 min_len;
 			u16 mp_offset;
@@ -1279,19 +1412,6 @@ static int ntfs_external_attr_find(const __le32 type,
 			u32 value_length = le32_to_cpu(a->data.resident.value_length);
 			u16 value_offset = le16_to_cpu(a->data.resident.value_offset);
 
-			if (attr_len < offsetof(struct attr_record, data.resident.reserved) +
-					sizeof(a->data.resident.reserved))
-				break;
-			if (value_length > attr_len || value_offset > attr_len - value_length)
-				break;
-
-			value_length = ntfs_resident_attr_min_value_length(a->type);
-			if (value_length && le32_to_cpu(a->data.resident.value_length) <
-			    value_length) {
-				pr_err("Too small resident attribute value in MFT record %lld, type %#x\n",
-				       (long long)ctx->ntfs_ino->mft_no, a->type);
-				break;
-			}
 			if (value_length == val_len &&
 			    !memcmp((u8 *)a + value_offset, val, val_len)) {
 attr_found:
-- 
2.43.0

