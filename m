Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018324;
	b=VYGdM4iHmdqtu92KRcCuv7MozU9QdaCiHDo3MuPBO0rP5ATeYICnMk+1W2xT4VrGoCv1
	 7v1lnWti6wB/tySVGQSw5wv2ytrQO8V21bQXM1f4/qJ/+osFRxMF/H3K9S0RIpQIvlbgM
	 9NRw94LjVyC0AHfxnqnRVG8XFKKta9S/2l3HEwdohlZ0Lx+FgxFE5bjKhAIKdU2ZbsTyU
	 iCqKWHGqm2CyENmGLuZ6aTDOb8bnV9cZXQ6Hhrsfw3YBoejeHEZt+hdmICBLdrcOwDvpW
	 oeMNtVgWXvt6GnGNr9yEnpogAH/yj1v4K82IGh+rapGLiNTeYrOdowKM3fkUUKJ9Ihg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018324;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LtOK71mgWL1hJ57ziMdV5/lpR6OIlsIMpvQ29Ztn9ic=;
	b=c/xkB9Zg0HJsHpj9FCvHfuH60BzxKzIf6vfKy43/o/yHaON5wXLJNbNg7Yv2OSpIMj+K
	 bEeP+uwLpZPt5+47D8BDss5MiHuGwYweZoLUZv+JZ2uY0+HSnJlWFYOrTaHsS7sAlsRUD
	 x9AKzADxcpE3QIDNQHz/YmZUtrql30yY5U9g9dJIWj9Qg5sOL/y+BucwYNlhME//hWwmi
	 74FzOGcZeDUGiKQ97tqvlBsxqKXimeqCVnMPT2AJ/jvY7wfVYZQVc/T8/Z2SF3Wh7YHTr
	 RBZ/47hrWUMvf1m8hu2/9ZoTfEaootgcwYhfB4L0c9AoMKiTJ/bCXwH7M7yyJuXo18A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YbCqZfuq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF251606A31C;
	Wed, 18 Nov 2026 16:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF251606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YbCqZfuq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C574C339;
	Wed, 18 Nov 2026 08:11:59 -0800 (PST)
Received: from [10.163.128.4] (unknown [10.163.128.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35E633F673;
	Wed, 18 Nov 2026 08:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795018322; bh=aYQ0HCEYlkn9BeS1THLapsztaFWJtc0g6BUkMATS0GA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YbCqZfuq9vsdroMTMmDXNL46nZtVMm9VNmLHTjEGcy2irM8ufBsCnBnRV/fVYl15N
	 4A8TlkUJeyswfIKtt74NSDt5rlzv/pIYVVWT98EMm8puIWg5sekv6yzmy/+A0dD3h+
	 1UzoLtCEDx4y9eRTDQ8enHNrj8UvtuZ9G8ANdCuc=
Message-ID: <15d75748-9baa-43d9-96e0-0e49c8e27be3@arm.com>
Date: Wed, 18 Nov 2026 21:41:52 +0530
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 1/5] mm: remove unused helpers from pagemap.h
To: Shivank Garg <shivankg@amd.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
 <20261117-unused-sym-mm-v2-1-2f845e94dd50@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261117-unused-sym-mm-v2-1-2f845e94dd50@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/11/26 12:46 pm, Shivank Garg wrote:
> invalidate_remote_inode() lost its last user in commit d73065e60dcc
> ("afs: Use alternative invalidation to using launder_folio").
> mapping_clear_release_always() has no callers.

That was added in b4fa966f03b7401ceacd4ffd7227197afb2b8376.

> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  include/linux/pagemap.h | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 73af18a37367..e681a7ba6642 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -20,12 +20,6 @@ struct folio_batch;
>  unsigned long invalidate_mapping_pages(struct address_space *mapping,
>  					pgoff_t start, pgoff_t end);
>  
> -static inline void invalidate_remote_inode(struct inode *inode)
> -{
> -	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> -	    S_ISLNK(inode->i_mode))
> -		invalidate_mapping_pages(inode->i_mapping, 0, -1);
> -}
>  int invalidate_inode_pages2(struct address_space *mapping);
>  int invalidate_inode_pages2_range(struct address_space *mapping,
>  		pgoff_t start, pgoff_t end);
> @@ -298,11 +292,6 @@ static inline void mapping_set_release_always(struct address_space *mapping)
>  	set_bit(AS_RELEASE_ALWAYS, &mapping->flags);
>  }
>  
> -static inline void mapping_clear_release_always(struct address_space *mapping)
> -{
> -	clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
> -}
> -
>  static inline bool mapping_stable_writes(const struct address_space *mapping)
>  {
>  	return test_bit(AS_STABLE_WRITES, &mapping->flags);
> 

