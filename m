Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F2211A09
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334382; cv=none; b=sLXtHhufYWUOy3BXbWjJ9Odp4tBZkEr4SxWIflBGlX7DL/P48LllRqh/wocw+DUeYfTtQXfOzDc5chEn2ccnzGIAGUGdI5nrt6PkTHxdVNH24tLWUAaWzKMltLVpEUxLs579JkqgRS3uz9QXWxBLpwE8nj8VnVQFhPgb2WN3c4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334382; c=relaxed/simple;
	bh=VoJSs4PDNmKJhjbLsydMo57sAVHn3TTHvx6cPZXkaYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xp2ILOUkkRm08/52aJv5S3RffOlSw+h+0fFRQwK0i7YTUBPh4glA440muFT+h4RP9kk36BRM6bSAHTsg/0msg9VCLssGhF7RbP3T89RNK11bOT+AIvO0zfOiyBk4ADSfIPMZg4x3ugaFxMXW9RPB/7JpnRwfOr/BEj8LchX5vFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbVKK8zI; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbVKK8zI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781334378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pF1QptbT4ANn9dIzeaKLaJnMG/TsByf/t+R0Qjd78m0=;
	b=sbVKK8zIzOChSg5o22XKRCzvqn9ogGWt+uRgS7n7cGELmP4UVSHuxv546SKLCTu72hnLJx
	BdFQGAUCzrbf7mCfdmcX6+EWjYoMGuI1Eu2zr20m2G8J05zf15Q/5MGvAmaU8VbEB1M8Ix
	l4+fDxaTOXTLgZuqNSpnaKB45S7FJw8=
From: Lance Yang <lance.yang@linux.dev>
To: usama.arif@linux.dev,
	willy@infradead.org
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
Date: Sat, 13 Jun 2026 15:06:01 +0800
Message-Id: <20260613070601.90382-1-lance.yang@linux.dev>
In-Reply-To: <fda62f90-2c8c-48ec-88ae-310bb5adaa37@linux.dev>
References: <fda62f90-2c8c-48ec-88ae-310bb5adaa37@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, Jun 09, 2026 at 04:55:03PM +0100, Usama Arif wrote:
[...]
>> 
>> Are you saying my transformation is non-equivalent (and I have
>> introduced a bug), or are you noting that this is a pre-existing bug?
>> 
>> If the latter, is the error that the else branch exists, or did the
>> author intend to write a different test?
>
>The transformation is non-equivalent.

Right. Let me try to make one case easier to see.

Assume:

  PAGE_SIZE             = 4096
  page->__folio_index   = 2
  pos                   = 8192
  initialized_size      = 9000
  i_size                = 12000

Before the patch, the relevant code was:

	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
			(initialized_size < i_size)) {
[...]

		if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
			clear_page(kp);
			return;
		}
		kp_ofs = initialized_size & ~PAGE_MASK;
		memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
	}

For this page, the outer check was true:

  page->__folio_index >= (initialized_size >> PAGE_SHIFT)
  2 >= (9000 >> 12)
  2 >= 2

and initialized_size < i_size was also true:

  initialized_size < i_size
  9000 < 12000

but the inner check was false:

  ((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size
  (2 << 12) >= 9000
  8192 >= 9000

So the old code reached the tail-zeroing case:

  kp_ofs = 9000 & ~PAGE_MASK = 808

and zeroed page offset 808..4095, i.e. file offset 9000..12287.

After this patch, the outer check became:

loff_t pos = page_offset(page);

if ((pos >= initialized_size) && (initialized_size < i_size)) 

For the same page:

  pos >= initialized_size
  8192 >= 9000

so the first half of the outer check is false, and the block is skipped
entirely.

Cheers, Lance
