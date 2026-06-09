Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E644963DA
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020526; cv=none; b=WmnxcAiRnlxdLhoFFsgZUmoIE2ulr/WFymygnQXV+SxUV3z9O/BVr0L+5zzAEbMD9yUMta9oNOZGxnDzQulw85pYoTGHIYqOaIFqkolEzbMeZuUswbAoCuLrPfkR3/D0rNggjVR/Q0ykgLfcEWQ+KMehTSa1HUyv6njusjGnGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020526; c=relaxed/simple;
	bh=Nk9Y+jtLk7gQ2IJFTB2frM6dvHYkb0+giUFjE1dHX9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjhHT/l1TiLnsYtYMDFl474NiCB2psB8/ZGqRwBwtdY7SJi7U1P5qsuNJs9hkAuOjCV3rNn9Sli5WNFaphBqF3QxTa4lNaZJoS/e5Yss5FcJn2qYgeMhHINfjhId9ODHwJWK8jRLS0tUPEpGdtW1Om0rVcqaHmmsRV6euPsSfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ay5Ciskt; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ay5Ciskt"
Message-ID: <fda62f90-2c8c-48ec-88ae-310bb5adaa37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781020523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVW8qj71/+Q1WHcblQi3iYQw2OS0VBC9fdNyR+PSVz4=;
	b=ay5CisktjARNBPfV8OacmD2GFWycwxxTEJdtdfuqjaIIwfUgr3EaK0yVRNBZ+tqLXll7V+
	YiM/Blhyx/Iu3sztfNBbyInOJJZtNmlMBDePIfYFt18G5wQTBVFPaVK7TG7wyN4vicbqfx
	BPsr8vEC2gezI98cRBos8x+2PouCE2M=
Date: Tue, 9 Jun 2026 16:55:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in
 handle_bounds_compressed_page()
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20260608210618.3437216-3-willy@infradead.org>
 <20260609131724.3114804-1-usama.arif@linux.dev>
 <aigkhkcXuQx7yfPu@casper.infradead.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <aigkhkcXuQx7yfPu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 09/06/2026 15:34, Matthew Wilcox wrote:
> [Editing your response to patch 3 into here]
> 
> On Tue, Jun 09, 2026 at 06:17:23AM -0700, Usama Arif wrote:
>> On Mon,  8 Jun 2026 22:06:12 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
>>
>>> Nobody is supposed to use page->__folio_index.  Use page_offset()
>>> instead, and simplify by working exclusively in loff_t instead of mixing
>>> up loff_t and pgoff_t.
>>>
>>> Signed-off-by: Mattinnhew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>  fs/ntfs/compress.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
>>> index c904858dff3d..b279f38636d6 100644
>>> --- a/fs/ntfs/compress.c
>>> +++ b/fs/ntfs/compress.c
>>> @@ -105,13 +105,14 @@ void free_compression_buffers(void)
>>>  static inline void handle_bounds_compressed_page(struct page *page,
>>>  		const loff_t i_size, const s64 initialized_size)
>>>  {
>>> -	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
>>> -			(initialized_size < i_size)) {
>>> +	loff_t pos = page_offset(page);
>>> +
>>> +	if ((pos >= initialized_size) && (initialized_size < i_size)) {
>>>  		u8 *kp = page_address(page);
>>>  		unsigned int kp_ofs;
>>>  
>>>  		ntfs_debug("Zeroing page region outside initialized size.");
>>> -		if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
>>> +		if (pos >= initialized_size) {
>>
>> Is the else branch over here unreacheable as the outer if statement
>> already had if ((pos >= initialized_size) &&...
> 
> Are you saying my transformation is non-equivalent (and I have
> introduced a bug), or are you noting that this is a pre-existing bug?
> 
> If the latter, is the error that the else branch exists, or did the
> author intend to write a different test?

The transformation is non-equivalent.

The original code's outer and inner tests are not the same test.
outer: page->__folio_index >= (initialized_size >> PAGE_SHIFT)
inner: page->__folio_index << PAGE_SHIFT

These differ when initialized_size is not page aligned, because the
outer right-hand side floors and the inner left-hand side doesn't.

After your patch, both the outer test and inner test is:
pos >= initialized_size

I think the fix to make it equivaltent is to relax the outer test
so that it includes PAGE_SIZE (maybe?). i.e. make your outer if
statement to be the below to make it equivalent?

if ((pos + PAGE_SIZE > initialized_size) && (initialized_size < i_size)) {

And then the else branch in your code should hopefully make sense.
