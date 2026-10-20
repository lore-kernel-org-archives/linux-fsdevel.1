Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533833;
	b=426AlgW7/1xdjnmumF3yUnxlzTY8okCGFa3MzZpQTa5Y3hCsNX1hRCVFpSSQ1mZTwrpK
	 uVaRD0tr8Y/pGy+Ioi0eULsyoGw1z+gjsdBNsS9ug0jRWYTbBnKMpGCUU5TLhP0aWmicJ
	 oypuLuKpKlUzqNh6xOwaS0VDRGmwNNAAphnNMIWqHsVeAjTv9U+3UD/Q4EiuSEOW21yaU
	 0Ug89waU02Zy3ft262fndtuVFej/s9qtvlXa9ixZxqi61WcbotktYzHOD4N9fQO6BH4lf
	 6QjuVlfQfAVquh8O5RmS2P11cQ61FrqP8dof5YlwwVEs2hs33lgzn4ACLo2lba2dDlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7y3NOM7xqvWmL65AFq+ZWC79CgE7opPLQwAIectARfc=;
	b=MaXmowjViiQZ53frc5HO1Pxs66aHLGWB6tKhwi98DmWR7MHwavIc4T/AhwanqukHXHY3
	 6yEP3FCXMVF3zaq1XCtWAIwN30dH46VqoSx8xMZ6lRCudIwKposproLVk7nBiQJD4bO94
	 c9aoMJo/c60zrzFjtnIOTXs3VydWyv8TCiFnXUjRJWvlPsdQYo7HST5tGu+atet4J3IU3
	 IkU2NmLJ8+gGKIq0ahzheSRDINrxWqR01LZZUVF/aLkjejypooALkCwXL3ur9KyaUn61K
	 s9Ass/Y9foqDiKylS+Scvo08kefUcP9wN598jEiVkAYwiznMwB1NpIkJS/y5noen4nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=e7v4dX4R;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B9606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 22:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B2B9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=e7v4dX4R
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91b834592afso1650946d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1792533832; x=1793138632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7y3NOM7xqvWmL65AFq+ZWC79CgE7opPLQwAIectARfc=;
        b=e7v4dX4RkKze3IRJFHlD90GiiRunjf1dW7R0ovnU+GL0YUvG5uNrO6oe7nd8vkHp1d
         ctyvI/jFJ6jCQ+EsmGNt9g9uXCJayx5vTOHlB0/45prHxEnD01+WxzIuTZ9oKFA0Je7B
         xJolL9Gu2l+kSm7jYJvJfA20olJm6WWRpHH7XHyh6uLzWntCtpCmcq4HaN0MkHR2DqXA
         l0w4btT6vddD/K6vPrJWBxM98p8iiNa1cksHwaZQwwnUtDC/hGh5q+iP9tfRDHGYNdqe
         tqdrfSxhuf5O/ugDKxdhepK5xgcERJbyZZFD0Wipn9BQXiH1MJ9Iqhwi/936FbfaUMUT
         38pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533832; x=1793138632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7y3NOM7xqvWmL65AFq+ZWC79CgE7opPLQwAIectARfc=;
        b=V3+KVFXvKCXBqQtTlPD2NPlTT8PaS0rVp0yJCdCgCGQ5RDgUnV0josMBEaj1CNMsfl
         lAbn/9WM6GId8eG26zBm8ul5lcJmKdR51QXyzKgv8PddzXtCDAAP1ruOG9/JFHJmJvOh
         yhVRxQ1H7fqtkPTcD7Uw2OnU3K8tQ09gVGhYhIIUbdMVMB+W8vZSnaIYzWVfgQV6rJDd
         tLN+Ny1CrZJ4t9fM5m98poBlwl+9kV4iqEfvOwx0wSwRYc2elRRUGxaedxZtYTczxXgs
         jngWTl/JVOeOPi6sYmXvPU605h4c0AiwFr5MHW66AulDBN5YLqSI8HjrxFyEtsDlncBW
         HEwA==
X-Forwarded-Encrypted: i=1; AKwUvBzOb9zUcBL/6oF6fAv7B0nlTuj1tjzT2fJqYporQ/shLJfe8iH1bRdL1ZZqcl13u66wWkRPf1tyqK8ckEZz@vger.kernel.org
X-Gm-Message-State: AFq9FYIUaZJy4fQSGDYkSztJ2tjH2fukJI6SKqqEYsQW8dqH1aGBUxwt
	r2JWYb8/ZPrIXh82RJUqG0FiwxjdTzKXoJ0lS2lv4jDr2L1WB+JsRGyMbuAmW+q45cw=
