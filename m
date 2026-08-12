Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7464309F1D;
	Wed, 12 Aug 2026 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494122; cv=none; b=ZtW5NIdwMsQedhIhMAjUqKRSVa+9eUNwc5y10Lsqe/NC7WtP0XcuVEVfRLv7aI92XeROBYjxn+g2oHXzwbAipshOfmeoLMumFa9X/fkZOw1jscV9iaR0+TzNtC9QTIHoYKKwaIsvEKjhWh4a7L3qyhw7wmdo0n6eqQXTOxdCDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494122; c=relaxed/simple;
	bh=86kRHvCfPEQrpiE0qCsIOVwwwyhqWxzSsJx3L+A+KCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNYW44QoJGrdGfPRg35cOrwMb7yAgicfI/j3PJ/F5/aCHMearU7iHU60Nrv+G5BPMZ9I+yfvkWtbBWWczlZWqJjpJQS5xAx4NT34Q67q1NanRxNw2QNnXoiu4hzAhpq5KL9mEwweCr+yF20bLIqB79/0mhaLs9XfJcrA7DgxUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysd8Fmn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysd8Fmn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3DD1F00A3A;
	Wed, 12 Aug 2026 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786494121;
	bh=VhwcullDweBA2y43cU3X0QJqXfzoX+SmzxNQiIKXUY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ysd8Fmn4nDDPohKAcrSHO1iFdNzAewdFZ3jn0ktnzfwnv7L1Azf5kIXYE2Tp/QGz5
	 +AgcdyPNfmyiJdymtRA0/tCwUZptVP8zj2Ou+kttITKGXhpic8sTZV/wXhx0//6cKu
	 r9OaKDZBGf/g4RgpTBi05+QLRVaG68nPN6Rz0YjCfNeGy8NsqR4HNILkTOpaeu6C+M
	 2ThCzkKyqdHOeji46dQFhlBhbqmZE1kB6/R4TkDYCjFOa6SiS+zeAZzBSr3STTgUes
	 TeQ0gx2W2jXOW83HBs4EFBMV8UGJLKENDWKEetAIpMLPLSaXuJ9kHzKvWNpFRa1vD7
	 e6XvRryqoFRZA==
Date: Tue, 11 Aug 2026 17:22:01 -0700
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: Add KUnit tests for fdtable
Message-ID: <202608111721.06C99CDB58@keescook>
References: <20260810204118.1981755-1-morbo@google.com>
 <20260810204118.1981755-3-morbo@google.com>
 <202608101713.34DEA00E9D@keescook>
 <CAG48ez1VBBkukXH17RRSnAU7rMu0St5x59rkTDVkcMebxuS4-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1VBBkukXH17RRSnAU7rMu0St5x59rkTDVkcMebxuS4-g@mail.gmail.com>

On Tue, Aug 11, 2026 at 05:42:05PM +0200, Jann Horn wrote:
> On Tue, Aug 11, 2026 at 2:16 AM Kees Cook <kees@kernel.org> wrote:
> > On Mon, Aug 10, 2026 at 08:41:13PM +0000, Bill Wendling wrote:
> > > +static void fdtable_test_alloc(struct kunit *test)
> > > +{
> > > +     struct fdtable *fdt;
> > > +     unsigned int slots = 64;
> > > +
> > > +     fdt = alloc_fdtable(slots);
> > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> > > +
> > > +     /* Check that max_fds is set correctly and is >= slots */
> > > +     KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
> > > +
> > > +     /* Check that fd is allocated */
> > > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);
> >
> > Nice to add these tests! Can you add one for each of the conditionals
> > in alloc_fdtable (e.g. ENOMEM, EMFILE, and the power-of-two rounding-up
> > logic, etc)?
> 
> Wouldn't tests for stuff like the rounding-up logic get into
> implementation details too much, and break if implementation choices
> change?

It seemed to me like we'd want to notice if that behavior changed?

-- 
Kees Cook
