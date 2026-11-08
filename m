Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149990;
	b=Xr3RbloGwR1P+ELupFQDLcIEi4wTwc0saGw3YEAlmWzHrFzpIYYwxTYqNdS0AS6bS1Sz
	 YHcDuMVZcCSysNpGHX/iy8zXl8M66fC6RfiTmew5JXak1/QbMlyAoMFwXQha1WXWhaP1S
	 HrOPdNzqEHoh+CXPqzZryUO8OKeo0tL/hdoq6DU7+iYZBdHd3M+OyW4Cf/UmM7hlxSYpv
	 ICAmjtKoLofCLgSbrqGlibOoKYT1UMccsnGdtxy6QQMLd74bTmeJfXrBlenhIgxXzry8u
	 S148Ko2brLBGeDwrMwAqdg2HTVRnscKKisfLd0/YKZCXnZLeYY1Y2mD+K15PqXEztOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149990;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=SXQNJ+p122gnLyH8yrLKt31093LHuXH9zkA5Ta6zR7M=;
	b=u/HLpGc+EyNAhRDhROadkKtto+y4RHU9VrkEuSFI0opX/6E01DqsV4clohErCLRIVNVN
	 ZNWcnZadEuMCSnZYGbZN7Xfy7qBFvVorvbWYuqiTEmB9rfa4Xv1VjHhgfy0cS9uDoZ3g/
	 ADuBrO/SMjP97xSww/UJdlFnZyBrux3qIBebdvwFdMtR0OqKPOFZkYicOXz9B2DU0DvnS
	 MaBgJdd4uJFTS1awx549NW0d+MspEV2V+KoQF2rPTPIidQrRN6LuVGncXZD6/O95pKOhz
	 EFDLrD7WyyDZ54qY4yJE4438aCs/KWGA0bhrE5+vsGObpXD4UUUJ8ZOuIEVyNren/Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=Kb8AUN2l;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b="Z2/s6RIX";
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBC606A334;
	Sun,  8 Nov 2026 14:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90CBC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=Kb8AUN2l;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=Z2/s6RIX
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id EDEF820BD288;
	Sun,  8 Nov 2026 23:59:47 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1794149987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXQNJ+p122gnLyH8yrLKt31093LHuXH9zkA5Ta6zR7M=;
	b=Kb8AUN2ljtNBD3KjhDkK/QWb6xDCPf8tF0dCEkNfwnPUaV9ixZXoTUt3b3fOvK91YIllaZ
	H1qC4XMYDPpOS7FkKiS5oE+bF/3qdin6qCW91HucovPc4ds0VVkde+Zq8kkGw3VtBXxbHO
	zM7So2dEK4wD0iJAi/X13VhKkMnChoRDgj1QzAHi/DMz81R4yaCkRDDZqF8GDL/CxKtl1/
	KmaRVBCiQzPRVvu9RUjBqd5GPjs4XRlOPMUmIxww/TcH/ZVmODuk13SOVEz9jgcu6GGmgs
	P61yK8zE/ML4MvOpsD4KhNYAXXutJZdmGAG44bHaui0msbuoJxqgVfkIVs5yGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1794149987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXQNJ+p122gnLyH8yrLKt31093LHuXH9zkA5Ta6zR7M=;
	b=Z2/s6RIXw7K2FkJ+7q4PsF7c7Oh5QyfgMFzozErOoC20X4x7GbZtXspfgdO6CiXx2Hn8ya
	OKEGy20Ilwm09sDg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 7C2D7E000D8;
	Sun, 08 Nov 2026 23:59:47 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 6BE1B22001DF; Sun, 08 Nov 2026 23:59:47 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  djwong@kernel.org,
  hch@lst.de,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/8] fat: drop ->write_begin() and ->write_end()
 usage from fat_cont_expand()
In-Reply-To: <20261031164326.278125-6-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
	<20261031164326.278125-6-matheus.aalmeida@inf.ufrgs.br>
Date: Sun, 08 Nov 2026 23:59:47 +0900
Message-ID: <87eccvtllo.fsf@mail.parknet.co.jp>
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

> fat_cont_expand() currently relies on ->write_begin() and ->write_end()
> to zero the new file range. These callbacks will no longer be available
> after the iomap conversion, so a new method for zeroing is needed.
>
> Zero new ranges folio-by-folio instead.
>
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/file.c | 122 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 76 insertions(+), 46 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 177a26186ddc..8689cbbdad13 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -18,6 +18,8 @@
>  #include <linux/security.h>
>  #include <linux/falloc.h>
>  #include <linux/fileattr.h>
> +#include <linux/rmap.h>
> +#include <linux/writeback.h>
>  #include "fat.h"
>  
>  static long fat_fallocate(struct file *file, int mode,
> @@ -353,68 +355,96 @@ static int fat_preallocate(struct inode *inode, loff_t new_size)
>  	return fat_add_clusters(inode, nr_cluster);
>  }
>  
> -static int fat_cont_expand_simple(struct inode *inode, loff_t size)
> +static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
>  {
> +	struct msdos_inode_info *mi = MSDOS_I(inode);
>  	struct address_space *mapping = inode->i_mapping;
> -	const struct address_space_operations *aops = mapping->a_ops;
> +	loff_t pos = i_size_read(inode), fpos, next;
> +	loff_t old_size = pos;
>  	struct folio *folio;
> -	void *fsdata = NULL;
> -	int err;
> +	size_t from, to;
> +	pgoff_t index;
>  
> -	err = aops->write_begin(NULL, mapping, size, 0, &folio, &fsdata);
> -	if (err)
> -		goto out;
> +	while (pos < new_size) {
> +		index = pos >> PAGE_SHIFT;
>  
> -	err = aops->write_end(NULL, mapping, size, 0, 0, folio, fsdata);
> +		folio = read_mapping_folio(mapping, index, NULL);

Hm, is this reading blocks from the device for zeroing blocks even if
page is completely unwritten block? If so, we would not want to read
from the device.

> +		if (IS_ERR(folio))
> +			return PTR_ERR(folio);
>  
> -out:
> -	return err;
> +		folio_lock(folio);
> +		if (folio->mapping != mapping) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			continue;
> +		}
> +		folio_wait_stable(folio);

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
