Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B63BED5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581346; cv=none; b=VmE+ID0bdi6JWo6YPDp4u/xyosoFecsJSbNKybkE0dfUl070H5OeXS5x2QYyJ0tRowSufMyanq4p1iKU7sh9T9xIiBSkLoiFeSaDwuW2qaOXa4Vj1RXJMzk0ah0hjTXgj11Q5U6rILSO8gSwulvudhV5ZIQuV3nsC0IDOApetRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581346; c=relaxed/simple;
	bh=BB0sPqRZ88+T3km26e+GeLS3s0vMjVM5Qt+LGf7fCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ydcz/1FV24UKgeAhRaaUuP2IVqAnUe+YnWCgL2MDu6N2QGevE0MPJ0oAQynP2pvjx4BtKD0AHxUfAbttfDGK65WglEq5BD0MoEHngvSyYeOMsyC/AAoUyYkBnUskET3Matq4kmCKtdgb9aEzMehoP5H8OMosVpXZb82WS7Uy8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=saDS2vic; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saDS2vic"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848761b5897so5744813b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581344; x=1785186144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q8M3ZYr7j0Vv2huOSINRreA5KjJf/RGJ9R7Nsb1zC5k=;
        b=saDS2vicGBfdIDHNI2MRkJAlVQNY+5LrwskJZm8j39wIOXZhi9WHe51bNueMHtJcK3
         8gjPdFkXixezecy+hIRDhN1Wi+uYgtKQsrr6PnB7WBVnnApQLVw++SyQ33tBfmBEsBBY
         YSe7GS8xjCulVhqaLosD7rxUYxPH+SpRBEZqZHZp46rOMtCJrtmh02ftT3EkfhgBsuKz
         f9hs+M9kcB3IXaEdVoC07poX/K2fPYE7+YlE7BoNUtgDCgrxA47jc1Vf0IqvAhsrwTCq
         ymNgmGUhXk7nMMGj2P1qIRT1gLHVDwp8IxXqN/HPwiB5KZ94m/01xsUj8XwAwJw4rbqM
         Ozow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581344; x=1785186144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q8M3ZYr7j0Vv2huOSINRreA5KjJf/RGJ9R7Nsb1zC5k=;
        b=YNz5sgLypA1xmbMm/68JUVBi06ApQyY98MIn+WOtrV7IjeoTSXDnKR076KeN+cTsqa
         nwT0r/63pcaS9dzsixClSTsmYgltzjnPaYdOKjtVEE0PrON7I4jpCwXHedoxvz5fO2zq
         XBKtzsohD0o4uPcmATxmZKL9SXjscz3l/b69tQMFoG0e04OCTX5InXhoQLnheWF7JFVn
         6JFFje5pGCJ0FK9RHxcV0Tq++p3noqNu5UVDBCLWxs2vrwkpiOXVVG+4Ys3aoXcEH/k2
         EyVMKIdgpFBbUq9YjVJInUaxLMDCvoVzro0jblsRbixcyFddpPrqIlONr6X0GTOg+ZGG
         i/XA==
X-Forwarded-Encrypted: i=1; AHgh+RqD8viudgGFxOzMG2VMJGo3nKHOJa2dTCAYvXep/z3uVjLb9mSh08DxyF/dPgJWwrnQQkAEhhlAO7ru6gGk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxah97+gIKoAvxmTMa9bFmzsRVtZnBdxz+9VZhM0EGlmUdZe1Cf
	Udxf8VLc2FvhqKOr8bFtgtRDzpqipbGd5+/YXTIBFu60ZvLXrNTjchf9
X-Gm-Gg: AfdE7cnAxYMryj3QE2tHxSEVztrmJ/R5HrKmQBdqbg0cMCLZHrx0IBmp4kcYMoErOTf
	bNC7iYrt+krb7WYutdHGhxupfA+/XSMdafvHHbhD5YgGgLKQJYE3uCA4rA5i1PmRBJK6bghSqO5
	uDd30LtpJB0QQgQe5jDkpMjV/9qJTosByNOM99EZbTzmSyMoh2UqPu2YuITQlu6LXJFQbskl546
	hg5FhbSSvsOHbzoRYv6RGKx9A2x/pyJ377/wgfkHe0zgy7z90X+ih/Or02B6MitYSWyIxF/vGSW
	uts72zrwPsxnyoY6v8YBbBemEWEvp0TUIWuLUo0l2s9r2AqYGkqdc/4zr/1VqIq9aESD33JgLV4
	A/oM7iy2AaaaRuozrn3dVAZUKwNRcxicZPgn9xWzsqirOd3hamqM7IPoBUztqmkgeuSlleoZUEV
	ro9O55GfyXR4Ju8MEx3odL2b40wNXqAIYJU/vae1i76ZvY476jzZoW
X-Received: by 2002:a05:6a00:2d0c:b0:848:4b27:36a3 with SMTP id d2e1a72fcca58-84c2953e53bmr15559509b3a.72.1784581344014;
        Mon, 20 Jul 2026 14:02:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3ebsm6149783b3a.46.2026.07.20.14.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 06/20] ntfs3: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:48 -0700
Message-ID: <20260720210202.1163861-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ntfs3 iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ntfs3/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index c43101cc064d..53031e71c8fc 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2101,9 +2101,11 @@ const struct address_space_operations ntfs_aops_cmpr = {
 	.invalidate_folio = iomap_invalidate_folio,
 };
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_iomap_next, ntfs_iomap_begin,
+				  ntfs_iomap_end);
+
 const struct iomap_ops ntfs_iomap_ops = {
-	.iomap_begin	= ntfs_iomap_begin,
-	.iomap_end	= ntfs_iomap_end,
+	.iomap_next	= ntfs_iomap_next,
 };
 
 const struct iomap_write_ops ntfs_iomap_folio_ops = {
-- 
2.52.0

