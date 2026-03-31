Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3C30E0F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939009; cv=none; b=qCT0igEh5Vw24zay65CJLuruIDRu91Kdv6IyfVhG2iWpwDKkYQ4l1YOzGzB4LsFtOR19d22pK0M7pnwOsJ3rE6XYCSkH76XdX+lBwUsyYKNpYSG7AG48GNKyORJ/1opex9nCFtdS6w/MPQKrydeltjicG8teKdAEU2awRrN3Aws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939009; c=relaxed/simple;
	bh=EMhDHkvah3nDpQWeA9C8/Qggu0IXctSXwO3g16B0Jik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Niuql0ALAH4OEvqiScOCRpHSQlbGCm6gzGzdjoJqPutERlxjRIsjDJRoypG9mM4Gr0068NS9z8zzDn10aSO5W5uU8FR3a3St5Wfufg9Ji8tgr24+ADZCsliHnvt+cCCPzKScttQ1P4nAtZZqzthBwthgePTDieethuLLR39Ufyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZx3WGlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZx3WGlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A68C2BCB5
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774939008;
	bh=EMhDHkvah3nDpQWeA9C8/Qggu0IXctSXwO3g16B0Jik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jZx3WGlhqW6FTRs5HgHvFwxZ5Unxa3gw+6xDsTv0VgY0URuEutT1UNO+03yqJTTjb
	 gVOLCNWlrz/996XxhOGYfWUapcuyi6xk6sMRHh5jG/V/FwEPYicrMO0Cw8LfVumAYH
	 6NJlb6HCjnN8Ov+eCPVAq9+Ph10wmzM6+OfxjMn5Sm+UYMdW1zVZLQ+Xa+qJc/fuSR
	 ZmcvAsGS//iaXY3UFs7bh+xwD1vRVHWpBt2f8yZtFjwP7smkxM2iGCzLIHXan7PEl3
	 8pwX3hsrIHA5MDlzEK1KGQbP+1wWJmDGn5ibKORPNBxFwy+Iquts04Id4xPO5UzPBG
	 VunWQHMGfiALA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8d7f22d405so820156866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 23:36:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaqHAJM1cGhysumDuxh6qpa6HJMyc7wGM10u7fI9C/HLJOtiKnBDqEifKEJpZwlHWjL78/IJvd7hz6M4RZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs78eDMS/jcJC78ekEGJj7j2mpELFuWR9C02E/asE/p0ztKy05
	+DIpT/p0FbTd1dSlMLVPO8ZhwHgB3b6rHEXr4itDZJEWMVkrY+CaYhbYSLG+QAG6FJeKVHAMomR
	XJH2A8H3VbZ4wHUIfsCshDik1fDQtEwk=
X-Received: by 2002:a17:906:8d8d:b0:b9b:1b9e:e4c9 with SMTP id
 a640c23a62f3a-b9b5094517emr952931266b.48.1774939007356; Mon, 30 Mar 2026
 23:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-4-linkinjeon@kernel.org>
 <20260330063821.GC5897@lst.de> <CAKYAXd9pZx1g=53wtCh0xTVYgQCLNz1sEL-2-fHbkSHQ=qTiTg@mail.gmail.com>
 <20260331054616.GA31506@lst.de>
In-Reply-To: <20260331054616.GA31506@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 31 Mar 2026 15:36:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-2=AM4vdwB6wzycDAXQd5CJEqUU0GPjRvskqZYFXS2eA@mail.gmail.com>
X-Gm-Features: AQROBzBZRWwF-2tUx2pDcqqwAg65JTW8kmXiigLhD9OETp47XxTkKRV_E88mY4s
Message-ID: <CAKYAXd-2=AM4vdwB6wzycDAXQd5CJEqUU0GPjRvskqZYFXS2eA@mail.gmail.com>
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn, chizhiling@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 2:46=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Mar 31, 2026 at 02:22:57PM +0900, Namjae Jeon wrote:
> > There is a deadlock issue when using iomap_dio_rw(). In
> > exfat_write_iter(), the inode lock is held while calling iomap_dio_rw.
> > generic_write_sync()->__generic_file_fsync() in iomap_dio_complete()
> > can be triggered, which attempts to acquire the inode lock again.
>
> Can you document this?  Note that Jan has looked into __generic_file_fsyn=
c
> and decided i_rwsem isn't needed there.  So maybe as a first step just
> switch exfat to generic_buffers_fsync_noflush, which doesn't need this
> (or way if/when Jan's series gets merged) and keep using a generic
> version?  If not document in the commit log why this is changed.
Since Jan's series renames __generic_file_fsync() to
simple_fsync_noflush(), switching to generic_buffers_fsync_noflush()
now would cause a conflict with his patchset. I think that we can wait
for Jan=E2=80=99s series to be merged first. So I will drop the
exfat_file_fsync changes in the exfat iomap patchset.
Thanks!
>
