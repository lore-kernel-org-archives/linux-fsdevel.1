Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6C399011;
	Fri, 19 Jun 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880745; cv=none; b=KJbYL9aEcxCjqGYkrmPCOCIMFAuNcfhgeC7SKeDCVmKUuwr+DPDfCwzV/4g6t8IZ7EDQa8qGTG3SvdGOiLioHgemEpFWlUqcE4E0gWs6aZZvwY14fuZCRUuLs+kNhRJ0KZWw1yGUMoRMYlMfUmmYnOuEZrQCBwTqdf1Yy0TbjaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880745; c=relaxed/simple;
	bh=1NxF9OEqzZjV9HpuOoEMDHMtFk29U8UuSY2cSTFY0hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bri0CN9Va4Acb4RO+ZARLb5oEQjE+Ijo6iMEhttsLUsi3KxJ8rvinH4RGlYdJzGZlECZ0vj2KQq1ACWIzOthNXSAwBq8XJgPlptARNu9AQTQdo4NJEwP+F5DOvISqYbucsO+vKGMKYKvkVSId/TAJGdh/1t6lM2HhLlprlsI6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQv4j3Vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQv4j3Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2E61F000E9;
	Fri, 19 Jun 2026 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781880744;
	bh=MMrfiUsFirA1Wml6QpEyIkRNWkxL+MwzDwXxle/2vjY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mQv4j3VbDWg8O5taJ9piUSfRU3AjvQi66hID3ksm16xst6HHiz9IzYOBf5fZ8yj/i
	 px+Tj1KSP09VAvZe6u1uozEvCw0ov85LXVNQvLcJ4X+V6M7WnaDyck3iAzq8dVql8D
	 gw6+gfB4QzFixuXHlUdJQaz47pQ98pXI/Hp/WTJNY6ZmsS+H9/Q/ujgmEI09i36r5M
	 PwMCR4zVuD1ws+erSTfQ5nrM/ziXF5Kc6/9xR8UDmYAesiKIRst9hkOn+vvC5WHgfq
	 jcUN5tenI8D+3Z3Z0I85Y/yQc9qJbyHmHUVhCiyd5QpsKFSG+sfAqwwK0XEx8UMNy0
	 +gEgu4+0Nz3wQ==
Message-ID: <92c3a198-98ad-47c3-a5aa-24db52109b06@kernel.org>
Date: Fri, 19 Jun 2026 16:52:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] mm: factor out adjust_range_hwpoison() from
 hugetlbfs
To: Jane Chu <jane.chu@oracle.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
 brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
 hughd@google.com, baolin.wang@linux.alibaba.com, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, lorenzo@kernel.org, rppt@kernel.org,
 peterx@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260617172534.1740152-1-jane.chu@oracle.com>
 <20260617172534.1740152-3-jane.chu@oracle.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260617172534.1740152-3-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 19:25, Jane Chu wrote:
> The functionality and implementation of adjust_range_hwpoison() is
> generic, so factor it out and make it ready for generic use.
> 
> [1] https://lore.kernel.org/linux-mm/aeZwAz6PcdlqSnJ2@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---

[...]

> -/*
> - * Check if a given raw @page is HWPOISON in a folio of any kind
> - */
> -bool is_raw_hwpoison_page_in_folio(struct page *page);
> -
>  static inline unsigned long huge_page_mask_align(struct file *file)
>  {
>  	return PAGE_MASK & ~huge_page_mask(hstate_file(file));
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e636647100c..a27ce4ad6247 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2753,6 +2753,37 @@ static void filemap_end_dropbehind_read(struct folio *folio)
>  	}
>  }
>  
> +/**
> + * adjust_range_hwpoison - adjust clean readable range to avoid hwpoison.
> + * @folio: folio that contains hwpoison(s).
> + * @offset: bytes into the folio where subsequent read starts.
> + * @bytes: number of bytes wish to read.
> + *
> + * Return: adjusted total number of bytes starting off @offset that can be

s/off/at/ ?


Apart from that, lgtm

-- 
Cheers,

David
