Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78A2046BA
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001604; cv=none; b=b8FAPBcFBGS3S4yEWacWe+Fbj4SI+HCTet7c0SXYUoxkkNvgJThVsfPv708xNnu4FlQ0pnsXK46HIovnata35vxMEWDOBDr51zYpWIA/dQxBv13/bMHOdBaKfqG/q3GKHORf9PF1fTejDWW1ZnO5lEZBXIkTcR9I1xZtys213Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001604; c=relaxed/simple;
	bh=8POKI42iNnUpc15c0fQGuFMyhFdHFDT3fMk3F7/7DIk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JpvcWn/ReMLIr+QUsFc8OBjrPe/V1WaMECUOUrUSsVf09RdwWXIBe1+nkYIFMiduXoXgjPZlbYpC6es+YxzLud9Zb5TkKa4JcpF5Dl0v2Vcu7fatA75SSfPvhV7VTzZQ8ggdfodAM6J7/HqeBEiTYs1OSnJ56oGteHe6W3hlC84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=D0Lnj5vE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2aMV71j; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="D0Lnj5vE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2aMV71j"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C312E7A00AD;
	Wed,  9 Sep 2026 20:53:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Sep 2026 20:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789001601; x=1789088001; bh=zo47I8k/YNVC6oUWIRPdNL+eZ8hwPoxc6Yb
	KHgicqDg=; b=D0Lnj5vEWco79WMGlAhcxAG5Rhp5ywK6nCuwmypJXjsTlwyX5yf
	rFL+7K6zJF5+RyVaSbpiPgQn/WqDG+U5LPD97ys7UnNENAZ/70ndM2if7bmSvj3S
	a5bvBZErQgshMmiJKh4lIrGueNECvKVG8N6m09JPklPzjBN4fcoV3ttPRkmpfd6w
	FGAkkPvneXW3n/7R8cElQGlH4QLYNHDi7K7igicq3ytmQZHWa/KZM0z7lXAUXIf/
	kKdE/2Xa99JVrpcwNGUJw2N5iDEwxPpz/6ChkpDxT6fPI6UyaUylwUJCKnxjZDwN
	f0riuH4N9ydX/1DY0hHuQlz/wXMkx3Kei1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789001601; x=
	1789088001; bh=zo47I8k/YNVC6oUWIRPdNL+eZ8hwPoxc6YbKHgicqDg=; b=f
	2aMV71jAlPR66q1wubHTLS8fWYEfIfhlmkvSg+ge38mevQDjFE1QNlNLcSDg6r+u
	bEPTjV98X9CzMNQ2Yrma6K6gh7ZK3ScUGYqVYv/fYX9nfweHxE7H8GhkuYTeoCDM
	MbNJH7pEfiXBm77EYXrQMBzvE9lnkF0E0nfqoSbnkuyEDXlzJb61GiTpuRHmEYQz
	BAnXCd7B3ONELYEY0IsgHO5QBHhaQrPxSX55Q+TJWcAwWz47wLcQ3kOuSRuEBSZd
	3qmuxBbXCiPWGpu0riaFLr+MP82XoNZAGEx/rLypKdzxjXgsBqzq/N/0HoWIxebh
	0EQyE8nV6BVX0Ss2X3u1Q==
X-ME-Sender: <xms:gP-havdc3ZPHw3nvohZ9dgGN7hazzaaD8hFydxZmqya3JG3gJzeq6g>
    <xme:gP-harP2fJWWdatQ4POXsoREpqGZUtfZVdMN9eYjR71oRhAd_qUufcMbAETbm3xrP
    MQVJvXrd0sVEttlgUWI8Avwx0k75Q3wUiUdY4JN3XWVNkJFIqs>
X-ME-Received: <xmr:gP-hajVFniZ6MtqCTyeQlqLL7_GAkjWxVQRwed5oBWYyCtqlQrcGCim8pZmVMqhS6AkEtiaJggmMexoyEp0lB18EHEOzodk>
X-ME-Proxy-Cause: dmFkZTGHE83XNGh1Ekp62eAKHY8AHl+c3ddNyqhcj/csZByxNQiypnRvLIF4qoglomwqEE
    ju0DVE8q24S/iOfczzNd9BSVus82lD40u3qoovsTAG+YOPz35zwpRW/zimMLwSKYkfv0O4
    G9DTs6i4WJedslslHPG+4B3dKd6KHICoy9OHVvUbWm2z5oGqXzHtE9cRHdNnwfIaVRP10j
    txAaxF6LIocZFWfiUJkKX6NAJVa6WZ2BxX4I1v0C/drNC4eSYeCUvlvhwAfWRzf/jOkcxg
    CZCI15huxhrlsBnK85BHtMspmQL9xHphzzrTdhGoxCpAWpEqzPT0pdDds3WQ+909/BkHpv
    IphH/544edf9k8UB9dGCV9MHiFaJENa3sJoCv2+lgfxRlRf52LDBofeINiALzlUukVnBq8
    pE74/2T+Op3kOMbERFSnj3jlTsQRHQ1yXaB4OVTsfIbW1mNFjrcligYFFD7V0pLMYlo2RF
    bBNb6qoqzEubOW0ueekpC/B6HgzEvN91H4cqWApRmNSjJsGLWbKGFqDMhnrbdZBKYHcxYf
    yaopunfSJJnF2/Uu6/d3dj73AqNL/AJkJOQaDPyrgK07i2nBOTt8HUYT1WSAAEwsOuV/0Y
    /oQsCCXD+YwLL0xtJ1EAMA5bwwj/GA69E9OJc8QMwzP0Eqg/LHS/QKJSSg+Q
