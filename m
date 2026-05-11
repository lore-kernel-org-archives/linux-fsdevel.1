Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD712C11E4;
	Mon, 11 May 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501897; cv=none; b=lIo7f79mY9Re4ywUwLtvXjeRR0PaWdOvbWQYx5dll2UbjvRKA+e+RWrFSHG8tapi5ud2FFYhkHfc9+zJuHOXRDbgpnR4Wsx+EgbjLv1V4rInSTjiKpZlFMCN6jlJIIE+ZyR/6k4dlspfNtVk1QonoiU0bqFNRUQAYKaOFqI0tm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501897; c=relaxed/simple;
	bh=yMjdymx8FHBrtj18YslQ/stGshcK0q1TjQd5LI7LL8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXdptBp2isnxxpWWbKuWFSil9QVvZQfE9UUSWTKJ7hNq1MLjiGCQqWr2rRO5qpGmDYshcutneKx3R4kGm1eY2H5oPIp2jCE2p8rPgNWVCEgXYNRhe/hhdA2pmznxzsd9cKhLtSx7VCcxqiO+nhXy+ZBn6N2fHy5B6CgwMgl5Pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glGQBqNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glGQBqNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715CBC2BCB0;
	Mon, 11 May 2026 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778501897;
	bh=yMjdymx8FHBrtj18YslQ/stGshcK0q1TjQd5LI7LL8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=glGQBqNc1KRIJY+4eXYuyo4x8xsdMn7qscU1jXE+LdfRxl8N3+y7ch4kG0XZEC13w
	 Rst3Ki2cfX5RVngCHsPWS3TxlWdiwjCqWw+mxwEzj76Ld9oGrEEE8izN+Qlfp09h6k
	 GQ6fflH7jVvzFIHnmKXBit/AboWC0MKEQ9gPQ1sRrS2y4uRLI8NqMbhvYFWTGM/Iih
	 G8dYr0EG5rZhZ1lvCP0hlskJ7cRHzE+lxy37XUjT538hZGp+rif9cejL7L5Uvjxmmn
	 Fw15ZFguBcITOg3hc+tfABh/s03IszofdxDKfTadhI+XvKL1DGOGrxGHDxhg1QUZVw
	 Sb6pbD0NFEMfg==
Message-ID: <b0abfdd5-b72a-4f62-8e0f-b6140d3e5fc7@kernel.org>
Date: Mon, 11 May 2026 14:18:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] userfaultfd: ensure mremap_userfaultfd_fail()
 releases mmap_changing
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Peter Xu <peterx@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260501145433.156211-1-rppt@kernel.org>
 <20260501145433.156211-2-rppt@kernel.org>
 <3a04ae6a-049f-4d3d-b5c9-e60e86be8e5a@kernel.org>
 <agGz5J6EKskMk26F@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <agGz5J6EKskMk26F@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/26 12:48, Mike Rapoport wrote:
> On Mon, May 11, 2026 at 11:15:34AM +0200, David Hildenbrand (Arm) wrote:
>> On 5/1/26 16:54, Mike Rapoport wrote:
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> Sashiko says:
>>>
>>>   mremap_userfaultfd_prep() increments ctx->mmap_changing to stall
>>>   concurrent operations, but mremap_userfaultfd_fail() does not
>>>   decrement it before dropping the context reference.
>>>
>>> If an mremap operation fails, ctx->mmap_changing remains elevated. This
>>> will causes subsequent userfaultfd operations like a UFFDIO_COPY to fail
>>> with -EAGAIN.
>>>
>>
>> Sounds like we should CC stable?
> 
> Yes.
>  
>>> Decrement ctx->mmap_changing in mremap_userfaultfd_fail().
>>>
>>> Link: https://sashiko.dev/#/patchset/20260430113512.115938-1-rppt@kernel.org
>>> Fixes: df2cc96e7701 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>>  fs/userfaultfd.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>>> index 4b53dc4a3266..ef963a58f1a1 100644
>>> --- a/fs/userfaultfd.c
>>> +++ b/fs/userfaultfd.c
>>> @@ -786,6 +786,7 @@ void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
>>>  	if (!ctx)
>>>  		return;
>>>  
>>> +	atomic_dec(&ctx->mmap_changing);
>>
>> I'll note that other users have a
>>
>> 	VM_WARN_ON_ONCE(atomic_read(&ctx->mmap_changing) < 0);
>>
>> In there. Likely we should do the same?
> 
> Yeah, we could.
In any case

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
