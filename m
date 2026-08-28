Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259733C1F5B
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950475; cv=none; b=jVe9QhTF63Mwx380nBfXnAvg/ked2Zy2SsrNSykuc9l7f1M9HeuWDQDvZeOJCBiAQlWvvQfNeW7oFNsr8/mon+TKyKecL7z6CZ3QHcALcpam4iKgVfuR84ZRokfJSR/O5dYAC9zt9k8g0nQFYsfCW5ebF+zkLc912tEg6NbLHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950475; c=relaxed/simple;
	bh=eYWYXT5ZM6JL6yUMfAUu+4YWkQPGBms0WdYEgTBzaxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdfMTwUFmeiUZB2c2x88cRrcJCXDFvLz+OOWpfZ6PAGkdXA8WpfiN3zSFVtjMNb5xys6fmq8MCn34HuxTkcQ73NVWLYByvDvdnjfh5ZCnwTFwePwA3p14SoxJLuAGfYvOZke9EpCodCDwHKAzhDIP/3d56R6RLx9uYdvLh7KAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B8v1Bj0x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8v1Bj0x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sP9OUbCerEYDJ3Qer0vBMtP8On2Qh6VA6sMTjkWgIPw=; b=B8v1Bj0xAdDVFvDs/emfsfqvso
	BfJRs99naTuw6hBURtXuzwGd7xjZibBlDr7kurD8X4XCsHBVmc+XwSrwFT2SMxRGe7xXn9kNnX6ax
	8/wuoJT6pmB8Iif/XkZiEwhvBPtwNgUZpicCiGviqU6sQ/2ZyDQWJBDKdjvBNtEAknjeL5jqxlVwH
	lR3GvfGRezZyIGQBwyB7gdGW3VWP7qtYa5zXgm7+Uqe052vEHBF52lUZMFznsGybBTx4z1qsAyAH7
	l7Thh2z52ORl8QsPCVk6nJhda1PoTt2t6ihckjm92yYDQ5TPMaatqiaQjIYiYJ+ZxKdPiQYPMqXzG
	QK73YDzg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x03ap-0000000FQsS-45yp;
	Fri, 28 Aug 2026 20:54:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/6] buffer: Document mmb_mark_buffer_dirty()
Date: Fri, 28 Aug 2026 21:54:24 +0100
Message-ID: <20260828205429.3678204-5-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828205429.3678204-1-willy@infradead.org>
References: <20260828205429.3678204-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc for mmb_mark_buffer_dirty().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index daf851ea9824..96bccff5688c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -618,6 +618,14 @@ void write_boundary_block(struct block_device *bdev,
 	}
 }
 
+/**
+ * mmb_mark_buffer_dirty - Mark a metadata buffer dirty.
+ * @bh: The buffer to mark dirty.
+ * @mmb: The list of buffers to add the buffer to.
+ *
+ * Mark the buffer dirty and add it to the list if it is not already on
+ * a list.
+ */
 void mmb_mark_buffer_dirty(struct buffer_head *bh,
 			   struct mapping_metadata_bhs *mmb)
 {
-- 
2.47.3

