Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B033655E0
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794169; cv=none; b=ABMClbiPSh3HcXIt3KcmqxIM0AjhE1lc6mPwpsxxZdhx8aORh/hpyDc4lwBHPpzwOpPeTv3VzoD4zIuHELuhYaVwgwWSbrmMu/FuKSmoVs17+Nr7i9xfwbFK7v/xDSF8QL0sO2LH8BuFd7rFPcd4Hd4lpqY1/tGG8ZL8mc0buJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794169; c=relaxed/simple;
	bh=971moIbuxQGrNg8shhjzaiFX0Rig1XFMJuAVYBXJXiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/bEh1NWomBBfgREZPQGgn2X2v8dvgmhlDdokkALN9plGfI6Z+yIpk7hFhGfOENqw9xxQeH9UtNLQXKtJ6kaLh68JHNgAjnq4Le2u/i2fJxtJ8T7NwxrGa2P/99Cp35pmvgxuXE/4zvNN8phhNNVSrWyNGk6zystGfg3vVtfE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fshBdm2A; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=rBCVruTt; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fshBdm2A";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="rBCVruTt"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687EZk803644775
	for <linux-fsdevel@vger.kernel.org>; Mon, 7 Sep 2026 11:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=c+TK
	bdK1agZJdxZqMsqMSFeIuL9KGJPEvEVEBL9qQ68=; b=fshBdm2AsgaCLXYLc3bm
	2lLQ43myR8qGRU8WGd/tVljomA6uUhMgO5t2sYWUW/b+a/gA+ofM3AhtgSx3N/Wi
	x1OrlJ3Aess6ZgeJ/E82KtJcEzDxakkkiZJEwE2MI+aC/AId514g8LKaUkYx5REt
	bVN+wDkOnv3yDNeyKR05T+aQpVh3UF/q6dkF4tz7AqASeNMsDzn9HsBJw+Z1U0h3
	NzAjIdxctvTph+1/h/0F/H8Q6BlVs8tQqB1m32zgHkhxMSGNdiYDCS7ewfldhzOE
	sOBwO67thb9h4a3Ic+ZR4pmh5ryGxkV6ZbsCkRUSPF99IGubhN6Yghy09ZgrsFW2
	bw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ghfabbvq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 11:16:06 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939694871aaso585589885a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788794165; x=1789398965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+TKbdK1agZJdxZqMsqMSFeIuL9KGJPEvEVEBL9qQ68=;
        b=rBCVruTtX7jtaxxFZPLzOsmnL1cKhq2enBnOgKSElDkUoix1avW1o+6POpnUQOc8Ix
         smBzE45W0nlIWrUth0Xv3xB+ioADfPkk3+2kpNaA/7y/Rr2m6MZxzyyb1m4yIRE6tEbm
         v8M6vLSU/uXWNlfenUVhQPkY8neQk2FnZC2TDUSY1jOjhzKGeB90fm6IoVUJOpVJHoP1
         tsELWHu3VdnXBxlbc0x6JU3ihb/bWGP1p2JG3fcbwq77/fcpU3fvdyIXUX2fstVv+nwj
         dV/BXCa5kSS4Lqkx4XzzfbBXHA7JsqvPESi31A7xocKWxRTJMXJgEFrofWrG/zC/pSNV
         XT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794165; x=1789398965;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+TKbdK1agZJdxZqMsqMSFeIuL9KGJPEvEVEBL9qQ68=;
        b=V+Lm73e1E8bU5ey9TXjXv8EwQqUooycPABuxymoxn8mkXRjuGDNasJddcyewBve6zI
         c+d3kfkYzgBlzL77zPVurrU1cBp6WJk40HqlNAo6ysbC8mbhcESh/OloF4h9zJXs5ofK
         htOFiac3hPs0tvi7bzIWboG0VUWV+aVWZ7d3MyWI+33fDVQvz60oR97FwtmnFHaWY6pb
         GTW8s28xn1BQfRcGbh3YuSf4QaOufJqj0aM2Y71lx5iE0bUANe8m6Sb7Nre8SU3FbPg3
         naHVphJp0SvpIT2YTWQo2axjnmebDaYwHzhC3HJwHqYFVURhHVxL6PcWESRtXotoJl+Y
         RTfg==
