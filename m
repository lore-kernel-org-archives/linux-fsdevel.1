Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7438371CF3;
	Mon, 23 Mar 2026 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267225; cv=none; b=lmwmitVmlmA0kLcvmecbGxqmaCHkaVmhwtPQDQ72J1g+QaCKyfYmBG7R4ibcEy4Hy1gAhrrlMaNjoTtv6G7btt5hgTgHmcsiVY4gZBq6kndebcZyqnkJ1bhyVZtj65SFoOVCI5+nsiSwSpZ+rb4RsPfv4bHC7lKQ33MHeJGD8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267225; c=relaxed/simple;
	bh=K6deGRTASItYsEGC7BMH3oTBhT9Wr7Ls9PRClFDB5qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTlivfV8CEmA3bKZiZSVUEioykH2wC1NfVKb0/jGceE6ch8h3hGHkLyo2NsVee70eAaABcZ0YvY10KO+4y06ztfD8A6/vCmSiMyG5R7ZiHbgFMlknb6uXymOZTgn9n2JOz7MtxDUOWq2uqbSzJjkZWwxg/FRx7rv6WNneXI1RuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO2g4oEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO2g4oEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437A0C4CEF7;
	Mon, 23 Mar 2026 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774267225;
	bh=K6deGRTASItYsEGC7BMH3oTBhT9Wr7Ls9PRClFDB5qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BO2g4oEME6wqg2740eiQgC3oaBz7+C7GNKGKKRVPszj0YJn/mLvjgyUkL8ngMID3+
	 V6tGkUZWFthNay58lPGtHgX0VdcqRBldyff2a1LuC/aD6WuntWrlIV2OC065Edj6hH
	 dsZUMmQLdnSH+0ODPgmAfJfhrzJIsh/vbpQJ2n4OAkcQ5nTfpfwB2rokTzHCExZHh0
	 K8xbHbi2xzWfK1hX0dWG3L+GfKmskxyUShcDhKuGV02cD6pj5+5BULW1KmDEwVBf15
	 2vXNYBtZSHY/LBQ9+677+LfERK0+j9p8n44iGGRQpp1lGruJHEGVzItIovScv/13hx
	 H/q4yc3bEm13g==
Date: Mon, 23 Mar 2026 13:00:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Daniele Di Proietto <daniele.di.proietto@gmail.com>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 3/4] fs: Export new helper do_replace_fd_locked()
Message-ID: <20260323-kocht-meisennest-ac89063f104f@brauner>
References: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
 <20260321232142.911280-4-daniele.di.proietto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321232142.911280-4-daniele.di.proietto@gmail.com>

On Sat, Mar 21, 2026 at 11:21:41PM +0000, Daniele Di Proietto wrote:
> This is a new helper that installs a new file in a specific fd number
> and returns the previous file that was there. It requires holding the
> files_lock.
> 
> In order to keep ksys_dup3() simple, this commit introduces a new
> static do_dup3() helper.
> 
> It's going to be used in a future commit.
> 
> Signed-off-by: Daniele Di Proietto <daniele.di.proietto@gmail.com>
> ---

I think this spaghetti here is really not acceptable and the export of
do_replace_fd_locked() is really ugly. Please try and come up with a
solution where you modify e.g. replace_fd() that does like 90% of what
you want minues that "needs async" shortcut you have.

It's fine that io_uring has its own fdtable. I don't want anyone else
to get ideas about doing the same by exporting ever more tiny helpers.
