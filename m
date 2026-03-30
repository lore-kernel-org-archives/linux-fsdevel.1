Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B438838D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864745; cv=none; b=JmpFDVMPbx0eoeD9pYn0nBmdiPhBG5u6FF9oK0gwL6N7tC8bD9qsDmlg/c1wq8dXNFoNv8JNAUMJtD2Mrk+1ADSnTMnXYqgA4hPCpt1N+Eu8SgyPaBzjcW8zzdRjojIb+M79tqqpR96wW9KRmN/sF94XBR03l/Jm1e18y+Mwkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864745; c=relaxed/simple;
	bh=/+x3NIpg89NdgGwjYj/Ur6/xfp7eg+l3YHCpEql0vXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5Ck3hsOdiu21GKzFDy1LWgvQTp8oDGqLGWFIwBAu4+FiABC5FmmkflOc3rODKA1hnbfyc7Xuu31OgnkNXF2nPfNdtVKhailhJQGZB5JwF9alXpSU7TuzIWGRDPhLUmRYrYZEAkVx1QldlSTa7m0Gpe3oYZlE0TrWr+7CsPavJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8agGshX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/58JSv3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8agGshX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/58JSv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774864742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol467QNmt0DQ6eYz8EW6+Q+7C35Qnp9U6TLS9yRvFHw=;
	b=J8agGshXjPpFTdLcYnkGFIJnEIUG9dYzEmXuMhbFu/QXhYj0Fs/oXqJcuh0TBwEWyzadNl
	8KSmVEQcLNfdIQ2t8E51xfq4N1VzK6Lc7C4vtIEa6mcVP2eJssCPbCOkFCdSzaC3/P9LJH
	vS3EI2gVYurnMh60e+UtM0kPM3LqbAA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-kGSHB5ccP-GXk9BO1d0EiQ-1; Mon, 30 Mar 2026 05:59:01 -0400
X-MC-Unique: kGSHB5ccP-GXk9BO1d0EiQ-1
X-Mimecast-MFC-AGG-ID: kGSHB5ccP-GXk9BO1d0EiQ_1774864741
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35c1107da15so3176339a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774864740; x=1775469540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ol467QNmt0DQ6eYz8EW6+Q+7C35Qnp9U6TLS9yRvFHw=;
        b=U/58JSv3JjO6C//qyapHFxYXzGlvSMBb+H5DiCzHRbQmdiOza7dtson4mTP525xN5c
         D1O79VlqgwVK1AmnkM4Ww8zwHSIiCrX7lDZJh69hgIBLOF/tt7A17Y2hWWVyNB8tbzEU
         GLIF5l8guWGTtbJnTuQJhNW5Iv/AAveXV6hPPKQTEJQtFYa43rhoPQbGPnbGPuRZmERx
         PNkRbXDOJxx++d5VjfLIR4LMbkOdwAWPFLZzfjRwYbCd9OQvCbCbB9sWYwGrC6Vp7MJp
         7aT2VxHCJCwEb6uNiy+Fn9Cv7RyZTNZUPJi/8Rtt/6hWdQCUHccQK4Ni/Wz/jy1HzasN
         7tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774864740; x=1775469540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol467QNmt0DQ6eYz8EW6+Q+7C35Qnp9U6TLS9yRvFHw=;
        b=q5qXnuyKzIhByUscuhOXcRkFufXJAKGwRP+GRaW1GhvkWa9UiTw3MkOCmasMVD96Vo
         bBQawWWRV3ixVDZ807lgDfVf1n8o7ea6elxs+gv6TyYVEZAxAAuuF9rccRGFkuRMGw7D
         Rb7uSm8Bd1QQNswH1HSB7gSQHJBQVlsao9kEltRDc5SYl+hs21zu3oEWC26yGq74tygj
         gVEYW/dxhBxYhvnQccc3sibq0IlUrCe6zmZx1A/39ISZSPf/jk1QszR8Srj8cloh13je
         QkLNaFQBvV2hRUFjnlnow0rqe5q25PTsOQVOrVt1g2AsZDC6JwLaTxgSWGB3E0HIQ3LQ
         cd6g==
