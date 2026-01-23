Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717832AAA8;
	Fri, 23 Jan 2026 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149117; cv=none; b=CQCiyDbztiIpfWhTlGIdeTejs7MwUNCKHEKLd1X3bXJhmxd70q4LLLaz2SRn4AS1llY0LbmpUfpIq6Ee7FJxUbL3eR7kHPxNi4ZRbw7X3IrNrIT2fL6rpiaVFIiEwg5D+DGVQtNxrNtMgvmnAoRRYzQe+Su86TrSbKEtMea5nus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149117; c=relaxed/simple;
	bh=21zTiJZvzT9ZAYi4Ha428OqLFwkfluz3Z4ygtj4B41s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKkaU+DPsyAKBPhLPCbpENXm25MevDGUQK1jq7IEZGc3SsyzX+4lz13SFKXD5WLh/BiOPori4IuhqYf0NKYjr9wMjCB+XszBauBKDaE8jHc0+widNQlpliW3VbPNTin/Rtl624QW/fXH7N+PH9Of97XTL7KOMQB9fqSafS7H3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C802F227AAE; Fri, 23 Jan 2026 07:18:25 +0100 (CET)
Date: Fri, 23 Jan 2026 07:18:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
	hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 04/10] erofs: add erofs_inode_set_aops helper to
 set the aops.
Message-ID: <20260123061825.GA25722@lst.de>
References: <20260122133718.658056-1-lihongbo22@huawei.com> <20260122133718.658056-5-lihongbo22@huawei.com> <b20b263d-132b-464e-8314-d3f795e5e582@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b20b263d-132b-464e-8314-d3f795e5e582@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 22, 2026 at 09:54:15PM +0800, Gao Xiang wrote:
>> @@ -455,6 +455,29 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>>   	return NULL;
>>   }
>>   +static inline int erofs_inode_set_aops(struct inode *inode,
>> +				       struct inode *realinode, bool no_fscache)
>> +{
>> +	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>> +		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
>> +			return -EOPNOTSUPP;
>> +		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>> +			  erofs_info, realinode->i_sb,
>> +			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
>> +		inode->i_mapping->a_ops = &z_erofs_aops;
>
> Is that available if CONFIG_EROFS_FS_ZIP is undefined?

z_erofs_aops is declared unconditionally, and the IS_ENABLED above
ensures the compiler will never generate a reference to it.

So this is fine, and a very usualy trick to make the code more
readable.

