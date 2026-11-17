Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947551;
	b=2JwSpRo3hp6IC3J6DDyKIGbX4qNdHvrwBJ2qAZ8xqLroDGQr7/VvZsR0ZDlzclHHlxyB
	 RtwJKAuryhWKznpYlESpk+W4Kup1XmYB2fPLrQNxBJhSjCjO3NaIp6DyYtCLRNz6M7dLB
	 YMxiNx/2rA4dCF1Olbc9zR79gNwqyqdq+irIfHYXQGG4HbElpOPcaHmIgI1lSPMliM0Nf
	 Hot2dObV1Y5coEAUck+WCnjihN6qPZ6oJBXe3MwWa7he4HgsBWxM4++FAJLmSqQCuJ9Lw
	 THvkS2DagsqTZxVM5WT/r4tourf/vsH44D7aLs1o6iSPOG3h2dAg8DeLjdSfeGseKKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947551;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GqaQtI2fC8lfSjdxuGSUaDwM6PKhC5J5LIM8z3yhrrU=;
	b=hXcAjBv7PDj/eW91tZCX1w/ZscknaxC9J+C8oFTtOH3hs4iMtZtjxx2Shhj9p60lam+A
	 aJJIff5K45FyTKzXITGY5xVnHTQOrQlb+c7jFy5l60TOSoe/P+cw4WbRtL2U7d95AGjDX
	 cciXfr7uaCkgL+yJ7ORlOOV5nv6SAYoX3fwJp49rpVtiJ5394M+uth0ehfkpk/ucOxelu
	 hmQOBw5X9xHyZFW+3/yfuqr4lsqdMovftv0OaCHGp+j+aaVnhVB+kDcWTq7H/JyG0nOIn
	 RWkH1puDRwR5tUwSZcrcGkU36MkQPn04/ljZIWSx9q1Rt2/8hJ0DP+mmBsQsrAc/oWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gO9r3IFM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB39606A337
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gO9r3IFM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05EB1F000CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947550;
	bh=GqaQtI2fC8lfSjdxuGSUaDwM6PKhC5J5LIM8z3yhrrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gO9r3IFMIxUnfx+bIm7/2Bj3uN1y/r1VE+imSRzZX0XM0QjXhhLpxvlsiA5OtTUrG
	 MEbcsWvoDIfDdd8WLAJFTdPhANLR5LNmxyNY+hDcrCOJ8FpcZ9Yjnll2rWz2gPZRQd
	 zMpKjlyFt7tIof7SXTACfXbpqhzA2sHdU137fxojGa/3Tkeau7yMs3rXhRB1EyW8w2
	 AscvniC/Ap6YHxfJ5zVgymgln+NWM91AlEdp/qxit/r8E49TshEbBWmttPSftp1aLu
	 cd14sP9BaUGyQ9YRi64qS5KcgMQ19iZB7QqKHRyGNSINa62rUe8yf2zQ4yyyIu8I0N
	 pjUtX/yrFTkbg==
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso1653905ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 12:32:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHhmfsvlslr9fe88BkpSlNkpQeFfkAfMCuZtJNspdqQMtdopPNzo/XSKhQAOcNK2avn4Udb4Gtfgbhzw/BJ@vger.kernel.org
X-Gm-Message-State: APuU4Z/aSoSZKT8dMOGfbpxqya82DsDoXMh+ZjQfI35Lx6gxCjKDHtSs
	qM12tcGy+1KDMbJ21B8qrcm7JKOSSL4b05PEHE6rTQx1HOWtcZQ4WatDBL8CcIzDt00HD6OnT5u
	xMsMrkIAGYoGJMwMmbqZnoPvtqszdaS4=
X-Received: by 2002:a17:90b:2805:b0:3b0:aaed:48d0 with SMTP id
 98e67ed59e1d1-3b3d07a23a3mr543066a91.37.1794947550414; Tue, 17 Nov 2026
 12:32:30 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com> <atjN3JX7sWx9kpQ5@hallyn.com>
 <CACmP8ULW+COA17s6_UUKhQrJaviWmnUCjfite43Y0FgPN30-AQ@mail.gmail.com>
 <avHfxe++P4WLUQxf@hallyn.com> <80ff9aea-3a5c-4c92-b713-99c249564008@huawei.com>
