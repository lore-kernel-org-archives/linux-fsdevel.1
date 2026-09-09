Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799D3BD63D
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994999; cv=none; b=CBJHLDXfyvow8DI9HIRT5Slq03uRzbxabun19fJBMkSr/P0iNgYhiv+S5yEXMT58VF4MMzW3889707G/WdKF7FjO5AThy8d4Tpc1gn7sNB8XqCBXAAIpU4dkuqvAL5xwGn7gSxOXbSP9fetfS+f37RsJROiGBsXn2xl6+emUnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994999; c=relaxed/simple;
	bh=S9OBK42tiKerUam/GfYdZEd/uYAEH2uwUbih9Ioag00=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hoz6gU7u7xq5QIJ1JGbXqrebnRICyuVdQM6OaNgrx0zNHkrSGFpzosHWj58t3N5LsY20qHPQ+p5jTdKDEvJRoubDXsONV+wFZ/i0rlRAAJfPQaVEWKeRSdRO18whdK62xdRNDQXvigV/0qespByIHWmym+tOpslBQltpDMKKu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Kwnuktwf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lmrzGDMT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Kwnuktwf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lmrzGDMT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D37AD7A0078;
	Wed,  9 Sep 2026 19:03:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 19:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1788994986; x=1789081386; bh=yAu9jdMUZ1pv/dcM2KAoWfjBO89A90GO2dz
	t8vHEqTY=; b=KwnuktwfqoTMcNSdHppOVQ7nYbCgrXU30m6XBoOlK26WLVAu8J/
	g74M8O6sHIc0iBCOYbLN0ctvKmtXRSmpz+I7iV7mjW6ll4HyrDE7a9wf6d0xTo7O
	TIyno342vTtty0kx3mHgkthFUyMUeO99SqDFjJ03XkXWd/961ykWokGngq+bNYK9
	y2ALee+66DW00LW9hQw8Zu1KaOKZKb00n6USpj4j6xUg01Z0HKm5NeoHmz88t/p4
	GQlanFPp+EZrA62NaODjB22KIyfUCWhkIBAPkUlBWZYtfAKU7oWH562r3Rwg9yQ+
	RtwPRf8Ll4th2W9uN8gzGEr8BAspMbYMj7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788994986; x=
	1789081386; bh=yAu9jdMUZ1pv/dcM2KAoWfjBO89A90GO2dzt8vHEqTY=; b=l
	mrzGDMTYhCgEcPu7+uSDRjReLqdJhM/dR4uYjzDMSS0KaOEqJYqZ05FadQp39mJj
	/vkKTm3W+BmGwPGF0hprjqKB+pr2oaJ0LrC8BtzoIISNPRt5FKLrJbn/TEEiEkTy
	pVZM04lh6PuBROsA9Dz7iyleolxscK9pXdPhdpriCGlA8NpjhKd/dvwYEsGRkYYU
	6dHDKtJ0Bp4SHh+x0cWKmV5RgDAAUPS987h1CQxyjNn+r8eodZGUzhov5LPsMVrM
	hfuzNlm6m7TYoX98GJWIxDSz0oUw+QhbOvSdtrHfKRPmD8zuwxVWYosbgVdqWehI
	4HF/L+wikqGN/s3Rvsw0A==
X-ME-Sender: <xms:quWhaiKWOGAxtlnn48yN7VEhXmLTxSrSn7CPCEV-1gtaxlRbpYf65Q>
    <xme:quWhagLwVIsaRrhiFZPeJaRdShJzhzuuiJdU1ip-UeVj-AI8THFyEFHuTXd93kak7
    7B6enVgadalaOhKbzV33UnAFMqEfsMiRMGAw22fA-LD9IjHDok>
