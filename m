Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937393F23CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331966; cv=pass; b=GjykQ3HCeSFjcqU1YAixI2miOzrZk+XTvpGCvvb1adwArapi4Ey/cUlYgJrmEezOzaGE2bMQh6Vh/ZYOQGnoihqGU+pYxkX+AnSaWR9slD8Vda3NmktHhYwTCj+lIe+6BqCRisoxB8BPC0P3bGoCCjvBp0VAaCkaPgeKCrAR0Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331966; c=relaxed/simple;
	bh=LBGM4DDocsSyMDS7zACLSq9suw7ZRsqdWFQ0lFss3Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ig1tJ1pjlsPJYi82QvlJr0X4buGyYj6LUBI/d+1ZwWkMgHKWX6y0GQ7hhN9fmuOjOSc1ETNNbIM8OXr4QrPiFBnd//dByCSQE0d06bamV8UaCdNUAeUNts54SZQi7tFITUG51oiJCp+pr3hnZBBgOO05RdYMR2Ab+ZXwZKdDugA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=NSIWy8ML; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="NSIWy8ML"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9707fc11so960032d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 09:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773331965; cv=none;
        d=google.com; s=arc-20240605;
        b=PJPGDgqHBt3H5n8EgpmPne1YROVGAUxmcxXVfur/BnE+YoUACh4jgyKeHsPuItdBPb
         gGSDSJ2xfLcifpKFu1Xz8XSJXTSChvYteC6dc39KAxRMHcb5toxQeptY8ynV/NJnjTgj
         VqK3o7h4fc+a57ZF1Ws82RSOa5WtXUq995rc57OIgzgi6+g6iIC2axcTWPKSw+kt9ChK
         djT5vu9wtx4ZSZS983Amb0cHBBdIzC3YosSTgbjcpkV7t+7blIv59y1FDCKbkvAk8sP+
         YYtojlNSqy8EVjzfvrF2gvB7jXNsalJkABWPZoBkt/RcaK6zuG/xevXHRR0ltKD1JFKi
         cPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dtV4pVssyyOMA/08yV/BNeq7V/A7TdhzmOy4bj+LB2w=;
        fh=cz9xtBi39WZn7cMr5ZSOHe1+rc/Totc4X6VCVu5V0SM=;
        b=hVygIm/JuJGCx8/nQaipF4gbpl4dW8VNiH8J00K4rfj2CTN2/Nw/yBG3xV41XCWN/H
         hsFPAWg/WRSRix/0Y5BFA2T8OgvWkyURM1cmCRUqw4cepdsbyGMMsnZc/y+ZiAW3w+HZ
         lCXc2uu3ulscztIH1VyYFTy+v497lTvo2Do0S/K9G765YEVt1+uhK1TTypXrojwnoZD+
         +aTCNSxAekQAr3FHRuH90AgIuI7jhPZlS6lVf/DFttZfTCB37ZamRZgebITYK3+j4e/X
         L/9iDKOT1+8c4Z73SDG1J+qNcKdpjy3uwHtJLzkaFxbJz/S4vrAYgs9I0hzOdMxBI44v
         13iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773331965; x=1773936765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtV4pVssyyOMA/08yV/BNeq7V/A7TdhzmOy4bj+LB2w=;
        b=NSIWy8ML21pljiHTcUnbwLMPHObxuLmgA2oKE1fkr2Xqc4DX7aea927hP9UJoGI7K1
         +JE6h6CzsiMXXm2EflqaThj32itFFzEPVurn/79HDp8c0e3l5wmOeNGhpkemIbs0M+th
         xk1K9amLGqIQ6NyxTGdBEDhuVjNj2Np8UXcsCvKModMpr8Jxg7Fpo1talZR+T2J+hQNE
         W9ZJJbX3x6vquZAIVlsFpXywaSs5OY6UZwFzDlDIFsolK9xqHEw8e7HlWmG/LkOR0/A2
         uQXfi7zkmm4Q85uZwUbWr/7UMVT9szJYhYQoX1MLsPURJbO06LEBQgYbBoMO8aK7nVIW
         M1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773331965; x=1773936765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtV4pVssyyOMA/08yV/BNeq7V/A7TdhzmOy4bj+LB2w=;
        b=K9w76LwFwi3jdiz3qxNuD6HnzaAEkfobMUsgqhSqbkR70schINmfWE5T3m2a1buEE3
         +yWLXLXwAo2lijbmffyWKVIl5KJsm5APUSO7r2Ipju4CZjUb3gxu1vD0DDnAHTpcyrMx
         90DTytcF2ToDpwGNFINRRlmltulgrJmC8Nv5uaS9nWPdiE6EWr5+BW9tWDg3PlAYx07c
         4rQ+mE6GfCyKGF84mCF2UT94hwHMsljwRO+9o2AoeJuy6tjxF4z9ouoWhtgc0NKN8D0g
         kH0M/9yZRECc54f0vXfE4dnI7AaYIn4nHZYTOzF3StcrjgAYImkg9wsQY32BFdFPxrvq
         V2wg==
