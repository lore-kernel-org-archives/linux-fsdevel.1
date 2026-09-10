Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42448EC77
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055166; cv=pass; b=mTcb3dxaT/AJ4/1otwC/Z6HQc7W6+jyma3NY9z1mR9mosusTZyFRhGyy2wbN9oHu1YS+fQkGFq/6a43j9HbkzBRVeADSbASBZT1UN8hS03R2mpr9QE8bH3qHqULHUKeK0ISNWmOWkygksr1uPx5HpDQFC+zG146wBuBgxGKGdaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055166; c=relaxed/simple;
	bh=xy9Lm9WxkQ3Mmgg/H7vfmk5N45FAYtw9hYAWl41XmQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYhvUkEAN4h5AFP2EqX2nOJ/MrOY+hn+GItCWxtoNfWR8AmpxCMw9ydsK2GK8+WkC318PFWei7AhXd1jPdKFl7t++/XfKzg4L/b2PGaOkf0U9i/zoGEgL6a5nB8L+wQmXnRAjiTZSZT/4S6rqd+BkA75dGrh18yfCg4dtjIxj8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZccLjKM; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZccLjKM"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5307425f44bso269511cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 08:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789055163; cv=none;
        d=google.com; s=arc-20260327;
        b=BuEzZRznxL8+gYxFrwme9izJjHdGCOAziMG68a9FxOxjC7Q0vhkmtVoteltjyjKpWA
         zx9+QC/sWf8KYMw9HvpWBnHPF9HODtniMLI7HQJYDMbmyCSRM9mH6jif57SotPWNR0wW
         yVWO8Ua0k77O8kMIzdEWCOfOzw0vU8Qs8RVxX/mYcJwgdNq6gtE2LA/bPUFJFL9Ao8tW
         ahoVORKHZrF4ngwcBKlF2mDQVJioSgDAKCsbo+xV9FuswvXSMR6qoeCysSpZ3QvUxJ7d
         snvwnq/y8QObWMhbEBvoXXq+wgubpzovKMzqOfyeEPvhCYpp1tphuuqnTeSNYv9yQinP
         YSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m1gukMKgmXXLSe/xkuRtjWvRwSakZxXxaaknc5QrDEs=;
        fh=GuBSFCNqS5yLDzLsq14sO6mun64F/JmXN+vzvjRBZEk=;
        b=Kkuvk17Hv0LERi16v5F6cZFYAG6jmkbTx4gYYSqKLHOox3JxGFy6MHoshBVQ/KAQup
         +2VXnjVa3le1QB8TrEITKi6fQUvX/X/nA+xFf1p+CQZbVWhVGQwKNWleU+4o8n1eWjq4
         WfhW8qIbukcj6o0X2JwzyQZtuZofgCFe0hnNXOyOnwWOxDa+lOIHTiK1u8tNCoON4kSk
         ShKWPL6uQwitYzuAuMzJbiBuRpJEyDNeDhQdjoqMDRomvhoDkm9R2moY4XJKMNbRXSkj
         bt5hx5+vDY1Wrh+z7WnFBHVYcYiUM2swheBuJyHz6bfHGdXNRNM88rU7N9iusChszCaY
         9kjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789055163; x=1789659963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m1gukMKgmXXLSe/xkuRtjWvRwSakZxXxaaknc5QrDEs=;
        b=YZccLjKMe0mGvg5tGI35ocfBP6r6eCfPjXwnP/rsTywf13dqe4heTT3Jem2Uuq0BJ+
         TKoyrJ5zFeUQIO4EL0/R+l5eLqIP7ljy1B+SYohBFx1fIlHrC1OcQfB0rgXmKERsYELn
         kp3GdHkWcIasssZLqmScACOuf6X5KFjVCUTo5uFx6ZTqWWZH9rljWGoalpwAI43FodbZ
         SbaLk/sUjtEGbQPGBFhPFgMgWpqFnAWMjO5P55cSPO/GsMj6OG6UJmxsTyQIQRyQScAc
         bdQ3EP0R8thdDDHc9HsHzfwsseP069iDbgbEZRFa+utA29n5MQtUUdTa+12jJmi/RTX9
         gwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789055163; x=1789659963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m1gukMKgmXXLSe/xkuRtjWvRwSakZxXxaaknc5QrDEs=;
        b=TAdNcvGHbPnvu6Xol90jJ89Vydp2AEpsDAci57WIWYo8jRNpqM8G4a+Id3y5073aYZ
         qIS4VefBWHrN31vr0bSpYHa37mkV7szEfKP6U8zHLNK6EIYaQdj6E/T0HD0Q3Gw/ia91
         IDfXkTqz1YgMXv04d1fe43yq518TYK8p808MYxVliWExv0uwbYVMUoWDLfc29/5SgqeO
         S8rUQy3qohOxb7vpGkNHSgOaaTfj2pQKpe1N/YNyxDQNWaG7r2iw66g5+mOVfQCbqqJv
         9tP5tJeqbU6eyrMS38kP+lOyyJj2C27nSWQRenyX8OXH5rQluJTM/8dRG2Yo12/yB9GB
         JmFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpTwK92z41rHACM66bp0UEcra6gy4NkDb1/Ml4nShEYiGGwC4421A2MmVZD4SZEwdWQXOpOUt2AxUE5HBR@vger.kernel.org
X-Gm-Message-State: AFuF++mIMajy3vgsz9AjLUCNdIRotIoaWY0u0Y/mCq3faquRaLAuiiiR
	AdEbiG/0Eg4E5F/i2AEfH29BO32Z+ABDklgpo48RYLSFfQdyi9e5ueCqhHoabh1FDlpwchiKbyL
	VaTlW9LI61sXMSubuiMglafsldnSedqiG9+50MDmP
