Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205029E11A
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151727; cv=none; b=e8iNxGD1/SEkr0hooAZ3/mc7USLyWHUBZRbeVVbUe00n+MoXReymoaz3XaM5UoJU48TXMdSwxVH51CA0Ww5mmk7II4Z7pgA64OJ3DVhiV0tAKGJeRJehdeLznFtg51r9bghw2byKjNPPCYXO4uz4JBUBIpmMDcsnmlSAq6a9iUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151727; c=relaxed/simple;
	bh=1vMLDFW2kS1bQAd09CHs2LUwo+EJDU2ey1BN1xmTXDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLwNPYMpWl3YhrEXQDOcoKwwOiB+u+VJDl79kmmWT0PO3KpYLBmCAV9ClJPO/mMHTfpopEK9BKIWy6AKAooIyRr5xqxc1r7O4hlfzJNSI1lQ9iDVrW3Jop+/oLia11a7PV5TyOQ6gzGFY0wxvmwTEfEGXQmqvuK+d4lixav/RMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4Hnx25d; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4Hnx25d"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-837b704783bso1424594b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780151724; x=1780756524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMlzIjbJAEGK5SSnf3zQHzXypQFZNks5QNE1s4jLr2s=;
        b=Q4Hnx25dI2sUDoeThbyrWAN2mQvsnwVuK7Thkm7lLeMEnLALvVPK2e3zijmkhW5Qnf
         CYH/tqm2Mjpa0h8RRAVQrEeaTFFd0cn2vKTJ1YsZnjlP2xhJ8DIV63GhBRF8rNOugevj
         Aka7HSFg/U6nXmQi2lHGxBW4RfAX5cQtbPcIpRacSrUIvDGyhHVhlnlbauwQaZRJKfu8
         jRl8q0fs9dewjus+d1WFYscBIC9ONhIBR6cXS+uUd0MS7UslQML3a7GOPwtxJV0+qIKP
         F9tOuMJg5kXhdipLXaq3Bby8WKVcK+AlpwemOuHZE5qVWkX25TKR0Azcg1cHwI+jZk/f
         rONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151724; x=1780756524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMlzIjbJAEGK5SSnf3zQHzXypQFZNks5QNE1s4jLr2s=;
        b=DjNGaAW0xjN9wqEctAltHWIZPa9VUFCMXQk2VF5WT6yRDYZTHrmCJYcp3tHmXQgnft
         IPDQCo9tDVeMVuBqtLXmkUMao3EY9s49/fULoBG4iNur5POcstHbTfUdhLVn14M/14jm
         KC3HXPS9wG7GEX0dWsoAnk09G+q4rudJApXYltaMOqWs8wi5JFYglXRvYV0wOU3cENzD
         nhV21AKk12JbpSy8mgNO5PLy4YWXQjS5fKBQWGWV0E4qYvsim41jXINGmypkm58OSyy5
         ixZBc4tL/RXGia6G5CSHlPgXE+gGmqvPpzBTwhLs9Pk5IiiYOql4NarNt84yUGsE76g9
         X4YQ==
X-Gm-Message-State: AOJu0YyNkxCyhhOWUBmfE6bbgZytxRPjp81P6ZbycEetHZAyRFhzp5Zc
	6dEPv5gqDnDfkxQiJfrbgHjpIFDcgmrdD83fdNEmct3cYXAQpDkS0Ve3
