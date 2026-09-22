Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1956527599
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068446; cv=none; b=Kaq7jWNoRn5oVO7gt0xc7OL66dRpBaxOr0Cs5AAEDrJgkMejEGJUGMYKG7hzfUFC+bcw5q4b2HNsmvrH3rJu8q8kTIAuEU2qm9sGiOl+n8CAqohgEvq1WPB4PLEGKThVFi9RalJVHLjOujhgh2dQOaEAKpLwdTK+ngOkO1Ac0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068446; c=relaxed/simple;
	bh=x6HQo2Ql98Umszl1bLbKyaBGyakHflH2Y/8sgqKcP6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlnYIwlMv+/hpfxcLn0ADD3G9fCu0WboAYLHBtj6x3TRV3SeKofAO96qo3kW+CZRQYqXljVsL88ZgU4hZGuzbUkuGF3rVqtaDkDQITvSBWALBf4UCzTXiucSmS3NeKPRWw85356anVzmbDhP19MF/InyiUiMFm/7HrZ1MgT+Sqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VowaxTuL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l1HC45aM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VowaxTuL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l1HC45aM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790068444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4baz/6RzxjMCiX3WhcQq7uKFgXpKloXgi45FkMIoFs=;
	b=VowaxTuLML705/5K17j+ePJjbtf7lqBINI0bTojZA5lK4HkYF3pKkiML0ldhM/qClmzMtx
	x8d0Ufx0kVpmbsNK6ntTyciqqIi8STid85JXscyKhVc7BpKmciDUa/lO7gNwz49TWWXAeK
	8Ol8ZCLPwJRiaJiBsd6dRjkBLRpJ9Zw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-D1G0OPaWOQ6wkI1ZTD5IdA-1; Tue, 22 Sep 2026 05:14:00 -0400
X-MC-Unique: D1G0OPaWOQ6wkI1ZTD5IdA-1
X-Mimecast-MFC-AGG-ID: D1G0OPaWOQ6wkI1ZTD5IdA_1790068439
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49d0ae342b9so28111885e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790068439; x=1790673239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4baz/6RzxjMCiX3WhcQq7uKFgXpKloXgi45FkMIoFs=;
        b=l1HC45aMBgZ3xdsjio+YOyFachXKLMHZ43yaEiUZSxWNLhureP/1vW00dqcUTs4Cfs
         cAZ7eDbExdfqfd7jumDGq05Wqgy43tgavAFljqCZwrZDPlodroYA7n0cw53ZsFu88knm
         /vUil+LjTJ2WzWoEnH/r2T1nHlFILNDmT8T84h5WGMfoWudwr6aALc4ysvJURZyvNsm+
         WkHIfqXvEnDl7/f+lAfOPN2nP/ooQQTMbcT5x2AodvDKawVN93woRz2w7FCYoDQ8UmJV
         4o/kz4S8Oxs91owRFPG390XpDgUi3Z9VrbKXP8ePWIar68iP6lU+M0SuEWokdxpZkRu6
         eexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068439; x=1790673239;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4baz/6RzxjMCiX3WhcQq7uKFgXpKloXgi45FkMIoFs=;
        b=kcBhCe6E9mIwCSO+0SRwXDl8eXGcmjh6sonp8hU9Yk7dqHjLfjzE0XH2O4dkGKTsyq
         mQ8u4jB8Y2cu/vJcsfoUj58CYyBrkxsoCVJ2khJ8p1oScWWak2JhW4qBTwbavqUmUenh
         u2M6JiKdZL5L0pdglw6e1SZrq0y9Ie7GSzdZvP4pj+poeDRWq1GHSMh4YBnZsjBR4ebf
         9v+45zkQmfN88SCnZ6hUQDzP8eGZGcx0VlkhSWMY8TP9TRAwkDyRiGwsM7cNLeQd/kOE
         k0tHFrifQ6Jv34r603/7q0r3ljREr/ZUHcR4R8pcduo2nVKzvZKz7WMfyxmh13xTOuYQ
         KpkQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4Jvqo25FzYwvc/fJ2Nj6TXweO9GmCJXQOJ7Ug3NoOpu0X8liq4qN0hQBWWmfnmtBg2EaZB6FBroDuLuLc@vger.kernel.org
