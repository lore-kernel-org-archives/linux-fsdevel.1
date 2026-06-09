Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6D14ABE;
	Tue,  9 Jun 2026 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964861; cv=none; b=WeCD4Ip6/j1M8FjQ+kekl1D6ly6V2l0nuLoxtBtsIKNuy5bixPtlfogUdsTFF9UiHdVXRydAj7BW2MIVuSWYpHCcbclaT/oB30FvefPGJNAcRXpSO3sVBaghJEkBJXvPoOO/EVZeSDgyGHeSv7tyWuEcaTrPUjuKt5I9fVBxjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964861; c=relaxed/simple;
	bh=AeM0cygRRWZWI2/TIWQJxoqR3yg6QMFETkMHI6xchRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZFCa6iimBIpOyp+g97yu7qeLrK6ltBTgkJm90HFjUtOchxpcF8dNijQ/DpDVjvPbQqofEhBXLE7qZXZxqb0/WfVQzWIYp3mHAu9plFHKbQvDaNaAWOtGkdIKfDQSxrxjuq8/qVotowH4c0c1hGHNOTHrtlyDi2gQETkMfbTJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoDDDd5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoDDDd5f"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 249AA1F00899;
	Tue,  9 Jun 2026 00:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780964860;
	bh=3o2xNYJ6BIIropkWsfz4PN5W1XWuT+BmqBSMYY+KCmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HoDDDd5fshZt/+J/H+RQ1xrN7A+JP3zmjSY9X3bLLWHmTwAb8hOwpHOkdq62PJCtZ
	 QKLq76lVnDjFmGSiM0626ARZ6roE9nRIEJH/elZKSB10jlYGiQliKTa9dTDeiQ2BHG
	 vBPtaYVU2/18M7XgKf/3O6kv9gaWnxItk85lN8dGhPEpA3yVQeMv7CjvTbnXV7t2Db
	 vqgxSAXT9RRwdV0Hp0XsfxXcWPc8+gQj0PdcDYgqVD7717tdpzmXsSzXpI+wBarIz/
	 3KvcgCu41wFRdV58LD2q3K7zFPOeyBE32zlXXwmnttpHw2I42gavBmUImIn61AiEZY
	 WDHf5h4SipdHg==
Date: Mon, 8 Jun 2026 17:27:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 2/6] mount_service: don't pass the chopped buffer to
 apply_fsconfig_mount_opts
Message-ID: <20260609002739.GP6095@frogsfrogsfrogs>
References: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
 <178044567862.1435997.14889132979032394431.stgit@frogsfrogsfrogs>
 <14b642b6-0df3-4d4c-a33a-fa9dddbe952f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b642b6-0df3-4d4c-a33a-fa9dddbe952f@bsbernd.com>

On Sun, Jun 07, 2026 at 09:48:34PM +0200, Bernd Schubert wrote:
> 
> 
> On 6/3/26 02:15, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > If mount_service_handle_mntopts_cmd previously looked at the mount
> > options to screen for allow_{other,root}, then tokstr (aka oc->value)
> > has been modified and not put back.  This causes truncation of the mount
> > options passed to fsconfig, so let's use the snapshot that we took
> > previously.  Codex noticed this.
> > 
> > Fixes: 7211953256526f ("mount_service: use the fsmount API helpers from mount_fsmount.c")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  util/mount_service.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > 
> > diff --git a/util/mount_service.c b/util/mount_service.c
> > index adcc7a296645ff..360a78bab3bd3d 100644
> > --- a/util/mount_service.c
> > +++ b/util/mount_service.c
> > @@ -994,7 +994,7 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
> >  
> >  #ifdef HAVE_NEW_MOUNT_API
> >  	if (mo->fsopenfd >= 0) {
> > -		int ret = apply_fsconfig_mount_opts(mo->fsopenfd, oc->value);
> > +		int ret = apply_fsconfig_mount_opts(mo->fsopenfd, mntopts);
> >  
> >  		if (ret < 0) {
> >  			free(mntopts);
> > 
> 
> Wouldn't it be easier to read if strtok would operate on the string the
> was duped than letting it work on the original? And also cleaner, let's
> say oc->value would get uses somewhere else? Checking for "allow_other"
> and "allow_root" could be even factored into a helper function.

oc->value is a throwaway buffer, because mount_service_main will free
the command packet once the dispatch function returns.  That is why I
let strtok mutate oc->value.

Obviously, the mount service object needs to retain the mount option
string for later, so that's why it strdup's oc->value before strtok.
apply_fsconfig_mount_opts takes a const char* argument, so I figured it
was safe to pass it mntopts.

Yes, we could hoist the strtok loop into a helper and have it quietly
make another copy of oc->value but that's just more work for the heap
allocator.

<shrug> This would all be so much easier if strtok and friends didn't
make *permanent changes* to the string.

--D

> 
> Thanks,
> Bernd
