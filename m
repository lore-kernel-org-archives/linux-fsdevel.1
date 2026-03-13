Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1CE182D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360620; cv=pass; b=pltvPgGSmRTKKXoQDRt94wJg6OFjMFjxrNQycnwzQYTRk1WIVBndfDOtv37u6iczCY3mjuoORhw912x5rJZZgoPvTwKVMiQUja0SRBFzrWLfI9PrEzp0yuQbT6B7tx5r+PAkhG+edX3N8DDQKCFbYjAv311Q0vmrsNAbRcof5Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360620; c=relaxed/simple;
	bh=IdA9uyb4tofjy5aPKMoWpRAQdruvZX9n+MlUrohi2ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPAxrhhXB45MgLLU4qmVx9dbHSp9wwliau84kXiR9CwQR5KuX7PcLuZGzoT+vzYemyvVRJ/nxQY2iDgiVcaQ+AjoFDvwVEDp5Q58RhuwqFAQGPNORhtyp/Zy6xwT9oMVGE063l+Un8YNSulUvLJsM3gFrddNhhUTswowzCxAw1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=dEJ7mp30; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="dEJ7mp30"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79800183233so25585487b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 17:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773360618; cv=none;
        d=google.com; s=arc-20240605;
        b=EREiKEoCuOxHwb34oi9IH4z2nt8+cD/a7vq2AhxM87qr67/M/96LiYQdBieJCOEAsU
         RPHpAeCjiQGaQRLi/Oy14GBwrdjc+Ngkv53k1oux7s8dZRhkZCgRDBwQeEdCOWI6zZWo
         KHbLYz1fNMga2ViE7yIKMJGL1A50XPj7qWiU4V91RULAc9IZQt5s9xiLZvUJ6nw0H9as
         PLCfgRnluADazju5ZgWmDh4PNK3BMxlhEpn/9FbvUfOcOudj1+P5lkjIN64idytdfoy2
         oF/xv5Q6zot3pAeOYDMflObeNYzCOhdnUAS+azf7UorikKOamOmIuMsMgGkSqOkkrhU+
         01Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62xPx8+aZwJ3Pgb8Nz0+Ol4Bn/gHH5Wgi7mQXMN5Jg0=;
        fh=OEDPbxfwP/T11op+KCXGN5nVgb+gcHSeHovlHNsOdQs=;
        b=N3XnTzgN/CQrbiNCK+IEK/5X+fj/O5AmNosvdwxfDRr04v9yrMIRy8oheNFO/n8HOH
         jsUKgJeUEePigrLVAX0rXDOzC28K2ZVANTqjIb/2+PyaZvyf9jCS2Q/Ud+7fwUkn1rMS
         F7qDqDaRvYdPBnO8WlG+vYqAIZTxvRKkLhIQUMJWbxcj54qf9JXbr0VUMRvKi5zz3oR9
         xBK18yd+OP0V8jR1BAjoJ6NuOL88X4FZrmSpFXZsItxj3vE69ci2/IosR6unt6KEP0/Z
         Wn/VtNYDkRDrLaxYsIyLrgZFeXkIZf8a6S+HWPIElQh/hVMbwM0vveQUCExruCZIEUMZ
         jKSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773360618; x=1773965418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62xPx8+aZwJ3Pgb8Nz0+Ol4Bn/gHH5Wgi7mQXMN5Jg0=;
        b=dEJ7mp30DkMV4kOWqkW7lqJr5+kkP2Z+UfbU2TF5LD3WqeyxzoRlLwz2K0sp6yHfUq
         cPlnhWCPMRLmaqV19FCGQRX4WzzZZedEvDT+7YVDDhxaLXExVGeWG6Og4OaW3ZiX1+8z
         CAdRFp0tMb7DnY7NC0h2UC/51OAwbgxSebOwOQE9qnuPYZL+RjB3CABfbI5aeLL7QMaj
         v/A8S7aiT751N8v6IFY41WxH7cz1KeDsQy3GD33bqLSHhmESdy6oaYUy6HI5zGPNGKBM
         vYDyY2pgSPbWMPyiIXVglVIPSo3FmjWbSEMFVtw7wsycawl0pUAIP4sGBHwKGPRHTldJ
         wbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360618; x=1773965418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62xPx8+aZwJ3Pgb8Nz0+Ol4Bn/gHH5Wgi7mQXMN5Jg0=;
        b=Or5LfSY2niGgvSqMUpJt/x/Nv6/+0aViwaxDMhe9UWvcvBJo/43J9MrO6H5DVhXJey
         KvkQ8RDBwlZGRgcZaMg6m4DAZI9AZmSbXoTsk4MHVjZrSuxTQOmlHqYTvhx5d33+zhCu
         cxXQyZuxiLaMKxi4V064N3ZhBmv2O8zvOEtsz61RUH/lF6J89rfiSWtd7zRBGixYL+U/
         tuX9jTpN/RG1AIN9KUu+lrrpF9LR4BmPNsphA3LQEt4ok+MH960/pJypCn4daPBju9Ht
         e27Z82r6rt8F8KdR4icARAj+YXu7KwAACKONkiZ45ZP6ebQTsb7MJ5AqSICq2Io1wTI1
         7qqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxBS2ZGvkHf+lAGYeW1Rd7a8JMs0dBWEkIbsZiDT1GBWtpVerRNZnj/UueECYjeVGASiDlbnPpnD2qcnGI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1EsC1gM1Lz22usiE4lAPy/QOXH0oyLOhF4zOKJeGh3EVAl1T
	tjhVi4cxGCPxn75wYHqm2mb5a9PU8lx7CxtPU50khf9SKzRsJsSkLZSXlkF2DtwEKXmMph/Beo5
	+xRyTnVYaDwkekZY135nkceyYGQQC+Y+H9PlcPjyNLg==
