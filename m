Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024E3FD142
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254463; cv=none; b=aU/oaaSA3chI0827zaDdxpo8otBhlUGGqWtXCK4LYtDAZ47PwSaqiZ6ca4VpFQP8ioKBsNS7vhlt/hqRp9wYMnKcRFHkMOvahPp+Y0Frbj9jFxhMo4+BKtO67ndGU+Er4S1Fml3Wy183BAukNKzjtwC4jTrUPJQdZaKkAKi6ysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254463; c=relaxed/simple;
	bh=p6tnX/4l5ZUM9aHwboY5tRoceNKto1CtwEkFY8BpzLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8sKYKcHFwxpfh+tdvaSN+NrrfEuUE7SVot3L3n+DiKQEsQ/df5nQ/YHGYOtnaatntHXHCTx4ChRPZg+cd9K5D5rR9d1wWmGH8hjGmr9DJqtirWHvhQZ7D0RWH75/oBnxHZ5bwLqTWBbCWhYK/iRkTSzepEN62n3WXF6hZ6M/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1wCqMeZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1wCqMeZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9a18f53afso1607345ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778254461; x=1778859261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An7yGTSxNUsE+yXCnDDGVLb/TeITDH3yvYUefWFxgYA=;
        b=f1wCqMeZkzwmFwJf5Qj/JGUsbjmeeIBy2cBxTIGyjryoMRjqONn1A6xHOg/XtwnRzQ
         fbQ/m9guDGqyXqA5PQRIxpCkDo4APZByxMuukSHg7i3YR50OKXBYnMvW4n1OGlyiyEhW
         g4yx1SrP+8A5Xa1RcE8tB5F1vPtud/Js7xLG1iNZo67NZCD9FdwJfi7rosbQ40SIL4dn
         IyLh26FmoFHe6Rii/19VSUpPhovvczaVUpRJKqBw0rq6l8wU/TJPu5s4teQ5MP2GCEmJ
         /o2RAuCeggufC9cbiD+MFusjpiCSo4DWwsvRNOSSmbIz9uA4lRkwPKdxbZ38Ah8GvrHO
         kk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254461; x=1778859261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=An7yGTSxNUsE+yXCnDDGVLb/TeITDH3yvYUefWFxgYA=;
        b=OXRp9VdFOlSNaCWn+5Y0dpmkRv30D6Kkxw0oGEpgs1ZTTS5JQYc4DwgAhOeW30ySQW
         tPJpFuTSTjaRjtqCZ+QSV4VtQRiqTDnk8WqvFfQMqdrcWTM7Wo2ZZDtz4eKpTywWa22p
         73z+dYD0ys8zvWxVNiubG1oPAucMEBMyjJEQo/kKTgVwkQawenl1slGuHGscSP5fQx+U
         lvUD+EwurSiHEaXSc+br4iRI+7XzMssDqlW/VWXT/MbDmu/UahU5ndpsRpA1KKCii7qI
         2+9HPvfxvGpzjVTMywJ2p3ZMN4pa59tLE4h5yu7PYPA7Mk7UAXfhZ165WhMPp4USwAEx
         NuyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tFI3d24hnC3kFFOY30WHWJFJcyTmN8n4iiWowSIDAdA4Jru+fVuUK9fBGhBKFBqaaJxLGTxLIeeynioWm@vger.kernel.org
X-Gm-Message-State: AOJu0YxYks4L1s49XKha/8fvxfMF4QjuUVGZLqbY00ucUXvYACJskp7U
	sn6/8wIhJVRnRA/ZTnLkf8oFwKIsJWOyzi4JE6e/4UM5hpnY9whHZqGM
