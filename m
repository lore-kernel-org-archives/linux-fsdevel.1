Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891034;
	b=gK5FcppLPsf7d45QjOTDgguYpbIghKfdKhmgz2PsRnU8j/j80eKKAJFgQMW8jHIu0j/U
	 ap1jodocx2Kd8oW9YE1vnzLA2SZxlT67Otvv1hVzAlb0pJ5HCAfv+YPzGFX5oH0nqDG3R
	 qbRImWfVvs0mosOZJkPf/aXvpfR6J64OfyI/DhJMIY17T3t1vBM9jdBcaapUExePOogKm
	 FteyE0VmDv0gTldwjEegk9N0xqOAmtnmQZGxNs/ugogfqa1w1cmsEQCbjeTdKqbl9M5fi
	 Dz/YdukWnYBwgByE4g1qR40xS2ItztXLC9dXlba6ZQOqmoJN0qMxJ9cgjWn8Z5ekjfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=yUYUZ2LlOsiIpdrbhk1wJZRY3ayR3Noi9TQPGtDKtP8=;
	b=1ABMdKQLWb0RiI2aezlI3h5c9nXn40bIFR0JOUncHevedfeyPhiyLU+gRc5oZR+uNsa7
	 QDvkHuyf9Qd8C7419WnWnwMpRkGgkSryWDHqMlYjeo0K0vPpp2buoJTomHUxbt8GbbaGk
	 dNRE98O1B9QI4ENg98aHCFrffQaR+S86BJ5x6LWzosOZzlTZ/GeSIlQlftbrT5926+pcn
	 RnRLMNfV2+n9w0woSDOpwH7zA8B5KL5iI0ibZNVKwVAIhMvskoL0wHGMZ2ErRNHfbnWME
	 FXgWxLW4eJrGeSc13MSu+72N31R1o6Po8AoHOT5DKehlNjSa6u05cb5td22g2v4AO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=xGusYjGi;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32F606A338
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 04:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D32F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=xGusYjGi
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-170135e43c7so6784091c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794891033; x=1795495833; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yUYUZ2LlOsiIpdrbhk1wJZRY3ayR3Noi9TQPGtDKtP8=;
        b=xGusYjGiAdnGxncVaBVneIpjK1Ph9eHqEeeWt7lnJOkMFdfkTt1BtipRJ++rtd7axm
         TNY7mXokRzpdPDScm4nkTWyZVHSDCLj45TjHq4Sbviprep7R07QzTsdMPDa4KrXp2Rvn
         8lsnvqGG1oEchDAwidDM03GPkgBCly20w/qqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794891033; x=1795495833;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yUYUZ2LlOsiIpdrbhk1wJZRY3ayR3Noi9TQPGtDKtP8=;
        b=GM5SS5CppthVjTmo3DOYW9Nv5UbGEkmz0cQkeL3v+ntQCnWMAjZB8prmCJVn68DE3N
         hepqk5u3oI4cGmRgzz46xGPhDchBcBIOp3bp9Gws7rQmVcHdDyJmfXNqXypnJJyeqF7O
         rIWZ7U9z1H3xM9UTqhllmtq2Xosu2Xn97uE7aXze/hybzBrUz+YSBGn4DQc0ZD0C1MRJ
         XVVg4Wt/8AZQD7St1FQBcZYgeZ3jmZ2Fz/GvB74a+xOsrkgYEaRqSJ+4GrK5QHduILuV
         yvapi9aCvloP+8x5TJt3tguHTOfwNX8o0nTOLRJ92eJ66RBhg7jrd6Dj99bPfy1T6oha
         EVNA==
X-Forwarded-Encrypted: i=1; AL+hErEIq4I1LjLRcwSi02tnkqi84AkMLddV6CxqOo7d9oaYttNzFpt+cGRi7sL2wwM0EAE5jNEUdLj9dKdDW3DD@vger.kernel.org
X-Gm-Message-State: APuU4Z8mYoz38Q5YFxC01ORODUteEsgRxjLlL8swzVsNTTs8W+xxirtU
	yDkFR+FX0dfi+y+6btbsKKACPc8d9HHCmNbrAmNv3mdlE6GuEI12Jwmqtvit6EoReq4=
