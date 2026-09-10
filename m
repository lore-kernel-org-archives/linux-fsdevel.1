Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5434BB28A
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056608; cv=pass; b=ZbWWtNIphCFc/iAiOCQ+vFWhDWK39jDbqU7UGNceomT5cYqAnUyslmOKC9jJgIT6qR52N94PYlStU4E4yA+VCWDNxP53M26fngLV4R7cM5RoAiQIN6/ViY81nStBNzG7LxHZx/JqXIo+sb+cCqQSsBDGGesCdf/q8HVST61FN0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056608; c=relaxed/simple;
	bh=nn837W91rvFvYJRiTa/P9FmCzgytAxp2W6ySv2FpOa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vr5l9otTpUekig0v0u1dHXVeTkGnLcWnK9APx/I7wT97WBl3NfmyXwgUF2RVr9l5kWg6bSibMCQHVT2GFAcKOXFObx5pbptyqpTyZEY3JJOFIeTvtm/YbYOZAZnQBrMAmMTKkD5PPHBo9gFRNPDE0mhMDa4rBZ0kbKpRoWP5O1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMt+uU8C; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMt+uU8C"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so325161cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 09:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056605; cv=none;
        d=google.com; s=arc-20260327;
        b=MQxT7EE9hFwNy8WSMWBzXwcbzOTbfYR5SsH9XKrJn1Xcqnd9OTyAZaQQMM0apPfJlW
         9zqN7QGJksxN4rT4HhWuSwW8nBarseXSOfVViY6sEVg+BOGChPOqNxzPS9mD7L3QozD7
         qIP1qpVSqEiYF7xMDgJEy37CjujrHw/c+DTDZssZmYqvc3fx7ScusbyLpJ0Qo6PdRfX1
         DxHrhjw4ZELNCosyCHlS+ADwacmkk1F9r7DemuD1POaFsHRPGm0IPZxdxQvdSjOPsRj/
         I2+bLpFZewoARmb8Awu6aREEmMLIL3SOgND77J3N4lZ5eG56Ua61GVqfot/oOb9VHJAW
         RoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nn837W91rvFvYJRiTa/P9FmCzgytAxp2W6ySv2FpOa0=;
        fh=9+7Zl27VMu6bnSTOGcqVZ5mCPcoYFRV/NOt4/tG/4UE=;
        b=mnQkMuO3L36fuQDqXIsAjkv59txbtKkOVMFAdErdoWzQbGpC4CuFHzeSU2pgZ4qmwC
         qyBXtBhh8QyAk44jC/HCPiZA9FnXNCIn3Bcnxzdz5YqaQr8q4Nb7EQkCq77bmfInNR7y
         e/EJgKcx2zm6/OuddVHvYJ1WDc/epB7Oq2VC4p6E/nczSEZAK4i8+EPMDvg2FDVOLILx
         YSDPWe2nCdrVdWIbMvLjn3VSsSOo7SXk7YKj2xVU09SnkjpHe+jONVFkxe3DXIe+GzzC
         LB7lnaYSs0KD/7xX/Mq8HnVME7eYLgpGN+7nvSDVZl1f7CGaQZ5PQDTDrYmhiN/Ou5el
         iLJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789056605; x=1789661405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nn837W91rvFvYJRiTa/P9FmCzgytAxp2W6ySv2FpOa0=;
        b=IMt+uU8CrV35BB98p6udc2LsxOQ/XZf7mxOj7QDGsifJWBZwWOfrXxNxWydSO4peoS
         E5bjmPxG0vV9n2QfQfMaOk3crfAJc2XOdYZzcX1mIGvlab5UnI8DKbTX8mK/SbrEybXG
         Nkp5ooo315icrZXte3BIk0HTx04Xn0ktHXnCGGdZRhLbKXGSkmlK72XqodqAO/Kavnra
         iJvfvsXkt4ARKXGPKLzcEcb7tKO3PRVk8PaYNls8xW8Kxt0xsRMH7bYdPmwiXOeqPb4f
         nc72+5EVZBzM4gCDpJxxM72MkcceDNe96ONcT4M8Zrsj2Ba3rkTjyBVvbxq4somrSD1B
         kl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056605; x=1789661405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nn837W91rvFvYJRiTa/P9FmCzgytAxp2W6ySv2FpOa0=;
        b=ChMGwh0FmBcy1kVu9XDs58W9wl1hDPI7Pkl2wa1P8P4T/8AtIahFKnx3Ma7SkruAGT
         m4MSvHZwqmBiGNYA4LlclGTMx1BCPbNTwHcXm44Rbg7RxFOEIFRuJhQGFHKh67u1DG5e
         uNCM4BVXfI/HTPdAoIM9gZg8kIIEU2Ka3ZTsjkEuCDrJUtt38XVFWfBNv7eXQkf0bmQd
         JCamlLWpJrQVpfXlZJsSgVY9vKJZk3Fscfyuc0rktAvw6xd9wL9EstL9APXGdmJkLi5y
         OVzd/jaHminfiL/YRO2lr/4+OIYFEW6Pec5BbVOtqV6PHNWXDxMN0tw51mufeSWX2+RP
         Nbbg==