X-Gm-Gg: Acq92OEyznDGaDtui66rMBjYtmNg7lwaZYyUZ5XhvPsTssx7b4v9MaiOFYXMnHMA1l8
	QG3iVuhMbXyi16DlvBYDT4dvOXkLyPhlMn7InGZbQsioSjMiUydVpvuUf8Y/ScqnMOR10Cu/iC8
	q1ETTGfd4qjY13Pn/bXxu1gtb8Ir/AckJxnI+VrcL0CbWcUOjKn5KfHiMx/1TJMaBq7F0yiQJoA
	dpean6H/CyURnuqLQChitzbbKR5VcNJGyDI0St1roja/+APn6tZgmKxIo6yahXKlSKhMy7eeIFx
	3hs7EIdFbFjxQIm7cFce4qX9Ybs+fRtfY3FfDSG1KnrsueHQVaRjI8ttK2Wl5d+E6HCOCo4M6oq
	+KexZW2NYRuEAHHXW2mrm5D1DZA6ynLifH1PLVIBobAwD/V37evfBHctNlspVF82qAg8PLZn1JI
	XD4tf+NDp7QMyl4TTdgnOEJfIUxoM=
X-Received: by 2002:a17:902:cf42:b0:2b0:7041:63fc with SMTP id d9443c01a7336-2ba7b47f7dcmr67159095ad.7.1778254460994;
        Fri, 08 May 2026 08:34:20 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4094fsm26666365ad.19.2026.05.08.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:34:20 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ntfs: validate MFT attrs_offset against bytes_in_use
Date: Sat,  9 May 2026 00:34:08 +0900
Message-ID: <20260508153410.2624801-2-charsyam@gmail.com>
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

ntfs_mft_record_check() verifies that attrs_offset is aligned and that
the resulting pointer stays within the allocated MFT record buffer, but
it does not check that the first attribute header starts within the
bytes_in_use area.

A malformed record with attrs_offset greater than bytes_in_use can pass
this check as long as attrs_offset is still within bytes_allocated.  The
attribute parser then computes the remaining record space by subtracting
the attribute pointer from bytes_in_use.  Because that value is unsigned,
the subtraction can underflow and allow bytes after bytes_in_use to be
interpreted as an attribute.

Reject records where attrs_offset is outside bytes_in_use or where the
used area does not even contain the four-byte attribute type/AT_END
terminator at attrs_offset.

A small userspace model with attrs_offset=128 and bytes_in_use=64 shows
the current check accepts the record and the parser space calculation
underflows to 0xffffffc0.  With this change the same malformed record is
rejected before the attribute walker is entered.

Fixes: d3ad708fecaa ("ntfs: Initial commit")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/mft.c | 14 ++++++++++++--
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index c04462fe049e..70c1aa76181b 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -30,6 +30,8 @@ int ntfs_mft_record_check(const struct ntfs_volume *vol, struct mft_record *m,
 {
 	struct attr_record *a;
 	struct super_block *sb = vol->sb;
+	u16 attrs_offset;
+	u32 bytes_in_use;

 	if (!ntfs_is_file_record(m->magic)) {
 		ntfs_error(sb, "Record %llu has no FILE magic (0x%x)\n",
@@ -65,7 +67,17 @@ int ntfs_mft_record_check(const struct ntfs_volume *vol, struct mft_record *m,
 		goto err_out;
 	}

-	a = (struct attr_record *)((char *)m + le16_to_cpu(m->attrs_offset));
+	attrs_offset = le16_to_cpu(m->attrs_offset);
+	bytes_in_use = le32_to_cpu(m->bytes_in_use);
+
+	if (attrs_offset > bytes_in_use ||
+	    bytes_in_use - attrs_offset < sizeof_field(struct attr_record, type)) {
+		ntfs_error(sb, "Record %llu has corrupt attribute offset\n",
+				mft_no);
+		goto err_out;
+	}
+
+	a = (struct attr_record *)((char *)m + attrs_offset);
 	if ((char *)a < (char *)m || (char *)a > (char *)m + vol->mft_record_size) {
 		ntfs_error(sb, "Record %llu is corrupt\n", mft_no);
 		goto err_out;
--
2.34.1

