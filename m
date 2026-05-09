Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C21E32D6;
	Sat,  9 May 2026 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778287419; cv=none; b=Jra8W4sJIRmTrZ6NU4Y4y7YR7RfmyddUVRigf0LU4Y9hFBNiAPG3xDuiKOhyjNvwnl6tjFX9Xc+zgMypWM0P+BlWmdOyPlwi3LGrSIcN9v6lWpfGQpjZtBFDHSdJgPjZ5fbvM6eEiiDfJuUgqx7bwoAro4CtP1+xO6pHsNzc5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778287419; c=relaxed/simple;
	bh=PZpr2p4YDgWap/5/dMhWt14zzDKeeLERwtn9i205fmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy2Swje7mYBNqx22qccJIiPLzNFZMP9ByQY8uWJUKcK5Z2Fo9LrMG+WgefzgGvqS27QlCnJwsiM21A2dxUa51vebwak5s3GuBVvhAoiRgi4Iac3Wd+G6CGRqaG4kZ/tSzjbUkG6CEJ71FZ3mP3NZxfpHyrhUxmKjSq2KcXbAUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm1FOSo4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm1FOSo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65001C2BCB4;
	Sat,  9 May 2026 00:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778287419;
	bh=PZpr2p4YDgWap/5/dMhWt14zzDKeeLERwtn9i205fmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fm1FOSo4bGl0DW5iYC7EAf2PeIV+hN8MO08in5qk4hGiJ5oVV01XwfyGoNzOU86B8
	 beExEasSLh5Tir3LYhwpge5mquFBY2qsqbSmcJlIzCnSGDtMSmBApZU7KcaJDo81rE
	 Qi/as8vhtBp9uEdmGbGrakqqLrB3tA84H7hra5A1cCSxjMQFcoCOfm6QC/UwAAa/sN
	 ZtOeV3FZt6nxJoYrITOGHJIjLWBP0gcWvMKWtdYisx8bBAnusvlO4+DjRvH9kuEGdv
	 U5iFEuhPH9dYn91cXIUURODKA8l0TRxUJt2RlCfF/YWbsP+/XIdsPue9VytUrtvAid
	 YzzRGpPnJ9wJg==
Date: Fri, 8 May 2026 17:43:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
	neal@gompa.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHSET 2/2] libfuse: new mount service container fixes
Message-ID: <20260509004338.GP2241589@frogsfrogsfrogs>
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
 <11a04b4e-db8c-423e-a351-e7fd2a8bcc7a@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a04b4e-db8c-423e-a351-e7fd2a8bcc7a@bsbernd.com>

On Fri, May 08, 2026 at 07:05:52PM +0200, Bernd Schubert wrote:
> Hi Darrick
> 
> On 5/8/26 00:13, Darrick J. Wong wrote:
> > Hi all,
> > 
> > This is a collection of bug fixes and cppcheck cleanups for the new fuse
> > service container code.
> > 
> > With a bit of luck, this should all go splendidly.
> > Comments and questions are, as always, welcome.
> > 
> > --D
> > ---
> > Commits in this patchset:
> >  * mount_service: use the mount_flags table instead of declaring our own
> > ---
> >  util/mount_service.c |   51 +++++++++++++-------------------------------------
> >  1 file changed, 13 insertions(+), 38 deletions(-)
> > 
> > 
> 
> coud you please add this or or something similar to your series, to
> silence gcc static checker warnings?

Ok... though it appears to be in your fuse-service-container branch now
so I'll just rebase on that.

> commit 670fb8f4a248cfd50af43510033b8b3167d75df6 (HEAD ->
> fuse-service-container)
> Author: Bernd Schubert <bernd@bsbernd.com>
> Date:   Fri May 8 19:00:02 2026 +0200
> 
>     Fix deref-before-check in mount.fuse.c
> 
> diff --git a/util/mount.fuse.c b/util/mount.fuse.c
> index 802d7f99fe78..00b133e62344 100644
> --- a/util/mount.fuse.c
> +++ b/util/mount.fuse.c
> @@ -384,7 +384,7 @@ int main(int argc, char *argv[])
>         }
> 
>         source = argv[1];
> -       if (!source[0])
> +       if (source && !source[0])
>                 source = NULL;
> 
>         mountpoint = argv[2];
> 
> 
> 
> All your "Fixes:" commit messages run into
> 
> bschubert2@imesrv6 libfuse.git>.github/workflows/run-checkpatch.sh &&
> stg push
> No typos will be found - file
> '/home/bschubert2/src/libfuse/libfuse.git/spelling.txt': No such file or
> directory
> No structs that should be const will be found - file
> '/home/bschubert2/src/libfuse/libfuse.git/const_structs.checkpatch': No
> such file or directory
> WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12 chars
> of sha1> ("<title line>")' - ie: 'Fixes: 3e1101057aea ("fuse mount:
> Support synchronous FUSE_INIT (privileged daemon)")'
> #10:
> Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT
> (privileged daemon)")
> 
> total: 0 errors, 1 warnings, 12 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or
> --fix-inplace.
> 
> Commit a9e52715f595 ("libfuse: don't use SYNC_INIT unless asked for")
> has style problems, please review.
> 
> NOTE: Ignored message types: AVOID_EXTERNS COMMIT_MESSAGE COMPLEX_MACRO
> EMAIL_SUBJECT ENOSYS ENOSYS_SYSCALL FILE_PATH_CHANGES
> FROM_SIGN_OFF_MISMATCH GIT_COMMIT_ID MAINTAINERS
> PREFER_ATTRIBUTE_ALWAYS_UNUSED PREFER_DEFINED_ATTRIBUTE_MACRO
> QUOTED_COMMIT_ID SPDX_LICENSE_TAG STRCPY STRNCPY
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> Is does linux checkpatch use two chars more for the hash in the mean
> time than what libfuse/checkpatch.pl has?

Current Linux checkpatch.pl enforces 12 hex digits or more:

$ grep chars.*sha scripts/checkpatch.pl
3288:                                "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) &&
3453:                                 "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);

This was last amended in 6.14 with commit 6356f18f09dc07 ("Align git
commit ID abbreviation guidelines and checks").

I personally set it to 14 in gitconfig for future-proofing against hash
collisions.

--D