In-Reply-To: <80ff9aea-3a5c-4c92-b713-99c249564008@huawei.com>
From: "Andrew G. Morgan" <morgan@kernel.org>
Date: Tue, 17 Nov 2026 12:32:17 -0800
X-Gmail-Original-Message-ID: <CACmP8UK=b4Hkivzf77BJ-S_CR94+AgpNs_EfQ4i=CHL3+=0Y6Q@mail.gmail.com>
X-Gm-Features: AclHuK_avYa_dJFxm6ZoqFYvunKpf_7Vv8MTzbp35jYWl588q9LTbO3-Gb4byKQ
Message-ID: <CACmP8UK=b4Hkivzf77BJ-S_CR94+AgpNs_EfQ4i=CHL3+=0Y6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Oleg Nesterov <oleg@redhat.com>, kees@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, paul@paul-moore.com, jmorris@namei.org, 
	shuah@kernel.org, brauner@kernel.org, alexjlzheng@tencent.com, 
	jannh@google.com, jaime.saguillo@gmail.com, elver@google.com, 
	blbllhy@gmail.com, bvanassche@acm.org, pjw@kernel.org, broonie@kernel.org, 
	debug@rivosinc.com, tglx@kernel.org, aleksey.oladko@virtuozzo.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM but reflecting on the likely lack of further expansion for that
new argument, I would have likely gone with different
prctl(PR_CAPBSET_*,...) values for the two scopes of operation.

Cheers

Andrew