X-ME-Received: <xmr:quWhathlZDTZ_9EXpoaqy_Uqaa1AGZjphETpHaEuxgfeG2fxjRZQVJ5rikCXhwPjtdauGidIjRWu6sFztvhqGeElmTlrbb4>
X-ME-Proxy-Cause: dmFkZTGfj6BIeoOD6uyBdG/rhHFIAWNC3J978ZeEihlmfS+6HzrcgMVbvL3ym6GJPVUUHq
    1gjYAYSMxwinChMbB35ojX+lSZy74eieEN/+/DEKp0xjcsoUT5BcVM+//cA+4RXDsIpA0o
    sRXa9RMuwxY5NDlABFQHdQOVuDZzORkIqFdktJw3rw3pi39xO2kaamdda0Zpd+wWdXD4Tn
    vHYoKYt82+W+HGnT2U3ZMN1ByS4qh1D1rCtF7X8xcP64Ze8Y+sVwE1WoGgQQ3sK4q0oz1+
    paWitqg+e2YVxdbryBEsMhqt415rUF8Ui7hf9CyM3PeCo+y6KgX5vFX4OlvGYoPMPlC6gq
    b2t4qNlXwGDFpmi0J3wyPLyBlyOy/IUAerj/n3fyv1hWN5UYDAUPhp1GR0HGDOOI98aAtg
    wl59xaKnfaB9Kb6mSrlxL3h4NZjAh3PK2RHecDMoi07AR7TvCbBapSft6AvIUeljm4u3EG
    0MCllA+8FpWQAJ2Ke35ZhpY0qlZn8/71CFkVZsPUnXRQ/IrocNHbKzKQ6X36wYfluuvOPc
    uhRKrEZWXCz60SPNwyCBeTyNmwf97jVraDvtTBwzh5tK+6uJktX+xNMLNotwgvtNpzskvY
    RE3pwPw5j3lS2ip1UQBAr66a4ioYWij0pBZkLjOgS76etnO2Owkvzo9rCEBQ
X-ME-Proxy: <xmx:quWhaqN90XcwaGOj-QC6JW04cvdP6qHunQAQ3TpP4CB_1K2ciZl7qQ>
    <xmx:quWhaoqy0fCxRIFvWvoXb0Ktmn9_As5EmI3gWGe0MgU23I7A75a58g>
    <xmx:quWhas6GYZVD9VC3UnHoebx1ZRhTx64jFdSp_8c5QLgIv6tnGUvP7w>
    <xmx:quWhami92RrvVQDQwg_Vw6PFGa-nQw5CBQ7aFm1O4elxxDPi8oMBNg>
    <xmx:quWhag1SFtcYgIxWYIOB0I88P1aeyT9ItBXum7o_UFcfskSySiX77dU0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 19:03:02 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Oleg Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
 "Jann Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, "Xin Zhao" <jackzxcui1989@163.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH RFC v3 13/15] coredump: add COREDUMP_CLOSE_FILES
In-reply-to:
 <20260909-work-coredump-unlock-self-v3-13-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
  <20260909-work-coredump-unlock-self-v3-13-04f907687563@kernel.org>
