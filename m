Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F3394478
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855398; cv=none; b=o1a/TBvBkBiwYLYSSB5Z9m9PJhEIVowu3bTS0F6ar48Q5ycfD758+4M3NZ4WuAgR7Qs3qK7Rls//aYeDqwK0y3cBqMG2LmZliMvS4iL6HJZ1gOdAIvGybmVOucXV/o3vhHgXrs0oJ0jspXQc7vQqy66354Y2TInHXRDDBnfilDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855398; c=relaxed/simple;
	bh=BdSusAkF/oQFRNlMBbzmWyLxgLq1gUDuAB+K4Y2gWQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYoj7UjAexi2mzcNIvKnaM3iEdAx937CEsWKAOqw6e3OCk86+ngHgH3kQ82KHdoPGzoLq3tC82HO4sroFDyJ/78dLN/XZ2iBa0agMvWTrSNdG452znQlsh7kB+ZfKGXtQfHG4LgSYFT356KW80x8bnuDKLJryqd+ZaBGHrRPsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMEpqDF1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o/t8v9A8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMEpqDF1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o/t8v9A8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774855396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ0LQnOR95aHR/QhroiVMVa82mQ7m1GAsbziC8rzFfs=;
	b=WMEpqDF1IsSpKcYeTheT7jZQV3e0uHXH8WMORTcl3MuLZdS12VukbC6XlSnNKducwLGs8x
	g4x0avanpO8QYv1cnUjmpMIjNA/S7G31WTYmA3Gam+Kb7pqm/MnQoS9FVavxblmwN7V+mg
	SR5OXnI2EgzDdD5RxccgU6tJVa9yrDc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Ufu3wcb_N3uoeQU8l6L-6w-1; Mon, 30 Mar 2026 03:23:14 -0400
X-MC-Unique: Ufu3wcb_N3uoeQU8l6L-6w-1
X-Mimecast-MFC-AGG-ID: Ufu3wcb_N3uoeQU8l6L-6w_1774855393
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c699d8caaso7954402b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774855392; x=1775460192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ0LQnOR95aHR/QhroiVMVa82mQ7m1GAsbziC8rzFfs=;
        b=o/t8v9A8KR68HcG5x2EwxpvqoBw6yf9EgNBwUNc531APA9cqkRPhD3bRfTPQvLPbS9
         PMAdlZyy1zBQZmIkX5Q9vHpykExjqy4uOd/coc2xESyFP46Wde91mzIx3mFi2+S+aGSq
         65PGdIcvmIkQeEhjdXfiZs9SCLls2lRt6IQAIbKF2900mo7Flbvw8XowAFfSfNWuMr7X
         eJo927pNbKcvT/mWjgMdb6nWff5Qjda3vWadtud82EQH4pu+Mg/gOtoiPWPj6V6xiGhf
         KU+HAzLP7tV4TL5OSh4RtdjDlu8An1DpFSS6YvQSIVe5tDO977l7ZelJObX41GASGmj3
         J7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774855392; x=1775460192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ0LQnOR95aHR/QhroiVMVa82mQ7m1GAsbziC8rzFfs=;
        b=jpPd7d6nsQGUy7MO+R0lbwLORsQLhjB8B/AgCfu0Y+r1XgbReZV3o6rduy90uEY8ms
         fGKGwkm2OuFM1uWgAH+26vhdBq4vrr8TGULH7TOQyz+NxKUHZcuVUgyEYsNcfGs/U7hq
         sG7JBUNUyR8dhyoSTs0Kc84Y4QozeI/wUHp73w8GrkQh9AdtjOyHpAKIpAzpU1OBv0Yw
         mJ6l1bnBODSeyv+EbcZ/Rnbugglz6c0ff52G+pNVp8+OHxEu7TOlbc6NPbbYXUr2AYEC
         yH0E/WFWh3o693nTSBPogSZ3DeMfUWkOd8y9C8wZFunl7630VtuJQVddZ/BeYJnzqssO
         Bcqg==
X-Forwarded-Encrypted: i=1; AJvYcCXaraotqGRgiMRYVMeuyF2CF/nSa/2+yXY+1pkSkS1H18MI1dH6CWHhnyQIg7KDF6DScB+D87ZXiDNlK0vX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxey6uZL0lWeJwzlWWGmnEQiHL4iUBFmAx3lQd4TQoUgkc5Ou9q
	o5MMT7udSCnPybF7jVNgIbwdI185lMqpVecerJlt2RMmER7UTrqj9jV6yo9xDax+kOXgseX50LW
	pxvlVij4JWXo35uwESW7kqgfSfVUa0ITL/myzFI9IpY0TCxOYg6UtovFwKmOo6mS/7siYylUayx
	A=
X-Gm-Gg: ATEYQzw/N1p0/WgY9ssahN66GglyLQ+g07cSxZ9AhGxo3r+K/ALcfefHyV8wp+2BEaE
	X1dboMNp6GPiBMqI3GelmjHoG891kjFs1o4I7D6gOAlQu3zKP/nv55JNyybLOo7CI+bqLTnlHBN
	Jgdg4w7QianQfDEl4ZT5GeWgYzRrXysWqt7WNvCW3mru2hY6v0MiOzYIi165G0FTlceuMlZZPRK
	kBukw4CB0xxIxpWNx7jvszSbvDGuU+qcHCdl+YEqFuV6CQL3jCMXOsUBgzdEFSFVXMs1/30eHsb
	uLIdKOw6awyA/G8VSLbUU+lSE+dsPxjRwlmYAP1vMorUqRVhRg31yUDSZpUqR0GOHTdgYXGsz1o
	8cdiI1PU/AGWdCE+4cg==
X-Received: by 2002:a05:6a00:2d01:b0:82a:79b8:2049 with SMTP id d2e1a72fcca58-82c95c21e4fmr10957441b3a.25.1774855392514;
        Mon, 30 Mar 2026 00:23:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d01:b0:82a:79b8:2049 with SMTP id d2e1a72fcca58-82c95c21e4fmr10957402b3a.25.1774855392034;
        Mon, 30 Mar 2026 00:23:12 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d3a71sm7217393b3a.30.2026.03.30.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:23:11 -0700 (PDT)
Date: Mon, 30 Mar 2026 15:23:08 +0800
From: Li Wang <liwang@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, aubaker@redhat.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
Message-ID: <acok3JY66OcV0Qab@redhat.com>
References: <20260330053915.75442-1-liwang@redhat.com>
 <a5b7add7-0507-40c0-a324-81f243ffa261@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b7add7-0507-40c0-a324-81f243ffa261@kernel.org>

On Mon, Mar 30, 2026 at 08:02:01AM +0200, David Hildenbrand (Arm) wrote:

> >  	/* Open the file to DIO */
> 
> This comment is misleading as we are not opening "the" file, but we create a new one.
> See below, maybe we should clean that up.

+1

> >  int main(void)
> >  {
> > -	size_t pagesize = 0;
> > -	int fd;
> > +	size_t pagesize = psize();
> > +	unsigned int dio_align = get_dio_alignment();
> 
> Both could be const.

+1

> Why can't we simply open the file once and pass the fd to run_dio_using_hugetlb()?
> 
> fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> if (fd < 0)
> 	ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
> dio_align = get_dio_alignment(fd);
> if (dio_align <= 0)
> 	ksft_exit_skip("Unable to obtain DIO alignment: %s\n", strerror(errno));

Yes, apparently this is a good suggestion. Thanks!

-- 
Regards,
Li Wang

