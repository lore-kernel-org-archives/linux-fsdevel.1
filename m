Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307B3AA1A7;
	Tue, 24 Mar 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377622; cv=none; b=sjbjT7zwgQH75JDIHrowzeTm3MAirpMbdSqIOAGyPP2yIoe+8dZXjrdUV+5ZCvwQ/vBy1jrH3wHhlFjjTb4MBv4aMdXZmBQUS635wWJ0xNJ//5d0CAWenXNxRO18/mAQ6xFBabdFj+55VjJ0ndea/XytHD42fN9FtnF+XXbgKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377622; c=relaxed/simple;
	bh=tk4vAe/SlzWEtNRNQzn2PzYDvQaUHgUhyhyKZV0bgyU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W6oMMSL94qXKVFQgv4fE7KoXFVAXGnMDzrEWtUhJt/uUS4Ig8lOWHAS683/tuT2E2cL4jrjL85/7VoBILgY6QNZlRcAJp7Srqww/Y2oKwFDZA5755JNr5UhZKxGGxHJ5pC4uc6+Wc99ykoAEcC0U/vjiWxSDmZi5XyxuCAc+KDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kFJ89+fG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kFJ89+fG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC37C19424;
	Tue, 24 Mar 2026 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774377622;
	bh=tk4vAe/SlzWEtNRNQzn2PzYDvQaUHgUhyhyKZV0bgyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kFJ89+fGi05G95oqfCS3SFBdCraoKecI2LmebckW2CMBtIBEpEv/vnVZp+8Aexalt
	 FH/xCH4cHAQR7D275Eqk/AhR2uBZLPZwAlcEaRvHLYgKwG/I13FRM5v4MfrEn9P1Cm
	 wftS+yoeWmj/+eZNR/MwYcDnWBK5PyLMG21Kfe1g=
Date: Tue, 24 Mar 2026 11:40:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 linux-kselftest@vger.kernel.org, rppt@kernel.org, jack@suse.cz,
 shuah@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, dmatlack@google.com,
 pratyush@kernel.org, skhawaja@google.com
Subject: Re: [PATCH 1/2] liveupdate: prevent double management of files
Message-Id: <20260324114021.f5546d2de5b6a2b0490f63cf@linux-foundation.org>
In-Reply-To: <20260324-langzeitfolgen-altgedienten-ccef17d19349@brauner>
References: <20260321175808.57942-1-pasha.tatashin@soleen.com>
	<20260321175808.57942-2-pasha.tatashin@soleen.com>
	<CA+CK2bD2aNu-NByET4KkBP0n2j8WQE2zjxb4g-1cv2hYfjaRZQ@mail.gmail.com>
	<20260323-leibhaftig-blasinstrument-58ec408b3c40@brauner>
	<CA+CK2bC6S7pFCYR0XS1ZPxw9HKjWgxy=0DkszYNjMUi735o_1Q@mail.gmail.com>
	<20260324-langzeitfolgen-altgedienten-ccef17d19349@brauner>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 09:51:34 +0100 Christian Brauner <brauner@kernel.org> wrote:

> > > So, I'm not happy about I_LUO_MANAGED. I don't think we need driver
> > > specific stuff in struct inode and not in i_state. Track this in the
> > > driver please. I don't want this precedent and I'd rather have you get

Well dang, I just merged v2 but Christian wasn't cc'ed.

> > I am planning to use an xarray in the next version.

That's what v2 did, and I_LUO_MANAGED has gone away.

Christian, does v2 look OK?  It's at
https://lkml.kernel.org/r/20260323203145.148057-1-pasha.tatashin@soleen.com


