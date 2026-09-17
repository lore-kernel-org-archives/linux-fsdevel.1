Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C437B03F;
	Thu, 17 Sep 2026 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609887; cv=none; b=qouiFs6yeij1r1FBHqEesNsJDvym6crTQkN+J0ixhhAWPOcUIa6/VzmbufAi3YcwoiiIfcyeWyFN9VbWlbDETlv9lh4bsvkV4/ebdW6Th+uKphn0H08e3t39433BS8ehHWRbvcMKE3PYeHnK1+rMtI0njcARAd83rP5N1pMr0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609887; c=relaxed/simple;
	bh=GnzSctD9vQwVJj6S88kSIvYlKIAZUYVFGb5XYJleZyk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DcmH7C7wZqw/A1DzQFF6rV7IEZjIIJpxi3os9HFbCbDatftRfI75cfGNWjjwMDwjBhaue52OKr6eTEsG3M8ub3ugKXcubck368uTEQWCmCyKGg4unAlbHtJpiaVrr02yPlx426ywFo8SrJL9MLZMEXDjw/xArf+1xu42iF8vhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NKltVacC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wqpyXN3m; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NKltVacC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wqpyXN3m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B549D7A003F;
	Wed, 16 Sep 2026 21:51:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 16 Sep 2026 21:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789609882; x=1789696282; bh=xxDjgtURUrYLXWuVmthOY/8nBxAdySxpDJX
	UwnjUFWU=; b=NKltVacCqkyNFITZDmhFKeDOqaPB+wpAQxxCpIx6b7kRYx5Ndz+
	RayAqd2dARzEpvsoqkNYW686ZPUCylpjjUKi8HwPd4LlezTZc+piCpYrI3kp35B1
	HaToMHQkyUx9v9ZfCy+vj2ijVXKWhdPzH1lp5titEvaz7hP2NMetfcc244+iPHaH
	MkPM/5GdW9PBHGspyBnaIL+szWyqSI65qw0oEoKebXKMjeY14b/dL5N6XBnxWAgt
	u7jop0pN3vVIN5wbVLWY7VJWZgmTaZZbZ/SLMiz1Z0C1vgfOZZLdjcVxKMg+eq82
	6VnoZxIQFwxFpirqzu4Hm0kXktL/w6XXgCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789609882; x=
	1789696282; bh=xxDjgtURUrYLXWuVmthOY/8nBxAdySxpDJXUwnjUFWU=; b=w
	qpyXN3mVBS/nvZfs2jm2m6/eDF1ttE11T94ywgwZDccSCljKxj1isOJqd2m+ury0
	mFP5+rNNNlVvbg8FQjqA4GGaH4zWMGGTZ1A4xQcPRWTfNQnizntlbMKOya9fSg2W
	qD3mqzmLO5KUmgubDLj2J64LlGoUgwF45Wet+q2BmdqZVeluaBuJ/o5Fzb0E5A/r
	aCK0QAKysScVJs6aEZfuiCrrxDXdyOEtOOqaTc9d4I6GRc7z2Yy6Usv93+smIrNQ
	Z9RmDRdDnNRrDCVBtQZMm/vkb87mah+ANcmnDDUcEmeW3r8zz7qJE3xeInMvviiA
	Bi5XAGwQBiFsszWZd1YxQ==
X-ME-Sender: <xms:mUerauqC3qHkdyj4_fx8xFrY0TkRSyqJLrwx02xmsVUUTvwxT7jW0g>
    <xme:mUeraodkRS6YY4f5DqETeSvJY7uZ2eKQKOZCl-FZ6d-Ogk5aa9oiEdT39zsH8zp0O
    XBI6n7M9uviesaQOWbnZfgiXAJyBqMbDdwwJ_1qgH53_Po3iN0>
