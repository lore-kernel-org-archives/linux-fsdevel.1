Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8E3563CD
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546827; cv=pass; b=bdsHtuU3uSBkjEDIe5UJnMxcEivvqkDF5mPhwPxHgIM5iRYBCnFmqSFFL+l510+wPHvR7R+SMD2/lPLl4yj3K2PXckMV5R5h0J7CQHSK3YzYZnLB1mmpRJ5uizzBQ9QgCLXCt7gT0VB7mB80i2yh3R8nsTUeUC6bE0UxXZUedrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546827; c=relaxed/simple;
	bh=fbQ6vfQrwARgrWDKvWJtpQq4FUoOqa91kgga49dPBA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUgiryauE7hiaRyzOdRYMK9sWkWfEnMT363QhGNh4Rb9MnVL7v6N1DssbM8QuIlFBG+veQChZc134rLGg86Nf5/511kt+x7JASyDEoPR7eWGF62mLyvfViFstwQ1+DgtO5Qb0Ey61gZM+rgJRzpHDT1C1Vae9KHGKFwUQq1xRGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh+9CDRv; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh+9CDRv"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91550f68089so31744885a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 21:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780546825; cv=none;
        d=google.com; s=arc-20240605;
        b=kRIhVnaP+CLKEedaTI9vdMk02g13xbUk1PS6oIDRn9nH8nP4ZjoDG98sqQZsUVjDY9
         Cufme7BuHQDeZZvdP/HlyR+J7BsPDwpE4gKfh5eXUKBrz+gVoPbp1DKoGKXae4F/h2Bn
         hvBeTfy0wQiEtY3GKV71IPOf6c8UZZMPUIl9tuTM3DU4vxx79l0S0ewfby95kaSNAwtv
         ajhDCTbzWmEH8VGx/OHin4z8r6jIQRs+eZOZuxBTDap4c4Lrt8LdyipQQdy+qx98W7kL
         vPtGGV4v332qGbWfgrSrQWtm7QkvXK2FfTvae0OltjkaOEdjFmBi7njZovXPt0vB+mU3
         PWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fbQ6vfQrwARgrWDKvWJtpQq4FUoOqa91kgga49dPBA0=;
        fh=/SAOyDNv+IRS2aoqdV1cIHHknxo7By/8BK65W1sg3/s=;
        b=e22VmJPgnwoIj/IY3wLagYV/TkDcXr3JTNlGrHiWV5sv4YpB8hPLVRaAwnDwsaOOYs
         CLNcSLA7llGhTOBGh0vFs3bi5f25re06JFwPbmYbF+XX2VCsZWr+kn4tpihh6NrjZg7z
         Rh3UneT0sU2/QwPdq9OZUL9ClT5hBb8PKp8ItrmDd/6fBvsJUJ8RJGeuzcT5x3RWO4E+
         l4DZ+NfQd69+kvoYcg9Yox2drgS/+LAG9o5j9p0GIe+Zruu4jTI1wkRRDHeZXJAtcSl9
         N1H0bXz6AIiILQjbPbHDfCMMu60xNqJmom5DQ854V6IdOer3w1dzK/GTtReAjLMY1okh
         8j6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780546825; x=1781151625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbQ6vfQrwARgrWDKvWJtpQq4FUoOqa91kgga49dPBA0=;
        b=Dh+9CDRvSNd6j2085TaMN9lCmb/V5z4U9MsuG6Phkisofterk5SKVLGPegXsRzloiZ
         b7SquUWlo3B6xJBJRVSJazIy+REwpWkqbGMEuRgfTo842Tr0s7pjIN4FSkFqakL0RO5h
         NJ48AV5gfeTALoyBvKinys1vu7rrsevf/jU0DYxKopA0efn8gsjOLpEgnNk8c2fRXp6n
         sPKo5WLmvUEhP7VcChlgEcAtgOWD8z53OQv3pigT7RbBb+q1joRWLgirOZjP9FP7DcM7
         WCFXamjC+tUQ/LF/33LGXeYaE2oNGBaX2KgTS/0Q6q2arEnVuPjqg6Zdxt29jUiZ4vL1
         7Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780546825; x=1781151625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbQ6vfQrwARgrWDKvWJtpQq4FUoOqa91kgga49dPBA0=;
        b=Wyoz/ZwkVLshBqm9WH33cRbYI6WWXx0tgnITnfH5Ihcv0XphAF4bDJW87FlteeU2SV
         Sn4rC2VYHFO3PuAJPgA3qFiHpaKWD8q5E6M7VLMAQwhyXCT4jXEQbB+iFhi6MjEMfaoR
         No+XWsOBAZI4D3bJW6VOEMYp6l1o9yDH+G+9ovBQqKivBqzzOaSkrkuQO3Og7UPSRoK3
         cVTfDWK42UMxMOjCaSUMWWQ+ZqJo4Q29wdZM6O85FcGyHmdNw9kq/pM810LEAVDZeVBn
         ZdWGsWBTJhZeXuV3F5GH3dbuLNcKCN3x3XmEcFY8MuEtV2Vc0iXywMsuzaSi26jWb4QQ
         N1xA==
