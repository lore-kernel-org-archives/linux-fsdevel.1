Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E363FA5EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802325; cv=none; b=aDimKht0wlRQftUQSTdRPhlI0gotEXSuG1PrI2G5RL+ackSe6VzYGkNxi1enk8hw4uMh1bo6WSS8Fp67skconNqR645TMfy22yTnEQ12C7FjSOD7Nc13YqDksU1EC1VIDvQvXTMscqAqMHGNxiC9GF2iJfIMaTNj+TC81s+lTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802325; c=relaxed/simple;
	bh=HwhzAtM+XNwwG9kqZSabVMEeDxCqRAqk3cTMua2G0xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0zqizsIcCX1MttKub0aH8YK3EF5QcuGxY0emjmImMoWv/GK2NC3Oogu8ViMGrJZ1ScitpIykXCC2WpYVt5Ud8zqvvbgw+tnIg4VRv5fPidXvwMpLMxL2UBfNYrrfULvi1DXxZLaZ2C7DweXYSzuAiERrybjhSmmMllCMUJ6kDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4g5a0Vb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4g5a0Vb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bccdc0e283so15108705ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779802318; x=1780407118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqeVPJKaMhyjbC6h9N+4+fsMpUnV3HwawjE7ULuFdT0=;
        b=V4g5a0VbenPvgfTSlBf9bQ5QjM+SGPVZgED1ixsbHvfcv8HL7JVyB8O0fI4PRbUtu3
         6OkzutEWACcZrQQ63Hf+igwsqXjoiwCnIus9bBhse7H7MNoLj4VcEfUxcVBfVUpFgI2W
         7L5I1dxPQSCg/8npSAiuWMgcL/1zoygNaQveGDWuzoHu6NNAfk5dgoclbRrvIDjAjDwd
         fcSg7E6jIfJRiMr1bTx2R5ov/o9EonNc3ov1L5tQPCre0PHwPkBBWme2tSw/vaFT7PUL
         WZtfzFOmnQm7tkVWYU+ADGAPJZc2ftbkXqi6C5HouvMA0vxL5B91frtUKJQyvjfPhoJa
         /UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802318; x=1780407118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqeVPJKaMhyjbC6h9N+4+fsMpUnV3HwawjE7ULuFdT0=;
        b=ObVdaMiP/rU4IAxGi+rIM5ZKBkK+k3RY3NkbNzeoWBg4y7z7qL+7/7T9CEoSeC89nk
         QuQx2be00yCaXzzsCzjVSc8jm3hV6N90RIh4lVC8yTrH6MYu9Z4lnTw60NYTY7r9sKHv
         9kDOHknJKKqjuyehDZAxNS+C4+LuTYms2z5LvmgujFGkGblS0A0sbmZCHRsgTZ4hJaRw
         WJpJIkVHORmPKEZWRncHPYNG2gxzmJ3tg30B6c51r8NuKZdPxIAmTHU/J3P12m3ZyhE0
         +wYd+6YaJ4kMboBtQFGt0zVPJtrmkp8eZhbyliQBlpfPHWr33wLmTXT9aUYcyJy7QTcT
         MqZA==
X-Gm-Message-State: AOJu0Ywe6bv7yfuwfnmTZ4LhOPYJL3h5V7JnMh8qHe6HqzDkxZSpgNAa
	bZ2pD8K0/lL6//6EHCWmhRiGF6THXpghLMv3HfCb2nC2Z01fFjyq2Y5N