X-Gm-Gg: ATEYQzxbd1b6efXXIeHMYnpBeapL/Qxuj4XcfZk+Ls9+QqeP48I58IVZKdU5o7+2Ldh
	JROogP1rz9tG7jE4myBAz3f7CjyrtbKOg2BQ8HP/TrVPrCbNS4usbnviYrwxO+PfmOh4sXW0xfl
	i0vzoMz9uzfWuGAM7J5u8726++9G4s35zEZJy7fZbbAW/mPnIFbm/wn59PfPeWryAzjWkCQ0XQ9
	o619YjKdbIz2d8KLe+LaUt66cWcKiD1DkIiwggpHNAPI5E2Dj4C276uMm16GGdD9mn+lLsrk3sd
	xq0hgD6DqRmpIf13jTTq6IKYsX0EYp1jQcPSMkKlww==
X-Received: by 2002:a05:690c:46c1:b0:792:7745:72fc with SMTP id
 00721157ae682-799475e6f5emr49906397b3.21.1773360617696; Thu, 12 Mar 2026
 17:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310031138.509730-1-r@hev.cc> <20260310031138.509730-2-r@hev.cc>
 <bca4ea00-3052-425b-8f39-729d504fd4db@kernel.org> <7937d789-539f-47db-838f-c153ca6cfc50@kernel.org>
 <CAHirt9gpZ98HQCXStEQMMfe6TEnSzmD04BM313h2LJGJ1K-hJw@mail.gmail.com> <60ba4311-01f8-4ff3-a2df-e1b3fb6db699@kernel.org>
In-Reply-To: <60ba4311-01f8-4ff3-a2df-e1b3fb6db699@kernel.org>
From: hev <r@hev.cc>
Date: Fri, 13 Mar 2026 08:10:06 +0800
X-Gm-Features: AaiRm52jdG3nfACWernvRkLmy2s6N34pUBtBRSkEgJDstHEPy6GnGv9garrc1XA
Message-ID: <CAHirt9gZbKY8ouvPYZh8=i-9Y3honXKApE1Xs+M2RGdNz66nSw@mail.gmail.com>
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

On Fri, Mar 13, 2026 at 12:29=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 3/12/26 17:12, hev wrote:
> > Hi David,
> >
> > On Thu, Mar 12, 2026 at 11:57=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 3/12/26 16:53, David Hildenbrand (Arm) wrote:
> >>>
> >>> There are other ways to enable PMD THP. So I don't quite think this i=
s
> >>> the right tool for the job.
> >>
> >> Ah, you care about file THPs ... gah.
> >>
> >> Why can't we simply do the alignment without considering the current
> >> setting?
> >
> > The main motivation of raising the alignment here is to increase the
> > chance of getting PMD-sized THPs for executable mappings.
> >
> > If THP is not in "always" mode, the kernel will not automatically
> > collapse file-backed mappings into THPs, so the increased alignment
> > would not actually improve THP usage.
> >
> > In that case we would only be introducing additional padding in the
> > virtual address layout, which slightly reduces ASLR entropy without
> > providing a practical benefit.
>
> Well, that parameter can get toggled at runtime later? Also, I think
> that readahead code could end up allocating a PMD THP (I might be
> wrong about that, the code is confusing).
>
> Let's take a look at __get_unmapped_area(), where we don't care about
> ASLR entropy for anonymous memory:
>
> } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !file
>            && !addr /* no hint */
>            && IS_ALIGNED(len, PMD_SIZE)) {
>
> Interestingly we had:
>
> commit 34d7cf637c437d5c2a8a6ef23ea45193bad8a91c
> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
> Date:   Fri Dec 6 15:03:45 2024 +0800
>
>     mm: don't try THP alignment for FS without get_unmapped_area
>
>     Commit ed48e87c7df3 ("thp: add thp_get_unmapped_area_vmflags()") chan=
ges
>     thp_get_unmapped_area() to thp_get_unmapped_area_vmflags() in
>     __get_unmapped_area(), which doesn't initialize local get_area for
>     anonymous mappings.  This leads to us always trying THP alignment eve=
n for
>     file_operations which have a NULL ->get_unmapped_area() callback.
>
>     Since commit efa7df3e3bb5 ("mm: align larger anonymous mappings on TH=
P
>     boundaries") we only want to enable THP alignment for anonymous mappi=
ngs,
>     so add a !file check to avoid attempting THP alignment for file mappi=
ngs.
>
>     Found issue by code inspection.  THP alignment is used for easy or mo=
re
>     pmd mappings, from vma side.  This may cause unnecessary VMA fragment=
ation
>     and potentially worse performance on filesystems that do not actually
>     support THPs and thus cannot benefit from the alignment.
>
>
> I'm not sure about the "VMA fragmentation" argument, really. We only cons=
ider
> stuff that is already multiples of PMD_SIZE.
>
> Filesystem support for THPs is also not really something you would handle=
, and it's
> a problem that solves itself over time as more filesystems keep adding su=
pport for
> large folios.
>
> So I think we should try limiting it to IS_ENABLED(CONFIG_TRANSPARENT_HUG=
EPAGE),
> but not checking the runtime toggle.

That's a fair point about the runtime toggle. Limiting it to
IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) sounds reasonable.

Thanks,
Rui