X-Forwarded-Encrypted: i=1; AFNElJ/TsVsBjgq8bXNIzP0mqyPci1GzDukOxOoAiEKiYye3meOKiazQTPKpIvmiF2iod1V8fiG6wyLUzoyN4WNS@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0RJAC1IYIlyYpzuXmCj6BbNQpBPkuoVgXOPn2HufVMzWWj3a
	1f4OvJPC51h1V0ikk81RFl9Rlvki8NUISlW3gaNVqsGO/2MElqSoGzpbBIwcTGTP98XWjcxgIRM
	m2TYOgnMjjQStJfKRM/2iI1TerKHvJeU=
X-Gm-Gg: Acq92OHz5e63LZrtVrt70k8Zk5DWIyR6seEnLx+XjpcxODg+8Em7zcUam25JmMtl7a7
	Uhe7h7QnXjgcJDy+mOVvFWjbrb+jkSpbyz6vCdiOeVbUSzvhgjnndmlBEpb9aWSLg5WXsLkO0eT
	GRxDZYv/8Q1/QtgfLFfDucU4y5iEXvwI6MIpsGo+FaK5vc9CwsGgI9yiYJcl08yjTk7armpkjgS
	JztBIWPCQjP7SyLBbPIprbFzbpIrQDzT1pYCrTLjssRCO9+nxiuZG3GAIpNUKDQPphjxgFMfVhc
	w1cdg6BPfUIiFhUmkrKFltX9YiF5OLUX6IZDG3MmJparMk2X
X-Received: by 2002:a05:620a:470d:b0:911:69a3:1653 with SMTP id
 af79cd13be357-9158a7fd516mr988560085a.46.1780546824101; Wed, 03 Jun 2026
 21:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
 <CAGsJ_4zg8+pVDwtsJtxxiC1ahJ9MR56Ue8VXCt_VrQgcXES2uQ@mail.gmail.com> <273d02a1af954b8c9f4da7fb74e6b4cb@honor.com>
In-Reply-To: <273d02a1af954b8c9f4da7fb74e6b4cb@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 4 Jun 2026 12:20:12 +0800
X-Gm-Features: AVHnY4KKmG5AxRaMLljUSifBekek5i7G4Gj54Kx0zUQZahUBQkVCtPOcn71W6Go
Message-ID: <CAGsJ_4xTMsV8fJVfhshDQp4=Ax2f_+b6yR873cEP11bjcEa_5Q@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: wangtao <tao.wangtao@honor.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"willy@infradead.org" <willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"ljs@kernel.org" <ljs@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"liam@infradead.org" <liam@infradead.org>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"jack@suse.cz" <jack@suse.cz>, "riel@surriel.com" <riel@surriel.com>, "harry@kernel.org" <harry@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>, 
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>, 
	wangzicheng <wangzicheng@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:03=E2=80=AFPM wangtao <tao.wangtao@honor.com> wro=
te:
[...]
> > > I won't echo what has already been said in this thread (and I didn't
> > > manage to read all, unfortunately), but for such big and invasive wor=
k
> > > it's often best to get in touch with the community earlier. Otherwise=
,
> > > you might end up wasting your time.
> > >
> > > Ok, arguably, someone who writes that code learns a lot on the way.
> > > And if this code really was written by one developer only, I tip my
> > > hat! I'd be curious if that code already ran somewhere on some Androi=
d
> > kernel out there?
> >
> > I heard from Zicheng that they have been running this for months and it
> > seems reasonably stable. Please correct me if I'm wrong, Zicheng :-). T=
his
> > really should have been discussed with the community earlier.
> >
> I initially developed and debugged this based on the Android GKI branch
> and did some preliminary testing on an Android phone.
>
> Since GKI generally only accepts features merged from the upstream
> community, and this memory saving could also benefit the community, I
> ported the patch to the Linux master branch.
>
> Because my English is not very good and I rarely participate in the
> community, I am not familiar with the community workflow. I did not send
> an email for discussion in advance with an RFC tag. I apologize again.
>

No worries. I know someone who has worked on the Linux
kernel for many, many years and has excellent kernel
expertise, yet has never submitted a patch throughout his
career for various reasons.

I heard from Zicheng that you are HONOR's key MM expert
and have been guiding them on memory-management related
work. That's really impressive. Personally, I'd love to
see more ideas and contributions from you in the linux-mm
community.

BTW, regarding my earlier suggestion about using GKI
hooks=E2=80=94limiting the optimization to newly created VMAs and
to applications that never call fork()=E2=80=94do you have any
ideas on what the smallest possible hook change would look
like?

Thanks
Barry
