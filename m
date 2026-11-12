Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457614;
	b=LcJhYGjWJGD69Seve9L0Xw/QY7s0cs1dOvqEgMJlPcLaXm8gKXvpchuK6FS0e8z0crB5
	 MPjccrPFdPMUp0eGzeoGXWXcPZWbv4pbYp+LMEAucuoe7C6v/OXfL10+0WUFVIlbhz08X
	 uuQVhogL3es4eBjLkWuFd0llzrgWtyoI6dxHKwaFdLJWZlJ3EkTrg77NbaOjFRuw7lzDQ
	 XO2G1jHA6VKsSBripadiwdEq1G2qFUc5OMezEWcvRkqjJCRGjMC9XjjGDQfKBrlKAiuJ9
	 PUFwgRQFePryqnf2tv6CMvUIgbS0EMJfZ4dQbW/9/HLk2DvUPK06vaEt//a35b5I6NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457614;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=o16nXbhGdI38NCz7kOzBXJZ5FkGZMWTru7Q24mnBhwI=;
	b=nraOHL/sr86lFHmB0fbm1Tp2vtzXRxGxP9FkUNe3AJycHIzjn1fs4xvQiBsv0zOOh4Xe
	 Q2orIArXQgeLdoRk2rSjccx/4HGgQQS8le8h2GOFtgtbwEdREcmncWnOtK75ifdnW0Yv/
	 5BaRql+GHKqtdo9RlHEIkOvnTLiOp8x08JyOHxSv13OfxRb0SienSFVKJUbRt6NWNX8Cc
	 kSKfjgV6kDkTLkIul/6KQFM40p8mCpfkhmc+UK1PchNl5NNZUsnK/AhBCbpmZQpcRCj1z
	 s0ClLQf2DviegUX5cBAZPy5NoUJhGDmutcEoaLkbKpNexmVrnvUZ/Vba5EHIELqRZwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=WDsKcABb;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4C606A321;
	Thu, 12 Nov 2026 04:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E4C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=WDsKcABb
Received: from DESKTOP-PJTTJ93.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 6138C12110C;
	Thu, 12 Nov 2026 01:26:50 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794457610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o16nXbhGdI38NCz7kOzBXJZ5FkGZMWTru7Q24mnBhwI=;
	b=WDsKcABbFgleyajAD6gyO8RY/kTGzL2BlrUgxBbqEIq6TLP0eoYrC0E5X1ZbEOBO7Pdwsf
	XrfmxZQ/q+qeCvSjL0B7ijfPCYoAbW+P1iThiLWRAtfiPvlJLPCdTq7w5U3uj3c4debVhY
	dbuJ4kNZrps6ZTVxnkZhb4ErfWthlrcM+zcUKGPF7qrPwFx1B8Mn0dKFnkcMV4RBcxOCGv
	9GG88n+CLwd3FNEogn+mn96CJ8B9fyjSscoJ5yNSC+295LmZ37ojCt6kaXdLAtMrsafRtR
	PPOQ3ddFSe5Juf0PHtnAYmg3U1zZ/0ek+hlIMMfmTMVT3+5Be2MLiW5zZX9GYw==
Date: Thu, 12 Nov 2026 01:26:43 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/8] fat: drop ->write_begin() and ->write_end()
 usage from fat_cont_expand()
Message-ID: <avU_DoFlFP9s6OeF@DESKTOP-PJTTJ93.localdomain>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
 <20261031164326.278125-6-matheus.aalmeida@inf.ufrgs.br>
 <87eccvtllo.fsf@mail.parknet.co.jp>
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
In-Reply-To: <87eccvtllo.fsf@mail.parknet.co.jp>

On Sun, Nov 08, 2026 at 11:59:47PM +0900, OGAWA Hirofumi wrote:
>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>
>> fat_cont_expand() currently relies on ->write_begin() and ->write_end()
>> to zero the new file range. These callbacks will no longer be available
>> after the iomap conversion, so a new method for zeroing is needed.
>>
>> Zero new ranges folio-by-folio instead.
>>
>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>> ---
>>  fs/fat/file.c | 122 +++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 76 insertions(+), 46 deletions(-)
>>
>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>> index 177a26186ddc..8689cbbdad13 100644
>> --- a/fs/fat/file.c
>> +++ b/fs/fat/file.c
>> @@ -18,6 +18,8 @@
>>  #include <linux/security.h>
>>  #include <linux/falloc.h>
>>  #include <linux/fileattr.h>
>> +#include <linux/rmap.h>
>> +#include <linux/writeback.h>
>>  #include "fat.h"
>>  
>>  static long fat_fallocate(struct file *file, int mode,
>> @@ -353,68 +355,96 @@ static int fat_preallocate(struct inode *inode, loff_t new_size)
>>  	return fat_add_clusters(inode, nr_cluster);
>>  }
>>  
>> -static int fat_cont_expand_simple(struct inode *inode, loff_t size)
>> +static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
>>  {
>> +	struct msdos_inode_info *mi = MSDOS_I(inode);
>>  	struct address_space *mapping = inode->i_mapping;
>> -	const struct address_space_operations *aops = mapping->a_ops;
>> +	loff_t pos = i_size_read(inode), fpos, next;
>> +	loff_t old_size = pos;
>>  	struct folio *folio;
>> -	void *fsdata = NULL;
>> -	int err;
>> +	size_t from, to;
>> +	pgoff_t index;
>>  
>> -	err = aops->write_begin(NULL, mapping, size, 0, &folio, &fsdata);
>> -	if (err)
>> -		goto out;
>> +	while (pos < new_size) {
>> +		index = pos >> PAGE_SHIFT;
>>  
>> -	err = aops->write_end(NULL, mapping, size, 0, 0, folio, fsdata);
>> +		folio = read_mapping_folio(mapping, index, NULL);
>
>Hm, is this reading blocks from the device for zeroing blocks even if
>page is completely unwritten block? If so, we would not want to read
>from the device.
>

It doesn't read from the device when the start of the folio is >=i_size.
However, looking at it again I realized that I am needlessly zeroing the
folios twice. I'll have to change this for the v2.

>> +		if (IS_ERR(folio))
>> +			return PTR_ERR(folio);
>>  
>> -out:
>> -	return err;
>> +		folio_lock(folio);
>> +		if (folio->mapping != mapping) {
>> +			folio_unlock(folio);
>> +			folio_put(folio);
>> +			continue;
>> +		}
>> +		folio_wait_stable(folio);

Thanks,
Matheus
