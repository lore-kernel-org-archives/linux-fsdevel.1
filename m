Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF233993;
	Tue, 17 Feb 2026 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316183; cv=none; b=AzSoeqiKrAsrrPuZNohzjbsGldhchfI6SnsSb+GBfhCYa5rD5QBasL5lBrzxInq+78M5sJIH99R7ACrmjgamlNiIEdXZnJfILiF+pqgLhM3iaxNl183BnITBp6r+mYIfZppi/XpbliGzFPtQ1IEGxqzGXWDLJhWpTaa1a1KaoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316183; c=relaxed/simple;
	bh=FrFBFXX4chEe2yDjZZSRJqlFEyAv0qFo8BMEAIEockw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPCpchCNYlgIHl/YgNxIY1G/7hWYFI3css2wMmJmxpAbPcTOKp7KB4Fs6EJF2bHU9PH31aApqovDN+fRwZzbvEKRxhPQMlXBb/TSh/FMhgu+piqw/Cn0jP4ao2m2UHwaSwlND09EN1qhwvg3OLa5z4PGfTQzuyGxKvhojr9gJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWPKIGgF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWPKIGgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C876C4CEF7;
	Tue, 17 Feb 2026 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771316183;
	bh=FrFBFXX4chEe2yDjZZSRJqlFEyAv0qFo8BMEAIEockw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWPKIGgF9BVEFAhCDceqvFN0a8dtDcqVw9Rb7WRfZCSL7kcHk8rCFEgvKHIzCdP0V
	 6vp4MtidOD/hdI++rhbH+humCZfRUrRdduLx7WAt5TbW93LeCu3R7y20bl4cCXf9EN
	 AycXl0f+vDxaHwXAA2oBNUddm1EEmtZE6nuzpHRIzE6DxXFiPsx3fiVUJt9M8cchwb
	 J+1jHkSzR4ZB7lyy7PdK2svdgmXduawv2dcR/53oR9BB4s5PLXQWtGJAxBAfEwH1tL
	 jQ1ViChU6jcPjp+JTyyPumLpoOOsueGWFtpXO1HBFhgtwvQoMugw8fjAO6JyL4wCCL
	 sybozBfi8o7hQ==
Date: Tue, 17 Feb 2026 09:16:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] pidfd: add CLONE_AUTOREAP
Message-ID: <20260217-ruder-mietvertrag-1f48c75ea965@brauner>
References: <20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org>
 <CAHk-=wj8Jp-JZRQsLaOGCWYb_qjsnHZUsdSfRpkwJOsjJozfGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8Jp-JZRQsLaOGCWYb_qjsnHZUsdSfRpkwJOsjJozfGQ@mail.gmail.com>

On Mon, Feb 16, 2026 at 07:25:48AM -0800, Linus Torvalds wrote:
> On Mon, 16 Feb 2026 at 05:49, Christian Brauner <brauner@kernel.org> wrote:
> >
> > CLONE_AUTOREAP requires CLONE_PIDFD because the process will never be
> > visible to wait().
> 
> This seems an unnecessary and counter-productive limitation.
> 
> The very *traditional* unix way to do auto-reaping is to fork twice,
> and have the "middle" parent just exit.
> 
> That makes the final child be re-parented to init, and it is invisible
> to wait() - all very much on purpose.
> 
> This was (perhaps still is?) very commonly used for starting up
> background daemons (together with disassociating from the tty etc).
> 
> So I don't mind th enew flag, but I think the restriction is
> unnecessary and not logical. Sometimes you simply don't *want*
> processes visible to wait - or care about a pidfd.

I'm completely fine removing that restriction and supporting autoreap
without pidfd.
