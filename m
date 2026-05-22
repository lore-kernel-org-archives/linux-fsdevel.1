Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897746AEDB
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462173; cv=none; b=W05Nv4odSxTPhG7kCqzK/szkZotEXWhhCpVee7xOSQy/aplnFCOB/kh5p7Z3wtKKU+2QVvQ4fBtfSqPyIYVzVP9wl2iNSs2YAABaDQaNfBn1Vlq1NDCh9VP+roQz6E3HFHKZ+eYxEeU3gsAok12mml4xY+9w0WLQQF/FSbzwt24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462173; c=relaxed/simple;
	bh=onon9cs0XoKtXQDQ9M8kR96Bjbb3a4xQzKOVGNQg5qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dswXx78a37EU8+Tu/Qt41d4acnPgHfsfzFL7fqw0tKsVhaVV6Nn3yvmxZ/x1xfttyXXIl5vj/xlbE2zJF5Zd7kSUZgv8L5JVK84tCUeNVnTtJHzhVDglHfwau7Fc1KaXMQFtfWhXmyW54cBl6i8nL6nekf9lzrujW2NvYucoscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK6e56P+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK6e56P+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB481F00A3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462168;
	bh=onon9cs0XoKtXQDQ9M8kR96Bjbb3a4xQzKOVGNQg5qI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IK6e56P+z/aBYoTkeMXAfUsWqs9EPvkSges4K4yNIsevFCWDPtkAHaHq9T0Tk4QKV
	 LDrM3Bk615rNotKNP8UN3Bp292es6fFeTJNVHVAAsDgJRkTtuvR1SYVj2U0HssBfiV
	 OBGylARSJ+99nufZFud7OWIj8OMNea3q6p33w40pZZGqN20SOPjEDBITe8KLU1rwUf
	 mHRtq3RhnE1L37WNyIyRSvb1BbHPrnVIk/xLRMkcx3GjtDthmvoAFbFvuClz6M784W
	 ptctre4o23Tf1FmjZWe44/7GNMY0XOeD6ZFOS8nHrytIvzlTvwBuFJfjCrrGR6YdjX
	 20Oop5bep8YEA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso8711923a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 08:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/xb/2HjF0zNjZyj4KPDgFa7/3BlxeRS1v9K2Qoo0elxW80bqetjGczBU0htI5oBdmotssyIW5ll7gyG59V@vger.kernel.org
X-Gm-Message-State: AOJu0YwfaaJQDFkqoHE0scp0FDsAHXO48gyamV0Vwj5hcdDV3BJGrLt2
	nS2ca3sK/COBnpMngqRAtnthk5VDmqM0CeEbOaqk+nZLInawYnb+yBd7mM2yCMCsNfsLyXl4aJt
	4qQJSlesKIJifd41nEJPkxQ2HzrEIFcU=
X-Received: by 2002:a05:6402:354d:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-6889cc4d583mr2197133a12.19.1779462167212; Fri, 22 May 2026
 08:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518114705.9601-1-linkinjeon@kernel.org> <20260518114705.9601-2-linkinjeon@kernel.org>
 <20260522-euphorie-duften-seebeben-eba5c7ce28a3@brauner>
In-Reply-To: <20260522-euphorie-duften-seebeben-eba5c7ce28a3@brauner>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 23 May 2026 00:02:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Tcixc4jMeFRWZVA1t=f7T33D3zKNRg+0Leq_iU40Gqg@mail.gmail.com>
X-Gm-Features: AVHnY4KdjccnUfjVqVt0P3C8AjzO-HOFQbJHDhdHouzrfjHSE7_Dmb-cbyb9uys
Message-ID: <CAKYAXd-Tcixc4jMeFRWZVA1t=f7T33D3zKNRg+0Leq_iU40Gqg@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] iomap: introduce IOMAP_F_ZERO_TAIL flag
To: Christian Brauner <brauner@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, djwong@kernel.org, 
	hch@lst.de, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, chizhiling@163.com, 
	linux-kernel@vger.kernel.org, charsyam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 9:53=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, May 18, 2026 at 08:46:55PM +0900, Namjae Jeon wrote:
> > In filesystems that maintain a separate Valid Data Length, such as exFA=
T
> > and NTFS, a partial write may start at or beyond the current valid_size=
 and
> > extend it. In this case, the region after the previous valid_size but
> > within the same filesystem block is considered unwritten.
> >
> > This patch introduces IOMAP_F_ZERO_TAIL. When this flag is set in iomap=
,
> > __iomap_write_begin() will zero only the tail portion while preserving =
any
> > valid data before it in the same block.
> >
> > Without this tail zeroing, stale data in the unwritten portion of the b=
lock
> > can remain in the page cache. Subsequent reads can then return incorrec=
t
> > contents from that region.
> >
> > Acked-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
>
> I've applied this. The branch is marked as shared with the exfat tree
> and will remain stable.
Thanks, Christian!
