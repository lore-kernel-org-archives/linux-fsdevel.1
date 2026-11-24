Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491242;
	b=5QqRhGEN8PoFcamTsQn40Cm32W3yXS3Rhb7lqQlSSmF8EfRJ7yNbJt9gL6mWCbCnCNv/
	 DR99eT4dj7pBnAfsaSZFdipQeJDe9iwrjKVmXEuxpRWFp1IhxIkM8mruXIgYBtj0OMBTv
	 gvG0FzmM8qIJWgfkbUnKUj32jpm3Ue+1L1pq4zswePIXDbRSzbRmUfHmpgO8W4VvAA8/9
	 ZbwHYRkbk+8gNUqKeOvx9SfjCWVK9EdpeR5dvkgy1FuC9aAGZK8AwBCC4hqw8/tAoFXkb
	 y65gb1Wh2MCBb/pdv7Uv1K+uL8rCQGOGX49vhZWWpQWP3D7hrTAcLbj6J1i9Q+wCxMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fgziihkmWmv71dbB/QFn4V+nTlNArdPHdIiY2QssMfY=;
	b=2WfLQ3CcjGwhyy+3TNuYS0kTV1dwWta5NqR0UVhiSwR5sm5vALZrlaRBCFSXt7O4YPWx
	 xorLMaOZhb4zVbni4KEAJ71ebtY/rHimPvWZMtJgEyaL8Cs870/1mVlP3eaoU/RFxRSEq
	 9xSiOMV18e3WmzbzqKCtpVjFBzNPl7W0XEQmuMdDCzX0FBEum7BXKiPMcuZhIl5Pzmmmt
	 uUOyQkygG/rwYMYMxGjUyEIDUSnHbDy8po0v7QSOqq204DP+m/Ps6yg6I64g4v8uFKXLY
	 leF8KzuoK9AzdjCyfT+ys1k4WdqomQf1qWkw3IjKzM/oSlHiObazf1Tut9xA1dafQFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WxN8COg0;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADE606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 03:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FADE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WxN8COg0
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3854627c1c8so5958589eec.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 19:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795491241; x=1796096041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fgziihkmWmv71dbB/QFn4V+nTlNArdPHdIiY2QssMfY=;
        b=WxN8COg0PefxhVQqeUlaJ3/KFXORBGCTADpKl+7eGLSYwwBF3nsSfeEDJH/s6FkHZl
         vgAYMAD87gqDnY20PDcVdPC27Y75VX70ayC0f9rXqnb2jtUwZS+YFXVhQR6WufRNOjpi
         DXcFso2vdFi87Yc2gjL+tE3x1c7o8b1vIkI1xoM8gmdFMoSMFViOzcKKPzpVd5My8qYW
         HmLPYr7InIvT/6zJuMRtzxH3VrApc4hphFuBjdWOteOkTY9YpBkt+9nCG1PliCaOQv4t
         ZY6YfK+MCGh9ku0b5/055oY3mq/pR3UzXaO0OOK/IgzLaMZCwfMoM/jFVS1HLqRCUREu
         eJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491241; x=1796096041;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgziihkmWmv71dbB/QFn4V+nTlNArdPHdIiY2QssMfY=;
        b=kg5+f3o2KRJxwXuJeQYj7ofjcYEe5Kv6dtD8cwZkCXNgCfOU6HRQS6+iYo93xZ3lWc
         nSXKet1HPvDonzTWz84GsCV8wlkLRHGcziO9G6MjG2UZ7SwkfTGFxc4vWvJOo67yjr+x
         6YBKbiIS9uxzgY/nXMckNqvst7Rgbr2yKGjrOFn/k9PuGFAwuRYl8km9YD7y6K/XD4NS
         YrTawevtYvf/R+EcxWdcFp4F5IrHaxoRGtLzAHSaFrx5+c17v3vjoxXzchLJTIP/Sv2W
         +mdyQ6XXn//9z7gtuRplR5kG9sLSruTcK7JrEgsijmJYJi1dlibX0uLLYrFfRJyl62HN
         RApg==
X-Forwarded-Encrypted: i=1; AL+hErECAanngeeIStqpfPnZHa/E3d13akzdi/pZ+D9y4Crhhc70444IqWeZKGuplC9FU4b+zNnG3rcvZpp+ZK05@vger.kernel.org
X-Gm-Message-State: APuU4Z8cf9zWxEb8BryfvHugarb0DahvhrKf/PGsS51NqRYtBDkYLFEM
	T1QsRnO+h6Na0Th7pmrJ1SKZlCo8EqNAvQ6WNWNYNgv2iffGstQj7GbeK0I97PPOuHhepfzzpeD
	lVJH1XTCxFmB4dule/HjiqA==
X-Received: from dyw11.prod.google.com ([2002:a05:7300:880b:b0:36a:de0:d28a])
 (user=nilayvaish job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:87d6:20b0:386:bc19:6a30 with SMTP id 5a478bee46e88-386bc196d10mr2286489eec.20.1795491241112;
 Mon, 23 Nov 2026 19:34:01 -0800 (PST)
Date: Mon, 23 Nov 2026 19:33:57 -0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261124033357.830767-1-nilayvaish@google.com>
Subject: [PATCH] fs/dax: use page_ref_count() in dax_folio_put()
From: Nilay Vaish <nilayvaish@google.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"

Once dax_folio_reset_order() has turned a DAX folio back into single
pages, dax_folio_put() checks that none of them still holds a reference.
It does so by casting each struct page to struct folio and calling
folio_ref_count().

The cast relies on struct folio overlaying struct page. struct folio is
going to be allocated separately as part of the memdesc work, and casts
like this one have to go before that can happen.

page_ref_count() reads the same count from the page that the loop
already has, so use it.

No functional change.

Signed-off-by: Nilay Vaish <nilayvaish@google.com>
---

Notes:
    This patch was written with the help of an AI coding assistant (Gemini).
    
    Based on next-20261123.

 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9d161d7ef3ef..16cad82c689f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -449,7 +449,7 @@ static inline unsigned long dax_folio_put(struct folio *folio)
 	for (i = 0; i < (1UL << order); i++) {
 		struct page *page = folio_page(folio, i);
 
-		WARN_ON_ONCE(folio_ref_count((struct folio *)page));
+		WARN_ON_ONCE(page_ref_count(page));
 	}
 
 	return ref;

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.56.1.839.g22a8290db9-goog

