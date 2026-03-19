Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60540DFB2
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881514; cv=none; b=rrKGb3Bp2h+7NG9u+R4XKJywouemG8NmU8fOhGc3Nqb+kUftvZpgvNXkUs2LBli9gR19993clDVLABdGDhwix+gmkIzsLlAy8ASWKoOPsxhqglOhbNeJFwKgKhoEkSPHbYIRWXyrfilVrwr6mo+hgPLwEhOK3MF4w0kxdMoTgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881514; c=relaxed/simple;
	bh=UJQ2XbQ3QkI6VFE8h6QNPZZDGxWzSCTFat9r0Li7AEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/JpGpKU7xAwsFYleZYU0CwSJ8q06x7aQWpkAF44hH9p+9Kw7vv3bju1mG6NDJzun3PqI/EzE5IzPW29jAqnuMgpe8Y+QNdU+ntMr/LsRssJLNLNfIx5fWnNuiNBRPyw9ATjWIFpS7RUWc5UsIHn4d3Hz7id0+8C5wJDP5IbGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5So8QHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5So8QHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FB3C2BCB0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 00:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881514;
	bh=UJQ2XbQ3QkI6VFE8h6QNPZZDGxWzSCTFat9r0Li7AEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s5So8QHGB2iQwMkI6TE6AEPeeBuLqoeks2AVqV2PHNQXuk+HgMrom32/9lHfUCQrM
	 EwvqkSZ83aROjCNhmPQUYgPEa3LtUnT1ueOYwrNyrDJkGrThWlFQ5E10kqY1i6uAwj
	 wJtk+oET23ZYVvrVe/pys/UXPbC5R3kx70akWo5v72spmt9V/SU7Q5+8dA88K3POjL
	 LPMNx0FpCxcY0mtokoZ6g7xk5DLCgluOQHWJT+5DzFHsfR4aqcC/92KQc45XUBMYQL
	 HOG4CTbIN1aN8PBgH7nlLEB1IY/gVXIiunjzznNHURfW0tkNSNcahgHX6bNEXtUWdI
	 tcej+8b8iO+qg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-667952a44dfso803347a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 17:51:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWa9brcohp0/NyTs6syelVMrwMh6W2N4v4d3VkjQXRdTlTA5nXOdjtB2VS/q7uDhvqhWpv6b5DvU1TeTrh7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1DV1Iw3vQyoBIelLPEbsEhWulILbpC+s6IKQAEW6cs8sgFYF
	p9nIpZIuTcJsdnEVRyPgmjcpDXFf7LgHcwNXSUcIyTKUDm8Bxqrcr2SQTD1Ei2rgTrOsD+PWX3b
	4opaJTpiZJiG0K726hLqAXWRJPjsXzZY=
X-Received: by 2002:a17:907:c11:b0:b97:a5cf:19e1 with SMTP id
 a640c23a62f3a-b97f4b707a2mr386029766b.56.1773881513007; Wed, 18 Mar 2026
 17:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311222613.2010177-1-dxdt@dev.snart.me> <abIxl8XEftpku8yf@casper.infradead.org>
 <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me> <abLUQECuMuxHNXjZ@casper.infradead.org>
 <20260312150623.GB1742010@frogsfrogsfrogs> <14dc2f67-7916-4990-b1c4-5d442c5d51fc@dev.snart.me>
 <20260313162408.GE6023@frogsfrogsfrogs> <898f4927-30a4-4ccb-b080-9e4d2fe3af1e@dev.snart.me>
In-Reply-To: <898f4927-30a4-4ccb-b080-9e4d2fe3af1e@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Mar 2026 09:51:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ptRdWc9Aot=5+GmRRbc989EY0QaHj14Mhs2wwiWBa8w@mail.gmail.com>
X-Gm-Features: AaiRm50O-UrNtbjaneBKpxf0f_aS-vhVVNSnLzcaUY4Nm0jbHb4lhTcFzx0JxMQ
Message-ID: <CAKYAXd-ptRdWc9Aot=5+GmRRbc989EY0QaHj14Mhs2wwiWBa8w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: David Timber <dxdt@dev.snart.me>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 7:37=E2=80=AFAM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> On 3/13/26 22:59, Namjae Jeon wrote:
> > I'm working on adding iomap support to exFAT, and I think SEEK_HOLE
> > will be able to address the requirements we discussed. I will bring
> > this up again once the iomap work is complete.
> Good! exFAT not constructed using iomap leading to an eventual
> catastrophic tech debt has been one of my concerns. Since you're working
> on it, you'd naturally implement FIEMAP as well, right? I was cooking up
> a quick and dirty functions for FIEMAP... Not sure if you're interested
> in them, but would happy to submit in the future. It's only a
> kernel-specific interface almost no userspace uses, but really
> insightful tool in analyzing fragmentation issue I'm trying to solve.
> Might come in handy in the meantime the new iomap implementation is
> settling down.
Since SEEK_HOLE will be supported as part of the upcoming iomap work,
your patch below can be dropped and I won't apply it. And I would be
very grateful if you could submit your FIEMAP patch after iomap
support lands.
Thanks!
