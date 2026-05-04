Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D835194C95
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777866494; cv=none; b=CzVO6DC3nOzvg0ATQhIiCW+r3+1012U0XD1r9YfdlKtP7aHf2urOESVmBwjTui+wECkrtclUNW0HmBvtXp7PARdyh67qd5vakDWf6cwqoFUKKhULPNOPWsWQBLenKCEHo5FFCjvsp6vHAjcEy7g7KWT8n0scYdIsPAfqEBP1Pp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777866494; c=relaxed/simple;
	bh=NE39VbSeyS1U/zfpUsibSgLVZCbZAEvdVZTuONAkhUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoXdOFNUIY+gma72AxMn6JLzVoNrmdHqefwXpOu+1PM73yACmW4AQYUU9sPSNbMSY/NrMudXf5tqEPlgzIfbWsZku6ZIsyjRlW0MklBl5YDvOTs+GQMyKgMN/afDLL8WtcG7UnD4KxRoRoKD2DtATSZHkeTtXJWuXJ9audWTOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZggEc9d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nT7WkBeP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZggEc9d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nT7WkBeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777866491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0d34gXFxHlvZ/8OcBwFmPS8KNdBuUnK/1QEoQcHntzY=;
	b=OZggEc9doR79XCcBLnTnSnAFsvaprK4Unx28P+hE5wSjG41VjpoBUy00eWzk9DIM8DQ0nA
	gWCmQxKe9wENxtbhxbF2OBB/tNM1JzTMbHpjVpMXZhDhJo9UiKqgzKb8Sj3fr6CfsYa83E
	Pfq7G4If6EQemi7FV+5bSKxdXd11lMA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-bvwPdQwGPTym0s2w1ihiCQ-1; Sun, 03 May 2026 23:48:10 -0400
X-MC-Unique: bvwPdQwGPTym0s2w1ihiCQ-1
X-Mimecast-MFC-AGG-ID: bvwPdQwGPTym0s2w1ihiCQ_1777866489
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bd5c9e1826so12993357b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777866489; x=1778471289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0d34gXFxHlvZ/8OcBwFmPS8KNdBuUnK/1QEoQcHntzY=;
        b=nT7WkBePnnBrQEXZAoRuepP1UEtpCwnef2J8+OQ/i9ln+IDV/Wg0ISr7yzEKeBXRRC
         PF0R/XSNj9fbP0w95a6wKRyltXrcMgpTjHV4XQYPDsDayILT4zi7gWzgq5oQMDfob4jW
         4mjn1O4KKYm2NScFwrTtqvvVjHw2QVaCKO3TnNYpKpCdwvWMyaP4K2Qsrkr2FABSbsPt
         OmZkvk3qMifuD/oCPL3mGDzvtx63DDC5I+j8G0o3aouEd9qlZQ3exwe/kJnxhA1LjYmx
         RFZiva/p2BT7KZk9tjHDs3popMQHmSOC8MlKxQfe4hQMRBh5o45n15JDM97wP7phzdia
         bHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777866489; x=1778471289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0d34gXFxHlvZ/8OcBwFmPS8KNdBuUnK/1QEoQcHntzY=;
        b=n8gKQdk08s/xE/P9oAAwBF0DqFVejRc0GDbtXpwVFg3tJ+wbQD+slRP6Oi2GEoEx3u
         T99Jn+vRur1jpMc1qwno0qIOLxvoxcAnq5Xpm0PGWbmUQbEiJ+U/Td8bb2gi6hMfLZn4
         rXSJ9C/HbC+Kqrie/9axUfzn+Zwms5qt3jqmf4e+J95PhgfkB4I3C+IyfYQtE15gvFeX
         Uq9uvi80MTL7+yEZ4H+H4fQnAWESyLh3UcgJseVYuatXrNAJ02S80n1S/+lFNUuPKIXQ
         7C5KDOoam+4Yr275+bZ1mkJoo6zZycSKCTdl+gGtKbgQUjykYBpLxSJ+QIl79zA7Onm9
         gk7w==
X-Forwarded-Encrypted: i=1; AFNElJ88U+q+hKbNR1dvg9KI+naSJQSfNxSKF3toAPfWoSn+SI8MYaFwKMsV4RdWI88X/mXg14ZuB0Jm0544PJqo@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhdlL0uPP1wjy7pNJyyTKTaIA5+iwa1844CtprEHWbXv2YA/f
	s0E7+3IRyMbHJ+obK6DRPmRhoLjN4ZDW8ros6AlqKKFXs68+wN412owE/6c2sVoi7btlb0E176T
	6tyxhe98VxioHsE59T6PzpTtl+GA1k4pN4xyFnepd4ca19VcU3AmyHbZGA6jfw0MNaag=
