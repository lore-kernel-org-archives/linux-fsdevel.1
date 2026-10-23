Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792799195;
	b=XFTjLQOazR62ER3YahZkSLfMKWom9gaNX5jA+qkc6cTqS4mIai5WhdKvGtPKlYT24m7I
	 w64LkAyTtad8uDvFhvilAlwDHchLyabp5cWmCYTeDo0ZxKZlzv+jA3KqtstIOMdYAKdaF
	 nWR3YcyVhzifk2hLyNWLSW9t+g9IWqIy8tXpQ7cc8XzB5iNJ2WMq2Lc4skXhiASf+pFMZ
	 ouZ3XeQZb/Iu0F4pKYoic2+onGJaFnJg+llW8ZguWJWnzl59Lw9HLpZooQZY31uQlfe/x
	 lF5k4Tqa0g1AJ9yJiSCD6HtxTJP2doeHWCLFUpIGNwwmIyQPXXiOzIY+v+MLayH+Lhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792799195;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Z3MFuAcLpLiRFPVALwy6pPp9ZRVoXC5ux3y+mWCxeaQ=;
	b=dr2inigMhOUs8HdEtcK32PHOed/OBmZaV3c9TlMzFt0LMdj+jE8V0GUUnZqpMTv427/V
	 /ievr5DrhRVDHXI1+m12jc1NbePOntFbum5mVura5QpVKU1QfOEc+Ve/7s+wfLyLJH52u
	 VPjcP2ed0rYThvSydKEZV7O6siD7i7XQbGsE0viU4oQZlXVVXYKYCZ1hrtrAnTXd1xgZ5
	 T88id+qEuT6OfvMF3VPE+olGxJOjy1WQeiAcAWXV1s4mSvJIBaUI0RzS5P1O6ozSFgbvv
	 jHqKc4beu+hfq3pQIYrWv6/PyAqfpflVyLonUC/XmOfI/a4mGne+syteOdkOkOOjhbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=l8p7PZZa;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=J+Y9OHQA;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D7606A31A;
	Fri, 23 Oct 2026 23:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E13D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=l8p7PZZa;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=J+Y9OHQA
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A975126F7694;
	Sat, 24 Oct 2026 08:46:31 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792799192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3MFuAcLpLiRFPVALwy6pPp9ZRVoXC5ux3y+mWCxeaQ=;
	b=l8p7PZZaYcgritagWMXIiG7qFPfseU9a5wi8JuD+yLynT1ZJjnOxgItq8nv4DYY8Vlo/K1
	CO27k5+3uj9orqFi0Zmpjj+apnfDn8Kl7RFdEDC7aVzD4zn4ARBsFutKXwxo4yXVszuHDs
	27QdnV/j/O+lQIjwWQNpao6KEQxQq4tHWHDrE0rYsVTxqs7+kWK7T0Eb8MXdTJphryGEE3
	eDKNrePFLKZtZK5OL6hOKD3Cu34AXqzvVPv3yL2GDgii3+xwE5mnGz7Zw3eBOx34Bd6tco
	N9/YxY8O8VZoTaPd0hxB8e+SpJCtmsIaOGXyO9yWLxVEnlW83V3+w6ykC8M2BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792799192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3MFuAcLpLiRFPVALwy6pPp9ZRVoXC5ux3y+mWCxeaQ=;
	b=J+Y9OHQAb/rfewPOW2tblDn03501m2y1fB1wrAzfzPKOwoyeFWUpNVdGBxF0rSUeS+trWy
	u3uLWMMLM8FBJ1CQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 2D797E00107;
	Sat, 24 Oct 2026 08:46:31 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 249E722000A7; Sat, 24 Oct 2026 08:46:31 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
In-Reply-To: <atvObRziUKEbNdUK@DESKTOP-PJTTJ93.localdomain>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
	<87se1wj2et.fsf@mail.parknet.co.jp>
	<atvObRziUKEbNdUK@DESKTOP-PJTTJ93.localdomain>
Date: Sat, 24 Oct 2026 08:46:31 +0900
Message-ID: <87ecdgq8tk.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> On Fri, Oct 23, 2026 at 04:34:34PM +0900, OGAWA Hirofumi wrote:
>>Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>>
>>> The current fat_write_failed() implementation calls into
>>> fat_truncate_blocks() without holding truncate_lock. Make it so it is
>>> held exclusive while truncating.
>>>
>>> Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
>>> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
>>> ---
>>>  fs/fat/inode.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>>> index 141276fcf8db..2a16ed415631 100644
>>> --- a/fs/fat/inode.c
>>> +++ b/fs/fat/inode.c
>>> @@ -216,7 +216,9 @@ static void fat_write_failed(struct address_space *mapping, loff_t to)
>>>  
>>>  	if (to > inode->i_size) {
>>>  		truncate_pagecache(inode, inode->i_size);
>>> +		down_write(&MSDOS_I(inode)->truncate_lock);
>>>  		fat_truncate_blocks(inode, inode->i_size);
>>> +		up_write(&MSDOS_I(inode)->truncate_lock);
>>
>>Which race this prevent?
>>
>>Thanks.
>>
> fat_write_failed() can race with the users of fat_aops.bmap(). bmap()
> eventually reaches fat_get_cluster(), which assumes the file's cluster
> chain will not be truncated concurrently. fat_write_failed() currently
> truncates without holding truncate_lock.
>
> For comparison, fat_setattr() correctly holds truncate_lock during
> truncation:
>
> down_write(&MSDOS_I(inode)->truncate_lock);
> truncate_setsize(inode, attr->ia_size);
> fat_truncate_blocks(inode, attr->ia_size);
> up_write(&MSDOS_I(inode)->truncate_lock);

Hm, looks like true.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
