Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE914884C;
	Sun,  5 Apr 2026 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367180; cv=none; b=XrxEbWjzAr9HkKcPNaElEHaOeW+u0fN3q6XUyL5aY4d7ndpVRHTBVVbF5KM3JQsJywv3jyZvCFpzymjdSzGwO9owBz4/31/oqr5g6q9ElPFidHZKDyekI4jUPpxvCYc7zSDqmUcjPPpT3+sbuHAa54l05ukuxSpoIftUpA/GWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367180; c=relaxed/simple;
	bh=sw/+m29S9rvyEZVP8yBapjFvZSpbgIUMlpVQEegRUQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyagA5ESWJXJwG/0a4efyrke07y6354d8K0rOUT5wObOkMZqQ9wUan6fMWfb1OG5tw4umuV0Td3zJKlPDeoEJ+KKRU+L9gLpqcPkIancLKClSS0fzgBA7k0FtF/oq3V/berFK0E1/RSpeimZDnZ694dnFG7ZLlTovlbkFn3/Uj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PThPNvLY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PThPNvLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B348C116C6;
	Sun,  5 Apr 2026 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775367179;
	bh=sw/+m29S9rvyEZVP8yBapjFvZSpbgIUMlpVQEegRUQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PThPNvLYkfzEYJNwOzTzaZRKYoYmiqYAXDyLJDqkvU8flJKztPDxUmmxm0oRCR367
	 9zeC+6tYmVHU9cG0NQUYNK02oJLRkXujWM1XQIuseSz/LLBSE4LJaI4ONoJ8a1U4QO
	 pfz/+jEjNW05GpRsd3qJumHSvo6S1t/d9SQ0d36c=
Date: Sun, 5 Apr 2026 07:32:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomasz Kramkowski <tomasz@kramkow.ski>
Cc: stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Brad Spengler <spender@grsecurity.net>,
	Alva Lan <alvalan9@foxmail.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Revert "xattr: switch to CLASS(fd)"
Message-ID: <2026040502-remedy-absinthe-a571@gregkh>
References: <20260404112219.389495-1-tomasz@kramkow.ski>
 <DHKD00A8F4MN.3394SJ86VMD72@kramkow.ski>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHKD00A8F4MN.3394SJ86VMD72@kramkow.ski>

On Sat, Apr 04, 2026 at 01:11:57PM +0100, Tomasz Kramkowski wrote:
> On Sat Apr 4, 2026 at 12:22 PM BST, Tomasz Kramkowski wrote:
> > Was asked to send a revert instead of a fix. Previous patch was here:
> > https://lore.kernel.org/stable/20260403230636.344097-1-tomasz@kramkow.ski/
> >
> > Tested via qemu to verify the fix and ensure there were no unexpected
> > consequences.
> 
> I should note, however, the backport was intended to fix a specific bug
> in `fremovexattr`, and now that bug is there after the revert.
> 
> Shall I just submit a v2 of this with the revert _and_ a new backport?
> Or would you still prefer to just revert and then have attempt #2 at the
> backport separately?

A new backport would be great, as the original was broken, and this
makes it more obvious where things were actually fixed.

thanks,

greg k-h
