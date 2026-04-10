Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116F329E6F;
	Fri, 10 Apr 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814073; cv=none; b=PrdzVz6fP9x4YlKRk7ioQjkVZwZyGVtf/aLDV7vp9Aca+hTDjxXcyhUqRQ+vN2TQEU1U/aY+MOhQ07g0UNtT9OdAHluz4feJ2FXFMSgMZkVpR1ALcSZ7L7/bNHRiXkxWSrD5VHj5urN6couraQJWA4rJ6kIdZu/gVkNdtcHkKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814073; c=relaxed/simple;
	bh=qaDTJIiv6rDw/RsT12RngB1605+MQTqzba52ymO6pT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltmNuNiFW1QGPfcVQj27l3lCm3mkmlJvvI1S7WdGvcLMo1eI6uJDqc0lhPZk3yukUGvrQeY7K1Dtg6KtvJZq0uqVNljyTt9p6J5nCS2tLc3N+5ajQzjIC1cAzH7wIcH+9jAeehzQGaXvtftNHez09hTAeHpd+twgEJA3z45j6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK+GJETC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK+GJETC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750BEC19425;
	Fri, 10 Apr 2026 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775814072;
	bh=qaDTJIiv6rDw/RsT12RngB1605+MQTqzba52ymO6pT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fK+GJETCB9/sZBK6qyFbfjOa7RSh5RrJNjt/IzHJRP/hzM/1S7mu1SopRT4BY2av1
	 TRsbxagh4a/ULXI2T0RcTM80i9Ce+30ILZ/TLJMYI/v6tLGN+MgAQSNCwmriJGsYD/
	 8VztA+O1QPwdbMDY3VCO9x/C8MXLFoUsjzGMZcVx8m2XY1L8F1b9X5r6bmdJxPvX9F
	 /T30MxLopUGk0uMHRC05eBeaZuPaP2svQYvKrGMjocXcwmyuOqkYj61hcVSq7vd1Pn
	 jY/8RRlO3czCJ1boJqgLGOsrFiLDfOqle8NyI39sYabiLzEBdQOWjJQVLLjK8VknUM
	 mFC/NVXot5yVg==
Date: Fri, 10 Apr 2026 11:41:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] fs: handle potential filesystems which use
 I_DONTCACHE and drop the lock in ->drop_inode
Message-ID: <20260410-schiffen-abbuchung-1383b7b048f3@brauner>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
 <20260331160851.3854954-4-mjguzik@gmail.com>
 <itaix3v2pgkrlvhxetyepfzrbyg7bnigghrkrdofznas37nsyf@irriakb7cwzj>
 <CAGudoHEBkMu=mY12U6WmXDReY5EUXehP6wG45XmLyQ5qHiMA3w@mail.gmail.com>
 <20260409-weben-obstgarten-1465edb3d7bf@brauner>
 <CAGudoHHeRPm+yZo7AVvadkZg5HNEKx6JPBBNQu0UPecJf2H7hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHeRPm+yZo7AVvadkZg5HNEKx6JPBBNQu0UPecJf2H7hw@mail.gmail.com>

On Thu, Apr 09, 2026 at 04:55:52PM +0200, Mateusz Guzik wrote:
> On Thu, Apr 9, 2026 at 3:40 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Apr 01, 2026 at 08:50:39PM +0200, Mateusz Guzik wrote:
> > > On Wed, Apr 1, 2026 at 7:45 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 31-03-26 18:08:50, Mateusz Guzik wrote:
> > > > > f2fs and ntfs play games where they transitioning the refcount 0->1 and release
> > > >
> > > > I don't see ntfs providing .drop_inode at all in current Linu's kernel? The
> > > > f2fs case is indeed ugly and a gross hack. But I don't see easy way how to
> > > > fix that for now.
> > > >
> > >
> > > This was generated against next-20260327, then:
> >
> > Ideally don't develop against next... If you already know you're going
> > to do a bunch of work in an area. I can just assign you a branch to work
> > of off. Easier for everyone. Also makes the CI easier.
> 
> So what should stuff be generated against? fs-next? vfs.all?

Use vfs.all
