Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078E3F39E8
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979855; cv=none; b=nmgyr4NezYZwvTsIN9z1qFAkAAh/cgHjHxPAalT9gvr4tIA+YzBLgSBE44xZTZSL7jmwFh4hyAwWib4pLN5sJ7+GMd8ufoP87MNi083GnHqpm0ONxIhD9wKMKMxzKp2k25Di6Pnv9NmXPDLsSxg/NqFgGYmPLRBSBdHP6qnAK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979855; c=relaxed/simple;
	bh=XTdh+SCtDlOb+7DDE8GqAquXCqeELh5PH2AOrxbg70Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyZSfHCFYFFhjBnGBDqmSilVAY8BavLlWnO/X173M8q8vjWqHn7olEikQN/zj98ElSFPS/dgrg3ux/4xNbnOU+FlhOKQrIqxlRuZjC74MBUiyyFaLqTIP1swhTuVHmEzId7yxjtlqDFSeEHQ3kuKwr3bh/hT/O++KSQPt0LWEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDbLJxh8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tg4ZnT5P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDbLJxh8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tg4ZnT5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779979851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UBtkZg2KzsdpXCtGBF+S9Fg8Iz8UrMjxsxZEct4ck8E=;
	b=PDbLJxh8YRqrrvjPYxj7RmYcNHwPu8ivAXRe/GjNMqp4wmeIt8cOq6rsDtLD8BfGbqMFvr
	r64nMcVvuIi533I/RQ94DLnKs5BD2roybqHcaecVIpbQgFh/nRM4PlB0bJSJM1AzadWGWB
	wnToAyLctZe2sPbwe9eGX/s1U3cF2po=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-XYWE152PMriGbaEpA6maoA-1; Thu, 28 May 2026 10:50:50 -0400
X-MC-Unique: XYWE152PMriGbaEpA6maoA-1
X-Mimecast-MFC-AGG-ID: XYWE152PMriGbaEpA6maoA_1779979849
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4518f777225so9157836f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779979849; x=1780584649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBtkZg2KzsdpXCtGBF+S9Fg8Iz8UrMjxsxZEct4ck8E=;
        b=Tg4ZnT5P/BrBgyQ1D+0wy/ynyGwDBviEXN7xLMQP+ozMnGUfEKVGR40bOfRb0OILYo
         9/qm11lxJO/WmKkq+++Gk8tsjEqO4mBIeirRGDEHnpA3AStiHjrKqLZZxRChwxyucbUl
         4Gwyc5SdRLrWg2Y7noTYRx2WyhnVf0n6vesqUcHsVy8ac97Z4uRe085mW14Qp5HCJbsa
         2+K6FmmhH6D9gwwe3KBxmiBC/L5AgSnbdCJllS9Utc1xG6SFflms68E5RPgLWuOvjD8S
         uYmb1DFTK1Lry4hjkv3a9lof0Vvinp3xH7IHZMVwJSGQIrVodfzdkWm77cp4d4TMa5QR
         /RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779979849; x=1780584649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBtkZg2KzsdpXCtGBF+S9Fg8Iz8UrMjxsxZEct4ck8E=;
        b=Eo/skfJMX0B+2yumDhVt0DZOc0ds88NTv0Zf+g/34cdUp/YGx93CA90i2NJYkyQ6Od
         TCEe7UD9zwUTtElJJ8DdgsNSDh8ejhCwPF8rTVEHgEr/pZ0w5lYak3u7Yhx+akUHx+a5
         G/4nzvHy3HdjN3pfzmZafPX3oPKI9F+sx1guv6JtKYCwCAuxjEdkfNVEF1wFe+lGmvGL
         hp2LSVhOBla5ltB+sIVjl2oRGn0oWP9Vuy9cuB7pBsE0IWTovtxVyOfmWcpLTGHFRYci
         9VP9BtKMKobCyN54k+j2HwKR4/7rX19bBcdMPdMHN6hwwt5vnJF5P9MI65+Y48UbMUSd
         4myA==
X-Forwarded-Encrypted: i=1; AFNElJ+RcUm0HkAb4R5AYs1k0cvSFGsoDe4FNSCxfg6KepQIx08hwsT5BVvzL0u5cNKCMpHoG49KpUC6LeycAz5V@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsPRZjSmMHXh1Sl64hVcLb+LAbPKxNengWGGWIy4s8W+iKani
	eRssCcMzfBlr7xIwGkXDYdQHmMlPMu/U+BM7FEQE/6mCCWU7U3i2a9OusbowaftcvqDQd/T4/bl
	KTUrEcPRHXRaMJ88c4lkkb+yHq8Krmh8UuGj4awsvLJ55SKg7y8H5K3KCXV4dbIw2lA==
