Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518833A9C6;
	Tue, 10 Mar 2026 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142429; cv=none; b=Dog9I1+ps2hGAZMdaTPqrzWcP7MUaRnHKvbHxI7v1aMoC3AXxc/b8k3cVJi9v/Von779EPQEYSDhfeVZaPBgzg5xxRhbViRKBJTYZXZw4rRf0c24XNFjde0dZDv1Zs6ny5xKbO5mzaQ4dcbI6pjGJ98ObBbV6h8cQEKTwp5V1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142429; c=relaxed/simple;
	bh=dJr/gybMIuNacyiP/Cn34oCQ2rTJo/f6aQUuUXs6B9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYz72qQPvtmDPGR+106sSP9hi8TqNgEGXICKK37jTMS8nuaZUjSIO03gVKmaFMuoOhk5YdB27kSJGov2x1GJA5dGYbyv5KdKgsINcXareCzluz79pNbHsk+OEZtM/vobP8QualDRi4AUBG25LWD22R02BWxCb4PhUUnz3TsxvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8NdQVEt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8NdQVEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008B5C2BC9E;
	Tue, 10 Mar 2026 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142429;
	bh=dJr/gybMIuNacyiP/Cn34oCQ2rTJo/f6aQUuUXs6B9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8NdQVEtKmkvDxTWCTVtyg9N5hzjciXN5E6JpH8B/lfx1D1UHKWWpzxgfg/OGMVt6
	 siybpRJ+VhEjZgsjQObbRnDBwCdptcluLv41vCyNQ3nNShFVr/iIuFaT81KTFWtPT/
	 0jJu08m5jX0xpf5uEG8WOpd4EXcc6OXQwbrcOFfJ2VQmAQtJ3NiNe+RPj1ndcDILfh
	 A6YWv+oN2w2Bz80FRDZ9ch/mtro4pIh3CkxI8UVCzgqU+nBG+djJRuORHK1p+NCrtJ
	 K281udmAJKrpXVtUU6vuAtNhh0ot1xmY9lFm3BK05KEQbyOzQXcD+3h3MrFebzIu/D
	 HQakCxgOwJVSw==
Date: Tue, 10 Mar 2026 12:33:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v2 04/23] crypto: ccp: use scoped_with_init_fs() for
 SEV file access
Message-ID: <20260310-verkehren-durften-881376a3a3ce@brauner>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
 <20260306-work-kthread-nullfs-v2-4-ad1b4bed7d3e@kernel.org>
 <CAG48ez060t6NXRt6Hua45aXxAmD0r1vAnm8eEyZSUh95GZG-vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez060t6NXRt6Hua45aXxAmD0r1vAnm8eEyZSUh95GZG-vg@mail.gmail.com>

On Mon, Mar 09, 2026 at 04:37:44PM +0100, Jann Horn wrote:
> On Fri, Mar 6, 2026 at 12:30 AM Christian Brauner <brauner@kernel.org> wrote:
> > Replace the manual init_task root retrieval with scoped_with_init_fs()
> > to temporarily override current->fs. This allows using the simpler
> > filp_open() instead of the init_root() + file_open_root() pattern.
> >
> > open_file_as_root() ← sev_read_init_ex_file() / sev_write_init_ex_file()
> > ← sev_platform_init() ← __sev_guest_init() ← KVM ioctl — user process context
> >
> > Needs init's root because the SEV init_ex file path should resolve
> > against the real root, not a KVM user's chroot.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  drivers/crypto/ccp/sev-dev.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index 096f993974d1..4320054da0f6 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -260,20 +260,16 @@ static int sev_cmd_buffer_len(int cmd)
> >
> >  static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
> >  {
> > -       struct path root __free(path_put) = {};
> > -
> > -       task_lock(&init_task);
> > -       get_fs_root(init_task.fs, &root);
> > -       task_unlock(&init_task);
> > -
> >         CLASS(prepare_creds, cred)();
> >         if (!cred)
> >                 return ERR_PTR(-ENOMEM);
> >
> >         cred->fsuid = GLOBAL_ROOT_UID;
> >
> > -       scoped_with_creds(cred)
> > -               return file_open_root(&root, filename, flags, mode);
> > +       scoped_with_init_fs() {
> > +               scoped_with_creds(cred)
> > +                       return filp_open(filename, flags, mode);
> > +       }
> 
> This patch, along with the others that start using
> scoped_with_init_fs, should probably go closer to the end of the
> series? As-is, if someone bisects to just after this patch, SEV will
> be in a broken state where it wrongly looks up a file from the process
> root.

Oh yeah, that's dumb. I think the fix is to simply grab init_task.fs and
use that until the series is done. Then it's 1:1 for all callers. Thanks
for spotting that!
