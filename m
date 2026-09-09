Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51728DB54;
	Wed,  9 Sep 2026 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950190; cv=none; b=c5/PakEPYC7rjjFj4aJQMVz6lMaUXV41XGiGJPoGzpc5QB9UqvLcmlzM8R9hNFNfTFDiv8ekZn6RbutpwGLg4w+dtM1WJSXanvIXzjugh4Xw6KeRdbdZOHGkXbj9KBpW6G7i1ilhJ1gwu++apw00YSvqmRlwvqo2zkcg9Sy0AE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950190; c=relaxed/simple;
	bh=JUMIVFPWF4YZ6cpd761izjnc4QCq/Z8L9frn7R5KxBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwkcO1Sjqm5BH1zYZeuHdu58EKNk24W2M9hMucQAP2fyjQovoo8DElbJjTRccwPQBUAsEaBzpUjU71MqHw0URAew4u8LA+IJoOa1izfOjbpUaY7/3hPRRtD8l0mi/PnPwGvqGSku/yMy9O1dZipTSGpG5shyTA9kddZR24heUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckRY4jzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckRY4jzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5897B1F00A3D;
	Wed,  9 Sep 2026 10:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950188;
	bh=kN6kXYgX1rYfFabYyhrxIsfX8ptCfYay5szDUrnpxUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ckRY4jzDsV7TtTU18KEwCRhMczCKZxzbj9OK6+aFcyC1Rb/JgYY3X6/eWEtBQiAWh
	 o34OzCerFZjtE8g9nzCR4X+DAMzGKs9BBq67OHucrvAAS+444+w3UG0Rr61UpXtWHf
	 KqzjDL72Xzc3mOH61KitSSpgIvMFMwl78gUnqw5J4UlWpqfU0lUDoUEaBxCOJFqL3a
	 jj1rI9q5EP6esFvQA8tMDb8VLF+WhqA7GSlym/wJLqO6fjun9cOtBpxTmVssxrBbg8
	 MOdpjhXkgfeIU1vCPNF2CDj9L8+xa7RZBtxWqRnCzzA09tkhlYXF4NSVB6AoX/vk95
	 c9KeudaCkup2w==
Date: Wed, 9 Sep 2026 12:36:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] af_unix: record the pid of the sending thread
Message-ID: <20260909-kredenzen-stock-hyperaktiv-121c1eec9f98@brauner>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
 <20260831-work-unix-passpidfd-v1-2-70cbfda0c7ba@kernel.org>
 <CAJqdLrooAYAcgzug=+idiPfqsZ0HGaqi29STuw7uzDh7eEB1xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJqdLrooAYAcgzug=+idiPfqsZ0HGaqi29STuw7uzDh7eEB1xQ@mail.gmail.com>

On Mon, Sep 07, 2026 at 11:55:23AM +0200, Alexander Mikhalitsyn wrote:
> Am Mo., 31. Aug. 2026 um 13:21 Uhr schrieb Christian Brauner
> <brauner@kernel.org>:
> >
> > Currently only the struct pid of the thread-group leader is recorded.
> > The identity of the actual thread that sent the message or is connected
> > to a given socket cannot be retrieved.
> >
> > Add the plumbing to make it possible to retrieve a pidfd for the sender.
> > Nothing uses the thread-specific struct pid yet. No functional changes.
> >
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  include/net/scm.h  |  7 +++----
> >  net/core/scm.c     | 21 +++++++++++++++++----
> >  net/unix/af_unix.c | 23 +++++++++++++----------
> >  net/unix/af_unix.h |  3 ++-
> >  4 files changed, 35 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index 86ae6bc109ec..aa7d15c5fc27 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -42,7 +42,7 @@ struct scm_fp_list {
> >  };
> >
> >  struct scm_cookie {
> > -       struct pid              *pid;           /* Skb credentials */
> > +       DECLARE_PIDS(pid, PIDTYPE_TGID);        /* Skb credentials by pid type */
> >         struct scm_fp_list      *fp;            /* Passed files         */
> >         struct scm_creds        creds;          /* Skb credentials      */
> >  #ifdef CONFIG_SECURITY_NETWORK
> > @@ -69,7 +69,7 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
> >  static __inline__ void scm_set_cred(struct scm_cookie *scm,
> >                                     struct pid *pid, kuid_t uid, kgid_t gid)
> >  {
> > -       scm->pid = get_pid(pid);
> > +       scm->pid[PIDTYPE_TGID] = get_pid(pid);
> >         scm->creds.pid = pid_vnr(pid);
> >         scm->creds.uid = uid;
> >         scm->creds.gid = gid;
> > @@ -77,8 +77,7 @@ static __inline__ void scm_set_cred(struct scm_cookie *scm,
> >
> >  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
> >  {
> > -       put_pid(scm->pid);
> > -       scm->pid = NULL;
> > +       put_pids(scm->pid);
> >  }
> >
> >  static __inline__ void scm_destroy(struct scm_cookie *scm)
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index f0d44ecdb11f..9b9e119c353a 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -149,6 +149,7 @@ EXPORT_SYMBOL(__scm_destroy);
> >
> >  static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
> >  {
> > +       struct pid *thread_pid;
> >         int err;
> >
> >         /* drop all previous references */
> > @@ -158,7 +159,18 @@ static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
> >         if (unlikely(err))
> >                 return err;
> >
> > -       scm->pid = pid;
> > +       /* A sender naming its own thread-group sends from the current thread. */
> > +       if (pid == task_tgid(current))
> > +               thread_pid = task_pid(current);
> > +       else
> > +               thread_pid = pid;
> 
> Hi Christian,
> 
> The patch looks good to me, but this spot raised some doubts for me.
> 
> If scm_replace_pid() is called with pid == task_tgid(current) then all
> good, because we
> get scm->pid[PIDTYPE_TGID] == pid and  scm->pid[PIDTYPE_PID] ==
> task_pid(current). All good.
> 
> If scm_replace_pid() is supplied with pid that has a type PIDTYPE_TGID, then:
> - scm->pid[PIDTYPE_TGID] == pid. Good.
> - scm->pid[PIDTYPE_PID] = pid. Doesn't looks correct, shoudn't we do

After chatting with you, I think I get the concern. You think that
scm->pid[PIDTYPE_PID] always points to a thread-group leader if pid ==
task_tgid(current). Yes, that's true but that's intended and fine. The
thread-group leader is just a thread in the thread-group just with
magical behavior (that we would really like to get rid of but can't
easily...).

Thanks for looking closely at this though!