X-Gm-Gg: AYBFou3Vf64tGdVrNnwlEvtWYM/fJDA+sDFZWsodWhZCkjgE/fVVrjnboUa1b9lFJJM
	POU4a9gqCnRFckLFUh5rDMoxH44eeCB/0Y1KZEcvnOkV4IJJkfeNZjeP33VkNbHayYtchVmiMG2
	x4EHwGw02eIT3NFRSpJKWTLxGNipzpmI6C+vSSKDkyywzS7dCxLecaWUdDB7CSpKK8BX1JXe7ov
	4F0iQrefDu/pkVW/FiVIahKWWtDTsbXIY9dIH5PH1oRr6XUg5p1V7THsQSx908qJOlUUr3leZsx
	cX0J8HZV0HMaJVRs4yHRd7Ard4HKzTG5OmZLpOzWGUT3uiotpVmvcx3JaBaWGSl1zwBrHE4YJ2t
	2Vj4o/RwrHAzDnmt5pdlB2JEiQvySq/uaRD0znh0ggz4z8paVjS2Y/PqvggmFDUnuoG4YPTyK63
	RH1RKbFMp70bPzTyRNfPN6xE5hqScyr9y1At+FZHyZ6xC27G81nSqxjt/dvj07O4g2eyTNwXi8x
	1Xb41WAKGmdybWwhE9EFKbEwFWe6ccIZC+tk/aHj+3uWhHwIIxbxD9gcewD9a5NIDKquATXcw==
X-Received: by 2002:a05:6214:1bcd:b0:917:a2ba:e481 with SMTP id 6a1803df08f44-91c12edd30fmr2833036d6.15.1792533831883;
        Tue, 20 Oct 2026 15:03:51 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b70c43sm8732996d6.10.2026.10.20.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:03:51 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 2/5] mm: add folio_mark_dropbehind() to mark a folio dropbehind and account it
Date: Tue, 20 Oct 2026 18:03:43 -0400
Message-ID: <20261020220346.28020-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20261020220346.28020-1-snitzer@kernel.org>
References: <20261020220346.28020-1-snitzer@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A folio allocated by an RWF_DONTCACHE write is marked dropbehind before
it is dirtied, so folio_account_dirtied() adds it to WB_DONTCACHE_DIRTY
and folio_clear_dirty_for_io() or folio_account_cleaned() subtracts it
when it is cleaned.  Nothing marks a folio that already exists.  A
caller that sets PG_dropbehind on a folio that is already dirty
unbalances the counter: the clean subtracts what was never added, and
once the counter goes negative, wb_stat_sum() reads it as zero and the
DONTCACHE writeback kick stops writing anything back for every writer
on that bdi_writeback.

Add folio_mark_dropbehind(), the inverse of the clear in
__filemap_get_folio_mpol(): with the folio locked, mark it and, if it is
dirty, add it to WB_DONTCACHE_DIRTY.  The folio lock orders this
against dirtying and against folio_clear_dirty_for_io().  A concurrent
lookup without FGP_DONTCACHE that clears the flag again subtracts what
this added.

The name follows folio_set_dirty() and folio_mark_dirty(): the first
only sets PG_dirty, the second also accounts the dirty folio.
folio_set_dropbehind() likewise only sets PG_dropbehind, and
folio_mark_dropbehind() also accounts it in WB_DONTCACHE_DIRTY.

A later commit uses it in NFSD to drop a page shared by two misaligned
WRITEs once both have written it.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-mm@kvack.org
Assisted-by: LLM
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0adfa6605653..3012bd95812a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1310,6 +1310,7 @@ void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void folio_end_writeback_no_dropbehind(struct folio *folio);
 void folio_end_dropbehind(struct folio *folio);
+void folio_mark_dropbehind(struct folio *folio);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f55..ed7e4dbea653 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1644,6 +1644,37 @@ void folio_end_dropbehind(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(folio_end_dropbehind);
 
+/**
+ * folio_mark_dropbehind - mark an existing folio dropbehind
+ * @folio: the folio, locked by the caller
+ *
+ * Mark @folio so that the writeback that cleans it drops it.  A folio that
+ * is already dirty is added to WB_DONTCACHE_DIRTY, as folio_account_dirtied()
+ * would have added it had it been marked when dirtied, so that the clean
+ * that subtracts it leaves the counter balanced.
+ */
+void folio_mark_dropbehind(struct folio *folio)
+{
+	struct address_space *mapping = folio->mapping;
+
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+
+	if (folio_test_dropbehind(folio))
+		return;
+	folio_set_dropbehind(folio);
+	if (mapping && folio_test_dirty(folio) &&
+	    mapping_can_writeback(mapping)) {
+		struct inode *inode = mapping->host;
+		struct bdi_writeback *wb;
+		struct wb_lock_cookie cookie = {};
+
+		wb = unlocked_inode_to_wb_begin(inode, &cookie);
+		wb_stat_mod(wb, WB_DONTCACHE_DIRTY, folio_nr_pages(folio));
+		unlocked_inode_to_wb_end(inode, &cookie);
+	}
+}
+EXPORT_SYMBOL_GPL(folio_mark_dropbehind);
+
 /**
  * folio_end_writeback_no_dropbehind - End writeback against a folio.
  * @folio: The folio.
-- 
2.52.0

