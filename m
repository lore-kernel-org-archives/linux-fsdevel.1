Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAB288BA
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783123651; cv=pass; b=qVjTJKYanH9WLKLQZQUanvoP2fDJu3Aey4YGQyNjfCpGjwcUs7eq328iym0NmIEgutjUVwmeO+owXTN48tw1vHIJ/LhhtyCeh+sEXU/hS9nHWbtimZ9oESleujxbZ6Ipy78qjIReDz8pKT4aGt8s6Ksuwqwm7fE1/Rx3KYGpu68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783123651; c=relaxed/simple;
	bh=vDHlcWmL4Cd5UT42ugQTjRnKNbXE5dy2ocFAsQoM96Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD72R5dNcYbvQvGNyUWFSlZy8w+vPXzyEERDZDpCZWU89J9xzBFz773aNWu92FTbA5Y91A05WUqv9N5bAPcIF3W2aqKkLQWbLFvLtb1qxhub41QWuh1I/YBlJDTQfgzygnGVC+1un5ArVc+qLzyrou9A4aMhHhqu96zD38dgGgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki+A0bbK; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki+A0bbK"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4728c12ba97so636608f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 17:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783123648; cv=none;
        d=google.com; s=arc-20260327;
        b=n/JZst18Ud5ZX8nEd7Gkznd/s4S3BZPqS3jexXjLWP69xYzkKnr4liIkJCP0Jb3wde
         jVioOA7JcuoUrAW3soh8BZjR6WGQqdPo71rpnXNUh077oykPq/fieoBzl7Cv6+vqW84R
         9nNgzGk0vpbjjsoYeVMpJ/NZ7+Yri9OQIO8Sad2Koo53W53WOsQL6BFn8QlizrhFL7Sd
         Hpuc87FKA6k5kpNuqpFOOtOp9i4mnQj38hc42ptl/AUHywYvWg/O0KdU0PAyx8YGblgR
         y0YXoGioLhCxQtRttPXRKFAZzv6ERh+7daSKG3j6G+H5QD1TreGDNdVv2iSpTBOgwJLO
         0/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDHlcWmL4Cd5UT42ugQTjRnKNbXE5dy2ocFAsQoM96Q=;
        fh=NsbnGy4a1ce/VhLcLW8RU5+LZ6NRp8I/uFKcdwqwAfE=;
        b=rxWeu/2OQFQ4AniO5A1cFKhSvKs+kPxMp31EWQ9CwN+fhA9Ga5pa7LG89lnKwQH6ZX
         5oxk1IKkhF22++oa6RzKD70TEw9EjZyss2ARmySXHd/ZiGrdwx4mgEY74Jduji93BuZl
         Wj9jVHArAhwYyMFjrt6buiyprVB3ZBNAyw+yz09lnmZ7QFwmMt2T5Rmz8VrgPj132aNt
         55IzZPUr2di4nEVMy267+9lkWUWGCOYKKeHZIaa8MDvFNbgLSLHfunfxRCsKzMC24636
         S5annAlY/kPcfSzJTub2xgXoF2SyDUL/YM6Ey+3RBOC5rGPmReiDFIT5vMDxxdXVNp2L
         IB6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783123648; x=1783728448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDHlcWmL4Cd5UT42ugQTjRnKNbXE5dy2ocFAsQoM96Q=;
        b=Ki+A0bbKzGZisB5V1frmhFAWaHUmml0lSbQaVT4Wc5AmhzhtZiLEbRZGydmphq8WNu
         WrbBGAVeEXZVheyQIXek9+iwrKEFyjDmDNjeQ1/NyvUuQ5dsYdUtXTjABn+tjaAB/nM+
         S0Wt95GY8YCt3jDhTRz8W7Q1099fwMbIhKWJ932bivc1pLQOIYh19ZE3SztF0jA7Ml2b
         XH+TxsMIt1sDuEMNW3dxNJALZl6oiW0wYrC4CsLSyo2jPbJpAZNQcObp88gjMG61DavX
         GCmbL0ElaaG9yqIIMsqfxzSqiMiROvFy0wb9rXwTnnpTlND5XlVL6vJf6zgLpsXYLko+
         RYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783123648; x=1783728448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDHlcWmL4Cd5UT42ugQTjRnKNbXE5dy2ocFAsQoM96Q=;
        b=QVL//oBlkx+RoDvXOK5HeiH+1ic1kX3su9vqHucOYOuvGEKFlK2jEHMlvIZjX4yZWn
         LDTpejXDyXrR4RluptdGamsXann4L0UIUBR71i5fiH9jqfMs5Xg0AAUJrMNxxiYu1tom
         sf6uEO2U2wYF6GSAjgEQX0WLnRgxg1iNd8KANEUkuMjz1vSPFDPaiXZ37lnH68jJdbhh
         NZJNQBUosg5NHMwu/obYgHzM2Ls75C3qmhx1tUex7rKmsFR212BxvH4DRXnmEoWE6DPI
         T0hSoZ/+zLf5W5oH/lfIzuEXJ0xFvK+7HsNt/XfpvabI3AYTM+ovDE+8SToR8z7zc5yw
         w00Q==
