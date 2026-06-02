Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B455158535;
	Tue,  2 Jun 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408224; cv=none; b=cNMWV15Q2V3CRe/wefaaWtaygJW479EN0gOwIMS57jHuh3UltQzBMJkGYONmfQQ/w4mHJxn9L9LmkmYPkU3QnD1S3KG0TnR8oe7+2kl9WhsFohmd4PmaMvKnf3mQxPLQYOSyZb3Wx2QZUFPBPzc5w2+YnvQsEiK7PccjbKwOdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408224; c=relaxed/simple;
	bh=kfokZ2H6wNEPx9QXqIGQxi5dBkbn2UZb4QiutV4UqLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT3rc/knCIZB+WA/HTRfovjBnKGO6/oSHSrc+ZNCbItYevnOtONjFJwzPJuRq136nksZvEmxPciKmDTHocaDW4uLqdOsC3cXfO7NVO8G0Xx7RdcomWBgp893nze2UFMczMYE4saC0I9QQoCSxmY0yvE5fpMd0U4eEXsl/QXi6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYJmroha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYJmroha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC321F00893;
	Tue,  2 Jun 2026 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780408222;
	bh=Abi/11pkmXbc/O3FpznXF1iIrYpHhjU7n86de2QBtMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oYJmrohaFPubXuTb1Gkn8mTAoe2dNGjJJbeaOun7PNJawNsTId4z+8vU0HW7UKBip
	 zMuxLQe+4ZihpHv7CIcn7u4nrMuV2vhtgWVSwMG+jdFZQpajX6uV19JT84ZZYVd7T4
	 7tJ/0ad1U5X9mOvMz3RqIfdFq2ZnlyYS9i4ais+/Dotig3FLwwmtryU5TVLMF9D16W
	 E9lcHNdAgdoDug+CSKDYBXSeDeHhlv32Vo0BWjJRksoxXyihXkyo9nv8lZKGVXInw5
	 pf+hsz+ErKUfqY40SKslGimE979QdHw7JbLaw8tT/l3V+wPgrPZ39Ci4xCraMw5dMN
	 tICnvyz+QyjJA==
Date: Tue, 2 Jun 2026 15:50:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: AnonymeMeow <anonymemeow@gmail.com>, amir73il@gmail.com, 
	repnop@google.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: register event pid for pidfd reporting
Message-ID: <20260602-patzt-sturz-segen-f1f305d61b75@brauner>
References: <20260530013732.50811-1-anonymemeow@gmail.com>
 <20260530105117.45792-1-anonymemeow@gmail.com>
 <dolfs6j4x4thpgluglxhlepg34l5uvvxv2sjcmuao57bxnbtjb@urx5vgczxbup>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dolfs6j4x4thpgluglxhlepg34l5uvvxv2sjcmuao57bxnbtjb@urx5vgczxbup>

On Mon, Jun 01, 2026 at 05:24:36PM +0200, Jan Kara wrote:
> On Sat 30-05-26 18:51:17, AnonymeMeow wrote:
> > pidfd_prepare() may still fail if userspace reads the event after the
> > task has been reaped and the pid has not been registered with pidfs.
> > Register the event pid with pidfs when creating the fanotify event if
> > pidfd reporting was requested, so pidfd_prepare() can later create a
> > pidfd for the reaped task.
> > 
> > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> 
> So the two patches in this series so far look good to me. This patch looks
> OK to me as well and since the overhead of allocation etc. is only once per

It's a kmem cache so should not matter at all...

> registered task, I think it's fine but let's wait a bit whether Christian
> agrees this is what needs to be done.

pidfs_register_pid() can only fail with ENOMEM or if the task is already
dead. The latter cannot happen because even for a non-empty thread group
where the thread-group leader already exited but subthreads are still
alive the thread-group leader cannot be reaped. So the only error here
is ENOMEM which means we should defo fail this, imho.

And yes, I think this is worth doing. Because you get a persistent
handle on the task that generated that event + all the exit information
even if that thask has been reaped in the meantime. I'm pretty sure if
you're using fanotify that's a rather huge win for apps that need it.