X-Gm-Message-State: AFuF++mFNda5MrsGxb9GI53PNrCCZyKh+SLsHhGKw52d6btOnyxiCkuN
	HPZYTvUKQHieBYWJAakcvEaWEqIzRjZdEj2kqWishAozkAN0SbmNDtKmO8R19YOUJAun8SAsazb
	GeZaf0YGrrPtEt5v90L/WPn0ytaGGGWW32088w2qNS7MtaZUGvU/JVLQEJA3ywdukgA==
X-Gm-Gg: AYBFou07HpOK+yBI4XB9RdnDsh2rpRloSDfVwEkVgNCJ7fCkqOKS441XVmi4TghqFaD
	nSvM5KbY80PzQF60uMhsh9zJ/2+NGU7AdNIg+Dww1F7nfQAjj+ycG4kFtnlOrgC2nXH07B6CHbz
	ddCO8GHEvkiBP9TGvw8kpeyvfOt9r+5gHfIBPp1QEvk/GJDFdrsFSSat9xEFJdK6NNymxbsH8SY
	F9apToon1J8leemkmy9fw1mo/s27/qq91i2IgcTQTEsZxo1vzHtKwlfqVDod/qpPkDagAWiKhJo
	l4jxY1OL57YUckwjaLrkCxgCFBy00VCQJeF4XbVg+por0ih9rtV/YssDNxM/dgTISpcmnqhEinU
	7eOSLaloXwKghgojOyIQqE4OxQFSczkLEAA==
X-Received: by 2002:a05:600c:46c7:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-49fc56dbb20mr184454635e9.4.1790068438824;
        Tue, 22 Sep 2026 02:13:58 -0700 (PDT)
X-Received: by 2002:a05:600c:46c7:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-49fc56dbb20mr184454405e9.4.1790068438389;
        Tue, 22 Sep 2026 02:13:58 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaa4e47csm74372105e9.1.2026.09.22.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:13:58 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:13:57 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org, 
	ebiggers@kernel.org, Carlos Maiolino <cem@kernel.org>, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH v16 12/21] xfs: use read ioend for fsverity data
 verification
Message-ID: <arJFUV3WDkY6zmfD@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-13-aalbersh@kernel.org>
 <arIrtgZ3-9zNuru_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIrtgZ3-9zNuru_@infradead.org>

On 2026-09-22 00:18:14, Christoph Hellwig wrote:
> On Fri, Sep 18, 2026 at 01:15:24PM +0200, Andrey Albershteyn wrote:
> > +	if (IS_ENABLED(CONFIG_FS_VERITY) && !error && ioend->io_vi &&
> > +			xfs_fsverity_is_file_data(ip, ioend->io_offset)) {
> > +		if (ioend->io_flags & IOMAP_IOEND_INTEGRITY) {
> > +			fsv_ioend = kmem_cache_zalloc(xfs_fsverity_ioend_cache,
> > +					GFP_KERNEL);
> > +			if (!fsv_ioend) {
> 
> This needs a mempool to be deadlock safe.
> 
> > +				iomap_finish_ioends(ioend, -ENOMEM);
> > +				return;
> > +			}
> > +			fsv_ioend->ioend = ioend;
> > +			INIT_WORK(&fsv_ioend->work, xfs_end_fsverity_io_read);
> > +
> > +			fsverity_enqueue_verify_work(&fsv_ioend->work);
> > +			return;
> > +		}
> > +
> > +		fsverity_verify_bio(ioend->io_vi, &ioend->io_bio);
> > +		error = blk_status_to_errno(ioend->io_bio.bi_status);
> 
> And I think you always need to do the offload because fsverity can
> synchronously read metadata.
> 

hmmm not sure what case you see here.

Without integrity:
For data reads we get here. Here, while verifing data page, fsverity
requests reads of merkle tree pages which WILL NOT go through this
path as no read completion is done for them.

With integrity:
For data reads we get here. Here, while verifing data page, fsverity
requests reads of merkle tree pages which WILL go through this
path as they need integrity verification on the read completion.
Therefore, to use this workqueue for merkle tree pages integrity
verification we offload data block verification to fsverity
workqueue.

-- 
- Andrey

