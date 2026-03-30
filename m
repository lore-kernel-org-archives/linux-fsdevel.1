Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBB3CA486
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871863; cv=none; b=Wbk95aM+SWNLzm7q5ComXnIyO3BqkviOODfs4I7bzljQMQZFbEoxpmpUqnN7lJFOHW0ZapcQJsQj6Yndk+MmYYUGSGMDScszZ7062rj/ibIoM9jWrAGozMkoJWyS8ulvJp8uwcJYAVeC+rJrVziUx/FW0ecwCm7g1oETov4CySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871863; c=relaxed/simple;
	bh=G/MG5H6UuEW1K0dEZB2Eqb+2kb/bNUEKQCUCpEF9Ymw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPbyoIHqxst1V/ywW9BrQVsfkzeus0Pu2RTlWTMx92sSa3saNMOMz15pnHa6JrT4wn2qaYyP2K9T86mld7AJZF/PJiZdfGEhHOu7z7W6/6xC916jZ6dTTs43Cq64r9T6kQ+lOUXVaJyzi6q69tmbSCDY11yCyBrSB2T5H3IXVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHA2SZlE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B39v5VbJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHA2SZlE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B39v5VbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774871861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh1xNXHxs6tIJU6BgE1ANOu6D34D8WcIS3q00d1KgWo=;
	b=fHA2SZlEJpwHtJMZrUDRjEw3+hcmzJfc0ELv32euewBlJzlK883MtAIbApCNxsgCpjhhAA
	g4Re8rlTEazduaPTGE1IrinPI2BnXO8Y+s33rBBdxT3OP+jxSlc5F6MQrSaBXQ9WqWXrj3
	Q4PZGh8bPNQbhTR0G+Gqc9TT4zaOg1A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-rETSnsJxPAa7eTaaoNlZQQ-1; Mon, 30 Mar 2026 07:57:40 -0400
X-MC-Unique: rETSnsJxPAa7eTaaoNlZQQ-1
X-Mimecast-MFC-AGG-ID: rETSnsJxPAa7eTaaoNlZQQ_1774871859
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b242062308so66657355ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774871859; x=1775476659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh1xNXHxs6tIJU6BgE1ANOu6D34D8WcIS3q00d1KgWo=;
        b=B39v5VbJPNsHpjH0rkY774c3ygZTxZj2NSy3YMSL54T3adPQ9cH+akHsMgP2n9XZ6G
         x7rSDjiIquC98C2UZP6esTOTanplOGpHwe9C9dJH19JOp56h0yAmmNMwFmaxLF7xnL4z
         Rs++TL5PSY1Z/AJmwe2D86zPtDfU0Yym35y2K6kTKrHjViy9Z+rWlKMkIMi63PyUxq5A
         Ck9nlVFb0G02Stszlz2NNIucOeQBm/TF7b6w8lAU38I3oZX11+1yZgwgUDbabAAcplF3
         kFFbsl/BSEvrNBF8ostUu97f+QI6FZZ6jcFr6trgUmNtp18lw2qPGzYMk9k5FUJm2pVi
         07yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871859; x=1775476659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uh1xNXHxs6tIJU6BgE1ANOu6D34D8WcIS3q00d1KgWo=;
        b=Et75RV3hEZ/hGT4NW9edLC5img3kq/ZpS9D5xh3xJbVjgDjLcgTbTQrzAAIXlmD1Zm
         RvhfL/9QIhE9Yf71RpwLEjGONj22CGn/i6KLVgTdBHiWKUgMDfavutFiawc7TRHJ5X0u
         pjbf4vl27Gc2yIN14SbtVdvq+nEBgtmSchgnVlTM3hvb0S9nlXyw+UZUnJJg95FLMB94
         c0Fokr8mOFdEVZC1/9iDqp9lnRwzcmuCNSgajslTuHmdQxse6FTXbO9kADMloBVtVh9s
         CCvFjFqSs3iyv1/AnuO36TFwIvx7J7wl0IZD+54IZA9mcvrMhT8lYSyPeYsNMR+dNxbv
         5dIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWREd0niUHdP+qt/aZuA6k8TZgSx8YUV1bJfSd7CASU+BSHyF9HZFjTRGltfOp9Dhd+2Pfv9n4fwsBBNnRj@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDD9JKHGlXABRTqLK05mJD1IBvmI7HLJ2FYjQNgvuZ1QirPHI
	OoRxWtgwgK/vkERhwUxnYLvhP1N349LuLqHqS8QDu1r1b/JIopXFb2bwQ/hXy2yrD3pjL9D3xjK
	YqcNWewYJnYxQxUJlQcg9S6ZwFVmYwalhz+QRA7GMS4wCTOjNvM+VtMHEpynhKV+ax/U=
