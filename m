Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782F1A2C04
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777866812; cv=none; b=o+rnWUApX1EO3ZGc7TriojVwtlS+2fPz46SX06CSvKRVbEywgcZ5A35jd5yfFUmY2Eaygszq7lyGP1W9dlowGuat5vGX/l0M9izbU+PH6iXx5zllNhbiKdh0jK0RouU8IqpVeCRWfdVHeJxE9r3TKDjz3X+6XR2GfN9cvJH0zyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777866812; c=relaxed/simple;
	bh=R0AUDzSWQxPWg+a126fEPwXl/Ajgx4AVi7lR7GVW0QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHiYguevZPSLHdBQfdPug7E8WlRtj7wnN0h+yJgq/VIRKnj418eCOmXHTQKHVQRZV9XN76lls+/Xdu9BJAr6YpKjU5Wrc7mvHls3mHrIGPWtl6f7ceIt/I/UNyMrAkgdffauPV09HXXM6mxvgxtxDErY3eNCNfOqTN9uYU+7/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DggAExdJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iw+mjYYN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DggAExdJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iw+mjYYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777866808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuwaC1QCoVaWPCWlh6YJVeUyAviJpTjgkGZ69+fjPic=;
	b=DggAExdJ9t/QzWWM4gwTcQqK9557AFouNO/DfqYftcycfZ4Dp6gVThzaghN1hK+YAVPRD0
	unu/NQAO80gPQi9wTUBhzaH9nuhL5Tx/dQ5jMk/EqfR2n47uZEvyagTJPo+vCxzO8tmX+J
	pAo1YZBQ714pb1pXxTg5S+H6Ah5fJek=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-zR55Q7n2Oja8fCwReogv5Q-1; Sun, 03 May 2026 23:53:27 -0400
X-MC-Unique: zR55Q7n2Oja8fCwReogv5Q-1
X-Mimecast-MFC-AGG-ID: zR55Q7n2Oja8fCwReogv5Q_1777866807
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64956932a51so4496844d50.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777866807; x=1778471607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuwaC1QCoVaWPCWlh6YJVeUyAviJpTjgkGZ69+fjPic=;
        b=Iw+mjYYN5BC8xxMjjX1BgJXn2asgCReostFQ1D9G9cwoCWp4a8fu6FdWM6t3MqsVAk
         +koDhi6A+0OdY+mHv0rP/K9zf84JLJL0qv1w/1Kk/AqqMDA6vB1TZF1kyYNbFZeXBk+F
         97AeuEaUHJdX9qJIpmMTKUPa0evbDIdWZLL9JKEPO2eMhBqok92LLsl7Xc408aGKkNSp
         CV/Hzm0NV/WgJOBU25+0yvnvjIPbn9fA4kh4pnHj7b4pC+4cKvkRoLxWA57IoLSv2gYl
         ipjcdRzvZpLtg8uW01GPEiai86ntrnGyEECZbCKEpDSuNKX+FFdSbosXRptWaUrtNQTO
         GU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777866807; x=1778471607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuwaC1QCoVaWPCWlh6YJVeUyAviJpTjgkGZ69+fjPic=;
        b=TsBBJowzw1axKBzG2KnDFO4bo053+LlrLWoc5sXHMVZYYLVKM7H5rqiTq6Lt8P14Ni
         wlJ0ieKU6fnfzZa9AkGM/hivOrV+Cqu7NoVhqffg+MNGRZg/IAf4GOC1x2CChWIWbZec
         1Ksqes9ApW+DVhURxBsy4E3N2TcJgkyn4TWwEid3ebcwQ5mSEj9eQ+5yXM72PB9Io2Cd
         4OSFAMXhIfy3ZpA0vne59DSJXDTm1mi1ZjRt3OsbntWETtf4QQKYKXBm7mAoXvdBMWJq
         gsEdK0y2t4V8wkzy81NLOLNELUMQJT6tvfOu+pYJR8vNFsnRQ2t0+kaMC9uO3D1YeG0M
         FwuA==
X-Forwarded-Encrypted: i=1; AFNElJ8DITlJM6p8n7JzoJgo+1M1hwXjkeXkN6oZ61OgvSP9ew4bin9zcUuYC3Pqv3TD28hxspeM79FrvBVXn1EO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7QkIp1QBF08YuHIuo3mZ8jWa2Z7s9I0hbEcfPaghqB0dbAe+
	PGRHNtyHGOtlQCkB0j8k318GtJyiXsWGwxIEDzXyY3dsGsDlwbJScqDq5nxeeqfT8vhCgJhJpOU
	7hktpf4OCcytFRIWfsFArJ6avrUW/dDYVULL/dgZL5rOIqjSkm2CkTiw2R1zE7nhwQxw=
