Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BA3D6497;
	Tue, 24 Mar 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341500; cv=none; b=h8oClhAHFCkV61AUszmFKCh/nr/WG0pq5iw2aUjFmwR8zcqMZVlB6NEtie7Z+5XnDnm2WirARSD7/tlbJovEQJA6Z75cOaAn2rDjx1sZO4eOmnV8dZZgMMuoQBHCI/cnSirm6H2L/DQH3kq7325Inix9XptW+JoRnqz5EqNMtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341500; c=relaxed/simple;
	bh=J3i+/hue+9gTlZgWtSDKJ80DXvvkwLtdtof8jpXweI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw2kefxLIvtqqarMvE3192IQ7ftgVn5JDpKYM60PJLTsiXSwbbEg4oOEfhOc35nNweo3XW29CyarQ8y/vY2Bx3PwiYFi3uRr7TL2ddSf0ddWJ7YIGsZNoxsF1xEd8XwMjaTmcWRVasDUHeb+hHfZwuIQnOzs13JrwXSLxJBw+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BadPVtUm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BadPVtUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E75C19424;
	Tue, 24 Mar 2026 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774341499;
	bh=J3i+/hue+9gTlZgWtSDKJ80DXvvkwLtdtof8jpXweI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BadPVtUm15LfadagP4yzeAZJoDDOdNmA9IsqGEea97V+ElU7VPrGJIEd9e1fKKmjx
	 We2440fNPuWPLLgFoXfwGjd3bkQ1C7QXywbGRbNCKU/PKjYDu7DRE9uyRGZ4gUC9tA
	 z9KQdsqEayuBgQxRQFElWLl2PhXh7YjLYeq72T2MT/hRxE2g3kOk4U/KTuNkZolNYx
	 hVwOOJbWlqUDMxp+kVjiBML0A0V51j/Cm5nKH0tOoRD9landHL5R+quIpMGJcunUQq
	 Ssw2W7KPfuRH7wVkhDUgVT4bwABWLh27JZMr0uVsF6BzkwZDRDkvzwikxhG8KyJ8TO
	 BMBuvNv4eQJkA==
Date: Tue, 24 Mar 2026 09:38:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	David Disseldorp <ddiss@suse.de>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 0/6] initramfs: test and improve cpio hex header
 validation
Message-ID: <20260324-konsolidieren-zwanzig-63f3a987e0b7@brauner>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
 <20260323150753.1937b34b80772602d634d180@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323150753.1937b34b80772602d634d180@linux-foundation.org>

On Mon, Mar 23, 2026 at 03:07:53PM -0700, Andrew Morton wrote:
> On Mon, 23 Mar 2026 15:54:16 +0100 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The series that introduced simple_strntoul() had passed into kernel
> > without proper review and hence reinvented a wheel that's not needed.
> > Here is the refactoring to show that. It can go via PRINTK or VFS
> > tree.
> > 
> > I have tested this on x86, but I believe the same result will be
> > on big-endian CPUs (I deduced that from how strtox() works).
> 
> AI review asked a few questions:
> 
> 	https://sashiko.dev/#/patchset/20260323150054.3587083-1-andriy.shevchenko@linux.intel.com

That review is mostly garbage. The VFS layer has it's own AI review
integration in its CI and it is filtered. We don't need to point
reviewers to 10 other AI tools. If there's relevant finds by AI it'll be
pointed out on list.
