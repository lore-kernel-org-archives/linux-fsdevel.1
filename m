Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0E390985
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343677; cv=none; b=MtF+8VgRaNUiZuPshcc/ELnzrhPmj+bv97cgTAdmwPFZVNW4rfCSGh1vO+qx3X5Ge3G8RM2NN2hzTOhMnFghq5queqil6n0KCoJ/3hORuMULYGPW+Agd9Vy+5aoeZ+ZqnTxq+vBvUbIC8ynjWFSfmnDTy362HMf/sXoqqQUF/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343677; c=relaxed/simple;
	bh=l9vhqsq5bfyaKJuEZ7vSS3uuF/Bho5vCtA+nLHPqRKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q60aa81XetFGurF63pqYDFOPsp0Vv8mHW6VPPx6eUA8S0ukJ8su4BcbnCA9AgdrvP/u+mY6ZboheRBmj73GxbXsBRTfa/Xf0aEM110DUzfsznd0zK+GAk8CNj7uJhVI2NbbmGCqwBr24aAMlsmraaxNNhucObXN8rUf/mRmrgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xXkESVPd; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xXkESVPd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781343672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9vhqsq5bfyaKJuEZ7vSS3uuF/Bho5vCtA+nLHPqRKk=;
	b=xXkESVPdFyKZZn6C6OJvt76RiV1y8lHsEnjZCUElMzdTuxcFSOe0ID2yshvdAt4hMuwZD/
	OtQnP1QlUKPZCKDgiBflT8ns5FKe0FLIA3se3BymbIYVxyDXabziEg3S1PGukLAfdShziI
	wz+HIRFPtXuGXkjpMldu70s0gWPY33Y=
From: Lance Yang <lance.yang@linux.dev>
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	hyc.lee@gmail.com,
	usama.arif@linux.dev,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 3/6] ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
Date: Sat, 13 Jun 2026 17:41:03 +0800
Message-Id: <20260613094103.14051-1-lance.yang@linux.dev>
In-Reply-To: <20260608210618.3437216-4-willy@infradead.org>
References: <20260608210618.3437216-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 08, 2026 at 10:06:13PM +0100, Matthew Wilcox (Oracle) wrote:
>This fixes handle_bounds_compressed_page() on highmem memory
>as page_address() does not work on memory which has been kmap_local(),
>only on kmap() memory.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>---
> fs/ntfs/compress.c | 18 ++++++++----------
> 1 file changed, 8 insertions(+), 10 deletions(-)
>
>diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c

Just a thought.

This file still seems to have a few more page_address() users where the
kmap_local_page() return value is not used.

Should the rest of them be cleaned up in this series too?

Cheers, Lance
