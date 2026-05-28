Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004A3DD50C;
	Thu, 28 May 2026 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969072; cv=none; b=UIg7l8jw0bavQlcsWBRFYlghkGe+n/cysFWo4fk608Z33Pdi28FlOvMmvm/mUrYLZUrjLEMAW/VnagxBOdlsFYq9OorYSENiCJrIqfhPYO5K4CkbwYS3aAvex4l7qX4zrs0upyo99Tx5qGaLPzdQ08o/76jg1q2tXs9VxSalj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969072; c=relaxed/simple;
	bh=Xd7xqSkso4Q2nxuT8CSKUefQWnpu+6UuPMIl+8mhtm8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=oWR7LsF7arWDG0cXX2qrFF4TypI2s+WGQ1XLzPjAteCDlouq9ep5iz+3oVciLvPF89itGvJpge32heyIaQDv2JttJkR7azvetIA1+SQv3OaTVTarOlPKA08sjDlAcJAi7LzQ27bs34c/40f/1FWWaqy4ulX2TmHqvBAGRn0RcbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7s6mbhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7s6mbhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826F41F000E9;
	Thu, 28 May 2026 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969070;
	bh=V310jeh3exb11XzZf9DK/E52a0qpB45n2Whxx036Ero=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=B7s6mbhgDQDIOaCG+WO+4rCNTYzL+jPT4iQ+Ko1WfGHPveolAv/wCvaLJqc5rUOGT
	 Mf1jNsDE0NHj8zZh43BcN2mNsA2N/2GCbbhjC+v45Seg41CPdyWgKI4JGw8siD76wr
	 NBfxKHXWWKi8Y5yBoNpjARtL/7xVmkPb/RygCCO3/Vqt03jEKMtgwJ13f2wo6D0m85
	 OmxeRBKLzPHdxTjhAcZGTaa9CPHXBW71+VFOzrsVYszEfK3RYyDA6ExdxX6W2eUsrW
	 1K2u0t8lF92Ja1Ko3M//10oQCNha9Y92cWf6aqNAjnEpC0xL10ARObxJ9hiJyCuMNV
	 q7RMfJX+sTICQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fanotify: report thread pidfds for FAN_REPORT_TID
From: Christian Brauner <brauner@kernel.org>
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: jack@suse.cz, amir73il@gmail.com, repnop@google.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260524102439.44642-1-anonymemeow@gmail.com>
References: <20260524102439.44642-1-anonymemeow@gmail.com>
Date: Thu, 28 May 2026 13:51:06 +0200
Message-Id: <20260528-schmuckvoll-heilen-garen-be77b4208671@brauner>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4076; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Xd7xqSkso4Q2nxuT8CSKUefQWnpu+6UuPMIl+8mhtm8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRJ6Oj6ZrmmdL3+flf8R+bVoIszZ19rm+MqbFD9+cURj
 +m3nVJcO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy9ycjw6o2bRORnr0zu2ct
 89BwTF37Xn/eq/c3btU5hW+P7Ptfbs7wT9fh6XzluxwhWUGnzt1Iinux7NT20JA0qyvfNA2vbeY
 t4AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-05-24 18:24 +0800, AnonymeMeow wrote:
> The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> exclusive because by the time the pidfd support was introduced to
> fanotify, pidfds could only be created for thread group leaders. Now
> that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> this restriction can be lifted.
> 
> This patch allows listeners using FAN_REPORT_PIDFD | FAN_REPORT_TID
> to receive the pidfd referring to the thread that triggered the
> event.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index ae904451dfc0..ebdd48942029 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -19,6 +19,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/statfs.h>
>  #include <linux/exportfs.h>
> +#include <linux/pidfd.h>
>  
>  #include <asm/ioctls.h>
>  
> @@ -903,25 +904,21 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  		metadata.fd = fd >= 0 ? fd : FAN_NOFD;
>  
>  	if (pidfd_mode) {
> -		/*
> -		 * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> -		 * exclusion is ever lifted. At the time of incoporating pidfd
> -		 * support within fanotify, the pidfd API only supported the
> -		 * creation of pidfds for thread-group leaders.
> -		 */
> -		WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> +		unsigned int tid_mode = FAN_GROUP_FLAG(group, FAN_REPORT_TID);
> +		enum pid_type pidtype = tid_mode ? PIDTYPE_PID : PIDTYPE_TGID;
> +		unsigned int pidfd_flags = tid_mode ? PIDFD_THREAD : 0;
>  
>  		/*
> -		 * The PIDTYPE_TGID check for an event->pid is performed
> +		 * The pid_has_task() check for an event->pid is performed
>  		 * preemptively in an attempt to catch out cases where the event
> -		 * listener reads events after the event generating process has
> +		 * listener reads events after the event generating task has
>  		 * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
>  		 * report either -ESRCH or FAN_NOPIDFD to the event listener in
>  		 * those cases with all other pidfd creation errors reported as
>  		 * the error code itself or as FAN_EPIDFD.
>  		 */
> -		if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID))
> -			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
> +		if (metadata.pid && pid_has_task(event->pid, pidtype))

For quite a while the kernel refused to hand out pidfds for reaped
processes even if the struct pid was pinned like in this case.

But that makes various APIs - including this one - way less powerful
than they can be. Nowadays the socket layer already hands out pidfds for
reaped processes. It also stashed the struct pid. Let's do the same
here.

Drop the pid_has_task() change and then:

pidfd = pidfd_prepare(event->pid, pidfd_flags | PIDFD_STALE, &pidfd_file);

which instructs pidfs to and out a pidfd even if the task has already
been reaped. Reaped pidfds can still be queried for various types of
information that is kept around even if the task is long gone.


> +			pidfd = pidfd_prepare(event->pid, pidfd_flags, &pidfd_file);
>  
>  		if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
>  			pidfd = pidfd == -ESRCH ? FAN_NOPIDFD : FAN_EPIDFD;
> @@ -1628,14 +1625,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  #endif
>  		return -EINVAL;
>  
> -	/*
> -	 * A pidfd can only be returned for a thread-group leader; thus
> -	 * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
> -	 * exclusive.
> -	 */
> -	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
> -		return -EINVAL;
> -
>  	/* Don't allow mixing mnt events with inode events for now */
>  	if (flags & FAN_REPORT_MNT) {
>  		if (class != FAN_CLASS_NOTIF)
> -- 
> 2.54.0
> 
> 


