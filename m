Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E9357D01;
	Tue, 12 May 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618003; cv=none; b=nFA8Z3keR1pZ3r1NHNZYrHAFBpckC+LlZ4d/48tVuTIhOwUBCTejVWCuqkH8LwXlg2BCzbcHhxBiQv17He4xL3t0rxifiqJ3XnEyfFCX7I8VmyNB05b9zgANL6Rz7GJ0i2ZmoPtPUWg4mvxxDzwQ2zBtpqevWI3sVckmD6XjchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618003; c=relaxed/simple;
	bh=Km6Rh4v5G8T8dQPpj9+aS8fpGyk8ffjwfzNRUPfwcwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T93nr+xna7GMn011dSIpw+wuKDBmW85XBoF+GfvRoOT6b3UO+0WK++N6x7LUcAxYexRMj6ja8y0iuCflBuGojIAicEwcCoGx/vUg/vaCBDMugXAyv8zEvM/BnHBEyo4tPxA7wnFjZ7Es0jqWg7MyDpQXSPt7JorcJ9gkUdbnLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjaTnOsW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjaTnOsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E437C2BCB0;
	Tue, 12 May 2026 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778618003;
	bh=Km6Rh4v5G8T8dQPpj9+aS8fpGyk8ffjwfzNRUPfwcwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjaTnOsWBxjdxTVVzjYkBp4Q0SOIKVMLuS5chsaWGNxJ1U0oChwpIOd9CJv1dPVwC
	 nfH7xFIruSRUTpRzqjDfrR2u44RUBFNgmFOIUPhI5qBZ9I21Eh4POfgkL1Zfziu7LM
	 sK9RmhmPo+tc1PSZb010pnpu05w8Dj5TGfC0NcR8gH3v8rmi23jvs3IvU8pT797CWP
	 hqf7W3CN5/kUDEFAI3YyRJR3cT45pUOjFqQm9wB5OOaxHbdTr4J5gUaKVpGNtl/Sz2
	 fUmMZLdnOaxrXKNeeUJy1ImTZ3dvQrgSAlGarCasopsK/55QcLz3HF33vFSB4eldgy
	 bwa1iF0NdyhZQ==
Date: Tue, 12 May 2026 13:33:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	fuse-devel <fuse-devel@lists.linux.dev>,
	linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	Luis Henriques <luis@igalia.com>
Subject: Re: [post LSFMM summary] where is fuse going?
Message-ID: <20260512203322.GD9544@frogsfrogsfrogs>
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <CAOQ4uxhnOEkX4qnn0wHMCqWhEeAGTR9rxcw5u_oqGUovuszo0w@mail.gmail.com>
 <CAJfpegt=eWS_6ZfRsL_P79COKJKoLGNOsJ9g6TkrAhvhSbb7nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt=eWS_6ZfRsL_P79COKJKoLGNOsJ9g6TkrAhvhSbb7nw@mail.gmail.com>

On Tue, May 12, 2026 at 11:52:53AM +0200, Miklos Szeredi wrote:
> On Mon, 11 May 2026 at 19:18, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > IMO, FAMFS sits somewhere between PASSTHROUGH and IOMAP.
> > The simple nature of the maps, the fact that famfs maps are const and
> > queried at file open time makes me think that famfs is much closer to
> > PASSTHROUGH than it is to IOMAP (in its full capacity).
> >
> > I think Joanne has mentioned that her customers have a use case for
> > multi backing ids per passthrough file and I assume this would be a pretty
> > simple map, so that sounds pretty darn close to famfs already.
> 
> TBH, I thought that fuse-iomap is just going to be a generalization of
> the passthrough interface.  At this point it seems like it's trying to
> do quite a bit more.

To me it's always been more about exposing to fuse servers the same
local filesystem file IO paths that in-kernel filesystems can use.

> > If we are being honest, then we need to develop features that users need
> > and if users need features, there are usually employers willing to pay for the
> > feature development and maintenance, if we let employers know that this is
> > what it takes to get their users what they need.
> 
> I fell that this is a "politically charged" topic.
> 
> Let's just say that maintainability is very important in big features
> like this.  Even deep pocketed employers can go broke or change their
> priorities, so we need code that can be understood by at least one
> additional person with a different background.  I think that would be
> a good enough guarantee that the code is not going to be a nightmare
> to maintain.

I can't credibly say much of anything to this right now. :(

--D