X-Forwarded-Encrypted: i=1; AJvYcCX8kIIOZ91SCZ2TQyAOCcc+tw7Tws23TDvUHgMU9IHGGMOZ33wHxRo7VFwzPpduQMyEnxEYggRHG3dvvXuG@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTwYXE8kvUBdmW0UVEt2UAVCxVYFk7DRH+rYAT5LkidmzfOpH
	+hBtgx6JFWGNEr5fqvAIAng/92wfB15O7Qyh+ck5Alyc72dgMqAAZFc4cTcD+CRP0iynjqYHF+K
	a34KUCezew7OvKnP/KthCF68qk7xhio3Err58ubZkWblzZbF+QUv/VD7p4J+4UOXWKkM=
X-Gm-Gg: ATEYQzzv1RoGkoVrgV7JcRPG6/toMIbFIvPb/spzqz4QEQQ2+Sqnm8BuQsX3bnVLg/r
	Bm7zjdqUp+G0DNme+0jZ6w328dgASLKK0hNvzgzSrV5LaYQJ8VdlZnA4GB0d3Rl2COID8Evmx9s
	XRCi6B8qbNgtnPoWToUMe4N7f+6tyEdd39y0TUmAj9nxCS8EBx+38QBrpW6ADf2WizwA2820p37
	OCtBdA8AUmu9ormziImkPFmUQ87PP12YcHR0CJp+dRKgUoBjghCUbfmRFQfnvMYi4qAvs3aJiEc
	T2Cm93XUyaD1X1A5jfnrmJ48KPqSq2r5vKJvWp8xzMPXkFuV+6sJ3v2yn7KEJIzYxP7EstE3jfm
	p60BktuGSBm+HUvbI0w==
X-Received: by 2002:a17:90a:2ca4:b0:35c:30a8:33a with SMTP id 98e67ed59e1d1-35c30a80a1amr6873865a91.12.1774864740160;
        Mon, 30 Mar 2026 02:59:00 -0700 (PDT)
X-Received: by 2002:a17:90a:2ca4:b0:35c:30a8:33a with SMTP id 98e67ed59e1d1-35c30a80a1amr6873768a91.12.1774864736640;
        Mon, 30 Mar 2026 02:58:56 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d908216ddsm3613964a91.5.2026.03.30.02.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:58:56 -0700 (PDT)
Date: Mon, 30 Mar 2026 17:58:53 +0800
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org, rppt@kernel.org, david@kernel.org,
	ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
	surenb@google.com, mhocko@suse.com, shuah@kernel.org
Cc: aubaker@redhat.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
Message-ID: <acpJXRokicaD5XC1@redhat.com>
References: <20260330053915.75442-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330053915.75442-1-liwang@redhat.com>


Reply to Sashiko:

> +	if (start_off % dio_align != 0 || writesize % dio_align != 0) {
> +		ksft_test_result_skip("DIO alignment (%u) incompatible with "
> +				"buf offset %u and writesize %zu\n",
> +				dio_align, start_off, writesize);
> +		return;
> +	}

> Does start_off represent the memory buffer alignment rather than the file
> offset alignment?

> If it represents the memory buffer offset within the page-aligned hugepage,
> should it be validated against stx_dio_mem_align instead of
> stx_dio_offset_align?

Hmm, I don't believe this unless you give me strong evidence here!

After looking though Filesystems for handling the direct IO process, I just
found that Btrfs does the buffer-address alignment check but it uses the
dio_offset_align rather than dio_mem_align.

And, the check_direct_IO() does not actually distinguish between the two
alignments in its fast-path check. It applies dio_offset_align uniformly
to pos, length, and buffer address.

Also, I tried the reproducer on Btrfs, ext2/3/4, xfs, vfat, ntfs, all get
passed with this patch. So I'd keep the patch not check for dio_mem_align.

-- 
Regards,
Li Wang

