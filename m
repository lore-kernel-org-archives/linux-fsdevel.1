Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3188436353
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562548; cv=none; b=XY/YbuFZN2bnWDyPFKP92FdutLYA6hXF+qQQwIRREscM/kRB1BYsxwtHW23Amc+If9dnEiV4P/s0LKjePeS2lg64ISssZZ2wrVO+vNcKxzbEO1EWzswrKSvBitmxOdb7mwJ+V9cyzX4teYkfWplcwDhPv9XhQv2RD/rg2pabuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562548; c=relaxed/simple;
	bh=iagDN9MQzUvFfugJi8ZOtR1qNU9GWfiOIuQ/KX35R/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kViGVpO/+S6fG3y9PwGrZOq4TgT5Gbrh5HHsSADhz6oiTLhlpf86LZA3bTVFrPplQz4ubtvxtgVk1Zox7SWn/fs3/Qo2r3TuUpHEHI8Ix7rbBKWz8KIK0V07QGIz5vyaTvmIhRdAAcJJgowfrZ+wK3Lrv/fx4yJj93PZUoAIIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Oz6w8IK5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Oz6w8IK5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e622cc874so763066485a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784562545; x=1785167345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=89meaKDhwFe10Z71hE7i2nRHODsJTbsiRnn58cHYtjw=;
        b=Oz6w8IK5ZAwjM2E9DgdoVBHJKXQkwDwrOnCBPa/wPDQNh683mkFqvwchbawBzpersU
         lj++PO8JAi1kix3SYjAsQlUsF08NCuwdBpR1vVso7HCgyZixchhFEWLB4Y12JC/HIi0R
         tcJzqSdLBUSfu7I9EY6SvqyxvEsxpeF0wWpMep7tX2zzHUCp4xWwAm0G2qEvDLN+gwbd
         9oe8mVqSlIPpWaIBQKBN5N8Zf4w90sYfSsEL+bFgyK3tUcz/X2fCWdnGFSe4WzIZHCBZ
         019Em8Ep7PoOFEKMjVWIR46FF2YzLSNUe53t1BUzoOkE0Tq4/lSQ0Hd3O/tqZDu0nh/N
         rFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562545; x=1785167345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89meaKDhwFe10Z71hE7i2nRHODsJTbsiRnn58cHYtjw=;
        b=RWmM5odsiVkME5Nh5oml0Zq1H3gYjdw0BzzDHaoNoaskZzvo0FBsn12luPCIABdwlo
         zS9S0GXDIQ32PbPBSQcAoViD9YlKq15MwtpBw9JzrqVt92/+OZE6j/okfXV2IBPQFh6J
         zaL9kvlbIiUufQGKtd5nuYLrFwSlpRsmuKaN3/eEYr2RKhdbmnXGCAr+FMkIE7xCftZL
         UU80W2H3jsqxWYwERdXzYT6IoaOqYif/4ns9FhiL8I5Q8f272kZG2iewbuBVPWlZyc+D
         QjNZt9VjsUZapvkjTjHiwJXuH9XpV32Br1seEJwdfsrkTqgJozSEicuDfIFJ1hCMoogK
         HPPg==
X-Forwarded-Encrypted: i=1; AHgh+RpHaZcApvmyb04/jcsvEtjci47mcOMK9d2tmXgBnGAXVLTTowaEydGiwNlQY/rMuNc72RNrc7OrR9RdgNVK@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGO+aQjXa12elVbUiJfysWv2R1vGrzU4nF5oiNxYhjg7+O9hl
	RBL8Zp8goa6ZgJ0qTB1+Il8G6rRION3nDm0WUUiyBoM10HbYJ+LH/Zyt5fGQ4uMVZBc=
X-Gm-Gg: AfdE7cl6J9q5SQSHm9TgUx1U5uH3sCZ/6aPE4X0SEchYiKq+4WOsPB2BCEVtvzXVLBz
	aRnQm/vPGpm4gxxEeUpNXVpym/+YECo7X1gLv0r6+gMCFKMRyb5fze285TQBF0v1Oc9cv5/7ImA
	N4OYxz7Wc8l068ldMTeoCExZXAf9yQSK2ks6IGKSgDrVWC6W8S1FuDxuRRL84kjstRKlkOauhSK
	JPRoe6Mw/361Z4VgWGUTZsKaMLbwNobWrlnfwLdWz2Ymj0RtsaYEHCRpprDvTtipgMPubHTl9kb
	IIIDRCydnw6hfLE7xvVMMgcwq6vV1U2ffqUYm8fBIt5EcnxVEKPd1J/vDeGPPS4MoIeckgGXun0
	RMEye431HgXRWspcuiCFg8K8TlZ3w2I75qzXqgzb//ODAaFelp9ZgosdtFocVV9du5lmZ1EUQU+
	ap+YTaIhUDdD31FlirBb/b6/As8xBnUtZQNckjL9JnaYkt/Ghv7CTjkQyqHg==
X-Received: by 2002:a05:620a:25d4:b0:930:ab28:9459 with SMTP id af79cd13be357-930b41e29bamr1533354985a.56.1784562545561;
        Mon, 20 Jul 2026 08:49:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b54773fbsm894382285a.39.2026.07.20.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:49:05 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:49:00 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 01/15] mm/vma: introduce VMA virtual page offset field
 and add helpers
Message-ID: <al5CPpc7XpRX7Vbt@gourry-fedora-PF4VCD3F>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <20260720-b4-scalable-cow-virt-pgoff-v2-1-2d549757a76f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-b4-scalable-cow-virt-pgoff-v2-1-2d549757a76f@kernel.org>

On Mon, Jul 20, 2026 at 03:38:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> 
> The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
> they are unfaulted or were not remapped, otherwise it is equal to this
> value at the point of first fault.
> 

The latter half of this description is a bit confusing.

Why would the value differ from (vma->vm_start >> PAGE_SHIFT)?
(because it's file backed?)

It sounds like this value can change in response to an event, which
makes me thing a reader could see two values across two calls?

Apologies if i'm fundamentally misunderstanding something.

~Gregory