X-ME-Proxy: <xmx:gP-hajwm3yhCXHUUcKi0m3nXyBbDeg_r3gKNHOMKKI2FxHZLg1RYGw>
    <xmx:gP-haq_xJ7TfQb5iNu_oBv69powGH8ZgVcHafulTNSr1_b8a82DY1g>
    <xmx:gP-hao-n8YnLslAVAfNE-eBSALJ7d7hJusUduVFmM_LQXUe7V5ZqHA>
    <xmx:gP-hapUVkUlamtXZG7l91RCrZYsZx4F-R-uBGx6jmJzH4Jfh6MYPqg>
    <xmx:gf-hajoJtiweF6nN1k9cdNk4BeNC4oLvFlHSxKoLCMVezU0EWiHWwCPf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 20:53:17 -0400 (EDT)
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
In-reply-to: <178899497961.207413.10554121774377911612@noble.neil.brown.name>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
  <20260909-work-coredump-unlock-self-v3-13-04f907687563@kernel.org>
  <178899497961.207413.10554121774377911612@noble.neil.brown.name>
Date: Thu, 10 Sep 2026 10:53:12 +1000
Message-id: <178900159210.207413.8292125177519817528@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 10 Sep 2026, NeilBrown wrote:
>=20
> And please - can "dumper" become a "struct task_struct *"
> and have a separate "struct core_thread *threads".

It turns out that "dumper" is only ever used to get "dumper.next" so we
don't need that "dumper" at all.

NeilBrown

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 06d0df105382..7b98a396a6ef 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1875,7 +1875,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 		return 0;
=20
 	info->thread->task =3D dump_task;
-	for (ct =3D dump_task->signal->core_state->dumper.next; ct; ct =3D ct->next=
) {
+	for (ct =3D dump_task->signal->core_state->tasks; ct; ct =3D ct->next) {
 		t =3D kzalloc_flex(*t, notes, info->thread_notes);
 		if (unlikely(!t))
 			return 0;
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 068c46875c74..a2633330c59b 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1504,7 +1504,7 @@ static int elf_fdpic_core_dump(struct coredump_params *=
cprm)
 	if (!psinfo)
 		goto end_coredump;
=20
-	for (ct =3D current->signal->core_state->dumper.next;
+	for (ct =3D current->signal->core_state->tasks;
 					ct; ct =3D ct->next) {
 		tmp =3D elf_dump_thread_status(cprm->siginfo->si_signo,
 					     ct->task, &thread_status_size);
diff --git a/fs/coredump.c b/fs/coredump.c
index 6114839f5178..bab87dc7eb4e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -526,8 +526,7 @@ static int coredump_wait(int exit_code, struct core_state=
 *core_state)
 	int core_waiters =3D -EBUSY;
=20
 	init_completion(&core_state->startup);
-	core_state->dumper.task =3D tsk;
-	core_state->dumper.next =3D NULL;
+	core_state->tasks =3D NULL;
=20
 	core_waiters =3D zap_threads(tsk, core_state, exit_code);
 	if (core_waiters > 0) {
@@ -540,7 +539,7 @@ static int coredump_wait(int exit_code, struct core_state=
 *core_state)
 		 * all the thread context (extended register state, like
 		 * fpu etc) gets copied to the memory.
 		 */
-		ptr =3D core_state->dumper.next;
+		ptr =3D core_state->tasks;
 		while (ptr !=3D NULL) {
 			wait_task_inactive(ptr->task, TASK_ANY);
 			ptr =3D ptr->next;
@@ -558,7 +557,7 @@ static void coredump_finish(bool core_dumped)
 	spin_lock_irq(&current->sighand->siglock);
 	if (core_dumped && !__fatal_signal_pending(current))
 		current->signal->group_exit_code |=3D 0x80;
-	next =3D current->signal->core_state->dumper.next;
+	next =3D current->signal->core_state->tasks;
 	current->signal->core_state =3D NULL;
 	spin_unlock_irq(&current->sighand->siglock);
=20
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..318c1e6a093f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -80,7 +80,7 @@ struct core_thread {
=20
 struct core_state {
 	atomic_t nr_threads;
-	struct core_thread dumper;
+	struct core_thread *tasks;
 	struct completion startup;
 };
=20
diff --git a/kernel/exit.c b/kernel/exit.c
index 97686af89501..e7cf65af9bc9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -432,12 +432,12 @@ static void coredump_task_exit(struct task_struct *tsk,
=20
 	self.task =3D tsk;
 	if (self.task->flags & PF_SIGNALED)
-		self.next =3D xchg(&core_state->dumper.next, &self);
+		self.next =3D xchg(&core_state->tasks, &self);
 	else
 		self.task =3D NULL;
 	/*
 	 * Implies mb(), the result of xchg() must be visible
-	 * to core_state->dumper.
+	 * to the dumper.
 	 */
 	if (atomic_dec_and_test(&core_state->nr_threads))
 		complete(&core_state->startup);