X-ME-Received: <xmr:mUeraulQopIoiorPP2dZkfhAfWhaL6ic1p3qq7tu9g3R_Wv4dXEFmbw7YxM-URRnMTBG0A2Nh3q2aALt-fiYRticZ7J2_Gg>
X-ME-Proxy-Cause: dmFkZTGkmOHunoqci/9FHiPfgcqwnWwz8WK2A0uF7GAvuC3rnWYoxyQgQ/RdKNab/feNWO
    MS2S57uSwbA1/qtw487tuoXeVZmGDJXP36KC6ndxBdGSo3p/lMAmNl6E/wM1EWA8knyNep
    0ZqPpulichB29V3OLf7WsPAZ+yWIHV58qJtZfhBjDyQotLKCxeWxQ17FGAomE8V4engW2Y
    8mO9MbWKMPMYMBkp7FeiEYtsCKWdZhrkz8shM1SQ7Sw0KjQuTSkRco+s/O0tyLzG+wDtir
    NNDKkLO5UuJO3IGalqxbxGBuWzcEZSKxXexPvYZKLL819nRuJT4k9cy4z+KhEKcbh0Yqtq
    KJeiK3mEEXHUI9qQlB2DZs1L2QZ6bWzyxqgu+kG/3GMJeVvHCYtnyEMSryqgU9C2cFZTnD
    OvuDexf5cXfokYOyCYxQuRH7Hy221FXiBp3kZLa3bq9j6Psh2W8rhDgdVfC57sLcgx/H9f
    HSr/4WXYGr7pq43OT1qmsZvsVWrl8ErXkOj6OMn1C6ZJnJC96nkzgLlIJUZFwqez8J/EYO
    ygh21PtIB2jofdXaik/kWPHe2ET3YY97+z6VkRSov6PPvSnb/90OTR5ErgLIeUxFwNpmx6
    h83aQQL//hHaGgQ5wlkazZDHSkq1igTn5gTUdY9QchxfYJPTTQcmVoe0c1gA
X-ME-Proxy: <xmx:mUeranYGSBtmmGPx3_yjmWNMCsAgsGE0asck9eV4svtsaNDT3u2FVA>
    <xmx:mUerar5ay-IliCnCbTjzjovbm8HjiMYZ-oW7DNK0aXZqquVmB2IL-A>
    <xmx:mUerapAoQ9pBW7IMjiYWrLLBwyxYoV3Xoe7nkbeT891salLDLeKlAg>
    <xmx:mUerah-zYlOuGeNGB4jmvLWryrbwcCksG8ipV-uakVAyyfmHmpa-Gg>
    <xmx:mkerajuEcI_6izq20eKwQaKHHYUlRaqNGF7Rl2hHFtH0CMAU2MPCyyhd>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 21:51:18 -0400 (EDT)
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
Cc: "Chris Mason" <mason@kernel.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Jens Axboe" <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 linux-mm@kvack.org, io-uring@vger.kernel.org
Subject:
 Re: [PATCH 1/6] coredump: don't switch a dumper that has no files table
In-reply-to: <20260917-staunen-sparsam-infusion-83238c68d21f@brauner>
References: <20260915-work-coredump-fixes-v1-1-f354ca41780c@kernel.org>
  <20260916194837.3732307-1-mason@kernel.org>
  <20260917-staunen-sparsam-infusion-83238c68d21f@brauner>
Date: Thu, 17 Sep 2026 11:51:14 +1000
Message-id: <178960987412.207413.3957049392884487413@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 17 Sep 2026, Christian Brauner wrote:
> > When I reproduced this one, it ended up deadlocking with the fix applied.
> >=20
> > vhost worker (the dumper)          sibling thread
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > get_signal() -> vfs_coredump()
> >   coredump_close_files()
> >     hands sibling a new table ---> switch_files_struct()
> >     coredump_wait_inactive()         put_files_struct(old table)
> >       waits for sibling's switch       last close of the vhost fd
> >                                      vhost_net_release()
> >                                        __vhost_worker_flush(): waits
> >=20
> > AI suggests making the vhost thread requeue the signal for someone more
> > suitable?
>=20
> Afaict, this is conceptually a generic problem with letting coredump
> close files for any type of user worker where the worker is the dumper
> and the sibling thread closes the fd that causes it to be stopped and
> waits for it to exit. So this needs thinking and we should drop coredump
> closing files for now.
>=20

It appears to me that there is already infrastructure in place to handle
the generic problem.  vhost_task has a "handle_sigkill" function which
cleans up on sig kill so that siblings won't keep waiting for it.
get_signal() detects PF_USER_WORKER tasks and lets them complete
normally rather than aborting them, so that handle_sigkill can be called.

So the problem is "simply" an ordering problem. vfs_coredump() closes
files before handle_sigkill can run.
Maybe handle_sigkill() could be passed to (a version of) get_signal(),
or maybe get_signal() could indicate to the PF_USER_WORKER caller that
vfs_coredump() still needs to be run.

