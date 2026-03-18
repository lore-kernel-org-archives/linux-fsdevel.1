Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A53DFC8F;
	Wed, 18 Mar 2026 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858804; cv=none; b=YrxhpoiYm4zmg5RZvkNEMwxomhwE5cyjxgRDoHHY+y5oLW7SRz71HJBOAmKkvyLsVCqf7VYVYeomdnPW/E2QVMTf1Vzw4geb8fZrO3MQd5xDA0owhGF//PQbcj1czmAefsj8f+Xldgg11V4ZInm3X/iJAFeVB7lmI4sNsYx6HQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858804; c=relaxed/simple;
	bh=Q/uh4QAy4IU2itVKlERvGMXidyUsuGdulupJTD5xwYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyKxPAfZ9DxVBJOGhvyhFf1Yd7wpQ75FuIz92JCVImPn8Lxh+YR1gs29MmlfcTXyYiGBz6traTpfVGYEb+OM+8rw+ZB1bconXt5rc85MCFkneVJSDPx5Uxk/K0ZRtev1zUPDDl6jTdGcdKZgL2Q8aTJMWBQHRVj87A9APf0GpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chyubJ3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chyubJ3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9929C19421;
	Wed, 18 Mar 2026 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773858804;
	bh=Q/uh4QAy4IU2itVKlERvGMXidyUsuGdulupJTD5xwYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chyubJ3X1/firrp76bLjG/+vNfJqNnB90aYEk6Zcih2c9oabwEvoGLloeOaNTiLY6
	 hqfkJjRL78NKkqbcVGtfZNCEqcNKCoe/PFcPdNbgXg0uXPCD7vW8Yp5avtdW0kKFp1
	 D7IbJ82yq6DqzJMjeVXAJ/qH152XodTiC3pihX1Ykbh202ePhb2bcbuHvCsQQOLcNQ
	 6qRpSFVvr0fwGlnPtaX/Rx1Npsvi8EP6hC8eHaFByCvd62g0GK15dVuaZz98LVdDIb
	 QGgz1CYNBDLxRBxcb9W7EoReKrwoAHzO4pm2annaPka3Sul+V3ascK5FgWfVDEgrGt
	 9b7D0aoZqSRiQ==
Date: Wed, 18 Mar 2026 11:33:23 -0700
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
Message-ID: <202603181132.507C829A9@keescook>
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-1-keescook@chromium.org>
 <a3e9b1c2-40c1-45df-9fa2-14ee6a7b3fe2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3e9b1c2-40c1-45df-9fa2-14ee6a7b3fe2@roeck-us.net>

On Mon, Mar 16, 2026 at 12:16:58PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Sun, May 19, 2024 at 07:16:11PM -0700, Kees Cook wrote:
> > Since bprm_stack_limits() operates with very limited side-effects, add
> > it as the first exec.c KUnit test. Add to Kconfig and adjust MAINTAINERS
> > file to include it.
> > 
> > Tested on 64-bit UML:
> > $ tools/testing/kunit/kunit.py run exec
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Justin Stitt <justinstitt@google.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > ---
> ...
> > +++ b/fs/exec.c
> ...
> > +	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
> > +	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 *  + sizeof(void *)),
>                                                                    ^^^^^^
> 
> Google's experimental AI review agent tagged the above change as syntactically wrong.
> How does this even compile ?

Wow. I have no idea how this ever built either. I will get it fixed.

-- 
Kees Cook