Date: Thu, 10 Sep 2026 09:02:59 +1000
Message-id: <178899497961.207413.10554121774377911612@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 10 Sep 2026, Christian Brauner wrote:
> Add COREDUMP_CLOSE_FILES and allow a coredump server to request that the
> thread-group closes all files before creating the coredump.
>=20
> There have been several attempts to let the dumping process decide
> through a new fcntl() flag, a new procfs file or a new coredump_filter
> bit that its descriptors go away early. That's just broken imho.
>=20
> Tools like systemd-coredump walk /proc/<pid>/fd and /proc/<pid>/fdinfo
> and some use pidfd_getfd() to preserve files of the crashing process.
> Only the coredump server knows whether it still needs the descriptors.
>=20
> So let the coredump server ask for it. Add a new COREDUMP_CLOSE_FILES
> feature bit. If the coredump server raises it the kernel drops the
> descriptor tables of the thread group right after the handshake and
> before it generates the coredump.
>=20
> COREDUMP_CLOSE_FILES doesn't work with COREDUMP_REJECT. A rejected task
> exits and closes everything right away anyway.
>=20
> We switch to an empty fdtable instead of simply clearing because
> io_uring_files_cancel() runs task work in do_exit() before
> exit_signals() sets PF_EXITING and may reissue requests that dereference
> current->files.
>=20
> Reported-by: Xin Zhao <jackzxcui1989@163.com>
> Link: https://lore.kernel.org/20260618030700.2511668-1-jackzxcui1989@163.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/coredump.c                 | 55 +++++++++++++++++++++++++++++++++++++++=
+++-
>  include/linux/sched/signal.h  |  4 +++-
>  include/uapi/linux/coredump.h |  8 +++++++
>  kernel/exit.c                 | 13 ++++++++++
>  4 files changed, 78 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/coredump.c b/fs/coredump.c
> index d0796536e03f..506410132e30 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -552,6 +552,48 @@ static int coredump_wait(int exit_code, struct core_st=
ate *core_state)
>  	return core_waiters;
>  }
> =20
> +/*
> + * Allocate a new empty fdtable and switch the whole thread-group to it.
> + * Put all the old fdtables freeing up resources and locks before writing =
the
> + * coredump.
> + */
> +static bool coredump_close_files(struct core_state *core_state)
> +{
> +	struct files_struct *files;
> +	struct core_thread *ct;
> +	int nr =3D 0;
> +
> +	files =3D alloc_files_struct();
> +	if (!files)
> +		return false;
> +
> +	/* Tasks without a table such as vhost workers can be skipped. */
> +	for (ct =3D core_state->dumper.next; ct; ct =3D ct->next)
> +		if (ct->task->files)
> +			nr++;
> +	atomic_set(&core_state->nr_threads, nr);
> +	reinit_completion(&core_state->done);
> +
> +	for (ct =3D core_state->dumper.next; ct; ct =3D ct->next) {
> +		if (!ct->task->files)
> +			continue;
> +		/* ct->files holds a reference until the thread switches to it. */
> +		atomic_inc(&files->count);
> +		/* Pairs with the acquire in coredump_task_exit(). */
> +		smp_store_release(&ct->files, files);
> +		wake_up_process(ct->task);
> +	}
> +
> +	/* Use the dumper's real creds not the overriden ones. */
> +	scoped_with_creds(current_real_cred())
> +		put_files_struct(switch_files_struct(current, files));
> +
> +	if (nr)
> +		coredump_wait_inactive(core_state);
> +
> +	return true;
> +}
> +
>  static void coredump_finish(enum coredump_state state)
>  {
>  	struct core_thread *curr, *next;
> @@ -841,7 +883,8 @@ static bool coredump_sock_request(struct core_name *cn,=
 struct coredump_params *
>  		.mask			=3D COREDUMP_KERNEL | COREDUMP_USERSPACE |
>  					  COREDUMP_REJECT | COREDUMP_WAIT |
>  					  COREDUMP_RECORDS | COREDUMP_SPARSE |
> -					  COREDUMP_MEMORY_TYPES,
> +					  COREDUMP_MEMORY_TYPES |
> +					  COREDUMP_CLOSE_FILES,
>  		.size_ack		=3D sizeof(struct coredump_ack),
>  		.memory_types		=3D cprm->memory_types,
>  		.memory_types_mask	=3D COREDUMP_MEMORY_ALL,
> @@ -909,6 +952,12 @@ static bool coredump_sock_request(struct core_name *cn=
, struct coredump_params *
>  		return false;
>  	}
> =20
> +	/* A rejected task exits right away and closes everything anyway. */
> +	if ((ack.mask & COREDUMP_CLOSE_FILES) && (ack.mask & COREDUMP_REJECT)) {
> +		coredump_sock_mark(cprm->file, COREDUMP_MARK_CONFLICTING);
> +		return false;
> +	}
> +
>  	if (ack.mask & COREDUMP_MEMORY_TYPES) {
>  		/* The memory types need the whole field. */
>  		if (usize < COREDUMP_ACK_SIZE_VER1) {
> @@ -1224,6 +1273,10 @@ static void do_coredump(struct core_name *cn, struct=
 coredump_params *cprm,
>  	if (cprm->mask & COREDUMP_REJECT)
>  		return;
> =20
> +	if ((cprm->mask & COREDUMP_CLOSE_FILES) &&
> +	    !coredump_close_files(current->signal->core_state))
> +		return;
> +
>  	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cprm, binfmt))
>  		return;
> =20
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 1c1e280a25a1..23bd841d7742 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -76,12 +76,14 @@ struct multiprocess_signals {
>  struct core_thread {
>  	struct task_struct *task;
>  	struct core_thread *next;
> +	/* The empty table to switch to, published by the dumping thread. */
> +	struct files_struct *files;
>  };
> =20
>  struct core_state {
>  	atomic_t nr_threads;
>  	struct core_thread dumper;
> -	/* Completed by the last thread to park. */
> +	/* Completed by the last thread to park, reused for the table switch. */
>  	struct completion done;

Ok, now I see why you chose the bland "done".
I would discard the completion altogether.
Rename "nr_threads" to "threads_remaining".
Use atomic_dec_and_wake_up(&core_state.threads_remaining),
and wait_var_event(atomic_read(core_state.threads_remaining) =3D=3D 0).

And please - can "dumper" become a "struct task_struct *"
and have a separate "struct core_thread *threads".

Thanks,
NeilBrown


>  };
> =20
> diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
> index 6d0c53b534ea..ec09d7ab0131 100644
> --- a/include/uapi/linux/coredump.h
> +++ b/include/uapi/linux/coredump.h
> @@ -19,6 +19,9 @@
>   * @COREDUMP_MEMORY_TYPES: dump the memory types in
>   *                          coredump_ack->memory_types instead of the ones
>   *                          the task selected; requires COREDUMP_KERNEL
> + * @COREDUMP_CLOSE_FILES: close all file descriptors of the task before the
> + *                        coredump is generated; incompatible with
> + *                        COREDUMP_REJECT
>   */
>  enum {
>  	COREDUMP_KERNEL		=3D (1ULL << 0),
> @@ -28,6 +31,7 @@ enum {
>  	COREDUMP_RECORDS	=3D (1ULL << 4),
>  	COREDUMP_SPARSE		=3D (1ULL << 5),
>  	COREDUMP_MEMORY_TYPES	=3D (1ULL << 6),
> +	COREDUMP_CLOSE_FILES	=3D (1ULL << 7),
>  };
> =20
>  /**
> @@ -137,6 +141,10 @@ enum {
>   * Note that @memory_types must be zero if COREDUMP_MEMORY_TYPES isn't
>   * raised. COREDUMP_MEMORY_TYPES requires COREDUMP_KERNEL and an ack of
>   * at least COREDUMP_ACK_SIZE_VER1 bytes.
> + *
> + * If COREDUMP_CLOSE_FILES is raised in @mask the kernel closes the file
> + * descriptors of the coredumping task before it generates the coredump.
> + * The task ends up with an empty descriptor table.
>   */
>  struct coredump_ack {
>  	__u32 size;
> diff --git a/kernel/exit.c b/kernel/exit.c
> index affee30bcbca..52e282df9e60 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -25,6 +25,7 @@
>  #include <linux/acct.h>
>  #include <linux/tsacct_kern.h>
>  #include <linux/file.h>
> +#include <linux/fdtable.h>
>  #include <linux/freezer.h>
>  #include <linux/binfmts.h>
>  #include <linux/nsproxy.h>
> @@ -431,9 +432,11 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct tas=
k_struct *parent)
>  static void coredump_task_exit(struct task_struct *tsk,
>  			       struct core_state *core_state)
>  {
> +	struct files_struct *files;
>  	struct core_thread self;
> =20
>  	self.task =3D tsk;
> +	self.files =3D NULL;
>  	if (self.task->flags & PF_SIGNALED)
>  		self.next =3D xchg(&core_state->dumper.next, &self);
>  	else
> @@ -449,6 +452,16 @@ static void coredump_task_exit(struct task_struct *tsk,
>  		set_current_state(TASK_IDLE|TASK_FREEZABLE);
>  		if (!self.task) /* see coredump_finish() */
>  			break;
> +		/* Pairs with the release in coredump_close_files(). */
> +		files =3D smp_load_acquire(&self.files);
> +		if (files) {
> +			__set_current_state(TASK_RUNNING);
> +			self.files =3D NULL;
> +			put_files_struct(switch_files_struct(tsk, files));
> +			if (atomic_dec_and_test(&core_state->nr_threads))
> +				complete(&core_state->done);
> +			continue;
> +		}
>  		schedule();
>  	}
>  	__set_current_state(TASK_RUNNING);
>=20
> --=20
> 2.53.0
>=20
>=20

