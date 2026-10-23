Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770249;
	b=mTFgXiyZM/zEP5/zURa4I3nMX1OSxCKCj8y0TyVHH5xtPVKuVyivAS3Q1x5rBXpRO82/
	 HcpskuIi2QXNzTsnw2A8uiFsVyNCh9IxUZ1mI3I/py+1A72JWQ8Yme9Q54/FvokHJ8elU
	 XyhsPzbbNFdnWulyeFjdUVhnY5A8Bs+Iz35P8y5p3e73Zi+aJm78cQ7J91bzHAC7JculZ
	 kveRicSbustzXBVsSkQtbR+/KdPPSq47H+dkroTZL9S/um+0ms6YJcCCjKQO5wxlZ2YkT
	 fdDIyCIy4PXOnGbz3v+KAIEfDFj5Q+S0XeJgSToZztU3aWkl2vM7t+I3FLSA6L3rVxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770249;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rjUCtJIciQo5ho3Ui9ESxf094IT1YDCnkt3qhuw9aiE=;
	b=gjiH+XAY2TSpEKq7++HoyG04sDB1KeFV+HeCko5lZc2tSfqvZEA+EvH16O6cizdIlbGM
	 lH+SaDq3dCsV1fUTQu7hO9RMVc+W8hFTUuKZxa0I2+OC2HbLgP1fab0pNBvSetupl9fN+
	 eKgwc0PhsUaOM/nNuy3eWbz5Musj+THH8ym6hV/r0dAZLDuiXVKcRMosNbdqiajA1WGnl
	 6ynn1q6vDfEoyaU46k2xOloIS8bwhH+cXGYwM+18QPif41dHI0GinNK8Frf+FqCZXUXp0
	 lqv+AjGbodL/eBmtXbAEPkUZYgPjoeNXphuaPbmlJRKeYEtz65ze/CzNNtqIiGNqJ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=vOzaNoRz;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=SAP4HN9N;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A6606A321;
	Fri, 23 Oct 2026 15:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA9A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=vOzaNoRz;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=SAP4HN9N
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B0F2B26F765F;
	Sat, 24 Oct 2026 00:44:05 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792770246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjUCtJIciQo5ho3Ui9ESxf094IT1YDCnkt3qhuw9aiE=;
	b=vOzaNoRzZo7uZ1GSiuZSIh0j85HbaZEYuiBYhi4QN6q/kmmRGVYe0QghsOSt/oYQ/i5H+Y
	+MMcsMMKrZ+9vaX5L5UrNPij2Xf3tFbUKOjnAcZ3c8AwiGMV0fiza58QKL1AYBUcEVvYNq
	wpBTD7DrVeQiTAL0YwCYyQzzY/tA03sxZFJk3nFMKaz0P2S338Ag/MX/Atnn8sNKXm9ZBl
	qhA2+P1cok8xRwFrU5r5A28OiChZA6hTYQpwKxGIZQSdnG5GPfSwag6iMyz5Hl5oprnj6K
	+gZy15TonTEMi25Z1Xccr7cAvCLahPLJV3KWYDVQhsjKdrkCcdhGjeKjU9IBRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792770246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjUCtJIciQo5ho3Ui9ESxf094IT1YDCnkt3qhuw9aiE=;
	b=SAP4HN9N/INquwHixuBNZ7oJxx7EuireA65RWgoudhMgpEUtjgM7ulu9VGO5fNbtS9mp+V
	w4eFfSzynLZFRkCA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 0B4DCE001BF;
	Sat, 24 Oct 2026 00:44:05 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 02556220017B; Sat, 24 Oct 2026 00:44:04 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fat: preallocate space before expanding in
 fat_cont_expand()
In-Reply-To: <87wlr8j2gs.fsf@mail.parknet.co.jp>
References: <20261021154024.56868-1-matheus.aalmeida@inf.ufrgs.br>
	<87wlr8j2gs.fsf@mail.parknet.co.jp>
Date: Sat, 24 Oct 2026 00:44:04 +0900
Message-ID: <87ld7oqv5n.fsf@mail.parknet.co.jp>
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

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

>>  static int fat_cont_expand(struct inode *inode, loff_t size)
>>  {
>>  	struct address_space *mapping = inode->i_mapping;
>>  	loff_t start = inode->i_size, count = size - inode->i_size;
>>  	int err;
>>  
>> -	err = generic_cont_expand_simple(inode, size);
>> +	/*
>> +	 * Preallocating space here is more efficient than during
>> +	 * generic_cont_expand_simple() because of batching.
>> +	 */
>> +	err = inode_newsize_ok(inode, size);
>>  	if (err)
>>  		goto out;
>> +	err = fat_preallocate(inode, size);
>> +	if (err)
>> +		goto out;
>> +	err = generic_cont_expand_simple(inode, size);
>> +	if (err) {
>> +		down_write(&MSDOS_I(inode)->truncate_lock);
>> +		fat_truncate_blocks(inode, inode->i_size);
>> +		up_write(&MSDOS_I(inode)->truncate_lock);
>
> Is this fat_truncate_blocks() really required?
>
>> +		goto out;
>> +	}

And maybe this will change the user visible behavior for ENOSPC. (I'm
not sure if it is ok for now)

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
