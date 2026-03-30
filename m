Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F133B2FE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865431; cv=none; b=h23jbQti7ElHLqeJA63FyulFpCyueclDS/MSmrYLLW1hkLYcSbs8EoFFFH0zSBeDxlepVkujNAKX9Q6RJoDwXGhGPXJGxxYVdNNFnEQdu8DdXbo+Y80qehvk9HrcwjuJCfzankWjYP97A1C90QZGTs2XNuOAIFxCSia5p7IDQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865431; c=relaxed/simple;
	bh=68Be/Kp4UaNAkfdH7LcHkioxTlr5rnpwO92KGW2bPHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+m+ecUHMjRX2w7Aqoic3GjDW5KyQRu8iQJHgaLfq85mKuQ9I9d5WufUtbhRJl91u/kAOBu8RLcJXvV2EIlrjQokYNtxTx42Nj5V4sDbtPZUbuTTbbiCEUQoby+EX/rJwAmr3TjKbfDM7+KULGnQCwOUxWOx8DOMB9kEiWQXxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfqXpm1L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWhSiihM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfqXpm1L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWhSiihM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774865429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpuA7dRNbkH8Q1aS+IRAmWnuwSwaRl+82FW2DyUbGL8=;
	b=TfqXpm1LWK2mhNiLJXybN1g93KgBGCQHz+G0stEbKULOmLM6XG58TUFe448uzUAT9GcJgT
	VoJnhrqW5YPn3bdwwGssj3luWetyE167Veo78/Mc0EViiNxHoasqisMP/COKGnctZaK74J
	y3mRxjX2Y9YIdn9TqHUeOrY5K5f1g2o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-cJFEm3TQP3GYUpgMHKMAcw-1; Mon, 30 Mar 2026 06:10:28 -0400
X-MC-Unique: cJFEm3TQP3GYUpgMHKMAcw-1
X-Mimecast-MFC-AGG-ID: cJFEm3TQP3GYUpgMHKMAcw_1774865427
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0c30b51bfso115703025ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774865427; x=1775470227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpuA7dRNbkH8Q1aS+IRAmWnuwSwaRl+82FW2DyUbGL8=;
        b=AWhSiihM5ryuKREc9m21s5+Atf1m/waYLP70CxkmzzMr+B7ZAgtZOP2T9piSIduLXf
         uocCOJMyfxst/7cQfp+VAUmvx/R8bD3yUmth4gGDgZh5oXYY3aF79y5awM8NVPVqHymN
         znUVclsHVJRl1g3UqSpm0RRh0s2+g02XrIMQjgmr1zqIu9zf2dXSoF9xLNmA10zOZ7BD
         2aezMq6BuXBwBxcZGjpQzDdVbNJ4mrulW0Dx1ucnf6h2XN7r5noVRy8pGJeqY3TLHuMp
         67MqbVCg/gyJghWWxYbd8gN7V4HVO00RU55ZN0SrZxZ50ABs9ePuLbFwCLGAWnLrEeYT
         4ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865427; x=1775470227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpuA7dRNbkH8Q1aS+IRAmWnuwSwaRl+82FW2DyUbGL8=;
        b=HapuFak9DZpn8kMl08gbHLRUq5GDWDhem/FHlbjlKhJCeq7BIV+huZFgjHUahgMjVH
         VT6+Gm2Adyte8onnqipC8BQyalPLM88G+wTH1aUBZyd6dUNgTQo1b5GJDvZzO1YtDYgK
         5eak/tzzCkpG8wFZ2ah+8l93z9N+hLINCer1TqYiHH2Ix2qbH6czopgpNc92b4Bdi9FW
         Ut1UtYF/ZS+OJBLCCJaLcK8mBilOpX6H+dbLIHyRJU49JRmxTnYN0wUESKX/BX8MyaaU
         qQhD109/9WSwmBuWX2MSfu9iO4G+I1Qa0bwJaSXHY2VYuhFIXX84dFunklw/rAlhHZXu
         uazg==