X-Gm-Gg: AYBFou1AlnW3Wk3F9AQt3Ov6eavS7bvUHBmcf6BWq3UgtINCffsJfsQFwmub4Iarxz6
	hJmmTvYI27q7Grpk+5UxpzaRpHuZC7S46GQeJw6dR/vR71SSf0GVSrvEx4kraqqaBzqYlq24utM
	J4J0LczE00obOlbg0GVvEujQgI+DR6v9/o42FbuBUTQd5s1Pk2YQCHPzZDLnGVkB/QyxuqPlyFe
	Fg8vto056je2y/VOKSrNhqc1XSaCdHfZlAAoDhm+Qruloo7JzDoxAXK2BH/T49YRwXf4R6O3x+F
	CgZcqhwAZdavrqlzQqE01PZ2zqe3I/I6p52jOnG4VJc4qYJXmBL7MCfsAKkZvyQEx9Ahr5UeqWE
	zUlVqoJXT1NikCzeQg8y53tkqjs6OzWdiTBDxDIjAqOozjtBiK2+s2mfplQtFVbm2atsFtdFqtd
	8gaMGFZCqoN1/PclR9jkqgII7IwPGVcbK5qw5sq0Pxzq85fBJJBsJ13LPb02B4AHmWZ3SBgE2fa
	YEEDCi0OlvKlX7fGnjt/xRjs+v6oW+MvOGw1inxYWaE2T+QF/OUXArFzjJB4yqc34Qb5RC1rnSP
	48rQLJXJeaJQkulJ6O+KSmty6jVzQPGOy2Q8eAZ909Cs+Qe5yAxWEOG2cAM0uc53S0TVeVwNu6i
	YlN3wel0cKmZUtnyPrVJVPWMwrRpRMs6CQaAniLohJvP1SziNq//Nfg1AuDbeSj7SXATkMs7OZL
	GIjJhNRVBFrt1o+HPs/KrD5rJc/UwNzduO3vs0W0mzsnonOSu7uzW8oUseNx/XuszP
X-Received: by 2002:a05:7022:1583:b0:1ac:1343:fa54 with SMTP id a92af1059eb24-1b503112a8cmr13989391c88.14.1794891033256;
        Mon, 16 Nov 2026 20:50:33 -0800 (PST)
Received: from [172.20.0.3] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm43375533c88.5.2026.11.16.20.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 20:50:32 -0800 (PST)
Date: Mon, 16 Nov 2026 20:50:28 -0800
From: Chris Down <chris@chrisdown.name>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: linmiaohe@huawei.com, muchun.song@linux.dev, nao.horiguchi@gmail.com,
	william.roche@oracle.com, ljs@kernel.org, vbabka@kernel.org,
	tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org,
	akpm@linux-foundation.org, osalvador@suse.de, rientjes@google.com,
	duenwen@google.com, jthoughton@google.com, jgg@nvidia.com, ankita@nvidia.com,
	peterx@redhat.com, sidhartha.kumar@oracle.com, ziy@nvidia.com,
	skhan@linuxfoundation.org, corbet@lwn.net, david@kernel.org,
	dave.hansen@linux.intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: memfd/hugetlb: memfd-based userspace HugeTLB
	MFR policy
In-Reply-To: <20261115160105.2507650-2-jiaqiyan@google.com>
References: <20261115160105.2507650-1-jiaqiyan@google.com>
	<20261115160105.2507650-2-jiaqiyan@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avvdFHtnw2BlE5Vq@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Jiaqi,

This generally looks reasonable in principle, but some comments.

Jiaqi Yan writes:
>+			if (!mapping_mf_keep_ue_mapped(mapping)) {
>+				ret = VM_FAULT_HWPOISON_LARGE |
>+				      VM_FAULT_SET_HINDEX(hstate_index(h));
>+				goto backout_unlocked;
>+			}

This doesn't look right to me. For example, hugetlb_mfill_atomic_pte() also
checks folio_test_hwpoison(), so UFFDIO_CONTINUE on such a folio still fails
with -EIO. Also, do_migrate_range() calls unmap_poisoned_folio() on any
mapped folio with HWPoison set, so offlining the memory block unmaps the
hugepage after all.

>+	folio_put(folio);
>+
>+	/* Refcount now should be zero and ready to dissolve folio. */
>+	ret = dissolve_free_hugetlb_folio(folio);
>+	if (ret)
>+		pr_err("failed to dissolve hugetlb folio: %d\n", ret);

This isn't a good idea when somebody else still holds a reference, such as
a long term pin from io_uring or iommufd (Jason was asking about the latter
in [1]). dissolve_free_hugetlb_folio() returns -EBUSY, and when that last
reference goes away later, free_huge_folio() puts the folio on the free list
with HWPoison still set. Now, while this sketchy page may well never be
handed out again, it is nevertheless counted in free_huge_pages, so a later
mmap() can end up getting its reservation against it, and as a result, a
SIGBUS when it faults. That seems like a real problem for a VMM with
passthrough devices.

I didn't check in detail, but since the folio has to be dissolved when its
last reference goes, wherever that happens, perhaps one way to fix this
would be to do it from free_huge_folio() instead, and treat a HWPoison folio
there much like a surplus one? That would cover the pinned case, and I think
it would also let you drop filemap_offline_hwpoison_folio() and the
folio_batch changes in remove_inode_hugepages() entirely.

>+		if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
>+			/* A new raw HWPoison page in a still mapped hugepage. */
>+			ret = MF_HUGETLB_IN_USED;

This also looks a little wrong, because a 2nd error now gets past here and
reaches the hwpoison_filter() check in try_memory_failure_hugetlb(), which
calls folio_clear_hugetlb_hwpoison() when the page is filtered. That clears
HWPoison for the whole folio, earlier errors included. I'd suggest instead
that it only undoes what this call added.

Thanks!

Chris

[1] https://lore.kernel.org/r/20250120172626.GO5556@nvidia.com
