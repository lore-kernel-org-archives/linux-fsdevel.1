Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CE32B13C;
	Mon,  1 Jun 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320132; cv=none; b=JDEY+Q3JY+EfM/KHh5n1EG9IPpBwqo6Vx5U8Z0LXrX360FcvRcUAYc3zr2IPbBgvqHOd90Uer126ofwKNwsJojAR8TQS9OCAvMjGimTYGBtveOwg3Ifp+YlM4GWr08jK9XVBEY4/fvZBoxvgo+iC59xpGT1kXCy0lidf3WrtNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320132; c=relaxed/simple;
	bh=dZ6UG3VQFfVAkrgWyizOkUI15Tj1E7h3LpiI7/1LtnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srOpipd4tfp7zpl1eJmhnxXht+sGXG8iA/VaWoHSQIq/+k7MZ7w2l2umkP+xvjXgAgTr9FYbxrDWz+YsLdZiLne0CMehu4jFGEoDVMdOPPuc4Tqcqmgsma/n8hicGXwwbSDnqVNVc+K61fqRsZdC17SF3o6uIQ47oqgd1z+z7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pEAqU15w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pEAqU15w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pOb9LhqR/KnOruqnLWEoD+CcFArNG+gznSArhzOADF0=; b=pEAqU15wY3w7FBx9lf+IeFDYcA
	ZMtqkG79AngwWMDjJfNb+l77I4o0kjUf8yR2RUtyq/6cxL4IYNE0ZWTh/s8cykofwmrRu7RFwPxxb
	cqWnYivy4OZwETNsxEZ08R0wcKGqfcrtRGkoKTiSe2QMMpwRjuYPSMgmBlhMlqtB+8bzV5Vux5r2o
	mB7EVz9Wwic6DI1NSh4Gv3nrJ24JCyHxXsmm5f3oEjZzfEHMlW61UDHuXdXD1hw4tjVUQamIjcTjd
	G/FK9fBCVQUFypMWEGSwixw5k8csrjn4COsjIP0w8eYpnFbvrg70jGQVBq8Webn8HYe3uq6hK7VG/
	XG2j8IWg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU2aj-0000000094j-0Q3n;
	Mon, 01 Jun 2026 13:22:05 +0000
Date: Mon, 1 Jun 2026 14:22:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 3/5] mm/shmem: introduce copy_zero_to_iter() for large
 zeroing
Message-ID: <ah2HfH3jJZDiNAQc@casper.infradead.org>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-4-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601055704.167436-4-chizhiling@163.com>

On Mon, Jun 01, 2026 at 01:57:02PM +0800, Chi Zhiling wrote:
> Currently, holes larger than PAGE_SIZE cannot be handled because
> ZERO_PAGE is limited to a single page. Add copy_zero_to_iter() as a
> wrapper to support copying larger zero ranges to the iterator.

I think Hugh put this optimisation in the wrong place, and you're
perpetuating that ;-)

So perhaps we can start by moving this optimisation to lib/iov_iter.c?
And then you can redo your optimisation on top of that.

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af7..06c54d719fcd 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -451,7 +451,23 @@ static __always_inline
 size_t zero_to_user_iter(void __user *iter_to, size_t progress,
 			 size_t len, void *priv, void *priv2)
 {
-	return clear_user(iter_to, len);
+	/*
+	 * it is noticeably faster to copy the zero page instead of
+	 * calling clear_user().  Shame.
+	 */
+	void *from = page_address(ZERO_PAGE(0));
+	size_t res = 0;
+
+	while (1) {
+		size_t n = min(len, PAGE_SIZE);
+		n = copy_to_user_iter(iter_to, progress, n, from, priv2);
+		res += n;
+		len -= n;
+		if (!len || !n)
+			break;
+	}
+
+	return res;
 }
 
 static __always_inline
diff --git a/mm/shmem.c b/mm/shmem.c
index 3b5dc21b323c..112cae9f9e4f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3427,19 +3427,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			else
 				ret = copy_page_to_iter(page, offset, nr, to);
 			folio_put(folio);
-		} else if (user_backed_iter(to)) {
-			/*
-			 * Copy to user tends to be so well optimized, but
-			 * clear_user() not so much, that it is noticeably
-			 * faster to copy the zero page instead of clearing.
-			 */
-			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
 		} else {
-			/*
-			 * But submitting the same page twice in a row to
-			 * splice() - or others? - can result in confusion:
-			 * so don't attempt that optimization on pipes etc.
-			 */
 			ret = iov_iter_zero(nr, to);
 		}
 