X-Gm-Gg: Acq92OGmbhZyGofzR797yLJ3NJgIPSbP+cj2oCYzH5bbPA77mt/wPnxQfy71rjLie9I
	NAySXZ/510400tMrx94b4Y+tYvxwmWOS17lVOOpXpeVok4YMvfGeznjKo/wxLfUBi8haTXqvUn+
	HASZuKKn4JmF4+ClbwlihNMRPVZdROgPIx2SZjotNxCUay+C4gaUHgZI1cguTAOf684ZfIedF18
	G9n42H5oV5JFXLBv5LJ1RXLeGtY/EL1vt41FI2K1BTY85JlR5NDHYJIL8F5SVUogDmuB9SQ5hO1
	uKfl3RsANaXHctYiNhWhoPaK9Dlm84PzSobOEjKsJiYEHRNr/YgKexoszJx1lQGgK99uYTKEWbe
	PdiKAEdhngbIhjP+L59eLoHlv/th2PU7KbAHyex9y0CzEBXDJh2UdbafcLtQdCh70+hZVl0iaFD
	y1HudxOEKEwCJ+5ke7yuHsSmdHGwM=
X-Received: by 2002:a05:6a00:bd01:b0:837:42a6:58a8 with SMTP id d2e1a72fcca58-84225333708mr2001962b3a.2.1780151723402;
        Sat, 30 May 2026 07:35:23 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm5832280b3a.13.2026.05.30.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:35:23 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v4 1/6] ntfs: validate attribute values on lookup
Date: Sat, 30 May 2026 23:35:09 +0900
Message-ID: <20260530143514.3083601-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530143514.3083601-1-charsyam@gmail.com>
References: <20260530143514.3083601-1-charsyam@gmail.com>
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

Add a shared attribute value validator and use it before a lookup path
can return an attribute, including the AT_UNUSED enumeration case where
callers inspect returned attributes directly. The helper validates
resident value bounds, minimum resident value sizes, variable-length
$FILE_NAME fields, and non-resident mapping-pairs metadata that was
previously checked separately in both lookup paths.

This also preserves the intended resident @val matching semantics in the
external attribute lookup path. The old duplicated validation block
overwrote the actual resident value length with the type-specific minimum
length before comparing @val, so variable-length resident values could
fail to match even when the bytes were identical. Keep the comparison on
the actual value length, and make ntfs_attrlist_entry_add() compare
resident attributes with lowest_vcn zero instead of reading the
non-resident union member after a successful resident match.

Reject non-resident $FILE_NAME records too: the format requires
$FILE_NAME to be resident and callers treat returned records as resident.

Fixes: 6ceb4cc81ef3 ("ntfs: add bound checking to ntfs_attr_find")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c   | 160 +++++++++++++++++++++++++++++++++--------------------
 fs/ntfs/attrlist.c |  11 +++-
 2 files changed, 107 insertions(+), 64 deletions(-)

diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
index c2594d4c83b0..afb13038ba42 100644
--- a/fs/ntfs/attrlist.c
+++ b/fs/ntfs/attrlist.c
@@ -118,6 +118,7 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 	int entry_len, entry_offset, err;
 	struct mft_record *ni_mrec;
 	u8 *old_al;
+	__le64 lowest_vcn;
 
 	if (!ni || !attr) {
 		ntfs_debug("Invalid arguments.\n");
@@ -158,17 +159,21 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr)
 		ntfs_error(ni->vol->sb, "Failed to get search context");
 		goto err_out;
 	}