X-Forwarded-Encrypted: i=1; AKwUvBwvwgy6hUD1+QfaU5CadIhnA1aBMMPERDVU3KLQcDHHbRg+gXwjvkIO8jnOhgSBWNacYC39iJro7u/aD5lK@vger.kernel.org
X-Gm-Message-State: AFuF++m2+ULhvH+5QRsx9heFv6bwnAsMc3+acn8rStNS887SqgZ/IniG
	8GutyO4otD0KGSI1EfHb2FJea1ToXZA1h7IffZrPhF/azgYH5gXexoXsV3z/4wMvZGoafuG/d5m
	r6pTMokNNKDkit74vsJ+SBGcTVZXwua6k+GLHFlH3
X-Gm-Gg: AYBFou38M0bcSmp4nLouR8l3SjrO5wpAmd9/HX19HpEXbrRsGN1x6vNNwLssM3ZXIG4
	spAUmu32fuYohe1wjHtAR4mynGWmeZ8kBmwZxlMs5xz4OCDafXnxl6C5HjLS1/9kUjevb6X5rAb
	lsH5b8NJB4gIwkZ7Uy1CDPGsUXpa7FpxnF2pJUzn/2JY7nmPtYhb75DZm5ENDXw7rC89tjy1I2K
	lwNL2qPD0t9t1t22U0q5NGCK7hybolAa3asVOnRReUAWFJ0Ffk0LnCLqpn3fFHhHmsHO2+mGO9M
	iWXsJEEYiuenhVaEJW2dZS9AfVPlxtI9v3c0+ufT27NHzoFYj+rQ/uHilzsOXQRLA/fiOAOSojq
	hp52gcIhqd7v8yhZN/nxo
X-Received: by 2002:a05:622a:258c:b0:530:39d7:ef48 with SMTP id
 d75a77b69052e-530b60199b9mr19460481cf.3.1789056604206; Thu, 10 Sep 2026
 09:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-4-surenb@google.com>
 <4825a2fe-f064-45d7-a7c9-e98de7efe86c@kernel.org> <CAJuCfpFL_g7tELjT8p8ExM3tX_v2gNDM9rRKwwefPV_KW=fHfA@mail.gmail.com>
 <8e643f51-a47f-428e-9443-678326288fa6@kernel.org> <CAJuCfpEYdj=u0wczKRrsB8uDkbSzPy+hrsCo9TW9-3J3r3p0xQ@mail.gmail.com>
 <2336140f-c993-467a-b2eb-e99dc9427a59@kernel.org> <CAJuCfpEL40p+vk6-km6_BBuE3+YY0WqkpbvQnQGFEo_73MAomQ@mail.gmail.com>
 <9e48cf7b-1700-4a85-af83-8883789ba87b@kernel.org>
In-Reply-To: <9e48cf7b-1700-4a85-af83-8883789ba87b@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Sep 2026 09:09:53 -0700
X-Gm-Features: AcwNN1W0lCJR22Fjje3cvEQd6sZVvwbNRZsVrrFWOXlsi8IV5nagaOj9ko-nhZo
Message-ID: <CAJuCfpE9_1VYqHp6bctUEihSW35TaTw_LZuOGP2UAnF7SA_UAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 9:01=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/10/26 17:45, Suren Baghdasaryan wrote:
> > On Thu, Sep 10, 2026 at 12:41=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/9/26 23:51, Suren Baghdasaryan wrote:
> >>> On Wed, Sep 9, 2026 at 12:16=E2=80=AFPM David Hildenbrand (Arm)
> >>> <david@kernel.org> wrote:
> >>>
> >>> Ok, just want to make sure I'm not missing something subtle.
> >>>
> >>>
> >>> Ah, good to know.
> >>>
> >>>
> >>> I see.
> >>>
> >>>
> >>> I was obviously overthinking this :)
> >>>
> >>>
> >>> Sounds good. Will update.
> >>
> >> Likely worth putting that into a prior cleanup patch, so there is less=
 noise in
> >> this patch.
> >
> > Well, this is a cleanup specific for smap_gather_stats() funciton, so
> > I would prefer to keep all the pieces in one place.
>
> I meant as part of this series of course.

I understand but this particular patch cleans up smap_gather_stats()
function, so if would be weird if I move the comment change in that
function into some other patch. Unless I completely misunderstood your
suggestion... Maybe you are suggesting to split this condition and
comment change into a separate patch and making this one a pure
special-casing elimination?

>
> --
> Cheers,
>
> David
