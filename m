Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A642F12A1
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207816; cv=none; b=OhLhglKsEzo84NHt414QXrcHMfVgywjDSrtFVzi+Ih0JizPlQ31mV34uEpUIeB2w3z1PhVtVazK2/uX+cmMuLqhemAlgEVe0nZNY+Rd/uewYWBq23a5REZqIi+MFcCj6sgCsLTy7JjL9igXWWtDZB//JM7EQOx05wJfQLfpC9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207816; c=relaxed/simple;
	bh=1Yi67YoV2rSIwB0L4yTtOVqoJC8cGOvw/QoY0tGceW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMFa2STXw+IaJ89dMTXyuQnxBfLb7OJOVRAUh6KjPfPDECRb79DHxr/eY+TLMbt3tMdNc3L4maiEaMnUkxUNbLZhMp4VGZPMS/3cTR9oycMhnaYOx4UIPrmvVPGK7/yzeTxrYh+9oDSC2g6k0h6TYH788+zbYjRp0W0UdhYRG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GS18ja3k; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GS18ja3k"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c04bf4711so33082001cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 20:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785207814; x=1785812614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Gfu3RDiGWIEKHkevZ+RloXDenOIdQzmWURT300Hc4w=;
        b=GS18ja3kcAMXyQIP/Q1JsFYPf4pFzYbYfPwg5bbPY7cdGH3jz94pUm+YYELV2fkyAD
         YR0CJFDx/3i/w5ZV8c53INCWi4eBc0BSVQVMOO40MZlf1F+eB1ZWIhTNC95F2N555bew
         Nu4rHpvPO8kXiMCpNclwr38N4k8VVPUnyKDvcieEKV6nOPEB5qZmgBa9muyZSjgSBKbV
         wC3OGHrdmexUymlqU47q/Su9cN5cTbFIP0lmfM+Ie1ZW8HBLxi9vSgbl12h5kHvkTG9O
         Nj4i/NXj7lCTEsEsSPfab5bvJC5sWS5wYjawQL/yiShIrVFvqo92hrSHf6otFdX9rhxi
         vAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785207814; x=1785812614;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Gfu3RDiGWIEKHkevZ+RloXDenOIdQzmWURT300Hc4w=;
        b=abTwcBVgeXusv0IBws+4NP7Gx2Lw3iYiBLixOUwpkkHCFNCk5fGpqvKFgPiM7o3Z+k
         ZtMu88LUNaapyCAz8kHd4OSYeEzZP8dtIxCM8YZz7LSIRtUR3le9TKhMTYemDMG9XH2P
         lwc6VTFk5ScyV8gdI+FzX4/bBkYy3/h+0s9SepIk56gznvHqVF2QC+BsvM5nHtR4KM6/
         ol4RPDpv7jrJnqp7VFmx0C+D8xyCrG0ehlqKNEvLUeeergfq/UAAJ9TftVIrhkJVXpun
         3YzhikjOfq6rQJ7rdZUdB4yAXsy+HaxAXwIextWO/R/Jz0JkdQlY5iXIo8EnKLYqKd+F
         r9MQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3JtukKv8+ovr9NB3vKDbyQTsuh9sbuJ6GZ03BTyyCL2FbIXW7EFSM7+gopqpIb0wm+BhAz8XP6oZ96nHl@vger.kernel.org
X-Gm-Message-State: AOJu0YzldC+/XJDVZnZzlPa+gouqXBZ7tAI3Qb7KfLiNEC3ROP3kiyVV
	WEoQkYSfXI+F9ssravf4cBBv2EDbw9vkpO+SbxMz4yGO6MnMys7wgPcPP/NjVhzJyVw=
X-Gm-Gg: AR+sD13/WnbW9aA7M4OwmmOxy5Sa5Xiy8vURvWBjzMHD6HTaLznt5Mcon6au3sqYFge
	KB4QRdaIGCd18ePoSaK1NWd9NWmrKtB4gWaIdttHibXLm+m2b5i1rMGAvacELlvA5Hrug4vWo5M
	ytaj2B9yVHxTBGrgn+7G/udbLD0IW9q4ysDWrrW6BmGWyOpft7YSHgEqA7GvFRwpoxYfjhbd5bE
	MjheCo+NCiU10SNrnKcBynHfsAbmUQK3bC2ua8bQyc+nyLY0DU3LYvRd0fjYLIXZHIvc/SkJNp9
	Y2n/0hW/uU928DSeX4mdEwOMDXU52offz5NOJefuIa/Eqcv1clM0iKqQT3lHmYQ8Z0vIjuk5c4t
	B5CSFeidWlQu10MRdoI2rcVwx03uLsddMGM/U1oeK8HJRIcIf5BrhX23Hn9/zrPeyG6yDAd9ZMi
	79uXcTXfp184wRklO329DmI1c0UMZzMv2XA9cqJ5hatyfr209HEPs4dZ/xzg==
X-Received: by 2002:ac8:7e94:0:b0:528:a8c:a9fb with SMTP id d75a77b69052e-529d71a5fcamr4404971cf.87.1785207814003;
        Mon, 27 Jul 2026 20:03:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2a4bed2sm65297261cf.29.2026.07.27.20.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:03:33 -0700 (PDT)
Date: Mon, 27 Jul 2026 23:03:26 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, 
	Sean Christopherson <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v6 04/12] guest_memfd: Use folio_has_hwpoisoned_page()
Message-ID: <amgb8j0JUn9hAc6a@gourry-fedora-PF4VCD3F>
References: <20260727181310.2671972-1-willy@infradead.org>
 <20260727181310.2671972-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181310.2671972-5-willy@infradead.org>

On Mon, Jul 27, 2026 at 07:13:00PM +0100, Matthew Wilcox (Oracle) wrote:
> folio_test_hwpoison() only works on hugetlb folios today and will give
> the wrong answer for other large folios.  folio_has_hwpoisoned_page()
> works on both.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