X-Forwarded-Encrypted: i=1; AHgh+RpcqUck9j95JtC8H361ZqmpYqTHBt059QDA3FpRBgINgAfHgHKrd2Afi7ePRBukHuohUFG9r/PgpGksUvTc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GW6gGNnbR6PJIQ2DpDXfyqlk2hY1aREiFXqqV/nlK3im8mDS
	mrEQ6/zaT4Nb8wjih4fJ5EicowWcYU3XsJrSAvBlIhmyoTEAQ92lkRGjbVQGD0qtCC/NawBXPGA
	T/jMW2LeSLu3kWb+UczRd8KUUAa9xChOICyfVtAg=
X-Gm-Gg: AfdE7cl2RL8X3A+KJh4eggEHmy/mFJXCuoVlerCH9YPcKQrhqqbnxtsBWwqC88QzYVO
	8ilwM7gx8XXGYoZ9Qo9UtcYElVUfAmlgmvs0iFs1IncTP38JmZ5fvoGhlV2B+9d360b8EEziuPQ
	gmlZbKEaYAUCgbeQ+oRB2zagGRZGR3/jj/B6KwvyQGqnXt5zTJxwvDXij+YB65CwlCJ8PnpULQX
	rF+GS0S0Pf1eQHdu5Wc26HcKdPDz4PxYg4KnBZz6TiuRTEyTWg69BJ4t6InpXZAlE59O/2hQtX+
	jyGVdMMyfWtiDC51ke6xavIo3bYtA9lgtKHPR3eGfcRFjUr1CwSe
X-Received: by 2002:a5d:64c8:0:b0:472:c426:2ce9 with SMTP id
 ffacd0b85a97d-47aa9699811mr1527073f8f.12.1783123647923; Fri, 03 Jul 2026
 17:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-13-joannelkoong@gmail.com> <CAHc6FU76J-YYRd2B=ZPN2DMabQjkzgG9qSzbP_S1s9AsSJNh=w@mail.gmail.com>
In-Reply-To: <CAHc6FU76J-YYRd2B=ZPN2DMabQjkzgG9qSzbP_S1s9AsSJNh=w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 3 Jul 2026 17:07:15 -0700
X-Gm-Features: AVVi8CdQdofMwGUqV4tTaAHxeI2fygjInGMJJOumzbFcOuGU31GOE644YhYA5nA
Message-ID: <CAJnrk1YmAjfSvkX5M0mu_ts_7APbp+Zfrz0KU6BMgM5fxN568g@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] gfs2: convert iomap ops to ->iomap_next()
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, 
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 4:45=E2=80=AFAM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
>
> Joanne,
>
> you say in the cover letter that
>
> >This series is submitted against Christian's vfs iomap tree, and is base=
d
> > on top of the current head of his tree (commit f2727952b21d1).
>
> which repository and branch is that? It's not vfs.iomap in
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git; I don't
> have a proper merge point.

Hi Andreas,

This is on the vfs-7.3.iomap branch [1] on the vfs tree. This was on
top of commit f2727952b21d1 ("iomap: add a separate bio_set for
iomap_split_ioend") but it looks like that branch has since been
rebased, as I don't see that commit hash there anymore. If it makes it
easier, I've pushed the changes to a github repo [2] that's on top of
v7.2-rc1 in the main linux tree. Sorry for the confusion, I'll include
a link to a pullable branch in future versions.

Thanks,
Joanne

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvf=
s-7.3.iomap
[2] https://github.com/joannekoong/linux/commits/iomap_iter_next_v2/
