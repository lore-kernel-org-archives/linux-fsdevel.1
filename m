Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062708;
	b=qlHPmSxYIjS22y0ERNxEKtqCEoZ19JQncYN7JXUswkIz4y7cRfGaRRO8J4Aj7PsTCBUE
	 DVqX3zhkcUffW4yAXA9p9fl7xZzBTFfSbtmZJUxsgxSrcmVZFbP7CQCKRIed+vz4EhMqR
	 /C87o+pp0rVpMH9/I86+5VnMFMbN85Cz2I2MQeyPo/2r7CahABzigYFE8g8ty1BkoIXKi
	 xF3NPqNrZ8zDuVInINYBPsYIPBXpT95nFC8i9OKGAJGSXpsXeTYdWfr0KVBOec0dZPLjl
	 ylHC3eIJXKjDZbfoQmScLhRHrmbINfIDkxca6Up+eO29mRHhfcV3JQROV6T/HrguGyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062708;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8aYYl4/sAKbtXT/bP9hKnwyymlW10siHkwx6r/MNifM=;
	b=K+Hm6vreskRrEm4RktXYUadfoHsYtlSvppOSwj3XZFwt59U1iIKXI+PUoHb4SiJfFk6G
	 bvARU/mOoeW7yk7YtBB6AxGTGMBh+nmITKelPiLdHKqDJovGItbSrkQfAkNcMzbuIc2Bl
	 YntIx1KHvQjowUMO4lfGqA+lZaYtl2dsQZsU30CK/VGJTgc27LrlgMAirjvEro9hykWxU
	 LPF9K9PscVANLVeNAJMy8NnXoZHKrIRaelIKwUnVN/e2DfXIkDPiOrobyOxg11glKHQyR
	 4pzRTl6cTK5nSzM6BwSYIv14SO9eMSzOoYRu0yougX1USuqf7dXd7otAGu/adtceHzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Z8TXECTu;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A045606A320;
	Thu, 19 Nov 2026 04:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A045606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Z8TXECTu
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802AE152B;
	Wed, 18 Nov 2026 20:31:43 -0800 (PST)
Received: from [10.163.128.149] (unknown [10.163.128.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDFD93F882;
	Wed, 18 Nov 2026 20:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795062706; bh=YHrUpukgLj5ZrCztymQv02KKeX29nkv1OoVNThLO7sQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Z8TXECTuEqly1FB+zcRKWRfSdyS8ZcWCRYQ2E0o7e82wrQqHlrjV+okOuImKNzcRi
	 lY228bxmY5FCdqnY8YIFb9JZAS44q4TXvKV/TqZsTQGWl0NXzzWbCqLFYFbO6iGCR7
	 beEb/XVbqtiGnYI4R/ABbSLpAxhOp2/52x0W/bwY=
Message-ID: <2750d7ef-57b3-4a4c-bddc-840ab35ef45d@arm.com>
Date: Thu, 19 Nov 2026 10:01:36 +0530
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
From: Dev Jain <dev.jain@arm.com>
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
 <15d75748-9baa-43d9-96e0-0e49c8e27be3@arm.com>
Content-Language: en-US
In-Reply-To: <15d75748-9baa-43d9-96e0-0e49c8e27be3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/11/26 9:41 pm, Dev Jain wrote:
> 
> 
> On 17/11/26 12:46 pm, Shivank Garg wrote:
>> invalidate_remote_inode() lost its last user in commit d73065e60dcc
>> ("afs: Use alternative invalidation to using launder_folio").
>> mapping_clear_release_always() has no callers.
> 
> That was added in b4fa966f03b7401ceacd4ffd7227197afb2b8376.
> 
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>

... with the commit message improved.


> 
> 
>>  include/linux/pagemap.h | 11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>> index 73af18a37367..e681a7ba6642 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -20,12 +20,6 @@ struct folio_batch;
>>  unsigned long invalidate_mapping_pages(struct address_space *mapping,
>>  					pgoff_t start, pgoff_t end);
>>  
>> -static inline void invalidate_remote_inode(struct inode *inode)
>> -{
>> -	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>> -	    S_ISLNK(inode->i_mode))
>> -		invalidate_mapping_pages(inode->i_mapping, 0, -1);
>> -}
>>  int invalidate_inode_pages2(struct address_space *mapping);
>>  int invalidate_inode_pages2_range(struct address_space *mapping,
>>  		pgoff_t start, pgoff_t end);
>> @@ -298,11 +292,6 @@ static inline void mapping_set_release_always(struct address_space *mapping)
>>  	set_bit(AS_RELEASE_ALWAYS, &mapping->flags);
>>  }
>>  
>> -static inline void mapping_clear_release_always(struct address_space *mapping)
>> -{
>> -	clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
>> -}
>> -
>>  static inline bool mapping_stable_writes(const struct address_space *mapping)
>>  {
>>  	return test_bit(AS_STABLE_WRITES, &mapping->flags);
>>
> 