X-Forwarded-Encrypted: i=1; AJvYcCUscUqVPXvFdQNZ/rmXLfIr7MRODuco91fHfrorseZH6k/MxPn/FZ5g+XTlrnJbyXQT3aB/DGdIls4sLTX+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWytbwg8fp0khT5ZUzx89wzv1to1K200Fj3XNR63X+MU0BVDu6
	UnmMYbBWlNBJ+CJsDSU9Hnd18maVGEmPQWHZrKpc7XjsaHd77E9kPd+qxqxjBXHtFM0dF1MFpRn
	zbzV7/k/DQmd521YJgYS8dZqIbJNoEmy7vVBtsVuMet8Un38f87cpfIAs2UYTEiW5Frw=
X-Gm-Gg: ATEYQzxoNY/hhE9imWdCfL01JWqwtfqu5x5jFVUObZvTF2KAKhg+Mr0mjGsbnW70Wbd
	IUnJBWCS9ZudW+UUybEKIzsdVoE0a+TZLUmApWDt9fFwmoB5ThrxhP50Okk2BGipUi/BmZMWhBb
	ySu3XXQ2juaYNJhkZCXHYYJm+/20GFNYPZUEZjsYiaTR6Nr8p4c8VDQV/Ah0GgvJ5efu/ImyLJ3
	WJ97xF+eb92wyyeZxkpszzvUzksEL+p1Mp6icNnUuazDeOwBN/2PNiIIT3RPPF+/IXL/qfm3n6/
	wxhKq1umOPM91UTijmdCN5vLObMB2/20l9m9wYpQ06efTbPhqlxpjmEUHbsxV6HuQ+eWcjvRL/L
	9kvJxtPXQOE33X50oMw==
X-Received: by 2002:a17:902:e852:b0:2b2:4029:d781 with SMTP id d9443c01a7336-2b24029dc37mr93217715ad.20.1774865427054;
        Mon, 30 Mar 2026 03:10:27 -0700 (PDT)
X-Received: by 2002:a17:902:e852:b0:2b2:4029:d781 with SMTP id d9443c01a7336-2b24029dc37mr93217465ad.20.1774865426569;
        Mon, 30 Mar 2026 03:10:26 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277e8d3sm74371865ad.55.2026.03.30.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:10:25 -0700 (PDT)
Date: Mon, 30 Mar 2026 18:10:23 +0800
From: Li Wang <liwang@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, aubaker@redhat.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
Message-ID: <acpMD8tRCJhgXHeg@redhat.com>
References: <20260330053915.75442-1-liwang@redhat.com>
 <a5b7add7-0507-40c0-a324-81f243ffa261@kernel.org>
 <acok3JY66OcV0Qab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acok3JY66OcV0Qab@redhat.com>

> > Why can't we simply open the file once and pass the fd to run_dio_using_hugetlb()?
> > 
> > fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> > if (fd < 0)
> > 	ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
> > dio_align = get_dio_alignment(fd);
> > if (dio_align <= 0)
> > 	ksft_exit_skip("Unable to obtain DIO alignment: %s\n", strerror(errno));
> 
> Yes, apparently this is a good suggestion. Thanks!

And, to make the test elegant, I'm going to add check_dio_alignment() dedicated
to alignment checking. Then we don't need to pass too many args.

Tell me your thoughts if you don't like this:

  static int get_dio_alignment(int fd)
  {...}
  
  static bool check_dio_alignment(unsigned int start_off, unsigned int end_off)
  {...}
  
  static void run_test(int fd, unsigned int start_off, unsigned int end_off)
  {
      if (!check_dio_alignment(start_off, end_off))
          return;
  
      run_dio_using_hugetlb(fd, start_off, end_off);
  }
  
  int main(void)
  {
      ... 
      fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
      if (fd < 0)
          ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
  
      if (get_dio_alignment(fd) < 0)
          ...
  
      run_test(fd, 0, (pagesize * 3));
  }

-- 
Regards,
Li Wang

