Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6A37B003
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356541; cv=none; b=PaJUCuGB+Ea/gbgZ8t1EWQhxavbHnng1gqIu6r8oD3r7EkRXnZdBujqkzWCkEGazISw039QIMuTig1JDloQl1gfapDIFvJz6aLWrVbpo679bAI+QUSsgMWoyJYUeuGjEAmhOOcrpXpVZtWizkJ8wQYB2ynnHZspZmYFxF+1dR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356541; c=relaxed/simple;
	bh=/n6YuXXsfcsk7J7Yb0y1thOCuPSSvlN7WSB70uhim0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb1V9GsjujR/dBdxsnw6sobfGIUzyZ/rHc+3fORkzlkPxLiPQmy26KfQTiAx7nsNF7PtTTKhVZHOsyFhzt5HRchs7TJbm1P952ecoBxY6F6URmdypR0pp196594nJBfccO/lM7VYZZ6lELJw+6NxRPwWZdXKST/WDFhnkJFEHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGcQDpYv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gE2mTH44; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGcQDpYv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gE2mTH44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779356539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WzMLsQukLw8E3UhBm+/KFb/Fo3mZZq0u+Zrumr4RyU=;
	b=bGcQDpYvPLEbfBQZC3lTQsyr+3H+rvNlLXE3wyLChrVgz3Apo2altjc2wB8pfFOfDsNfFa
	UadquxiGdIqFnEDcyI2HQZx4+8VlVdn7CmW1otNXES/tIBRVaUSEV1co+/vet7wFiJPgDJ
	a/dekJKAtWfO86M4E3Kz6p0phUb113Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-REI1V__UMqC1rIM3eCsdZg-1; Thu, 21 May 2026 05:42:17 -0400
X-MC-Unique: REI1V__UMqC1rIM3eCsdZg-1
X-Mimecast-MFC-AGG-ID: REI1V__UMqC1rIM3eCsdZg_1779356537
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a71109b94so4410609f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779356536; x=1779961336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WzMLsQukLw8E3UhBm+/KFb/Fo3mZZq0u+Zrumr4RyU=;
        b=gE2mTH44GayFr9mtAkmJVfSU67d3tm+/YLoN17BfGZH3Kca71yP9gzWsOKPeIsBvRD
         laEPjmCECV77JeVn2SVjFX74IqeEWHDMu8tUR8rhrshkr5wxfi2XcsVJccvbpbFEoWPv
         T0aUIqhFrL5b/ffdNRMW5j4OnaKfqZS5jKXSx8i7zQFOkQn+EJQ/EZi9N9/nAPflgD+5
         dy6pfrWDU14zulEvGUGFZnzpcbEeVydktffcHNVHMhfkzW3gi8amUGywq1wodNRvSV7A
         SWesHKw5+EIirgvWil3KTxyyGqJCG5WJq03iNKYm/EYtJ/BjPsF9U4QLV9nW/dOAZEDz
         6nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356536; x=1779961336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WzMLsQukLw8E3UhBm+/KFb/Fo3mZZq0u+Zrumr4RyU=;
        b=GVgiOLjXiseUvuIPdnHI80yFGkhdoQbLByt5weT7yt0AcX0mn+JKiD9SQRhVWylWYY
         Udmn+SwhJQZDJq6BNZu7vkdOa6pVZNg20WQeh4xaELTdw+52MGm+P1PzrqCpWyXRDpdZ
         AAbHZYQxquM5l9OuKVYhPUuO/vKDJ9+1jFww1RVMMtI7FHYQA/nuAxR4Om9WYgDP/nCk
         umVDKazXCcl+sHYL+ykx/MIGOErgjzQtzrEWORjejemvV8d8qoqEUBOSxdalyFHsURFY
         mZ5H8a5rXfk+IdBwQxx4BRplJPsTntY/PWUgNZF+wlpaAXSBBmTNrOh3HZYT/5+3vHaD
         lQow==
X-Forwarded-Encrypted: i=1; AFNElJ9YnGJlebW30Q7yYuIZjnBUMQQsKc9Vsqqa1w6Mvhkkv8kHgJHKw2kn5B4gNdrEgIgUnUcivGZkpY7DCfyO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqt+j3gtzgM07+Z+bsHJDugc+L8gk2uv2wImylwlfmlXxZ/21z
	e05sdj4IR9w7yAk9ruXQYzb4CPq2ohR7Rt/z23w8TrTWrsiy8Owz5v4v5DEMPj0kkfIWLYKGBVn
	W3dycjDrVnrXVvQdw9OMqQ4Dk43ViwrMAWoTQO9Qe5CNQVUL0kzfK7H7TLWnraUbUmA==
X-Gm-Gg: Acq92OHPlUEzUPI1UJ1ASAmrx5gsKenk0nH5lZDDtzJNW9LE0GOPK7Kf+dVXxg4gjwx
	+OyORf7u3ZFjd252prJHESRjunWjnvhJwqpiXkkvkmdf6VHbmVlRCr9kNtY0HwtywRshfBsIIpJ
	IQbYizrCwI5l/cfsjJF+gUlJRqQY+hmZrulOyFc8pX5f7D83MiMOIZ2PiyQ8rURdhihPG936pi4
	MvFWwJLqhpcn6zGyOnjyBTFG2oOFoDRXu2DdtkTDh1h2bcbxA6s686b79Cn1rqrfl7PkUmLqqIj
	yw1Vh8TU2u6hagFx00R6wXt6182xwi4BocR0Lehp5XS/EfMA6qH4foKWhgGtYYA7wk9FicFjf/c
	PNCkSlPD8svFQit/l8On7p5kSh2GnTiW3F4bOwQrSClpbdxk+nJLxaXk=
X-Received: by 2002:a05:600c:81c9:b0:490:3cec:52f5 with SMTP id 5b1f17b1804b1-4903cec55f5mr9775955e9.2.1779356536303;
        Thu, 21 May 2026 02:42:16 -0700 (PDT)
X-Received: by 2002:a05:600c:81c9:b0:490:3cec:52f5 with SMTP id 5b1f17b1804b1-4903cec55f5mr9775515e9.2.1779356535822;
        Thu, 21 May 2026 02:42:15 -0700 (PDT)
Received: from thinky (178-221-68-189.dynamic.isp.telekom.rs. [178.221.68.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903c9abbadsm13930015e9.8.2026.05.21.02.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:42:15 -0700 (PDT)
Date: Thu, 21 May 2026 11:42:13 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, djwong@kernel.org, 
	david@fromorbit.com
Subject: Re: [PATCH v10 00/22] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260521090705.GA14254@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521090705.GA14254@lst.de>

On 2026-05-21 11:07:05, Christoph Hellwig wrote:
> On Wed, May 20, 2026 at 02:36:58PM +0200, Andrey Albershteyn wrote:
> > This series based on v7.1-rc4.
> 
> How are we going to merge this?  It touches at three subsystem trees
> (fsverity, vfs/iomap, xfs) so some coordination will be needed.

As most of the patches are xfs, it's probably make sense to go
through xfs tree

Carlos, what do you think?

-- 
- Andrey

