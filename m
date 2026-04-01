Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8FB34753A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033082; cv=none; b=GmD39mAxtK8K2jH/CPxd684stNVyiP/C51rqHV5edvzgF7DT2e6hX3teQuzOkbHnTQGK/KEs1uNcup0vGtt74p0I7+2cQLFCKsZKhr+BOpXhzEX867uM2avlWFsUAIQ/PlWasSn3tyRW0pbPbY1ndMqn18GzkmX8cl/juCu9jCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033082; c=relaxed/simple;
	bh=2D38ere3Grccf2yg0w7Pk1KMScDLLh+TTvPAiTTHJX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFKtvCop/aRQYyuxUgf/5qqMC+PjAQ6bC7rT6iV6PsjA9ano2Y0rTinvF8sLK49spK2bHeuXYxsoY4SPseEVvzkMOhhHLiRwCU35HEUZBYHhi7GsjzFjn+2t1vU6EWD23SoljDpiYwp/B7RJdJnPANz4fXBb0Jgf0CDjHEF1KKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1iGxiRs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qN6Q+t7v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1iGxiRs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qN6Q+t7v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775033080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VTKemEY4CMnXuTlNCjNoZ777F7zIOeMz1S1dcBfefw=;
	b=Q1iGxiRsomEcR6WbY9Km5ozdtqhUQ7cHeFzBHsH2U1WDBiAO18Tc4AQfyVNywULi1hM0vF
	sLUjXLAOPdje+uHxN7HlbTFXVeLIOqQnO4YTGeeK1bnDKgB7fS5/5sRegQibVNo2MOns7u
	7S5b5eyT5kfTbEYwZ9sz8P0HCDUsXJo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-e7VruErjM-m0WH5m6NTu3A-1; Wed, 01 Apr 2026 04:44:38 -0400
X-MC-Unique: e7VruErjM-m0WH5m6NTu3A-1
X-Mimecast-MFC-AGG-ID: e7VruErjM-m0WH5m6NTu3A_1775033077
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82ce1c395ccso2607734b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775033077; x=1775637877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VTKemEY4CMnXuTlNCjNoZ777F7zIOeMz1S1dcBfefw=;
        b=qN6Q+t7vhg73ZbhdC/GgnDkWs0SVh2rUirPKmpAxDYLGrN/SXrxkC6ZvykSIvpPc0x
         FxvflGb2H2MfxriFmYdc1fJ+iIpE5pjsQb2wllwLpKf0ZdFwMn68oglw0HTLnaLdVS7Q
         jUTbW/WixpNoQmn+R13m+ijs9iCV5GhobIuAsEP2am8+CgWGKYythnosQQaj4yZMixrJ
         z4jYFbBEsKl7/kBKEKpC+ZY8xOmxWSw2fzedz1UWoU660TTm4Azs0fMDKt5SCDGGYyqP
         1OIoVE2Gwlx39CttOdmFK3IlJ5rO0Ism7nbVmfvdCvG7YiXe2B06f6H0P/IIK6a/ak2G
         HuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775033077; x=1775637877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VTKemEY4CMnXuTlNCjNoZ777F7zIOeMz1S1dcBfefw=;
        b=QSP+UU0bRYHtiJd/Rmhy8Spo/wOfrCfBT+e6SF4GWY3EoYAUUlJuT8UHrpvrDAJG0p
         X2epiHmxnoTidL+iEZnJI3zTqoKQLrgaZh25d5fgFSTKEELuuIomYXKfeMumvlPZxHDF
         4cdsszOcJ4qACBZE0t4HiMUq9+HQMybKWKiu5Lh3Pul6Js1EbRrLLXGBhkPhZLRzfai9
         7glNRivarhjr5ZWSGnyh8Mkflnxzrm+Y+uZAMqPiAx63HqLDtt5Cg8cq4DTFWOgm34MK
         O153BpZqkVQ63Hyn6X0KImDEwm2w0KFXL3s8GkRlzfModPCfb7kEYztsLC/a0HmYOiw1
         Wvcg==