X-Forwarded-Encrypted: i=1; AKwUvBx7O50R5KHN+zMoU5ePLQNUV4s5dXBC1oPNGTVOzadY6snWB05j9CbJ6QKmSyN5FouW39tCXcVhgqG75cKU@vger.kernel.org
X-Gm-Message-State: AFuF++kQICY/MQz7UhjV/bXk1HnlcefclFcAg/D58QqZ4URcwPJsJmnB
	39YlVo2AoTsbRjx+ozZhTApJuKacKLvzIYgz2eWC3YAz7uGTHuyPlsXdoNpzXkyA714OnmgJ+oh
	4grMfG8cY8L3t3e/JtW/4OVd2PO25wLouabUzta8D4xPAFn3R4hUQ+BxRcf1tPqo=
X-Gm-Gg: AYBFou1hqlkeP+9PGLmQNK5+GTsi5REeXrS6T0mJ0xzWX7lwa2fJS3s9045kfdrKdfq
	FTzqKcEv+Y7xNwm+2Co0vcnMlWjEuUny7LZNl5cZxqHH1i0tsjyIyw5540W+SudUzWHAwakDWxj
	0gM2nIs/lSwJRvfoB5NpbSpB6RMvpFDmzf/EOowCsnUP2HNdTHaSmbiM15Wtv1OAefPI0pb6Gvj
	PXU3rJAUpM5EMjndzFrHhx7ZuSMg0uSzcRDDQO4Bu5WXrBoEusJuDWspQvcTk9NOfXmq2sZFL+K
	mvlqZX90bjpHr0VILdg0Q/br0UdQXDD22F22nWpTAqhVGgeEKhyHRipcmhUjd8AxjxM+5deHxRo
	MkiOxqKoba2fiU2z082g2p24VUM473oZBEZledQPmQZTPmm1+GQ==
X-Received: by 2002:a05:620a:2903:b0:939:13a7:70f0 with SMTP id af79cd13be357-939802f7939mr2480344585a.5.1788794165070;
        Mon, 07 Sep 2026 08:16:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2903:b0:939:13a7:70f0 with SMTP id af79cd13be357-939802f7939mr2480332385a.5.1788794164195;
        Mon, 07 Sep 2026 08:16:04 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe31c6sm913141485a.46.2026.09.07.08.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 08:16:03 -0700 (PDT)
Message-ID: <3b01d1c8-c207-48c1-8700-0e7b350aecf5@columbia.edu>
Date: Mon, 7 Sep 2026 11:16:02 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] isofs: convert the zisofs read path to use folios
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260906-isofs-zisofs-folio-v1-1-cbea614a773f@columbia.edu>
 <4cnybzi6btbswplm6xeuamkxf7k7a7hlvw5oa4urst6tltbw4x@77nu26jpv5oq>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <4cnybzi6btbswplm6xeuamkxf7k7a7hlvw5oa4urst6tltbw4x@77nu26jpv5oq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2OSBTYWx0ZWRfX3FfLtSk9OHJ8
 03bcl7WUBNj1BZfNEIuLIeQTL4yjyWcv+lyeGMqZKWhup0EXjAQ25Vpr+S7Ijd6HF6N+Q3fFaRe
 XVhdQp+4CPndOJRjg+5zOaZAfbZPbXv+rI3koKeF6/O/0uNyBjdqaeVYrXbl2sL6cKO0UTeneLq
 Um6nGCU4nh7EITJ1qG3gpYl12eY+I9CBLPioiR5oOPrelui7t//widrUfpJWXVlCqLgnWT9lKkW
 NJSHEWHDoYjTkv3lHiDu3sT9nZSJGavkf1X1t3xtBWDGNdu4Qv/8MAsFb0B0voGUdi6XI0iIZ1t
 S9M0Hu2zNctOSC+/VXZKIraeminRYUbSXrhe8hMC2EEWL8lzwekpiLvN5lHSe/PoB/PvpMt8zwb
 X3+KONaMgP8QU8gVvFPekPkk2uk4DM6FFKupp0LRx1nQcTZaYyrjic4eIal1LnvQUOkF1+Rwkvt
 95QFtLxbdjbF59JAomQ==
