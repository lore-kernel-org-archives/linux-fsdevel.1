Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF426ED3C
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933781; cv=none; b=qYjO5yCX97hUgJHGPQDbP0S15qecmf/40NodRFmmStd3MDfc5XQCfjRda4s5Rpz8Gle6lrRvgcutjVG0exYv7mucCr9qZNKXKTrFv6qlIVz1VQBXv3jK5onVCZDu9ixs84qugAbczHJm27LglYAjcGz0H/wH96HtzS9WxbCEAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933781; c=relaxed/simple;
	bh=J8uga1NMLeLuTW0Ga/UbrI8RuV+5khdm3fHTSqOApmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHHwrXKlUrqaOhJapSCbF6aQ92vMXYo+i9h9NnriQuypI+cwT8GtRopAwWr5HZX9oq5ml6aC9UEPhGRFrnLWhjTjb4NYT/0Wbv6IzayY8vuP3ED4I7oNBfw+VWsJGsXXhbomEVwUGds7vWC4QnYzaJfpmo8Hr4YUKGAVvdUVG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWp1+JG9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWp1+JG9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8424b2502c8so248041b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933779; x=1781538579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62HcDbguGiGWBfESIpGMa4jmu+LyX4+s9ZYxbBD4ZI8=;
        b=DWp1+JG9DadAw23EvspEMGVjw8B2RHJKKPIPpkq5BKV/mwIT+yX07Yd5K+Hk3OHqHb
         epFkBL02uxj6p4gcyQyesuNX+KxIYeJJ2n2PhpzBttmwpQwvl78HGVx9ARvKKqj1DM30
         E6mG2Via4KvixBGkbf5C+9BBg2Nza8MuXxdZQrq+/VURXP3foDUoMBuJlSJyZK8JqO1e
         soVN+vSW2vI783cTZVdnKg6v/1lTJeBVP2K/5aLeHgCZpfqceGqHHm09hEIvQMAx64Mj
         BbqFZl72LgHxQMgS0jotkcbA0sRvQUxw7LGK7n6Gei+VOWvKX4EwqTI37BDInDa4ghSd
         7Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933779; x=1781538579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62HcDbguGiGWBfESIpGMa4jmu+LyX4+s9ZYxbBD4ZI8=;
        b=Jen3DybVMVXjObpd4mQPVys/9e2uTMnikl3MKzxskr8VUw+a8zsX0mCpgk6oA2qfbG
         IWPxtQUoepi+7HbBd3rv1HOcfV/i/Mw2JPWee6GSJxDZOSrYNU1NevZhrocDyb2pM8En
         8cmta7J9KE65sjqblKxGxqK0W+k5BHrppIAFtK8DcwQuyEXWps5E47CmfIEWPnlwJ4HD
         CP57XMaFG1JO5VRJ3uoIxZpyVPEPdmQc8EtGr5TGj7TYytOoPEWsJk9FkAApydJ8Xn/j
         +I2SdvrQ8VN+cmgyhR0JfGlkchHN99UZCB65VcarbNKQYFNhloF7vMqPPMLdumBuBiHL
         ulKg==
X-Forwarded-Encrypted: i=1; AFNElJ8v5OffJKDj/0a0raVw0BpaW199BlrWg/oiigVl0e+uEG5nFR8J+YdqFpjbxwrYDDhDlkkpiUu+HiLwYtbD@vger.kernel.org
X-Gm-Message-State: AOJu0YzmF5kcVvwavFtoThPUBt2yIygKJAh1nHasRO2gjCyayJELEwwy
	xKzeufYkJwIG0v26RW1LK+cfoO230HxGKhVlG7ir4uXgljSQSdcOUFG1
X-Gm-Gg: Acq92OGbTCym/YmQUY96k+81hn325f0D4p9aBY94eQCnX3UuVarikNi+TYpnyBjVimc
	7E25P0u0dhNhNY2mnDi6FT2aMNo/yVivTbkUXczr6tNenf/UzmNo/fHtU5SGWmJhV6cn2+El7V8
	7DPT7ntbuC3iO5Z6/Ar3q1jxq/TefXhJ2mP6gYK0eOzXlqwuwbIUZyctkEEU4xUKtRxNtBXSX+3
	iLyKppgrnIPzvK29i6HxXqUGHbnezXCSqVr3YeJpmf61G6voy4meefmO/GEopJTftLNbxCXAr/8
	DleUYw264w+F9FeNY/LzOSB9ddceHlQQAs5HJpJW2AXNx2ZqQaPCiDp4ytU8Olh8hI7RcJuEEoa
	tNACVavzzpDyz99vbwgdJhLnTj/kFfHX9fg1saos24P6XgtZjFNzY8SZZHoNRCYtBvGernOLgqM
	XLU9qmORggDpYLLRxEjEYBoj2OSCA=
X-Received: by 2002:a05:6300:67ca:b0:39e:df5e:edc2 with SMTP id adf61e73a8af0-3b4cd17fadamr9344971637.2.1780933779336;
        Mon, 08 Jun 2026 08:49:39 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm15937526a12.18.2026.06.08.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:49:39 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v6 4/4] ntfs: validate resident index root values on lookup
Date: Tue,  9 Jun 2026 00:49:17 +0900
Message-ID: <20260608154917.2703739-5-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608154917.2703739-1-charsyam@gmail.com>
References: <20260608154917.2703739-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resident $INDEX_ROOT values carry index header fields that callers
consume after lookup. Some callers already validate parts of the layout
before walking entries, but those checks are scattered and do not cover
all root header invariants, such as entries_offset alignment and lower
bound, index_length, and allocated_size consistency.

The resident root resize paths now keep these header fields consistent
while the value size changes: ntfs_ir_truncate() lowers
index.allocated_size before shrinking the resident value, and
ntfs_ir_reparent() grows the resident value before publishing a larger
root header. Lookup-time validation can therefore cover these invariants
without tripping over the driver's own resize paths.

Add $INDEX_ROOT to the minimum resident value size table and validate the
resident index header fields before returning the attribute from lookup.
Require 8-byte aligned index header fields, a sane entries_offset, an
index_length within allocated_size, allocated_size within the resident
value, and enough entry space for at least an index entry header.

The shared validator already rejects non-resident records for
resident-only attribute types, including $INDEX_ROOT.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 1254fbe7666e..8f10688a17df 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -589,6 +589,8 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 			sizeof(__le16) * 1;
 	case AT_VOLUME_INFORMATION:
 		return sizeof(struct volume_information);
+	case AT_INDEX_ROOT:
+		return sizeof(struct index_root);
 	case AT_EA_INFORMATION:
 		return sizeof(struct ea_information);
 	default:
@@ -632,6 +634,31 @@ static bool ntfs_volume_name_attr_value_is_valid(const u32 value_length)
 	return value_length <= NTFS_MAX_LABEL_LEN * sizeof(__le16);
 }
 
+static bool ntfs_index_root_attr_value_is_valid(const u8 *value, const u32 value_length)
+{
+	const struct index_root *ir;
+	u32 index_size;
+	u32 entries_offset;
+	u32 index_length;
+	u32 allocated_size;
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
 struct ntfs_resident_attr_value {
 	const u8 *data;
 	u32 len;
@@ -705,6 +732,10 @@ static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
 		if (!ntfs_volume_name_attr_value_is_valid(value.len))
 			goto corrupt;
 		break;
+	case AT_INDEX_ROOT:
+		if (!ntfs_index_root_attr_value_is_valid(value.data, value.len))
+			goto corrupt;
+		break;
 	}
 	return true;
 
-- 
2.43.0

