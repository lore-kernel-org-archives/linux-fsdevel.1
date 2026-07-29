Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36E282F35
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285715; cv=none; b=lVra3YU1phHd62YpfUHwN4OlpubqinMWRV7C910NWxX/cxPxCvHER71rp0svW4xiQ1oRVpz0lLcbkwdb8eztBGrCkSYusC8nIXlHcMcr8hlwgvHdWHXCSJ159pWrbNFf17w5s6Q3Z+F/Qp588OFTTALfQ3lurOuHbeQlQHyyDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285715; c=relaxed/simple;
	bh=HD4E0cyd7wCQkWFnwtz/bq6KOmc9FXVhiSL/15chKRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSODIZT032L6W1e/gNnIeJx78mCYiZhRpae7TsTE5vBZtPSxjtLic/2bzVrm8d4O5fvl1KX/3oQ5dVZtT5/CvQIEM2gbMYLQHk97hwSu74KM2RBXKmeeiLNGmpzQ1myJAvVIGgp6u4V5/3A01cR6gpQhvDahXpxEZDSAgH9tmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s3QXA4fX; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s3QXA4fX"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-902fc790cd5so2544426d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 17:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785285713; x=1785890513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j9nli9m4Bc7pFK4IHJyjckwpxfCqeOd7xuoXeRuq6Jk=;
        b=s3QXA4fXvEwyB+gcoHfScVJy2nQ4qMqruTJHNyCczHioYGfYpEAz2qOyyN/mm6VVCN
         V011BsKeSafnKmdKdh6GfP5hcQmRPCVqQKo9qSQYtMMHR+TEc0FASG7x58FWGn9/FBDA
         kxDR1t8uSaCWFpoK/vpyaiD+3S3i5EU4mZCCStbQOcUrZA5SmsZPjymN6XVmVS4/9AOU
         Z1H10+iVTAUADT8ITC1oY/LcXJUFuv5ZPAuvVxAMrCqYS2emtkaMYASlg5ZgopP/I4xa
         edAupHQNkPcyqT7BdW7e3gTQcysMrcGQXUHmmgvQV8a4tlSDO3aI3OXPTxklMdynmKvm
         Dtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785285713; x=1785890513;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9nli9m4Bc7pFK4IHJyjckwpxfCqeOd7xuoXeRuq6Jk=;
        b=CjKMish5RdZtRJ3xz1eHPW+vw184THp4ZmO+BvHM0hON+WFt9vfZt1Km6T47IIVcmb
         PVSFdTx4ErQ7qm/zgiNp0wZixRFHyu38xxfkopctc1a/f8lQqmup1B7TSFA9vNG3Mart
         8QhNxLkWEHm45JRnVZK/BlXjY6XY1ANdkydT1Zri5pmOn17YhYn7cxIwNOgbh6970Qd2
         Xo3I9js2Fnp4QjUWWBAXu4RIrwKDHMWC1a7Z3zWZBthETPD8yPVMFUET9HTMPK3usc8r
         twanSPuA6xvikdmm8FGeD9ulsu6vNz5SgMhzJJ6p+0aQEC/TzSg4YhJfQsbBMr+dYz4Q
         iRUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVW+xStmqQbHAjRWzt/+uKgLySaCY5wRtk1O5YcxaGJE/WpA1LwEqDLAIBY+syY/DFKTZ0AG1FKw9kPyQ+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1b7SrR/g1xlErIWRRWT/pzdybo3FNBUbTcW99yIIFIz5W6Y02
	qhbtcVD6Ka+KHz2ZAe9K8YjRNK53p7jJU/iolMV9JwngzZaYvrbXXA/pMpTts6owBGo=
X-Gm-Gg: AR+sD10B2Z06GuliKN9HP4fhjEWMwfGjohy2Wuud9KUglx6vPu0F2NiNw0JPFaTlBB1
	Fjh3sMpzta+SbdWQKSIRXpMcIUC4lydoGVm1ibsPi9etDB9QT9bfBmm5x4RRsuZmCuMzg1jgZ/y
	2Ga1hQr2uoVd33QpShNdr9tpV9L01SNlnP6wBB6NpQRT6rwhCJP2EsY8hSZTbaTgs7iDJ7Yv7Ib
	2u35RudSmq/zhw6E5Q21up38YrTFO1RNGXfvQ5Tqqv/UeDKoxN2PUCQvkC1my4ui6+RD84btdk0
	KyqjSfcIAgdTUTybk8EnbXC1voHgb++G4QVhzkGH0SsIEAiwsNdKIahQDh+U9V063JCZOMiM7su
	/KoJk5mf4gQF/id6PvRcUE41RjYPAODWcnD9Y5EB/ac0r+vPBsQEq5Jzs6U4eGfGR5fc78A15O6
	0tUlHqD1kWOQ0zZqB3cnOAAxfsBYJxkLQilEo4fD2HnzR/vGX8QINeaC4CcOmGtNX9P4dHdSLDO
	Ptnp/dM+8CvoVTqEhp1wEja75XkdTXSjXCgeM7PF0lO
X-Received: by 2002:a05:6214:428e:b0:8dc:40bc:b593 with SMTP id 6a1803df08f44-90816fa80edmr57286176d6.10.1785285713351;
        Tue, 28 Jul 2026 17:41:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd6c599sm11500206d6.34.2026.07.28.17.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:41:53 -0700 (PDT)
Date: Tue, 28 Jul 2026 20:41:50 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v7 05/13] hugetlb: Move poison to pages before clearing
 hugetlb page type
Message-ID: <amlMOd_eTbqgtS22@gourry-fedora-PF4VCD3F>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728204409.3396238-6-willy@infradead.org>

On Tue, Jul 28, 2026 at 09:43:57PM +0100, Matthew Wilcox (Oracle) wrote:
> For is_page_hwpoison() to be reliable, we need to set the hwpoison
> flag on each page before clearing the hugetlb flag.  Introduce
> folio_clear_hugetlb() to make this easier.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