X-Gm-Gg: AeBDievgIexBg692U6q1xpVH5Ti9nMpmO8oLMJOBLxJ0Ug8dH5HOlAAf7rojKsUXQDH
	HxjjgLSyd09CgD0AGs23D1XP70A0z5B+vkbgKpOUXvHOCMZt0bg4GwvCIn5DgGInouyx7oFPSRW
	u9w0pYyRgQPm54LJLynM+jskfi6Auuagtni1/N42hvgDGWueC5BunixA2jR0qoxcE7fJN4Br8lN
	rJs8ucUvdpIwUfLCZCFrSJCdcLJ0sdA6fyc1Uom4jCJmd6YhZlKeuCLETN2Xv3842uPeyZcs8VW
	E5VYUHS9f2AURqhSqJaH8JbELh4I9DD+jqBrDL7DvpYQ2LO7ypdljy6g5KvK7qYfbGRu0Th8bTx
	j0F0Kb/OcX9BC0J3Xo7bGyhTUJE4jkQFs2ptHz/pgHYfKfKHKZEUevNoWRE6B2fJmsIw=
X-Received: by 2002:a05:690e:13cb:b0:651:be50:af09 with SMTP id 956f58d0204a3-65c3d96ca98mr7541987d50.3.1777866806642;
        Sun, 03 May 2026 20:53:26 -0700 (PDT)
X-Received: by 2002:a05:690e:13cb:b0:651:be50:af09 with SMTP id 956f58d0204a3-65c3d96ca98mr7541955d50.3.1777866806149;
        Sun, 03 May 2026 20:53:26 -0700 (PDT)
Received: from [192.168.178.105] (78-0-206-107.adsl.net.t-com.hr. [78.0.206.107])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e8b2e55sm4980740d50.20.2026.05.03.20.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 20:53:25 -0700 (PDT)
Message-ID: <b3b5cfc6-e61f-4904-ad2a-dc1f53f04838@redhat.com>
Date: Sun, 3 May 2026 21:53:57 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/14] mm/khugepaged: add folio dirty check after
 try_to_unmap()
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
 <20260429152924.727124-3-ziy@nvidia.com>
Content-Language: en-US
From: Nico Pache <npache@redhat.com>
In-Reply-To: <20260429152924.727124-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/26 9:29 AM, Zi Yan wrote:
> This check ensures the correctness of read-only PMD folio collapse
> after it is enabled for all FSes supporting PMD pagecache folios and
> replaces READ_ONLY_THP_FOR_FS.
> 
> READ_ONLY_THP_FOR_FS only supports read-only fd and uses mapping->nr_thps
> and inode->i_writecount to prevent any write to read-only to-be-collapsed
> folios. In upcoming commits, READ_ONLY_THP_FOR_FS will be removed and the
> aforementioned mechanism will go away too. To ensure khugepaged functions
> as expected after the changes, skip if any folio is dirty after
> try_to_unmap(), since a dirty folio at that point means this read-only
> folio can get writes between try_to_unmap() and try_to_unmap_flush() via
> cached TLB entries and khugepaged does not support writable pagecache folio
> collapse yet.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM

Reviewed-by: Nico Pache <npache@redhat.com>

> ---
>   mm/khugepaged.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6808f2b48d864..71209a72195ab 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2327,8 +2327,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>   				}
>   			} else if (folio_test_dirty(folio)) {
>   				/*
> -				 * khugepaged only works on read-only fd,
> -				 * so this page is dirty because it hasn't
> +				 * This page is dirty because it hasn't
>   				 * been flushed since first write. There
>   				 * won't be new dirty pages.
>   				 *
> @@ -2386,8 +2385,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>   		if (!is_shmem && (folio_test_dirty(folio) ||
>   				  folio_test_writeback(folio))) {
>   			/*
> -			 * khugepaged only works on read-only fd, so this
> -			 * folio is dirty because it hasn't been flushed
> +			 * khugepaged only works on clean file-backed folios,
> +			 * so this folio is dirty because it hasn't been flushed
>   			 * since first write.
>   			 */
>   			result = SCAN_PAGE_DIRTY_OR_WRITEBACK;
> @@ -2431,6 +2430,27 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>   			goto out_unlock;
>   		}
>   
> +		/*
> +		 * At this point, the folio is locked and unmapped. If the PTE
> +		 * was dirty, try_to_unmap() has transferred the dirty bit to
> +		 * the folio and we must not collapse it into a clean
> +		 * file-backed folio.
> +		 *
> +		 * If the folio is clean here, no one can write it until we
> +		 * drop the folio lock. A write through a stale TLB entry came
> +		 * from a clean PTE and must fault because the PTE has been
> +		 * cleared; the fault path has to take the folio lock before
> +		 * installing a writable mapping. Buffered write paths also
> +		 * have to take the folio lock before modifying file contents
> +		 * without a mapping, typically via write_begin_get_folio().
> +		 */
> +		if (!is_shmem && folio_test_dirty(folio)) {
> +			result = SCAN_PAGE_DIRTY_OR_WRITEBACK;
> +			xas_unlock_irq(&xas);
> +			folio_putback_lru(folio);
> +			goto out_unlock;
> +		}
> +
>   		/*
>   		 * Accumulate the folios that are being collapsed.
>   		 */