+	if (attr->non_resident)
+		lowest_vcn = attr->data.non_resident.lowest_vcn;
+	else
+		lowest_vcn = 0;
 
 	err = ntfs_attr_lookup(attr->type, (attr->name_length) ? (__le16 *)
 			((u8 *)attr + le16_to_cpu(attr->name_offset)) :
 			AT_UNNAMED, attr->name_length, CASE_SENSITIVE,
-			(attr->non_resident) ? le64_to_cpu(attr->data.non_resident.lowest_vcn) :
-			0, (attr->non_resident) ? NULL : ((u8 *)attr +
+			le64_to_cpu(lowest_vcn),
+			(attr->non_resident) ? NULL : ((u8 *)attr +
 			le16_to_cpu(attr->data.resident.value_offset)), (attr->non_resident) ?
 			0 : le32_to_cpu(attr->data.resident.value_length), ctx);
 	if (!err) {
 		/* Found some extent, check it to be before new extent. */
-		if (ctx->al_entry->lowest_vcn == attr->data.non_resident.lowest_vcn) {
+		if (ctx->al_entry->lowest_vcn == lowest_vcn) {
 			err = -EEXIST;
 			ntfs_debug("Such attribute already present in the attribute list.\n");
 			ntfs_attr_put_search_ctx(ctx);
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 421c6cdcbb53..98e0b8ea2edd 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -595,6 +595,97 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 	}
 }
 
+static bool ntfs_file_name_attr_value_is_valid(const u8 *value, const u32 value_length)
+{
+	const struct file_name_attr *fn;
+	u32 file_name_size;
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
+static bool ntfs_non_resident_attr_value_is_valid(const struct attr_record *a)
+{
+	u32 attr_len;
+	u32 min_len;
+	u16 mp_offset;
+
+	attr_len = le32_to_cpu(a->length);
+	min_len = offsetof(struct attr_record, data.non_resident.initialized_size) +
+		  sizeof(a->data.non_resident.initialized_size);
+	if (attr_len < min_len)
+		return false;
+
+	mp_offset = le16_to_cpu(a->data.non_resident.mapping_pairs_offset);
+	return mp_offset >= min_len && mp_offset <= attr_len;
+}
+
+static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
+				     const struct attr_record *a,
+				     const u64 mft_no)
+{
+	struct ntfs_resident_attr_value value;
+	u32 min_len;
+
+	if (a->non_resident) {
+		if (a->type == AT_FILE_NAME)
+			goto corrupt;
+		if (!ntfs_non_resident_attr_value_is_valid(a))
+			goto corrupt;
+		return true;
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
+	ntfs_error(vol->sb,
+		   "Corrupt %#x attribute in MFT record %llu\n",
+		   le32_to_cpu(a->type), mft_no);
+	return false;
+}
+
 /*
  * ntfs_attr_find - find (next) attribute in mft record
  * @type:	attribute type to find
@@ -705,8 +796,11 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
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
@@ -747,37 +841,8 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
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
-
-			min_len = ntfs_resident_attr_min_value_length(a->type);
-			if (min_len && value_length < min_len) {
-				ntfs_error(vol->sb,
-					   "Too small %#x resident attribute value in MFT record %lld\n",
-					   le32_to_cpu(a->type), (long long)ctx->ntfs_ino->mft_no);
-				break;
-			}
-		} else {
-			u32 min_len;
-			u16 mp_offset;
-
-			min_len = offsetof(struct attr_record, data.non_resident.initialized_size) +
-				  sizeof(a->data.non_resident.initialized_size);
-			if (le32_to_cpu(a->length) < min_len)
-				break;
-
-			mp_offset = le16_to_cpu(a->data.non_resident.mapping_pairs_offset);
-			if (mp_offset < min_len ||
-			    mp_offset > le32_to_cpu(a->length))
-				break;
-		}
+		if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_ino->mft_no))
+			break;
 
 		/*
 		 * The names match or @name not present and attribute is
@@ -1252,22 +1317,8 @@ static int ntfs_external_attr_find(const __le32 type,
 
 		ctx->attr = a;
 
-		if (a->non_resident) {
-			u32 min_len;
-			u16 mp_offset;
-
-			min_len = offsetof(struct attr_record,
-					   data.non_resident.initialized_size) +
-				  sizeof(a->data.non_resident.initialized_size);
-
-			if (le32_to_cpu(a->length) < min_len)
-				break;
-
-			mp_offset =
-				le16_to_cpu(a->data.non_resident.mapping_pairs_offset);
-			if (mp_offset < min_len || mp_offset > attr_len)
-				break;
-		}
+		if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_ino->mft_no))
+			break;
 
 		/*
 		 * If no @val specified or @val specified and it matches, we
@@ -1279,19 +1330,6 @@ static int ntfs_external_attr_find(const __le32 type,
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