X-Gm-Gg: Acq92OG6pT16kyRzUPmcppUHvEIGTidJlAzGEmKkIDlJ4BfqsTWhyN2AgkIXUBlPeoS
	RZVaolYFFJ5B+Aj/jN6heQS1HrZFWlka2jsvkwjg/1DVR92HyA954j1MuJUlK3hJbWfS/LINPI6
	d+mtBbEzSfLV92sMtDoyz4tZ1D+bHXc6U1HNlSsBXo1QsCVBaMbxw267ox/q36dIttKDTNGpJow
	OxPI0FYoGYjAu7ro8nVMi43ttuiYzYItA8ahHNnzkij4Z0j7/WsRMBDrvq+pdhxBheKYQrTc8bQ
	X9prHIuKLMjxYR1MEbhZ9N1YRJ1I+00GkmUg4keCs8hEC/yWGxWIlEiXstZWcin0Y8YE+aaX15q
	5AGWvWyhXTy1OGE4xCUjYu9rV2f7PddMSWaEnpXtfZD3A8msoFWN6cfOuRd14O2kicuzrPLZ3py
	8Mj/7zsdYRS9JOcnCe
X-Received: by 2002:a17:902:ced1:b0:2bc:cb8f:c286 with SMTP id d9443c01a7336-2beb07a16a7mr109198715ad.7.1779802317555;
        Tue, 26 May 2026 06:31:57 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591d102sm122455505ad.81.2026.05.26.06.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:31:57 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v3] ntfs: validate resident attribute values on lookup
Date: Tue, 26 May 2026 22:31:52 +0900
Message-ID: <20260526133152.1205929-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMrLSE5izyWrP=t3_7UWjKJTd296fBrdoHZBW3DMMCzwPY9v-Q@mail.gmail.com>
References: <CAMrLSE5izyWrP=t3_7UWjKJTd296fBrdoHZBW3DMMCzwPY9v-Q@mail.gmail.com>
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
validates resident value bounds, minimum value sizes, and the
variable-length $FILE_NAME field, while preserving the fixed-size checks
for attributes such as $VOLUME_INFORMATION and $EA_INFORMATION. Log
corruption at the rejection point with the attribute name where known.

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

Do not add $INDEX_ROOT-specific value validation in this change. Testing
with stricter checks showed an existing ntfs_ir_truncate() shrink
ordering bug: the resident value_length is shrunk before the root index
allocated_size is updated, so a relookup can observe allocated_size
beyond the now-smaller resident value and fail. Fix that ordering before
adding the $INDEX_ROOT-specific minimum-size and structural checks.

Fixes: 6ceb4cc81ef3 ("ntfs: add bound checking to ntfs_attr_find")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Patch 1/2 of the previous series ("ntfs: free link name from
ntfs_name_cache") has been applied to ntfs-next; this v3 contains only
the remaining patch, with the resident attribute validation reworked per
review feedback.

Changes since v2:
- Drop $INDEX_ROOT-specific validation from this patch, including both
  the minimum-size table entry and the structural checks. QEMU testing
  with xfstests generic/001 showed that those checks expose an existing
  ntfs_ir_truncate() shrink ordering bug, where value_length is reduced
  before allocated_size is synchronized. The same test passes when
  allocated_size is lowered before shrinking value_length, with the
  $INDEX_ROOT-specific validation enabled. That ordering issue will be
  fixed in a separate patch, after which the $INDEX_ROOT-specific
  validation can be reintroduced in a follow-up.

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
- Type-specific format validation for $VOLUME_NAME is intentionally
  not added; see the commit message for the caller-side reason.
  Generic resident bounds checks still apply, and the $VOLUME_NAME
  entry in the type-name table is kept so that those failures log
  with a readable attribute name.
- Log corruption at the rejection point with the attribute type name
  via a new ntfs_attr_type_name() helper, matching the existing
  attribute-name corruption message in ntfs_attr_find().

 fs/ntfs/attrib.c | 148 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 117 insertions(+), 31 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 421c6cdcbb53..382d1b6e877e 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -595,6 +595,112 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
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
@@ -705,8 +811,11 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
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
@@ -747,24 +856,11 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
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
 
@@ -1252,6 +1348,9 @@ static int ntfs_external_attr_find(const __le32 type,
 
 		ctx->attr = a;
 
+		if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_ino->mft_no))
+			break;
+
 		if (a->non_resident) {
 			u32 min_len;
 			u16 mp_offset;
@@ -1279,19 +1378,6 @@ static int ntfs_external_attr_find(const __le32 type,
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