X-Forwarded-Encrypted: i=1; AJvYcCWt6KMRyCNLWyDl+brNyh5b4LC45FO/b1YMesjDcy6vgZ6olO6B9HtM6KpjHPE9ttDNEW9qg3B0rsw0xRta@vger.kernel.org
X-Gm-Message-State: AOJu0YxXvQ50dd0OJ/lkIwtLE2zij6jaogBlOivMRzea4Z1CS5S3Njr/
	uVHgplyQGTouL4b9M+gHbzxGkcIvO+vqpWtYTwwaLGGPCqM0HdxmDs83dvqbpQc6zxVLFlPEPpK
	Kly4jNs7fqNz5D4z+fxIc5IF3nUBG241Uh32FDtbR011rkNA/l8kayJh5KbZFHnE3oW4=
X-Gm-Gg: ATEYQzyiescLGIz0hn22glpc384lTWTmHdHLUUUG0USt/cUpTDsduHbH+SuxpKehWSU
	1JcpMrxU7l6fgVwEV8SNLKxDCUIVkNyy5nvE9LKANotaAw8FO2XYPV08HGuvtZ0MnktHjrln+rM
	pemRlCA715ZodNDSGBOHHCLjr6+RDH9jrJAYI8thJA0+xzXvWvmWtGfkjPxMQvTxIT64lSh8vO7
	O6OAdeUAXCpn4YpvWOp9MD3YCadwHo9Pes1qrSE/26BsJQloCHrulEjF/HrA97hXtVD1Cw8AYW+
	A4v3uiyFt6C/n81O2bG0yYOA0f3sOnSXA/DyuCE73Y3MaaJ6AqtRdDQ4adFsTUBUhnB5WfUbV3c
	qhw+Uh0fuEMY5JueDSA==
X-Received: by 2002:a05:6a00:3d47:b0:82c:217c:98ca with SMTP id d2e1a72fcca58-82ce88f50ecmr2952035b3a.12.1775033077481;
        Wed, 01 Apr 2026 01:44:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d47:b0:82c:217c:98ca with SMTP id d2e1a72fcca58-82ce88f50ecmr2952007b3a.12.1775033076966;
        Wed, 01 Apr 2026 01:44:36 -0700 (PDT)
Received: from redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8465746sm14068621b3a.21.2026.04.01.01.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:44:35 -0700 (PDT)
Date: Wed, 1 Apr 2026 16:44:32 +0800
From: Li Wang <liwang@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, aubaker@redhat.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] selftests/mm: skip hugetlb_dio tests when DIO
 alignment is incompatible
Message-ID: <acza8JhtGD6sE3N9@redhat.com>
References: <20260330125307.98581-1-liwang@redhat.com>
 <96d14f27-ca0f-413d-8b61-768933ee70ba@kernel.org>
 <acxpVd5hQUuGPQCF@redhat.com>
 <b9625c60-2b1a-4890-a703-49e31aaaa168@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9625c60-2b1a-4890-a703-49e31aaaa168@kernel.org>

On Wed, Apr 01, 2026 at 10:34:40AM +0200, David Hildenbrand (Arm) wrote:
> On 4/1/26 02:39, Li Wang wrote:
> >>> +static void run_test(int fd, unsigned int start_off,
> >>> +		     unsigned int end_off, unsigned int align)
> >>
> >> Nit: prefer to-tab alignment in MM land.
> > 
> > Yes, I noticed Andrew (thanks!) corrected it and added to -mm mm-new branch.
> > 
> >>> +{
> >>> +	if (!check_dio_alignment(start_off, end_off, align))
> >>> +		return;
> >>
> >> Is there a reason we just perform that at the beginning of
> >> run_dio_using_hugetlb(), avoiding run_test() entirely?
> > 
> > That will make the run_dio_using_hugetlb() have too many args and
> > uncomfortable to read, yes, it's more likely personal preference.
> 
> Nah, just squash it. There is no need for this separate function, really.

Okay, let me do it in patch v5.

-- 
Regards,
Li Wang

