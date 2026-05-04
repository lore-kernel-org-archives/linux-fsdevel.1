Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1323D2A1
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777867325; cv=none; b=GkqY0irWeVl5Okn/jhQCII2aMvCo9ZQJugGcF12scjltltlkExk4rFvBreDqZIfUwnqsKlEFFJ5Qc0UEYEHzgpWoYh0DDxNALBwys11qckKfl0BsGBW2ejPW8Rhbwg7rqZlu/y+qg1beqTPZZsxL09mP0G5WxPVkaDYsNmvpY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777867325; c=relaxed/simple;
	bh=3P9PTGXQEqceejzlt4oB6hCgg6/9NoHPJVWEt1XjDfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCLI/ufXARDxpnqh79KUzBuAkOhsxx//kA3gpX9vcDM5UU1rhl9+1JWR97x3qVaMjDDSHhj2O/WdRLn1DghLapLBYQkTA8Wcb8eL2MNyauKI3kdnQZOzuKDEro98jsA//GN/JTxV5TDemmg1eOWSomHyB/rlJbkrwMqlDTF/W/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ua8w5baX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahR74mpf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua8w5baX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahR74mpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777867322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+5Um6TFBnBOiuOAmXBNCCA71a07CLbH3rgRCp2jTGs=;
	b=Ua8w5baXTyx647bYp7W1t231fDT7If2CZdyS+eI13gdUGfJdDE5Au+oL2fz356thMlE050
	i786VyLj2payeqgZdYk+2U5mdEiGIWsBimOqCw2cnko0rgRRj53ZrcFhziCfVgfsMIL+MD
	G4T4WAKJ5Rv8ZiUPfDEwdYc8e6HH51Y=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Oaqj6jACOaWVsj0O86v6oA-1; Mon, 04 May 2026 00:01:59 -0400
X-MC-Unique: Oaqj6jACOaWVsj0O86v6oA-1
X-Mimecast-MFC-AGG-ID: Oaqj6jACOaWVsj0O86v6oA_1777867319
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd5c42192aso16176277b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 21:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777867319; x=1778472119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+5Um6TFBnBOiuOAmXBNCCA71a07CLbH3rgRCp2jTGs=;
        b=ahR74mpfjikES/sgx6xLa/BlnQXifJ4h6HXe6qLXrKtEC+bL/gABxFJjjNfMC+/5/+
         nLzFjIYylBjQS6n19zZio8rwBbMNlVLjdJCyUuOPC4QnmMrzjdclBu7n1gQoAspU1ceb
         tTrQOPRRr5ZBbRvkiy1c4gyyh7HMuhVAfJf0cW2ewvvT5HWPyI2ucfpBcTGTJW4YoYrK
         Ciqn3wQbO6iQaR3BbY74WB2sf/sIWETkuMl5SDK/HhynLdPK4WMSldCyOr6+DnDEiSc1
         mOAI6eEsXjYjx5x+CEPn1RhuLqLNo52XiK2DxOB3sebtOzUgUWZeEpLkszuiyy+lDtF2
         lDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777867319; x=1778472119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+5Um6TFBnBOiuOAmXBNCCA71a07CLbH3rgRCp2jTGs=;
        b=D1+OtfbnDegCD8+YSFsRRzk4tLMxe5EWv+vyCiZJZJnx34nOFPH3qSY/98mefNsxRs
         Xo0is1IpykBAlcT4OOLB8epCin5CbbLDZMsjDoYkB8Bzp9cnKWNWGwWL+GYXEw0BYR2m
         MVM7UPRQ6WWG517s7sXNySnDgEcW2I/29Pe560vjVuSVRcTFKW1XsXfUyUC2BGJg7qY+
         xS6Ze1ffXHWCMBJHFuUARpG3/MtfHF/kOAs534whGp12K7Kx5aRaL0LAAiuCxFXOatJv
         4prVam7STeR3El+4/eQFYqfrNu5XqVeZkV73hcaqu68xjBpBeImQzwamaIufbL+l8Vte
         z2sw==
