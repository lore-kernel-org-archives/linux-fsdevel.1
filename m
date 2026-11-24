Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506346;
	b=xpjUbX+/Oth7KPuMYqQD28tVS+o1oYMmXi/A5ameqLL8rk/ZSRvgjDiCgFwFGXIrolLz
	 2obMgBZOOokmRontm1cy+gqPor+GDNeAO2xVksgY4w6BulbiXD8uwxxD52j6fPR+n1nzr
	 lAxOUnE12KkMekMtx/ie2/RdpHP3HY3NcGragEHkZtOKnDKrrBLucfpVZ/ldcqLQX/GQe
	 zEWRdnYM0wNmMHjGAyBPCfAYOoxe1xYYhMVlQBaxAbB+rLBqyfIOgxLu8uw6HG8GFIlrz
	 ZkzrSMfsbDOlt3K03D9Gmmis6vVxRul25q59R99tzabp13CFtqBrY6T2tBbSxFIDv2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506346;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Thn+VaFVC1REryUWa6XAf56aRbZr1l1qS8ugDKgj6oQ=;
	b=BUMfa7TvWEa1Zzitv8Be1omMIcXY2IW/TVyjMIAWNyDUhew88R+XsBqM3zKCwz3SON0y
	 1xl/LgLOGiMgTqoQlIXuJb1BuYQaV59L9oZWHrL6DW6Za9Sx8ylnPs3jos8bxwYZWxfeu
	 zsazYPgD8pKUpjPTXJf4xxpjWlDm5YDghLyTJxuFUwJKYlZPCjkXhEhJSO4Rf+dZ+BbmA
	 0EHPdGEooL0vx9T3PgnGeoHMD1txiMEu/Xpv5E7a4EcCsrBvJTE7Fc4vw6Pvz+VNwPGrT
	 K8r9vEr+3806FrSUTmQjs+FKP4DP5p2T/suhWQoPUQmT2u+1rSBeCd/T6ToeA9+BqYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tEiwZMT2;
	arc=none smtp.remote-ip=91.218.175.36
Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D8606A322
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 07:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C07D8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tEiwZMT2
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n4sjkNswfGhBdYtaSlqhTBoXLN/YX3BFxi2FIUhtl0c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795506343; v=1; x=1796111143;
 b=tEiwZMT2M5Qf+XnP4mL2Ld4GFXG3lqRlkDJYSN1LMgH4VIjsLiOi/IyFB0pTzZLmmAt/R8yW
 fJVdSXa5zvkUSVG3CWfAqLzybCJrO7XrphJRVoo6a7ujJQse9ER3Fi4Q1FLTEuQUeZBr1Kqn4cr
 1+FO4Bs8/JIbI0yCyUVR00wE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 84eae793db55e172;
	Tue, 24 Nov 2026 07:45:43 +0000
X-Mizu-Trace-ID: 84eae793db55e172
X-Migadu-Flow: FLOW_OUT
Date: Tue, 24 Nov 2026 07:45:40 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: nilayvaish@google.com
CC: brauner@kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watch_queue: use page_private() accessors
In-Reply-To: <20261124033740.833270-1-nilayvaish@google.com>
Message-ID: <74B03DB4-CE55-410E-8E18-E6B8A02FFC26@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 24 November 2026 03:37:40 GMT, Nilay Vaish <nilayvaish@google.com>
wrote:
>watch_queue records the number of the first note of each buffer page in
>page->private, reading and writing the field directly.
>
>struct page is being shrunk as part of the memdesc work, and its private
>field is one of those that will move. Direct users have to go through
>the accessors before that can happen.
>
>Use page_private() and set_page_private() instead, like the rest of the
>kernel, so that the code no longer depends on where struct page keeps
>the field.
>
>No functional change.

Cool!

I like this, makes sense.


Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


>
>Signed-off-by: Nilay Vaish <nilayvaish@google.com>
>---
>
>Notes:
>    This patch was written with the help of an AI coding assistant (Gemini).
>    
>    Based on next-20261123.
>
> kernel/watch_queue.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
>index e2bdd5fb0db1..eeb7fb9bc0fd 100644
>--- a/kernel/watch_queue.c
>+++ b/kernel/watch_queue.c
>@@ -71,7 +71,7 @@ static void watch_queue_pipe_buf_release(struct pipe_inode_info *pipe,
> 	bit /= WATCH_QUEUE_NOTE_SIZE;
> 
> 	page = buf->page;
>-	bit += page->private;
>+	bit += page_private(page);
> 
> 	set_bit(bit, wqueue->notes_bitmap);
> 	generic_pipe_buf_release(pipe, buf);
>@@ -284,7 +284,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
> 		pages[i] = alloc_page(GFP_KERNEL);
> 		if (!pages[i])
> 			goto error_p;
>-		pages[i]->private = i * WATCH_QUEUE_NOTES_PER_PAGE;
>+		set_page_private(pages[i], i * WATCH_QUEUE_NOTES_PER_PAGE);
> 	}
> 
> 	bitmap = bitmap_alloc(nr_notes, GFP_KERNEL);
>
>base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
>prerequisite-patch-id: d52d42a2ec9ddc2b12b3412ec0d07254b417e60f
>prerequisite-patch-id: d8338f943ba7ae297eefbb26dabc3bcfe7994461
>prerequisite-patch-id: 3d99b53c242296b89d7f7b41f1995188f5a02369
>

--- Thanks!
