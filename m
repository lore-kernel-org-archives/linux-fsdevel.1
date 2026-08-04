Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09EF3E9C0D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878811; cv=none; b=sygTx6t3X4ZBEYsCXmF8OE55+V9FeS/Tn/5mq6JBb1uMUBkzCKS3PvR5FuNEoTOacoRP2Raeds3wcOC0EOSoLgeSXbnqLsT8Avlnov5eEtexGynhpmgjM/hfFSAx8mZIy7Dndhj+dIkc8dpYL8qY8FrN8D4khlyyz4yJfMfoBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878811; c=relaxed/simple;
	bh=jJAgdT+F3Gpm7IdMgKwN4g1YiqIWWg+hw8OQ2yKCkf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYWbGLFEmOLbGkCXkBWu+kR2RdskJsL5L+a2zP/Mufc763P4klQJ3d1wOMmLxVaqSg1p0lijC4Hpl9a03JemD1pO8rpg69FdX7ZsXq4mwGuMmIQedEhJ0RYLBiOaxSv251UPS9uFw6dCk1DO4ORmdmz7x7wMlmISIVbrtsbMO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Vw0643oI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Vw0643oI"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-930c0f9c1b1so25050785a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785878808; x=1786483608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8E0jAVHN8ZtyJncyypOkHVI2p3kLARZRTEYAoWDJwJY=;
        b=Vw0643oIyFt4IVIeqRLigfvdhOXIlMhvgSTxZd85ojs0bDnowpOZZkj2B3UZA00Zyw
         ZZpaj//EZY3CfpljgCfK28uYaXRZdjYbbZTzB071PsiHXrRGJWBL9J6Q8fm1FD64ksd2
         rPPQ6PeeL2ncv8pDhCtRJwkaS0YOTizr8lb+EjJ7eHeJW4Q57zhhpb5nRkXvxgUQNzU0
         UPP0b9Oa2iqptNc7uEa0e4joqRzkdmBrSOI5T8xQ7Ur4tor+3L9ZZf5i/PDX0y7obxah
         2ku/04Ya5XoNYW7odc7Sk0cVkQvBuJ6k5v3NvYR5c+eBj4cIW/ZhAqHoPLS3A9eG33os
         Dm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878808; x=1786483608;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8E0jAVHN8ZtyJncyypOkHVI2p3kLARZRTEYAoWDJwJY=;
        b=MieFuCEgM3CbTxioyvM+zYaTrGx5y54AJXRC1VZaseMWDwQ+zti4yqoPT9rK/XM6yS
         oREtk6MavldEQy2icLd/EOYQwGJzX+GHBiVb30D8Ho8YMs8YGUVW781/wifxx+2j8cJY
         3x0btnY9Q1X2488LFQTR5o14CdiBztpSlvtGDLF3tahq/IJQhXpMopnW0FMm9whhqne3
         JcAyRsOmYqEWPDyfjXoCMbcGscO+ZO0egbZJqpoiKj9wNOXXMmtIRwfGvOSvyW8OSnun
         ZLX48WT3Hcy0DYrx8bEP5l+WUiHHKMI26yBXMNl6nloQG3TKRhJSoX43X6gCaATancux
         UXmA==
X-Forwarded-Encrypted: i=1; AHgh+RpDVCDTEzgMITnLWADg4VIqBkQn/B5PJn0mBBsLsgdHo2EUZiq8QZui3Ed5bf2vLHIB6LanGnbUy+vCwIfh@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHVDqA/akiygPt/xUNhg3JLQ1YUu8TmbyNTt4Z0DkKCqWHY9n
	FdMxpM4Av0CTImyVFXsajX6pWh4O5/4Rltm1T+LmgKGVuiynltr5gfvAEmnbN1f88Co=
X-Gm-Gg: AR+sD11JVbnpD0fKC9CFrNNt8MV+drFUVAnHeXSw+mrx2MbS2ISYpyHzNokJmpK+yqf
	HS/qU5W3LfL+b3zA3I3hlmwcrFb9iJEWDRwzXBK9PenGpdygJf5rRpNwN+ZHt+qe9StcOo/AzlW
	VO4XM3GPyDWcBGANXkTPUlYhwa2PfGixEWCu3C3HSh/Wbm2rJDeW5ID//jaJ/OPXj16eoOKxLqw
	WDaDRxQ2oSkFpuV1KwcJsKTisELJbq+fNdtm74JSY0T0w4raMIPFrIXrhsF/nhh4NERJN6YP2Ut
	AMiCakZfoWmZ8lYYq+UWW3eIlCGyGgXF2Ff5AX9ut7AFpMcPxSdxK2Guwv4dFu6mLddyBKbeQ0e
	46RvPMQulEhbxJvo2TvqNEbzfzwLBZ8FH4SWpRF1yvVAdqwW0xTKTsEQo65qHlAcP7hTKzDZ0Y9
	Ebb+ioy5NRx8U+WiBCtprrF3VGeGPTBwOdXViIo2wqXV8PBRqtrxtJMgDJMLPgo7TaE84iUjmZj
	eiQanlaPQVlfmHMTw7pHJkHIRLarpHOYlTchEttDUWk
X-Received: by 2002:a05:620a:7101:b0:930:9e52:2b05 with SMTP id af79cd13be357-93649150e9amr130786285a.15.1785878808478;
        Tue, 04 Aug 2026 14:26:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a5296e3sm19453685a.26.2026.08.04.14.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:26:48 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:26:46 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 15/15] hugetlb: replace hugetlbfs_read_iter() with
 generic_file_read_iter()
Message-ID: <anJY2zu_7J-ewVES@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-16-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731200802.574821-16-willy@infradead.org>

On Fri, Jul 31, 2026 at 09:08:00PM +0100, Matthew Wilcox (Oracle) wrote:
>  
>  static const struct file_operations hugetlbfs_file_operations = {
> -	.read_iter		= hugetlbfs_read_iter,
> +	.read_iter		= generic_file_read_iter,
>  	.mmap			= hugetlbfs_file_mmap,
>  	.fsync			= noop_fsync,
>  	.get_unmapped_area	= hugetlb_get_unmapped_area,

Still trying to wrap my head around 11 and 14, but this is nice.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