X-Forwarded-Encrypted: i=1; AFNElJ962gdOW3NyTdfKLd1FUO+l6cB/TtGw7cHLlv5rbWmiYSJTpDvgMzltOaXIOlOV0ZoiP/c+DWVZVPy+4b6L@vger.kernel.org
X-Gm-Message-State: AOJu0YzlYUKSVxVuND9FgVi4T45htqbeJx4GcF+iS289pCGUNBrx7zY8
	lC9VijzsKLSSb18IkpWhg/B1mMslqOMvXjKgjtdm2ydwtIh7lSZ/gtAFzdtDzqFqKQS1EH5NP+z
	4v5LMBO8T3Vib6UbDBJeNgZDUSJFQ6gG7K3SEXdSjnWbsSoON27pawbr6PKXKdygEW6s=
X-Gm-Gg: AeBDiesrsKowWzTR0vCrFCeOkEiHIeRVEEqG+kbyj+49t3+nmw1LCMHNjO7RGIm1MtZ
	AVBbi3bGEPfS5apwy7ADrB9eQa+BNx+WFSwl0eMVSmC9krTu1lKoPhWoSMSoo3jL+Mp4YzTls5H
	IP5ImupXKH3UO5QS69qgEw92RzmyCd4bCbrcWSnOsws3KfLHSOU6I0e9w76McNq2SbpAO+uz65T
	DyTz0EYfqwnoomJmiSJ7zUQ6NY7dosXshCwG4ow3JuwZ40cHcACHZM8qHYoU2/L9OKHcbeooUDl
	a2GPmEcwQxE2JdIq1X6HZDQSAy9mwvCm6Ve1oc4cJ9cDbDYF0CqTmPDXJOv2UhBNp1uRmZS5Cqy
	o0gXMbgt8UzFz+552O16zUA5Psn5zNF0wvchnEv33nQAeoLUDzX8YodJ8KeK6cQyiUQM=
X-Received: by 2002:a05:690c:289:b0:79a:b440:5c8d with SMTP id 00721157ae682-7bd76928ceamr64734307b3.11.1777867318931;
        Sun, 03 May 2026 21:01:58 -0700 (PDT)
X-Received: by 2002:a05:690c:289:b0:79a:b440:5c8d with SMTP id 00721157ae682-7bd76928ceamr64734087b3.11.1777867318535;
        Sun, 03 May 2026 21:01:58 -0700 (PDT)
Received: from [192.168.178.105] (78-0-206-107.adsl.net.t-com.hr. [78.0.206.107])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6654e464sm44456777b3.14.2026.05.03.21.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 21:01:58 -0700 (PDT)
Message-ID: <0c385b67-035a-4f66-8f3a-febd68a9318b@redhat.com>
Date: Sun, 3 May 2026 22:02:30 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/14] mm: remove READ_ONLY_THP_FOR_FS Kconfig option
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
 <20260429153538.727855-1-ziy@nvidia.com>
Content-Language: en-US
From: Nico Pache <npache@redhat.com>
In-Reply-To: <20260429153538.727855-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/26 9:35 AM, Zi Yan wrote:
> After removing READ_ONLY_THP_FOR_FS check in file_thp_enabled(),
> khugepaged and MADV_COLLAPSE can run on FSes with PMD THP pagecache
> support even without READ_ONLY_THP_FOR_FS enabled. Remove the Kconfig first
> so that no one can use READ_ONLY_THP_FOR_FS as upcoming commits remove
> mapping->nr_thps, which its safe guard mechanism relies on.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/Kconfig | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e221fa1dc54d0..27dc5b0139ba6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -936,17 +936,6 @@ config THP_SWAP
>   
>   	  For selection by architectures with reasonable THP sizes.
>   
> -config READ_ONLY_THP_FOR_FS

Yay its gone! Thanks for working on this :)

Reviewed-by: Nico Pache <npache@redhat.com>

> -	bool "Read-only THP for filesystems (EXPERIMENTAL)"
> -	depends on TRANSPARENT_HUGEPAGE
> -
> -	help
> -	  Allow khugepaged to put read-only file-backed pages in THP.
> -
> -	  This is marked experimental because it is a new feature. Write
> -	  support of file THPs will be developed in the next few release
> -	  cycles.
> -
>   config NO_PAGE_MAPCOUNT
>   	bool "No per-page mapcount (EXPERIMENTAL)"
>   	help