X-Gm-Gg: AYBFou2VQ28xrItul/AzUbq1IMSWmNfbdVyqKZrYfF3pjdVpOiLl8mHdvOJrjfvLcNE
	97XeSweaU55IYMJTZqfVvUEuR9yF0Y9aRsLckEdavOACEgeuzB5w2nXQxXyrm3cV+/vmMd71xBX
	poXSmZbukckkWHyd1P+ZFPC+LDzhtsHogNBcLE7QxnVsFYSgw9EF3o+ZcJInyZVekyzAuO90Ox8
	4e5BFUoRlNUnn7UO+IHOjxSZuMBuP2fmc1Oov2susWbqy6wVlOrSR3YaWQ1/rbqHIESZzwj4pd3
	gIkJAOoDWPxiH/teR0A1IAy7T2LcTUnPAZF5mTgZiXzv4iczzG94GcSE9qifjIhC5NX9Z3nSfx5
	Yws3dbUfm8A==
X-Received: by 2002:a05:622a:1c17:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-530b49672bdmr21908571cf.14.1789055162926; Thu, 10 Sep 2026
 08:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907063918.3432401-1-surenb@google.com> <20260907063918.3432401-4-surenb@google.com>
 <4825a2fe-f064-45d7-a7c9-e98de7efe86c@kernel.org> <CAJuCfpFL_g7tELjT8p8ExM3tX_v2gNDM9rRKwwefPV_KW=fHfA@mail.gmail.com>
 <8e643f51-a47f-428e-9443-678326288fa6@kernel.org> <CAJuCfpEYdj=u0wczKRrsB8uDkbSzPy+hrsCo9TW9-3J3r3p0xQ@mail.gmail.com>
 <2336140f-c993-467a-b2eb-e99dc9427a59@kernel.org>
In-Reply-To: <2336140f-c993-467a-b2eb-e99dc9427a59@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Sep 2026 08:45:51 -0700
X-Gm-Features: AcwNN1U3AJ7bd1wu5DAq47WAQ3768Dp9C-h3ciQoeJdMEez_KO5Qa_LhKJ8PHrw
Message-ID: <CAJuCfpEL40p+vk6-km6_BBuE3+YY0WqkpbvQnQGFEo_73MAomQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] proc/task_mmu: remove special-casing of
 smap_gather_stats() start parameter
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:41=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/9/26 23:51, Suren Baghdasaryan wrote:
> > On Wed, Sep 9, 2026 at 12:16=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 9/9/26 20:28, Suren Baghdasaryan wrote:
> >>> On Wed, Sep 9, 2026 at 10:16=E2=80=AFAM David Hildenbrand (Arm)
> >>> <david@kernel.org> wrote:
> >>>
> >>> Hmm. So, are you saying that !is_cow always implies shared_or_ro? Or
> >>> maybe you are stating that vma_is_cow_mapping() was the actual intent
> >>> here?
> >>
> >> So the comment says:
> >>
> >> "For private writable mappings, we might have COW pages that  .."
> >>
> >> Which translates to:
> >>
> >>         private writable =3D=3D vma_is_cow_mapping()
> >
> > Ok, just want to make sure I'm not missing something subtle.
> >
> >>
> >>>
> >>> shared_or_ro =3D VMA_SHARED_BIT || !VMA_WRITE_BIT
> >>>
> >>> is_cow =3D !VMA_SHARED_BIT && VMA_MAYWRITE_BIT
> >>> !is_cow =3D VMA_SHARED_BIT || !VMA_MAYWRITE_BIT
> >>>
> >>> so, !is_cow would impy shared_or_ro only if !VMA_MAYWRITE_BIT always
> >>> implies !VMA_WRITE_BIT. But I think it's possible to have a VMA that
> >>> has VMA_WRITE_BIT but not VMA_MAYWRITE_BIT, right?
> >>
> >> VMA_WRITE should imply VMA_MAYWRITE
> >
> > Ah, good to know.
> >
> >>
> >> (in sanitize_fault_flags() we even disallow write faults entirely if V=
M_MAYWRITE
> >> is missing)
> >
> > I see.
> >
> >>
> >> For example, a
> >>> driver can create such a VMA to allow writing to the VMA but to lock
> >>> its content once mprotect(PROT_READ) gets called.
> >>
> >> I don't think that would be valid for a driver to do. But it wouldn't =
matter
> >> here because
> >>
> >>         shmem_mapping(vma->vm_file->f_mapping)
> >
> > I was obviously overthinking this :)
> >
> >>
> >>
> >> I think we could simplify the comment as well to:
> >>
> >> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> index e671b4fd8dedd..4b7e7089cafa7 100644
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -1303,12 +1303,10 @@ static void smap_gather_stats(struct proc_maps=
_private
> >> *priv,if (is_partial || (shmem_swapped && is_cow))
> >>
> >>         if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
> >>                 /*
> >> -                * For shared or readonly shmem mappings we know that =
all
> >> -                * swapped out pages belong to the shmem object, and w=
e can
> >> -                * obtain the swap value much more efficiently. For pr=
ivate
> >> -                * writable mappings, we might have COW pages that are
> >> -                * not affected by the parent swapped out pages of the=
 shmem
> >> -                * object, so we have to distinguish them during the p=
age walk.
> >> +                * In CoW mappings, we might have anon folios that are
> >> +                * independent of the shmem object. So fallback to the=
 less
> >> +                * efficient mechanism in such mappings.
> >> +                *
> >
> > Sounds good. Will update.
>
> Likely worth putting that into a prior cleanup patch, so there is less no=
ise in
> this patch.

Well, this is a cleanup specific for smap_gather_stats() funciton, so
I would prefer to keep all the pieces in one place.

>
> --
> Cheers,
>
> David
