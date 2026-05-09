Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920A382F2D
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307171; cv=none; b=uNeQ7Cg9LiappI3SXi4UIu0ISDmSBJb6OgYPmAH4DaXu/Sz+LWB9uSrYh3Os6hAlhkd+3SlE4M2u9TIiMDIL1wtj5M4VryWJ+avNS1QSFHX9YE4/L9IDdgCXOPP9eNTMZKESxruMA/FOoFUHw2hcD8p1ddBlsTLpgTvgqWdd43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307171; c=relaxed/simple;
	bh=x3U0+ik7ABX/ipLSzhLPhRGDfe/68tRYRIvR0CNMyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAWRtjYjgAa5SK3SyMLyk447/LuvTiE/wgfwdDVLEttgfRtzWNb6vyYVVDEPu5gGi3E/Ep3oH5LkKxzzwTdigSyJQt/rN/8yspakeO39Xotw2qkCmWzRWZxZmcxtGoOu9+IpFKfDLxac2EhnA9Bpiwh0y2dvXauyZp2FilE8T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+f/AuHW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+f/AuHW"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7963df896fso96259a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778307170; x=1778911970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znfabyFueBNEPqXXyOxpAPqjsy9bDnSpb0+GPews0kY=;
        b=P+f/AuHWaV4ZexxEQY2RRFRGTVJQVZfjn1pQ5S8d3MPW8y+t0/rDum/Bk/x+b1lkxb
         5VV5Kn4qugZS2B2ygvsQXD+dHPMB5z0K0sPHNouHA+TaUVv0MI71CJSPxi/8fq8CwuOt
         hV1kdk6eeaokwGFrXC3FeZLXdJMdpiuZEKnWdbZbZnKtczeZ9YrgOKiMBt9dQW28khcg
         A44P/v/gzqVLuY3OBOHt9O5l91zIFs7NcfTIY0gdZOmXWjYwT99InG0xieb5KzWQmbYe
         oAIfVDQzd4oozzhGTJUXPy/Q8c1nuXFeggmVGFNtHp4N9VcyQw3TNaZBfLdbsRNGOMUV
         Ss7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778307170; x=1778911970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znfabyFueBNEPqXXyOxpAPqjsy9bDnSpb0+GPews0kY=;
        b=G11biZ48SRzHN1j+bDmojWI/P8KOgvFUC8WRPlq2slEh6onvyBsSbGxi3sYUtWrrpU
         Eerg+UZ50gldGZ4jhuNBgUQDbQj0nyIjRDX3/NfNJ6EdfuZjkRRHKWYNbOLRmnuV5tjb
         rOIzMLh9WGXdJKbQWxuJbBJcOjzkxGy/CgSwfAa5yYrhevZ5yE7DBi966no+eoJpl7Pn
         Y7dJSOZMTVVkQh/MmA9fUCeNYfbo4jtH+JXh3IObCOhuP7hNYF9YLDMAgaDemxca1OF4
         wURxs92zQG/uVi14hQS9P5R4aUGrRJ4BdMMoatSEE71XKgl2/QnscfKaoL587A0PpTON
         Hxuw==
X-Gm-Message-State: AOJu0YySJKCRT3Ohpg6S06YJvwYDWtoE9pekqrRuvfwK8IxgZ2bGgYyX
	MVinNaa3jlA+5WijhdvEYn87+fMuOpf4RX6/tEBYk6plKqS9Vbuj9tmO
X-Gm-Gg: Acq92OElly5WUBoNQSuzZelCHHDDdIw0imxJHeF8QH7TduM4xQE5tbtb8NChk6X52G0
	0lVPQ4PyYMEeAjCbKvGXdt4mTJkbPm7FvqOWHCNqgptWmKl73UJtqdbp8twrvnS2+DlzEr/h9TN
	QYf08dqojOgR7JZeYxTmjS+R5gFO7Gk0d7zR+zk69UUF7nLo1SDpeZq7aBHgEygfzBcN/6AvqJl
	td169AF+5W13CJqXHzSVnvPaYnvhI0fMJztAiLObrAsUor4W2KoLkl6vI44jGFi4sSDl9nJ62BY
	gbbD9CBJqsXOjf6Y5H0nYdqJ16YRajuok1/O3qMyuo7jLtbfk9v4u/BHDEVx06MV03ORfHolku2
	B8m2Glbxikaz1E5QcfxdJuVajpxHy1rYzVNKrc3IX0hKrq3eMeHEJ8jPra+AvyujryWh6LmrcNd
	E/JWJyav+dd+d8rwKw1zmFF0pxQJ4=
X-Received: by 2002:a05:6a00:1c86:b0:824:9f50:83c7 with SMTP id d2e1a72fcca58-83a8ff17470mr7354332b3a.0.1778307169711;
        Fri, 08 May 2026 23:12:49 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659487afsm13380429b3a.18.2026.05.08.23.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 23:12:49 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 1/3] ntfs: validate MFT attrs_offset against bytes_in_use
Date: Sat,  9 May 2026 15:12:35 +0900
Message-ID: <20260509061237.3233714-2-charsyam@gmail.com>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/mft.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 7d989267a82b..827b99f4597a 100644
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
@@ -65,7 +67,16 @@ int ntfs_mft_record_check(const struct ntfs_volume *vol, struct mft_record *m,
 		goto err_out;
 	}
 
-	a = (struct attr_record *)((char *)m + le16_to_cpu(m->attrs_offset));
+	attrs_offset = le16_to_cpu(m->attrs_offset);
+	bytes_in_use = le32_to_cpu(m->bytes_in_use);
+
+	if (attrs_offset > bytes_in_use ||
+	    bytes_in_use - attrs_offset < sizeof_field(struct attr_record, type)) {
+		ntfs_error(sb, "Record %llu has corrupt attribute offset\n", mft_no);
+		goto err_out;
+	}
+
+	a = (struct attr_record *)((char *)m + attrs_offset);
 	if ((char *)a < (char *)m || (char *)a > (char *)m + vol->mft_record_size) {
 		ntfs_error(sb, "Record %llu is corrupt\n", mft_no);
 		goto err_out;
-- 
2.43.0