X-Gm-Gg: ATEYQzytCi/sYjrLUwqJ9sKM7foNFvrLoYQ+aL5kFRjQzGx4alVtQ7RaCV1lUgbLLkM
	E14Un3md9p/DRNvUl7f8lds4MA/67jTeFvP6kYatFuUDeVyLm+F8BNOGPhtuJn+ELTWTXu5s26c
	/U+X4rwTSbZi6ho/LRQ9zUCVvBVRPbIvCFoTXGL9tdCR8iP2Gz3uUNmQdtploidK6nVlanEGWcK
	48V031f1k1RIpKVpjS6aTx6XvCqNBfX7SU1votW2mZda06zekhT+1u5Ply0rfkib1D8op8gOKyf
	U4DfHRCrCc2nTAeVQO9ZUWVskZM1LCBB3p+1fpqEGIAJVJexwFdC0AzKK1w2FNyBFpvNXxZq6gF
	0ni5sX3Ns3Ea+wxinSA==
X-Received: by 2002:a17:902:e84d:b0:2b2:481b:de6c with SMTP id d9443c01a7336-2b2481be11emr68540955ad.10.1774871859281;
        Mon, 30 Mar 2026 04:57:39 -0700 (PDT)
X-Received: by 2002:a17:902:e84d:b0:2b2:481b:de6c with SMTP id d9443c01a7336-2b2481be11emr68540635ad.10.1774871858854;
        Mon, 30 Mar 2026 04:57:38 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765b9fsm94275665ad.43.2026.03.30.04.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:57:38 -0700 (PDT)
Date: Mon, 30 Mar 2026 19:57:35 +0800
From: Li Wang <liwang@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, aubaker@redhat.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
Message-ID: <acplL3cHWqp0-RMO@redhat.com>
References: <20260330053915.75442-1-liwang@redhat.com>
 <a5b7add7-0507-40c0-a324-81f243ffa261@kernel.org>
 <acok3JY66OcV0Qab@redhat.com>
 <acpMD8tRCJhgXHeg@redhat.com>
 <a1054c28-b574-4fcc-afe9-5e902209a22c@kernel.org>
 <acpgFlG4qj646hYp@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acpgFlG4qj646hYp@redhat.com>

On Mon, Mar 30, 2026 at 07:35:50PM +0800, Li Wang wrote:
> > >   int main(void)
> > >   {
> > >       ... 
> > >       fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> > >       if (fd < 0)
> > >           ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
> > >   
> > >       if (get_dio_alignment(fd) < 0)
> > 
> > I would suggest that you query the alignment only once, and forward it
> > to the test.

Oh, I suddenly realized that you meant to store it in a local and forward
it through to check_dio_alignment() and run_test() as an explicit argument.  

Sure, I'm ok with that minor change:

int main(void)
{
        ...

        alignment = get_dio_alignment(fd);
        if (alignment < 0)
                ksft_exit_skip(...);

        run_test(fd, start_off, end_off, alignment);
}


-- 
Regards,
Li Wang