On Mon, Nov 16, 2026 at 10:39=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com=
> wrote:
>
>
>
> =E5=9C=A8 2026/11/9 22:59, Serge E. Hallyn =E5=86=99=E9=81=93:
> > Hi Jinjie,
> >
> > how do you feel about adding something like a thread | process flag?
>
> Hi Serge, Andrew,
>
> Sorry for replying so late.
>
> I think this sounds good for me, similar to seccomp's
> SECCOMP_FILTER_FLAG_TSYNC: by default only the calling thread's bounding
> set is trimmed (so a later fork() inherits it while the rest of the
> process is untouched), and PR_CAPBSET_DROP_PROCESS applies it to the
> whole thread group.
>
> Is it similar to the following code?
>
>
> #define PR_CAPBSET_DROP_MASK          <n>
> #define PR_CAPBSET_DROP_THREAD         0
> #define PR_CAPBSET_DROP_PROCESS        1
>
> User space use as below:
>
>         prctl(PR_CAPBSET_DROP_MASK, lo, hi, PR_CAPBSET_DROP_THREAD, 0);
>         prctl(PR_CAPBSET_DROP_MASK, lo, hi, PR_CAPBSET_DROP_PROCESS, 0);
>
> # cap_task_prctl()
> case PR_CAPBSET_DROP_MASK:
>         switch (arg4) {
>         case PR_CAPBSET_DROP_THREAD:
>                 return cap_prctl_drop_mask(arg2, arg3, false);
>
>         case PR_CAPBSET_DROP_PROCESS:
>                 return cap_prctl_drop_mask(arg2, arg3, true);
>
>         default:
>                 return -EINVAL;
>         }
>
> static int cap_bset_drop_thread(kernel_cap_t mask)
> {
>         struct cred *new =3D prepare_creds();
>
>         if (!new)
>                 return -ENOMEM;
>
>         new->cap_bset =3D cap_drop(new->cap_bset, mask);
>         return commit_creds(new);
> }
>
> Best regards,
> Jinjie
>
> >
> > On Wed, Oct 21, 2026 at 07:42:43AM -0700, Andrew G. Morgan wrote:
> >> There are a number of situations where existing code wants to
> >> (temporarily) affect the capabilities of a single thread, so a
> >> subsequent fork() starts with those without affecting the parent
> >> process as a whole. I've been wondering if this code could be
> >> structured to allow an argument of the prctl() to indicate if the call
> >> is "whole process" or "just this thread" scoped?
> >>
> >> Cheers
> >>
> >> Andrew
> >>
> >> On Wed, Oct 21, 2026 at 7:36=E2=80=AFAM Serge E. Hallyn <serge@hallyn.=
com> wrote:
> >>>
> >>> On Tue, Sep 29, 2026 at 09:01:59PM +0800, Jinjie Ruan wrote:
> >>>> PR_CAPBSET_DROP only affects the calling thread. Process-wide capabi=
lity
> >>>> dropping requires user space to loop over every thread and every
> >>>> capability, which is highly expensive. For instance, long-lived
> >>>> multi-threaded processes (like gVisor's sentry) spend milliseconds
> >>>> trimming the bounding set because the runtime has to coordinate
> >>>> and signal every thread.
> >>>>
> >>>> Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
> >>>> capabilities from the entire thread group's bounding set in a single=
 call.
> >>>> The capabilities are specified via a 64-bit mask across arg2 (low 32=
 bits)
> >>>> and arg3 (high 32 bits).
> >>>>
> >>>> The drop is recorded in a per-thread-group mask,
> >>>> signal_struct::cap_bset_pending, under sighand->siglock. This pendin=
g drop
> >>>> is dynamically folded into the bounding set in critical paths:
> >>>> cap_capset(), PR_CAPBSET_READ(), and cap_bprm_creds_from_file().
> >>>> Running, concurrently created, or future threads within the group wi=
ll
> >>>> all immediately observe the drop. A forked child inherits this mask
> >>>> in cap_bset_drop_fork() under siglock to close the race window
> >>>> against clone().
> >>>>
> >>>> The operation is drop-only, so concurrent callers commute and a sing=
le
> >>>> atomic OR is the linearization point.  It performs no per-thread all=
ocation
> >>>> and only the caller's replacement cred can fail, reported synchronou=
sly as
> >>>> -ENOMEM before anything changes.
> >>>>
> >>>> In an arm64 KVM guest, trimming 41 capabilities of a multi-threaded =
Go
> >>>> process takes ~8.5-23.6ms with the per-thread PR_CAPBSET_DROP loop a=
nd
> >>>> ~11-14us with PR_CAPBSET_DROP_MASK, independent of the thread count.
> >>>>
> >>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >>>
> >>> Interesting idea, storing it in the sighand.
> >>>
> >>> Oleg, do you see any issues with that part of this?
> >>>
> >>> Overall, this seems ok to me.  That is, I think it addresses all the
> >>> concerns I had with the previous version.
> >>>
> >>>> ---
> >>>>  fs/proc/array.c              |  3 +-
> >>>>  include/linux/capability.h   |  5 ++
> >>>>  include/linux/sched/signal.h |  8 ++++
> >>>>  include/uapi/linux/prctl.h   |  1 +
> >>>>  kernel/fork.c                |  1 +
> >>>>  security/commoncap.c         | 91 +++++++++++++++++++++++++++++++++=
+--
> >>>>  6 files changed, 105 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/fs/proc/array.c b/fs/proc/array.c
> >>>> index f6f75d206762..f1cde26d079c 100644
> >>>> --- a/fs/proc/array.c
> >>>> +++ b/fs/proc/array.c
> >>>> @@ -63,6 +63,7 @@
> >>>>  #include <linux/tty.h>
> >>>>  #include <linux/string.h>
> >>>>  #include <linux/mman.h>
> >>>> +#include <linux/capability.h>
> >>>>  #include <linux/sched/mm.h>
> >>>>  #include <linux/sched/numa_balancing.h>
> >>>>  #include <linux/sched/task_stack.h>
> >>>> @@ -318,7 +319,7 @@ static inline void task_cap(struct seq_file *m, =
struct task_struct *p)
> >>>>       cap_inheritable =3D cred->cap_inheritable;
> >>>>       cap_permitted   =3D cred->cap_permitted;
> >>>>       cap_effective   =3D cred->cap_effective;
> >>>> -     cap_bset        =3D cred->cap_bset;
> >>>> +     cap_bset        =3D cap_bset_effective(p, cred);
> >>>>       cap_ambient     =3D cred->cap_ambient;
> >>>>       rcu_read_unlock();
> >>>>
> >>>> diff --git a/include/linux/capability.h b/include/linux/capability.h
> >>>> index 7921a0b3b04a..6413c7fedb69 100644
> >>>> --- a/include/linux/capability.h
> >>>> +++ b/include/linux/capability.h
> >>>> @@ -38,6 +38,7 @@ struct file;
> >>>>  struct inode;
> >>>>  struct dentry;
> >>>>  struct task_struct;
> >>>> +struct cred;
> >>>>  struct user_namespace;
> >>>>  struct mnt_idmap;
> >>>>
> >>>> @@ -197,6 +198,10 @@ bool capable_wrt_inode_uidgid(struct mnt_idmap =
*idmap,
> >>>>                             const struct inode *inode, int cap);
> >>>>  extern bool file_ns_capable(const struct file *file, struct user_na=
mespace *ns, int cap);
> >>>>  extern bool ptracer_capable(struct task_struct *tsk, struct user_na=
mespace *ns);
> >>>> +extern kernel_cap_t cap_bset_effective(const struct task_struct *ta=
sk,
> >>>> +                                    const struct cred *cred);
> >>>> +extern void cap_bset_drop_fork(struct task_struct *p);
> >>>> +
> >>>>  static inline bool perfmon_capable(void)
> >>>>  {
> >>>>       return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
> >>>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/sign=
al.h
> >>>> index d45a5476b97d..bda6f18b65b9 100644
> >>>> --- a/include/linux/sched/signal.h
> >>>> +++ b/include/linux/sched/signal.h
> >>>> @@ -98,6 +98,14 @@ struct signal_struct {
> >>>>       int                     quick_threads;
> >>>>       struct list_head        thread_head;
> >>>>
> >>>> +     /*
> >>>> +      * Capabilities being removed from the bounding set of every t=
hread in
> >>>> +      * this group by PR_CAPBSET_DROP_MASK.  Read on capability-tra=
nsition
> >>>> +      * paths without sighand->siglock, hence atomic64 (a 64-bit va=
lue would
> >>>> +      * otherwise tear on 32-bit).
> >>>> +      */
> >>>> +     atomic64_t              cap_bset_pending;
> >>>> +
> >>>>       wait_queue_head_t       wait_chldexit;  /* for wait4() */
> >>>>
> >>>>       /* current thread group signal load-balancing target: */
> >>>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> >>>> index b6ec6f693719..85ac71897070 100644
> >>>> --- a/include/uapi/linux/prctl.h
> >>>> +++ b/include/uapi/linux/prctl.h
> >>>> @@ -70,6 +70,7 @@
> >>>>  /* Get/set the capability bounding set (as per security/commoncap.c=
) */
> >>>>  #define PR_CAPBSET_READ 23
> >>>>  #define PR_CAPBSET_DROP 24
> >>>> +#define PR_CAPBSET_DROP_MASK 82
> >>>>
> >>>>  /* Get/set the process' ability to use the timestamp counter instru=
ction */
> >>>>  #define PR_GET_TSC 25
> >>>> diff --git a/kernel/fork.c b/kernel/fork.c
> >>>> index 5ef413368912..bf671a85d39d 100644
> >>>> --- a/kernel/fork.c
> >>>> +++ b/kernel/fork.c
> >>>> @@ -2504,6 +2504,7 @@ __latent_entropy struct task_struct *copy_proc=
ess(
> >>>>        * before holding sighand lock.
> >>>>        */
> >>>>       copy_seccomp(p);
> >>>> +     cap_bset_drop_fork(p);
> >>>>
> >>>>       if (clone_flags & CLONE_NNP)
> >>>>               task_set_no_new_privs(p);
> >>>> diff --git a/security/commoncap.c b/security/commoncap.c
> >>>> index 3399535808fe..3bec15d43731 100644
> >>>> --- a/security/commoncap.c
> >>>> +++ b/security/commoncap.c
> >>>> @@ -3,6 +3,7 @@
> >>>>   */
> >>>>
> >>>>  #include <linux/capability.h>
> >>>> +#include <linux/cred.h>
> >>>>  #include <linux/audit.h>
> >>>>  #include <linux/init.h>
> >>>>  #include <linux/kernel.h>
> >>>> @@ -19,6 +20,7 @@
> >>>>  #include <linux/hugetlb.h>
> >>>>  #include <linux/mount.h>
> >>>>  #include <linux/sched.h>
> >>>> +#include <linux/sched/signal.h>
> >>>>  #include <linux/prctl.h>
> >>>>  #include <linux/securebits.h>
> >>>>  #include <linux/user_namespace.h>
> >>>> @@ -30,6 +32,25 @@
> >>>>  #define CREATE_TRACE_POINTS
> >>>>  #include <trace/events/capability.h>
> >>>>
> >>>> +/**
> >>>> + * Effective bounding set of @cred in @task's thread group
> >>>> + * @task: task whose thread group's pending drop applies
> >>>> + * @cred: credentials to read the bounding set from
> >>>> + *
> >>>> + * A drop recorded by PR_CAPBSET_DROP_MASK is authoritative on the =
thread group
> >>>> + * and may not have been materialized into every thread's cred yet,=
 so the
> >>>> + * effective bounding set is the cred's own set minus the group's p=
ending drop.
> >>>> + */
> >>>> +kernel_cap_t cap_bset_effective(const struct task_struct *task,
> >>>> +                             const struct cred *cred)
> >>>> +{
> >>>> +     kernel_cap_t pending =3D {
> >>>> +             .val =3D atomic64_read(&task->signal->cap_bset_pending=
),
> >>>> +     };
> >>>> +
> >>>> +     return cap_drop(cred->cap_bset, pending);
> >>>> +}
> >>>> +
> >>>>  /*
> >>>>   * If a non-root user executes a setuid-root binary in
> >>>>   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> >>>> @@ -284,8 +305,8 @@ int cap_capset(struct cred *new,
> >>>>
> >>>>       if (!cap_issubset(*inheritable,
> >>>>                         cap_combine(old->cap_inheritable,
> >>>> -                                   old->cap_bset)))
> >>>>               /* no new pI capabilities outside bounding set */
> >>>> +                                   cap_bset_effective(current, old)=
)))
> >>>>               return -EPERM;
> >>>>
> >>>>       /* verify restrictions on target's new Permitted set */
> >>>> @@ -849,7 +870,7 @@ static void handle_privileged_root(struct linux_=
binprm *bprm, bool has_fcap,
> >>>>        */
> >>>>       if (__is_eff(root_uid, new) || __is_real(root_uid, new)) {
> >>>>               /* pP' =3D (cap_bset & ~0) | (pI & ~0) */
> >>>> -             new->cap_permitted =3D cap_combine(old->cap_bset,
> >>>> +             new->cap_permitted =3D cap_combine(new->cap_bset,
> >>>>                                                old->cap_inheritable)=
;
> >>>>       }
> >>>>       /*
> >>>> @@ -925,6 +946,8 @@ int cap_bprm_creds_from_file(struct linux_binprm=
 *bprm, const struct file *file)
> >>>>       int ret;
> >>>>       kuid_t root_uid;
> >>>>
> >>>> +     new->cap_bset =3D cap_bset_effective(current, new);
> >>>> +
> >>>>       if (WARN_ON(!cap_ambient_invariant_ok(old)))
> >>>>               return -EPERM;
> >>>>
> >>>> @@ -1283,6 +1306,63 @@ static int cap_prctl_drop(unsigned long cap)
> >>>>       return commit_creds(new);
> >>>>  }
> >>>>
> >>>> +static int cap_bset_drop_process(kernel_cap_t mask)
> >>>> +{
> >>>> +     kernel_cap_t pending;
> >>>> +     struct cred *new;
> >>>> +
> >>>> +     new =3D prepare_creds();
> >>>> +     if (!new)
> >>>> +             return -ENOMEM;
> >>>> +
> >>>> +     /*
> >>>> +      * Record the drop before committing the caller's cred, so tha=
t a
> >>>> +      * thread created from now on is guaranteed to observe it.  Ap=
ply the
> >>>> +      * current union, not just this call's mask, to the caller's c=
red.
> >>>> +      */
> >>>> +     spin_lock_irq(&current->sighand->siglock);
> >>>> +     atomic64_or(mask.val, &current->signal->cap_bset_pending);
> >>>> +     pending.val =3D atomic64_read(&current->signal->cap_bset_pendi=
ng);
> >>>> +     spin_unlock_irq(&current->sighand->siglock);
> >>>> +
> >>>> +     new->cap_bset =3D cap_drop(new->cap_bset, pending);
> >>>> +     commit_creds(new);
> >>>> +
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>> +/*
> >>>> + * Propagate a pending process-wide bounding-set drop to @p, a task=
 being
> >>>> + * created by the current thread.  Threads sharing the group read
> >>>> + * current->signal->cap_bset_pending directly; a forked child gets =
its own
> >>>> + * signal_struct and must carry the mask itself.  Called under
> >>>> + * current->sighand->siglock, which serializes it with cap_bset_dro=
p_process().
> >>>> + */
> >>>> +void cap_bset_drop_fork(struct task_struct *p)
> >>>> +{
> >>>> +     kernel_cap_t mask =3D {
> >>>> +             .val =3D atomic64_read(&current->signal->cap_bset_pend=
ing),
> >>>> +     };
> >>>> +
> >>>> +     if (cap_isclear(mask) || p->signal =3D=3D current->signal)
> >>>> +             return;
> >>>> +
> >>>> +     atomic64_or(mask.val, &p->signal->cap_bset_pending);
> >>>> +}
> >>>> +
> >>>> +static int cap_prctl_drop_mask(unsigned long low, unsigned long hig=
h)
> >>>> +{
> >>>> +     kernel_cap_t mask =3D mk_kernel_cap((u32)low, (u32)high);
> >>>> +
> >>>> +     if (cap_isclear(mask))
> >>>> +             return 0;
> >>>> +
> >>>> +     if (!ns_capable(current_user_ns(), CAP_SETPCAP))
> >>>> +             return -EPERM;
> >>>> +
> >>>> +     return cap_bset_drop_process(mask);
> >>>> +}
> >>>> +
> >>>>  /**
> >>>>   * cap_task_prctl - Implement process control functions for this se=
curity module
> >>>>   * @option: The process control function requested
> >>>> @@ -1308,11 +1388,16 @@ int cap_task_prctl(int option, unsigned long=
 arg2, unsigned long arg3,
> >>>>       case PR_CAPBSET_READ:
> >>>>               if (!cap_valid(arg2))
> >>>>                       return -EINVAL;
> >>>> -             return !!cap_raised(old->cap_bset, arg2);
> >>>> +             return !!cap_raised(cap_bset_effective(current, old), =
arg2);
> >>>>
> >>>>       case PR_CAPBSET_DROP:
> >>>>               return cap_prctl_drop(arg2);
> >>>>
> >>>> +     case PR_CAPBSET_DROP_MASK:
> >>>> +             if (arg4 || arg5)
> >>>> +                     return -EINVAL;
> >>>> +             return cap_prctl_drop_mask(arg2, arg3);
> >>>> +
> >>>>       /*
> >>>>        * The next four prctl's remain to assist with transitioning a
> >>>>        * system from legacy UID=3D0 based privilege (when filesystem
> >>>> --
> >>>> 2.34.1
>