X-Gm-Gg: AeBDievCn2aIV/XtElziE/MqO5lsP1i5EOFObpxqo+I1B2DssiG1qvVCLfBgZ7fv3SI
	I5EiRtLCuokQtocznrDg9iqKJZVFMpWb2LMO6FSeQ1jy5z9dpvJ+AQNijnX3cNIdL/CysNsZTzs
	fmcaXaBBTIqoPwOM7Dq7yfzGkcXI6ExDaegC0/5ijVu7/nOosx1f0JPj9P4zW2H8TYMAbHlyi3T
	iXixBCe1xhAe4LPJCvXzh+/S45EoWZzbTXLsML9msdvxR1odVBSidcaxWZ1j4bgaoy79Rr367am
	PMApbgwycsyjeGl4NvLrMjd9WznheCxhlsyu1s/0FIb+bMtCwHz70Dc003C2oXnSg0x2C2FgpzE
	lT6Gph7UveJL1hnQ5SOEOdX+y5zYrlizntjVEl9PLNWi98GwaKc6hv52svttjLcUud6U=
X-Received: by 2002:a05:690c:d85:b0:7b6:783f:2122 with SMTP id 00721157ae682-7bd768ef380mr66368937b3.9.1777866489492;
        Sun, 03 May 2026 20:48:09 -0700 (PDT)
X-Received: by 2002:a05:690c:d85:b0:7b6:783f:2122 with SMTP id 00721157ae682-7bd768ef380mr66368697b3.9.1777866489040;
        Sun, 03 May 2026 20:48:09 -0700 (PDT)
Received: from [192.168.178.105] (78-0-206-107.adsl.net.t-com.hr. [78.0.206.107])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66839f63sm44701847b3.31.2026.05.03.20.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 20:48:08 -0700 (PDT)
Message-ID: <aa778cfc-b7f8-4100-89bb-d2b2ef8e1138@redhat.com>
Date: Sun, 3 May 2026 21:48:40 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] mm/khugepaged: remove READ_ONLY_THP_FOR_FS check
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Song Liu <songliubraving@fb.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Lorenzo Stoakes <ljs@kernel.org>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20260429152924.727124-1-ziy@nvidia.com>
 <20260429152924.727124-2-ziy@nvidia.com>
Content-Language: en-US
From: Nico Pache <npache@redhat.com>
In-Reply-To: <20260429152924.727124-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/26 9:29 AM, Zi Yan wrote:
> collapse_file() requires FSes supporting large folio with at least
> PMD_ORDER, so replace the READ_ONLY_THP_FOR_FS check with that.
> MADV_COLLAPSE ignores shmem huge config, so exclude the check for shmem.
> 
> While at it, replace VM_BUG_ON with VM_WARN_ON_ONCE.
> 
> Add a helper function mapping_pmd_folio_support() for FSes supporting large
> folio with at least PMD_ORDER.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   include/linux/pagemap.h | 26 ++++++++++++++++++++++++++
>   mm/khugepaged.c         | 10 ++++++++--
>   2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 1f50991b43e3b..1fed3414fe9b8 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -513,6 +513,32 @@ static inline bool mapping_large_folio_support(const struct address_space *mappi
>   	return mapping_max_folio_order(mapping) > 0;
>   }
>   
> +/**
> + * mapping_pmd_folio_support() - Check if a mapping support PMD-sized folio
> + * @mapping: The address_space
> + *
> + * Some file supports large folio but does not support as large as PMD order.
> + * If a PMD-sized pagecache folio is attempted to be created on a filesystem,
> + * this check needs to be performed first.
> + *
> + * Return: true - PMD-sized folio is supported, false - PMD-sized folio is not
> + * supported.
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline bool mapping_pmd_folio_support(const struct address_space *mapping)
> +{
> +	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
> +	VM_WARN_ON_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON);
> +
> +	return mapping_max_folio_order(mapping) >= PMD_ORDER;

Probably a stupid question, but I dont know FS thats well.

Here we are checking that the max allowed folio order is greater than 
(or eq) to the PMD_ORDER. Yet the function asks if PMD specifically is 
supported. In the future could we have some FS that does not support PMD 
orders, but does support larger orders (eg. PUD)?

Other than that. LGTM

Reviewed-by: Nico Pache <npache@redhat.com>

> +}
> +#else
> +static inline bool mapping_pmd_folio_support(const struct address_space *mapping)
> +{
> +	return false;
> +}
> +#endif
> +
>   /* Return the maximum folio size for this pagecache mapping, in bytes. */
>   static inline size_t mapping_max_folio_size(const struct address_space *mapping)
>   {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e112525c4aa9c..6808f2b48d864 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2235,8 +2235,14 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>   	int nr_none = 0;
>   	bool is_shmem = shmem_file(file);
>   
> -	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
> -	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
> +	/*
> +	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
> +	 *
> +	 * TODO: once shmem always calls mapping_set_large_folios() on its
> +	 * mapping, the shmem check can be removed.
> +	 */
> +	VM_WARN_ON_ONCE(!is_shmem && !mapping_pmd_folio_support(mapping));
> +	VM_WARN_ON_ONCE(start & (HPAGE_PMD_NR - 1));
>   
>   	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)