X-Gm-Gg: Acq92OH2xpBgSVuQ0OY4JHtDbG4k6O/XSyW5OLtLpek9dfZHA4IqJQYMMHHwf521y71
	T2bnA9o3ti7HwvONiAJp+hKcZTHV+MR7ALXH83zZCBiP6AqwyA5srpYg5zYemHr7QJSTRVlTrzn
	O9qLH5hcKOk/yNZXhTHXPPns64O86O7VoyMRXFAKjY47PRPMLWXQZNVgNN7QmaFV+mmogVd5dDx
	nh96X2OboBEm+N23oeJICoNxCmBS/aem8SWS117ZLvbSnemNxWLy2kUTYVmCJVd2t+r1cXUyWwe
	5MiC3zPKqWFupObw0PG2oxxJzxu9WocicbixM+f9nmXCQ7HutTv2ir5xdq51tHgKd8FIF1BTcLt
	RQmJtgn2qeuO4+wmOHESVkJCJ89Of0uLWxileuaOH0dYjcgbe8OmDU7G/MoBawi880w==
X-Received: by 2002:a05:6000:26c1:b0:44d:1338:46b4 with SMTP id ffacd0b85a97d-45eb36731d0mr47511219f8f.9.1779979848936;
        Thu, 28 May 2026 07:50:48 -0700 (PDT)
X-Received: by 2002:a05:6000:26c1:b0:44d:1338:46b4 with SMTP id ffacd0b85a97d-45eb36731d0mr47511162f8f.9.1779979848360;
        Thu, 28 May 2026 07:50:48 -0700 (PDT)
Received: from thinky (178-221-68-189.dynamic.isp.telekom.rs. [178.221.68.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eeb36c40asm3352619f8f.13.2026.05.28.07.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:50:47 -0700 (PDT)
Date: Thu, 28 May 2026 16:50:45 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	djwong@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v10 00/22] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <fjdfwhwi4aogyiaoijwvw6w4npuu5mbt6ua6fkhwcp5ajlm543@ume2fkxg36cb>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260521090705.GA14254@lst.de>
 <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
 <ag7uW7KQ5mVyCGEv@nidhogg.toxiclabs.cc>
 <20260522-unbehagen-baumethode-erlesen-811a4065eeac@brauner>
 <20260522120757.GA21041@lst.de>
 <ahVzkf8JoKP-kSC2@nidhogg.toxiclabs.cc>
 <20260528-offiziell-luftleer-misswirtschaft-3503bda2ad70@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-offiziell-luftleer-misswirtschaft-3503bda2ad70@brauner>

On 2026-05-28 14:20:08, Christian Brauner wrote:
> On Tue, May 26, 2026 at 12:19:43PM +0200, Carlos Maiolino wrote:
> > On Fri, May 22, 2026 at 02:07:57PM +0200, Christoph Hellwig wrote:
> > > On Fri, May 22, 2026 at 12:03:20PM +0200, Christian Brauner wrote:
> > > > > I was expecting this to come through xfs tree too if Eric and Christian
> > > > > agree.
> > > > 
> > > > You may take it through the xfs tree if there are no conflicts with
> > > > vfs-7.2.iomap. If there are I want to add the iomap changes into
> > > > vfs-7.2.iomap that you can pull in.
> > > 
> > > Merging the iomap bits through the iomap branch might make sense, given
> > > that iomap usually tends to see quite a bit of activity.
> > > 
> > 
> > That sounds good to me. If you want to go ahead and pull in the iomap
> > bits, do so, and give me a heads up when you do it so I'll pull your
> > branch locally.
> 
> Great, can the series please be resent based on current vfs-7.2.iomap
> then please? Because the iomap changes in this series don't apply
> cleanly on vfs-7.2.iomap so we already have merge conflicts...
> 

hmm do you mean this branch?
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.2.iomap

patches 07..09 seems to apply cleanly. The only conflict I see is in
the overlayfs patch 03. This is because [1] (is in -rc5) is missing
in vfs-7.2.iomap.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/overlayfs/util.c?h=v7.1-rc5&id=0c8c88b8eb82a2a41bec5f17c076d6312dc40316

-- 
- Andrey

