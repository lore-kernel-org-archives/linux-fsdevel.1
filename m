Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456599;
	b=we/+TbesmS5vasSrdxLbcKoH3ejlJQn7mW3rH+Izwe4/4rsUa2rfG3Lrr/SRbVUHINsW
	 eHRxsvl0QN+nDB9Ii5fepbkYW9qXHRlCQ5titvrbxixfcCzLRWuvHkbEzi9O8wF7ivZFa
	 JiiXQwvGegEyie2Z8qhkMpfaBawOp3/mujOGrcYc5em0VaDoXn6u7upy1YCGMQhbLAcgS
	 a3Q1gWcvk5IZfrPIGi8BQ13avhql23qqKHZUbB8RZ0fuHySjrfiFu3hM8PTYqoB8geX/+
	 va14Z2t+C/q51P1LDYB25Xpv1zLwdSceT4sgWVsUAuj6HVFTWk5MFe4Ud77rmx/STEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456599;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hMPF3ZU2VriMPfR+JRpvYYp1KVjv+Kz7L/UjnD7aATE=;
	b=XHVo2sghjCfDn+szlvc9qWHKDpm2I3L/2rC2LGu1jmogeKloT0d8owJcoZ1S89ha1W1W
	 Nn8KAxYxhK8rcX+7LIPx9RmHRyguaRs2VbUeAR3z/9HohgYiqSC4zZcGlOA13GVWmid6T
	 ysXaIW0APVRN1s8BchBvlmDSG84K2KK3TYdbe4lCkdADd2xBx9zHs1+lVUZiFMUVXT2Dw
	 v/+4a9iwWw0qHof1PY/w1vNwbNFiwUXCReoCiBFsLodVahVgR/zsnvQYIYz/tEs4XoyjN
	 jPN5BdxfTsaP8F+31gazGa+32QjQ/TwdQeguY82rgFmELcZp/LHKJOeFoDQLekVFz7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=K2iOREdI;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AC606A31C;
	Thu, 12 Nov 2026 04:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 386AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=K2iOREdI
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 448B0121113;
	Thu, 12 Nov 2026 01:09:46 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794456588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hMPF3ZU2VriMPfR+JRpvYYp1KVjv+Kz7L/UjnD7aATE=;
	b=K2iOREdIkPpQGXtGkeeQ5wnq2mknumCielaUAVeMwBZKuPkDFvqyLbuUmwzgfqdccu/Now
	X97PsKA6L+cyc85kW0ETdBbRGhIzZVH3KU9HLQunt5ShNKwrQyFnZ2XzqxTsUNAUKUJ2m8
	oG3/6FWWgzAQCOcnsBjCd5+m3XuxXhT4q/XDOpkV3aKSqnGOT82QjvSSkNZ/OkBzipsL9D
	ZyxP6i0vTYEQjfXi3+29I8TvwUQy3ZtOKOsdERbQCX7bB00YGjEZesTd4rIpb9sOFdvGZn
	+5ymDUOjsPJPfvV44E4CbVl0CvezSZhH7EKcZonlDHih6n+R+KxMqm9oLDWpKA==
Date: Thu, 12 Nov 2026 01:09:42 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] fat: support FIEMAP
Message-ID: <avU3IRmswObU2pH6@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
 <20261031164326.278125-2-matheus.aalmeida@inf.ufrgs.br>
 <87tslrtlyu.fsf@mail.parknet.co.jp>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tslrtlyu.fsf@mail.parknet.co.jp>

On Sun, Nov 08, 2026 at 11:51:53PM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>> Implement support for ->fiemap() using iomap_fiemap(). Add a read-only
>> fat_iomap_begin() and a fat_get_cont_clusters() helper for finding
>> contiguous clusters.
>
>Not fully reviewed and I'm not understanding iomap fully though.
>
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>> ---
>>  fs/fat/Kconfig  |  1 +
>>  fs/fat/Makefile |  2 +-
>>  fs/fat/cache.c  | 80 ++++++++++++++++++++++++++++++++++++++-----------
>>  fs/fat/fat.h    |  5 ++++
>>  fs/fat/file.c   | 12 ++++++++
>>  fs/fat/iomap.c  | 71 +++++++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 152 insertions(+), 19 deletions(-)
>>  create mode 100644 fs/fat/iomap.c
>>
>
>[...]
>
>> diff --git a/fs/fat/cache.c b/fs/fat/cache.c
>> index 1b87354e24ba..f545e1db1d47 100644
>> --- a/fs/fat/cache.c
>> +++ b/fs/fat/cache.c
>> @@ -76,7 +76,7 @@ static int fat_cache_lookup(struct inode *inode, int fclus,
>>  			    struct fat_cache_id *cid,
>>  			    int *cached_fclus, int *cached_dclus)
>>  {
>> -	static struct fat_cache nohit = { .fcluster = 0, };
>> +	static struct fat_cache nohit = { .fcluster = -1, };
>
>Maybe this change is pointless?
>

It is needed for the cache_init() change, as otherwise it would not find
an entry at cluster 0. See below for the rationale as to why I was trying
to do it.

>>  	struct fat_cache *hit = &nohit, *p;
>>  	int offset = -1;
>> @@ -217,14 +217,16 @@ static inline void cache_init(struct fat_cache_id *cid, int fclus, int dclus)
>>  	cid->nr_contig = 0;
>>  }
>>  
>> -int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
>> +static int __fat_get_cluster(struct inode *inode, int cluster, int *fclus,
>> +			     int *dclus, int *nr_cont)
>>  {
>>  	struct super_block *sb = inode->i_sb;
>>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>>  	const int limit = sb->s_maxbytes >> sbi->cluster_bits;
>>  	struct fat_entry fatent;
>>  	struct fat_cache_id cid;
>
>[...]
>
>>  
>>  	if (fat_cache_lookup(inode, cluster, &cid, fclus, dclus) < 0) {
>> -		/*
>> -		 * dummy, always not contiguous
>> -		 * This is reinitialized by cache_init(), later.
>> -		 */
>> -		cache_init(&cid, -1, -1);
>> +		/* Cache the contiguous prefix from the known first cluster. */
>> +		cache_init(&cid, 0, *dclus);
>
>Doesn't this add a needless cache? 0 is cached in the inode itself,
>isn't it? (and can be waste small fatent cache slots?)
>

This is mostly for caching the number of contiguous clusters starting
from 0. i_start only really tells us the first cluster of the file. I'm
not exactly sure of the best way to approach this, though. I guess we
can skip caching when its a one cluster range in this case?

What do you think?

>>  	}
>>  
>> +	fcluster = *fclus;
>> +	dcluster = *dclus;
>>  	fatent_init(&fatent);
>> -	while (*fclus < cluster) {
>> +	while (fcluster < last) {
>> +		if (nr_cont && fcluster == cluster && cid.fcluster != -1) {
>
>cid.fcluster == -1 is possible with this patch?
>

Good catch.

>> +			fcluster = min(last, cid.fcluster + cid.nr_contig);
>> +			dcluster = cid.dcluster + fcluster - cid.fcluster;
>> +			if (fcluster == last)
>> +				break;
>> +		}
>> +

Thanks,
Matheus