X-Proofpoint-ORIG-GUID: IYdWOr4KnXhPhwHaaXEwUl0g6VQRl1uK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2OSBTYWx0ZWRfX4hTQMuaIc72e
 7g3+KQ2oKklk1oAYIBKQKfnFWpfSwUSPjMeQNTskvxtey+T8WmG41U5xSGBaMOoKwU+1lI6dNFH
 /3UhmHD9JGIVwXNBWnDS+otD/qajXV7M63hDccE9rH1SkVRjbW1t
X-Proofpoint-GUID: IYdWOr4KnXhPhwHaaXEwUl0g6VQRl1uK
X-Authority-Analysis: v=2.4 cv=GMw41ONK c=1 sm=1 tr=0 ts=6a9ed536 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=iox4zFpeAAAA:8 a=pwd4NrRpc-W-YhxAJzsA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11899
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=10
 clxscore=1015 bulkscore=10 impostorscore=10 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070169

On 9/7/26 12:34 PM, Jan Kara wrote:
> On Sun 06-09-26 22:14:59, Tal Zussman wrote:
>> Store folios in the array that zisofs_read_folio() passes to
>> zisofs_fill_pages() and zisofs_uncompress_block(), use the folio APIs on
>> them, and grab the folios with __filemap_get_folio() instead of
>> grab_cache_page_nowait(). This removes six compound_head() calls, from
>> page_offset(), the three SetPageUptodate() calls, unlock_page() and
>> put_page(), and the last struct page usage in isofs.
>> 
>> grab_cache_page_nowait() passed FGP_NOFS as well, but FGP_NOWAIT already
>> prevents reclaim entirely, so leave it out, as FGP_NOFS is on its way
>> out [1].
>> 
>> Change poffset to be unsigned int rather than just unsigned while at
>> it.
>> 
>> [1] https://lore.kernel.org/linux-mm/20260830041901.2668-9-willy@infradead.org/
>> 
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> Thanks for the conversion! The patch looks mostly good, some smaller
> comments below:
> 

Thanks! Will adjust all of these and send v2.

>> @@ -66,11 +66,12 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>>  	if (block_size == 0) {
>>  		for ( i = 0 ; i < pcount ; i++ ) {
>>  			unsigned int off = i ? 0 : poffset;
>> +			struct folio *folio = folios[i];
>>  
>> -			if (!pages[i])
>> +			if (!folio)
>>  				continue;
>> -			memzero_page(pages[i], off, PAGE_SIZE - off);
>> -			SetPageUptodate(pages[i]);
>> +			folio_zero_range(folio, off, PAGE_SIZE - off);
> 						     ^^ perhaps
> "folio_size(folio) - off" here?
> 
>> +			folio_mark_uptodate(folio);
>>  		}
>>  		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
>>  	}
> ...
>> @@ -119,9 +120,11 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>>  
>>  	while (curpage < pcount && curbh < haveblocks &&
>>  	       zerr != Z_STREAM_END) {
>> +		struct folio *folio = folios[curpage];
>> +
>>  		if (!stream.avail_out) {
>> -			if (pages[curpage]) {
>> -				stream.next_out = kmap_local_page(pages[curpage])
>> +			if (folio) {
>> +				stream.next_out = kmap_local_folio(folio, 0)
>>  						+ poffset;
> 						  ^^^ this is just:
> 					kmap_local_folio(folio, poffset);
> 
>>  				stream.avail_out = PAGE_SIZE - poffset;
> 
> And this would be probably more idiomatic as "folio_size(folio) - poffset"
> after the conversion.
> 
> ...
>> @@ -289,9 +292,11 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
>>  		cstart_block++;
>>  	}
>>  
>> -	if (poffset && *pages) {
>> -		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
>> -		SetPageUptodate(*pages);
>> +	if (poffset && *folios) {
>> +		struct folio *folio = *folios;
>> +
>> +		folio_zero_range(folio, poffset, PAGE_SIZE - poffset);
> 						 ^^^ again
> folio_size(folio) here?
> 
>> +		folio_mark_uptodate(folio);
>>  	}
>>  	brelse(bh);
>>  	return 0;
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

