Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C893BD63D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870560; cv=none; b=IPGQ6Q6ng6iocOT6J6bm03R5yP2QO7PXmVdrM6V/6o/ciFETjojoR+kEDteez1y8XDE4bdXjBfNoDK7C1pZkaijUcAK60mAYd2fEwouEyp2+QTk75r6sv1bCkk/MEwBBlk2GrZnK4C/X6/EQ1IVG8sp2kasgHeVTqX5iRRpE9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870560; c=relaxed/simple;
	bh=IHi+tz61BqV6himK80I8WymO/a5UUCf4uLwI/wHDak0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1Qg0vIjm4beuXWPq5AxUo3Qr8howMW78ze4/IxKKX2owIsmVp+bwRC2Scfj8qXUHbrnA0P1HiL1zb2G4Lxdk/tuFLH0bbjCWfvpnjJSB+dNmzp3AEITus5YwzQ0t4+oadbYpDbFVFYzO6r1Z6w4xQ+Lx48TkhWmMZhY67R0v0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aj7KxfNh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQBDW9dx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj7KxfNh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQBDW9dx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774870558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=556GKtPgfbryfydv+tI3+PhJHtuBKVNgx90rfTV7vcs=;
	b=Aj7KxfNhLRKFariNLYY9LNQW4OCnXk01oZ9e+CxD1eoIpo3sTWWoh7LSmThwwICeWSs2LQ
	wn+8/yazH32n0aej9JVXRSVQTg3b5RB8hy/Dx6mntm/lbMMgXcr/Y3MW2wjiKjlK4I2HaM
	2MQeG05HcidECx0sE3sXgifOpJ4fBbQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-8VpMuX6JMJKm3j1Ke6qDjA-1; Mon, 30 Mar 2026 07:35:55 -0400
X-MC-Unique: 8VpMuX6JMJKm3j1Ke6qDjA-1
X-Mimecast-MFC-AGG-ID: 8VpMuX6JMJKm3j1Ke6qDjA_1774870554
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2471321dcso65956625ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774870554; x=1775475354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=556GKtPgfbryfydv+tI3+PhJHtuBKVNgx90rfTV7vcs=;
        b=CQBDW9dxA0k5X2MFTZxscu7MMyZn5vU+OG2p2JYcErpTDB1uqkXs/RHNxu/7E1l5Ng
         LGUobvnBEkyf3ybCfY5qFTRJiIJM1P6XrNGw2FQJ+vUpO5EHcdNMmxV684baW95MGBIz
         3j9PO+ZeGoKAIcQdu7x/KIHpde0ulP3qNf25pmm+pXhgGafw+NYwOz/KNAUxrhU1vu8h
         gP7qZ86XGpLKuQnPIVp7XfxtkfKYNY34FJlQI0jcGApSvHZU3hLJtzA70m+pTLu/Qf5o
         Bb/TLsIdeI4ujHY2yEHpPQyzRC/5xz3EM0MPUsZsEsdNTziYHwj18o3m4lOeulr3z91s
         1FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870554; x=1775475354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=556GKtPgfbryfydv+tI3+PhJHtuBKVNgx90rfTV7vcs=;
        b=amnSoXUbvZp2j60++BrVguFBWXzDKGF3OwmcPRk2Bpujxg67hnwmTjAViQJO2Yt9PI
         E2uZP2+DmW/sLyzNigX33wZPzRSOZT2nalHfz4fYcTh4TmSib1d5I/2sOy77b1cG35g/
         4vwF+FGparRuY/S7j0UB+92oLtRZVom+RlpJ7h5f+PHODznasA6e0YO9ljmty/lPPWcT
         mE02mzw1W1xSILXgIgqX1jfz+c2gtlp46U79ubldLClYYPDAXQGmk03CXR40nbysFaOd
         +cvVPdqB5bNkC4ENcLiF/UGJc4Flg2dqEO4bhgQ1QE6UycfjfgotGUZhPs38zb2KC3hk
         gpjA==
X-Forwarded-Encrypted: i=1; AJvYcCU0x6jYTY3CzLaR583Wvu9pdVuzhynbXQ/6V57S1jVl7cN6/ueCp3g37jqIJFRU/hLA4b1GetiHtYpvQnoO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mSMLeyNv5yVKwuQkEzuWMTo1GZ0aD/i95qg1ZgvnE72i51Ht
	D0/aoWvMoqgz6hF9vQGnmt+QY2NQhbbnNmDrwRV3iHtjMvV4jis9LGq0sGFlYVkvSbmtBnh9CjT
	KCbXH+BhuExsHJ3EW0Vsct1A6ZBouGMqRN63t5HebzNxUMEZHWayO8ORKYMWO+Lbs76c=
X-Gm-Gg: ATEYQzwvVuc9x1aXxfBBnOuyhefxF/Jtl22r3tisviwMUml+H6Hl4SXNsrHJfZtuaH2
	5tfWVwZf3m7rESTzhWQksf8dezX4frtukX0o9MuSnKQzOGSikEp/Pe62/DjyFd8iDr7NV3mMa5i
	vaHrowKplaWH3ADB/8gXp8yO+eONMKbZ/OPTrYqxnncGguXFRoCA67uu4jsamn4lqfArBb6bwce
	COYSKeGkMuAe4eDyf16zcBEv962N5U+FtA4DAYPfi51bB//onQNEvJP2Dd7CsjuVUOiOL9qwb2M
	Sx/1kzwNhOMnLSgnur9aY8LoL+yNu3TM0J2YZi48gW0Hq/PAdlI3A+P84cC8ESPwhDoc9do1Lu4
	2JGC/TF+uaCgjOTYyqA==
X-Received: by 2002:a17:902:f70f:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2b24d3609ffmr53808575ad.35.1774870554451;
        Mon, 30 Mar 2026 04:35:54 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2b24d3609ffmr53808365ad.35.1774870554017;
        Mon, 30 Mar 2026 04:35:54 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427acdb9sm80473665ad.68.2026.03.30.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:35:53 -0700 (PDT)
Date: Mon, 30 Mar 2026 19:35:50 +0800
From: Li Wang <liwang@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, aubaker@redhat.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
Message-ID: <acpgFlG4qj646hYp@redhat.com>
References: <20260330053915.75442-1-liwang@redhat.com>
 <a5b7add7-0507-40c0-a324-81f243ffa261@kernel.org>
 <acok3JY66OcV0Qab@redhat.com>
 <acpMD8tRCJhgXHeg@redhat.com>
 <a1054c28-b574-4fcc-afe9-5e902209a22c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1054c28-b574-4fcc-afe9-5e902209a22c@kernel.org>

> >   int main(void)
> >   {
> >       ... 
> >       fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> >       if (fd < 0)
> >           ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
> >   
> >       if (get_dio_alignment(fd) < 0)
> 
> I would suggest that you query the alignment only once, and forward it
> to the test.

Sure thing, I declare a global variable 'dio_offset_align' to get the value
only once via get_dio_alignment(fd).

(sorry for not posting in the above email)

static unsigned int dio_offset_align;

static int get_dio_alignment(int fd)
{
	struct statx stx;
	int ret;

	ret = syscall(__NR_statx, fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx);
	if (ret < 0)
		return -1;

	if (!(stx.stx_mask & STATX_DIOALIGN) || !stx.stx_dio_offset_align)
		dio_offset_align = 1;
	else
		dio_offset_align = stx.stx_dio_offset_align;

	return 0;
}


-- 
Regards,
Li Wang