NeilBrown

Possibly something like this completely untested patch, though maybe
io_uring should use the new interface too.

diff --git a/include/linux/signal.h b/include/linux/signal.h
index f19816832f05..def89bac90e3 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -291,6 +291,8 @@ extern void __set_current_blocked(const sigset_t *);
 extern int show_unhandled_signals;
=20
 extern bool get_signal(struct ksignal *ksig);
+extern int get_signal_nocore(struct ksignal *ksig);
+extern void get_signal_complete(struct ksignal *ksig, int signr);
 extern void signal_setup_done(int failed, struct ksignal *ksig, int stepping=
);
 extern void exit_signals(struct task_struct *tsk);
 extern void kernel_sigaction(int, __sighandler_t);
diff --git a/kernel/signal.c b/kernel/signal.c
index ec30550951ec..ab8e0207f079 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2812,7 +2812,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
 	}
 }
=20
-bool get_signal(struct ksignal *ksig)
+int get_signal_nocore(struct ksignal *ksig)
 {
 	struct sighand_struct *sighand =3D current->sighand;
 	struct signal_struct *signal =3D current->signal;
@@ -2823,10 +2823,10 @@ bool get_signal(struct ksignal *ksig)
 		task_work_run();
=20
 	if (!task_sigpending(current))
-		return false;
+		return 0;
=20
 	if (unlikely(uprobe_deny_signal()))
-		return false;
+		return 0;
=20
 	/*
 	 * Do this once, we can't return to user-mode if freezing() =3D=3D T.
@@ -3021,21 +3021,6 @@ bool get_signal(struct ksignal *ksig)
 		 */
 		current->flags |=3D PF_SIGNALED;
=20
-		if (sig_kernel_coredump(signr)) {
-			if (print_fatal_signals)
-				print_fatal_signal(signr);
-			proc_coredump_connector(current);
-			/*
-			 * If it was able to dump core, this kills all
-			 * other threads in the group and synchronizes with
-			 * their demise.  If we lost the race with another
-			 * thread getting here, it set group_exit_code
-			 * first and our do_group_exit call below will use
-			 * that value and ignore the one we pass it.
-			 */
-			vfs_coredump(&ksig->info);
-		}
-
 		/*
 		 * PF_USER_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so we
@@ -3058,6 +3043,38 @@ bool get_signal(struct ksignal *ksig)
 	if (signr && !(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
 		hide_si_addr_tag_bits(ksig);
 out:
+	return signr;
+}
+
+void get_signal_complete(struct ksignal *ksig, int signr)
+{
+	if (!(current->flags & PF_SIGNALED))
+		return;
+
+	if (sig_kernel_coredump(signr)) {
+		if (print_fatal_signals)
+			print_fatal_signal(signr);
+		proc_coredump_connector(current);
+		/*
+		 * If it was able to dump core, this kills all
+		 * other threads in the group and synchronizes with
+		 * their demise.  If we lost the race with another
+		 * thread getting here, it set group_exit_code
+		 * first and our do_group_exit call below will use
+		 * that value and ignore the one we pass it.
+		 */
+		vfs_coredump(&ksig->info);
+	}
+	do_group_exit(signr);
+	/* NOTREACHED */
+}
+
+bool get_signal(struct ksignal *ksig)
+{
+	int signr =3D get_signal_nocore(ksig);
+
+	if (signr)
+		get_signal_complete(ksig, signr);
 	return signr > 0;
 }
=20
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 3717885a5992..8bdf5b55f419 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -27,14 +27,15 @@ struct vhost_task {
 static int vhost_task_fn(void *data)
 {
 	struct vhost_task *vtsk =3D data;
+	struct ksignal ksig;
+	int signr =3D 0;
=20
 	for (;;) {
 		bool did_work;
=20
 		if (signal_pending(current)) {
-			struct ksignal ksig;
-
-			if (get_signal(&ksig))
+			signr =3D get_signal_nocore(&ksig);
+			if (signr)
 				break;
 		}
=20
@@ -64,6 +65,8 @@ static int vhost_task_fn(void *data)
 	mutex_unlock(&vtsk->exit_mutex);
 	complete(&vtsk->exited);
=20
+	if (signr)
+		get_signal_complete(&ksig, signr);
 	do_exit(0);
 }
=20