X-Forwarded-Encrypted: i=1; AJvYcCUD5VIMg2FqyvY3awfmrimWGUi5uvxcsve7E4B4nRRZ3jeELUZj/i1vM9Qu2JqDuBRBfcIAXljqZUkfv1j1@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHNAnc4VPaEJgpjhGmOlR1ZT9PuSnr53qnretN+qJPvIY92BZ
	NyunhmidjDGGbHXmczpQgSvy+nfQauYntUUsa7eiXsiNpHm5BqBCDbkOP5JGRcvbkRfK/UVJxpj
	0aU/onM4o15ZzB1Nj2GKiv1mgkaAV+OUn1D405Md+AQ==
X-Gm-Gg: ATEYQzy8elH9cOEXX3/FOpknJtj42yhZ0lM4Rk/IxYTwseuJqH6TYe1vtK2rEnUW6ai
	iYEn48674OBdZFELsLL6jRoigh2KKNbg7K38Seo2VMhDUUvgSR6+rrhfRHzdLRsVl7bfc/im6YK
	ZSRcG643SFw472V20keajdcVvw8xII29UJGfRYpw5w7ASGhULfiW9nNczEVzZE5plTWs7zIkUbj
	/epzq/O4r7Ux47RTMKRPs1JmjotNd8zSkzn5rC7i3lCJh+wCXFHDU+YH+fQIJZoweeHDtcQZtZc
	itnhc4gXeDQA+m7pL89VOYmKDk0sYci8Cw7fxAqHQQ==
X-Received: by 2002:a05:690e:23c4:b0:64a:fe95:2ba7 with SMTP id
 956f58d0204a3-64e62fa66bfmr100462d50.31.1773331964675; Thu, 12 Mar 2026
 09:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310031138.509730-1-r@hev.cc> <20260310031138.509730-2-r@hev.cc>
 <bca4ea00-3052-425b-8f39-729d504fd4db@kernel.org> <7937d789-539f-47db-838f-c153ca6cfc50@kernel.org>
In-Reply-To: <7937d789-539f-47db-838f-c153ca6cfc50@kernel.org>
From: hev <r@hev.cc>
Date: Fri, 13 Mar 2026 00:12:32 +0800
X-Gm-Features: AaiRm51siSCEAkZ-ba-2YedtaHq7E4-85jHPxVQW2_x0EqyQuvL291b70026mMs
Message-ID: <CAHirt9gpZ98HQCXStEQMMfe6TEnSzmD04BM313h2LJGJ1K-hJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] huge_mm: add stubs for THP-disabled configs
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Dev Jain <dev.jain@arm.com>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, Mar 12, 2026 at 11:57=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 3/12/26 16:53, David Hildenbrand (Arm) wrote:
> > On 3/10/26 04:11, WANG Rui wrote:
> >> hugepage_global_enabled() and hugepage_global_always() only exist
> >> when CONFIG_TRANSPARENT_HUGEPAGE is set.  Add inline stubs that
> >> return false to let code compile when THP is disabled.
> >>
> >> Signed-off-by: WANG Rui <r@hev.cc>
> >> ---
> >>  include/linux/huge_mm.h | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index a4d9f964dfde..badeebd4ea98 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -570,6 +570,16 @@ void map_anon_folio_pmd_nopf(struct folio *folio,=
 pmd_t *pmd,
> >>
> >>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >>
> >> +static inline bool hugepage_global_enabled(void)
> >> +{
> >> +    return false;
> >> +}
> >> +
> >> +static inline bool hugepage_global_always(void)
> >> +{
> >> +    return false;
> >> +}
> >> +
> >>  static inline bool folio_test_pmd_mappable(struct folio *folio)
> >>  {
> >>      return false;
> >
> > There are other ways to enable PMD THP. So I don't quite think this is
> > the right tool for the job.
>
> Ah, you care about file THPs ... gah.
>
> Why can't we simply do the alignment without considering the current
> setting?

The main motivation of raising the alignment here is to increase the
chance of getting PMD-sized THPs for executable mappings.

If THP is not in "always" mode, the kernel will not automatically
collapse file-backed mappings into THPs, so the increased alignment
would not actually improve THP usage.

In that case we would only be introducing additional padding in the
virtual address layout, which slightly reduces ASLR entropy without
providing a practical benefit.

That's why the current code limits this to the "always" mode.

Thanks,
Rui
