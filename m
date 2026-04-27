Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7302F5491
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299274; cv=none; b=mPYJGfzd1vzNoTz5HiKaLVWDXXUpCTxMWjK49l3Psvw0WMDw9N83la6M51gevsh+7Xp8hsoOxNT6ujtp38KYD7tb1TFjMECVOIyBL4mjz0Xk79LtcOql2f8IYWr4IFpo1uhfbqtjnP7M+FU2Z7NaJXjOisOGw/mCGGsn+NaWKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299274; c=relaxed/simple;
	bh=awOzeK2M04gBjyIw8LeuWMGOZ4QxMCutlQJoBk6edm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m75jIU8lS2p46XUPqvuY7ajnBPgqINEuQNmRFfFuGfWxoJU7RsifbFRFc71qxEt1rg5nKsoT0XCqp4e6VqKkhelfDEQMrox3oQ5SWiln9IGkOUajUhFz3ttkSG5vUWgSEjffOpNit6cMTq9y6UTGhl9NKw9QFk5Jvi5bQueFySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utionYZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utionYZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557A3C2BCB9
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777299274;
	bh=awOzeK2M04gBjyIw8LeuWMGOZ4QxMCutlQJoBk6edm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=utionYZV/b1tKANAhl70oWGG5Eav6QDOcj8CoGIlkaipSRkaH/H0Mb/qLQGTjMpy4
	 9J3nMq92Cz8/imwYyNSI+l/l7nG5ZEWSSwiHUMsWa4k6py7idcNsLj8S+Lj9gIZVlh
	 JJbe6pYyb+0itHNZti4U02rzBxKn30XdIrsV6fYrh2ncDEFvUftpTjLClbT51HTV34
	 oWw63A9UFcC8UEZLvZ0BDMOATj4lGWrgkwE6T973JRLKb5N+XAX6Y3ZTjorqjjiEV7
	 01PqrUjbmx+BMwjWHLP6aHGMifXE2x9Ay1bfH9vD2rNH9TqhYLtbn6aYJkPVKT9s04
	 dTAcoyVET8gOQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-671ae79e617so13196050a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 07:14:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+wWEEB/klUYjehHjUQM+lfna46Z/l983bTAuFaZccMJor0dG4S9ZczXfzrvKMBJLmZfRtRmE8Dz0u8LYb6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0feCVeFV8Ln0f774c1KzgIiOjCY5kOFv1rNBsqlQTGLVHLVW
	MaBEpRMLNqxVEkgO/sqZaUeHz57Gfq66abbEe3OJUW3XS2196DaVgSJvCLimh/zjJACGVPj7Q2E
	mRgrUPEOp/sgXqurccve4dmyV2BaRRb0=
X-Received: by 2002:a05:6402:5305:b0:678:9826:b758 with SMTP id
 4fb4d7f45d1cf-6789826b949mr6631207a12.6.1777299272836; Mon, 27 Apr 2026
 07:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423213203.5533-1-linkinjeon@kernel.org> <20260423213203.5533-2-linkinjeon@kernel.org>
 <d9ac4def-a34a-4748-8cc8-d63b460ba8ab@linux.alibaba.com>
In-Reply-To: <d9ac4def-a34a-4748-8cc8-d63b460ba8ab@linux.alibaba.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 27 Apr 2026 23:14:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_1yeaUYant=09=EnStad-Ti91J5J6fvXBRSJLcdJFiZA@mail.gmail.com>
X-Gm-Features: AVHnY4IZQi1okzynvAo8ZS8EIkS7M5r153oZh_PIbRaSiTJV6hdJTE__i8qTjDI
Message-ID: <CAKYAXd_1yeaUYant=09=EnStad-Ti91J5J6fvXBRSJLcdJFiZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: remove over-strict inline data boundary check
To: Christian Brauner <brauner@kernel.org>
Cc: willy@infradead.org, xiang@kernel.org, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, hyc.lee@gmail.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 12:06=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2026/4/24 05:32, Namjae Jeon wrote:
> > The current iomap_inline_data_valid() check ensures that inline data
> > does not cross a PAGE_SIZE boundary. However, this is an unnecessarily
> > strict constraint. If a filesystem provides a valid iomap::inline_data
> > pointer and iomap::length, we should trust that the caller has mapped
> > sufficient memory for the range, even if it spans across page boundarie=
s.
> > Removing this check allows filesystems to point directly to their
> > internal data structures without forced page-alignment or additional
> > redundant allocations. This remove iomap_inline_data_valid() and
> > its callers in buffered and direct I/O paths.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Hi Christian,
Christoph and Gao have reviewed this patch. Could you please take this
into your queue?

Thanks!
