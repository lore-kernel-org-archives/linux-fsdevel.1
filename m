Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECB3F6C2D
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827198; cv=pass; b=Eh+YkDj3N5q/E/Yb0q9bjeRMT36oGOSP5Uj+zqQ4a35gFnGSQQ5KYrURur4s+QN4rqYYE6vevbITnhKdAGEq+lU8pMSW4LzKTtW2nTH7dBfzyl44ocH5ZrZ8tdo9+RBoCXFMvvN8ZE45RyJ2m14f5ilLgDoyWggHCPWZxzdJ5ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827198; c=relaxed/simple;
	bh=JfjhtWAX/5PoHBlGE27TqtOtdtC4PuPBWAxjmTiuq7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0kREprSAxhupT2xMIo1Vdo8zE8VU0Sx0j7cMeG4reM0gXzVNif+bEVWCBXdvjDjjHJsmU1WyGCD4ZrbhWcKNttvJjv6oDyK4ZmdAUi3VxNISu7NJ70vjAdz7SpAJrCrcXUpkVnREAjiFpuFnaLBUSzUGfBOlQPrhcfrOy5IBnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwtaXyA8; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwtaXyA8"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so6657712c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 20:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790827195; cv=none;
        d=google.com; s=arc-20260327;
        b=rubY3kjEO55gmWdaE1iFpr8gteGB8IuPIKyGPObIyEWk8cLFzLzPMYNsOmemeLE8Sz
         TF28Rw8B5g3RS8/pgozxxHPgRLhF7jFJv6eeZcuAw9nNub9OECiKnLvJigKUF8UOVENP
         I2C2skpQk9R4pJDDXzVlpG0zTrB2JyzJPnFw3R9xiqsZ18gPvbRF1LAMeeU//g3XsXdy
         DZfnKUS7XvvXDZcEJ/MIwBcfugF6T0mkP8K4DworBsv6W3fu5k+RKUfpE3MEBSw49MHw
         n+N9PsXJC45e/n3j50TW3H0hDg7vf3FwbJ/n2clf7pfkYnrgd4FTWschf7pPCjMUTE0F
         MFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ywwb2zJHaIFNjSQOhqCmHZmRwQwtwKhmlrvLgQ+t+Tg=;
        fh=syVeQMULKSCQNUvXArjvX8pTERVPjvssKX+ESttwhzo=;
        b=fUUmj3QlmIe/K1mdQnH4kPHCBfBU4b/0bFD91uv/XAdv1X7JOEfpLLw2Hj18zPm5VD
         Z8pGnwKNimgjQoQEzdcADLCxt8nfNyxFvW8tvwvNvWwOGi27EQvsC7vUU45BWDEt8ypI
         asJBX8vKf2DmaG3OA6UpIGizG/WlArdNhSLUDNLJdrf4ta3IxPhTS+TXBEdsKRcRnBK2
         21xMJrHTfA08GwZrVMnl/9PxJrjWCS7otIvSDZhEDw9DyQpYyI6MJl2DKwa/KEw3Q2G5
         y/SHZoLVSkllvWms6DCj6DwDk4o4bLz/bhOiDnB3ViJ96EeOJsrG5r/a75/+kAK6OUxd
         B1Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790827195; x=1791431995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ywwb2zJHaIFNjSQOhqCmHZmRwQwtwKhmlrvLgQ+t+Tg=;
        b=cwtaXyA8+DEpkP3kx8faRD87R2av2SFFcHmzcAihOwIC4826BafRF0YWeM23RUv+t3
         R1BJgFJrogeHKrG+ctyAS762llUZCEVUokwkOn8k/R1D0iqZ4Z2IQBVEm6bUYtOtBXqv
         nlux+OEJOIvjP/E6FKO8H2RBrShnWXLiz3CDqruvXgagFFN06GlplMsCmiEf8SeE4576
         SYGkB1fVhPEuHTo8AJAPjVsUFApK1/FnJopsmEqULz0pWV50u60mHuhVqgqIc9lgcRUz
         Y6b8vJlMnTGaj5Damldl7h88xpBABJ7C/TAmjC4WfrMhYSpBNVy6mt4HkjHzmI0lUjTo
         w1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827195; x=1791431995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywwb2zJHaIFNjSQOhqCmHZmRwQwtwKhmlrvLgQ+t+Tg=;
        b=L4D1Y4D82g269H1INUg/aUmCck/h+t5O76xo1Nfj9+jAYs8KbZBTTbfqatmaiNRHpi
         JO+m2/O/fAZ+3NrrVyYbfBPDeqyxon5AoRbyew5TaStv186X1MFv7S1tFJ4gE4tf6QBE
         aTqUrUmNJNAfP/kYSM/wIVISIq5UHq94oUZrqkByhsc4wNZ32ABDcacVQ7NLkHF0DHIL
         TLUYhGEP7S+KVeyUttAVB5wPUPl7KWruQNF8nHbxxvgQzWi637zY5zBvdOPtod/JmE7V
         nLj4K7fkamUfXZqr97EKUsFLJtnGQDMOZEc8CyCwpnlHlROjox3/HFpKU7k4F1xnG033
         vaaw==
X-Forwarded-Encrypted: i=1; AKwUvBz//ERV+Uje+7A65qytWKmHMZqETiOy0aXzTSBTSXYoX9JDQV0XkzK8ByWRF9dWbf7tR2nTPKw5crh5z6Ah@vger.kernel.org
X-Gm-Message-State: AFuF++kwV4dRAYGT3xgdpp14b526SRuxSzmECbCxYrOMb/O3dAYDwuqG
	TRq13PRrcrzAQUmPq3sZguy//TppCekH5Ut/jNQTvXTyA6CURnFHo2v3xeXAnyFq4PvoWvZ2eQe
	m6IizKJ2X2f/F9i00W6A20RFzpbxRoct2uHXlbJMB
X-Gm-Gg: AYBFou38LjFzpqw3dAZ7nj4KtnzXuWzGwVk+z0L5WPa1u5MEjS0JB/OyDN1wz4EdkKP
	BXssict+R5mVHN91oqlPArGdt+LWu1Vje532U5Wo4QTd0AAxB/z1rSYKgiZ3cp5N1AbhQ0TpA6f
	a2RBQeNxY/mMn6VT7FG3g4ER68D2m0t83r0DniAZ9wwVIqB6SICa8jwlb5ZVVT2Nvmc6Ghi0ihM
	uh1LH62l59eFYgvbINHSyyZg1dDoPXwX/wSGAUa4qLLF/AeEsejTceUlWjhf3pcvkfI/YSZFdG2
	dMPX7+54YoqqiugWTJV9gyEGAd+UyanyPiFx8n6vahefvyjGODf+5C2UQNzHSS8tRfnX9s2QNFz
	zwUxo2pkVtwlk1k0aet3ag4uXhikpOhIKFWGC2WB+VSxnyC2NUsOHneiSPlWJBFaXanE=
X-Received: by 2002:a05:701b:4511:10b0:149:f2b3:ef78 with SMTP id
 a92af1059eb24-14d3348e2femr3016102c88.32.1790827194314; Wed, 30 Sep 2026
 20:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-2-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-2-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 20:59:42 -0700
X-Gm-Features: AclHuK-Ya3wsqs8meD2kLmWdhIUvmp-Bq6013K1cUrm-VFKKFzhmNEX86QW6AHM
Message-ID: <CAAVpQUD3XomEde8kR2m1776rPwkJwp_qHraAiWbdrWk6Y+=RaQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] af_unix: record the pid of the sending thread
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently only the struct pid of the thread-group leader is recorded.
> The identity of the actual thread that sent the message or is connected
> to a given socket cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the sender.
> Nothing uses the thread-specific struct pid yet. No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>
> ---
>  include/net/scm.h  |  7 +++----
>  net/core/scm.c     | 21 +++++++++++++++++----
>  net/unix/af_unix.c | 23 +++++++++++++----------
>  net/unix/af_unix.h |  3 ++-
>  4 files changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 86ae6bc109ec..aa7d15c5fc27 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -42,7 +42,7 @@ struct scm_fp_list {
>  };
>
>  struct scm_cookie {
> -       struct pid              *pid;           /* Skb credentials */
> +       DECLARE_PIDS(pid, PIDTYPE_TGID);        /* Skb credentials by pid=
 type */
>         struct scm_fp_list      *fp;            /* Passed files         *=
/
>         struct scm_creds        creds;          /* Skb credentials      *=
/
>  #ifdef CONFIG_SECURITY_NETWORK
> @@ -69,7 +69,7 @@ static __inline__ void unix_get_peersec_dgram(struct so=
cket *sock, struct scm_co
>  static __inline__ void scm_set_cred(struct scm_cookie *scm,
>                                     struct pid *pid, kuid_t uid, kgid_t g=
id)
>  {
> -       scm->pid =3D get_pid(pid);
> +       scm->pid[PIDTYPE_TGID] =3D get_pid(pid);
>         scm->creds.pid =3D pid_vnr(pid);
>         scm->creds.uid =3D uid;
>         scm->creds.gid =3D gid;
> @@ -77,8 +77,7 @@ static __inline__ void scm_set_cred(struct scm_cookie *=
scm,
>
>  static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
>  {
> -       put_pid(scm->pid);
> -       scm->pid =3D NULL;
> +       put_pids(scm->pid);
>  }
>
>  static __inline__ void scm_destroy(struct scm_cookie *scm)
> diff --git a/net/core/scm.c b/net/core/scm.c
> index f0d44ecdb11f..9b9e119c353a 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -149,6 +149,7 @@ EXPORT_SYMBOL(__scm_destroy);
>
>  static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pi=
d)
>  {
> +       struct pid *thread_pid;
>         int err;
>
>         /* drop all previous references */
> @@ -158,7 +159,18 @@ static inline int scm_replace_pid(struct scm_cookie =
*scm, struct pid *pid)
>         if (unlikely(err))
>                 return err;
>
> -       scm->pid =3D pid;
> +       /* A sender naming its own thread-group sends from the current th=
read. */
> +       if (pid =3D=3D task_tgid(current))
> +               thread_pid =3D task_pid(current);
> +       else
> +               thread_pid =3D pid;
> +
> +       err =3D pidfs_register_pid(thread_pid);
> +       if (unlikely(err))
> +               return err;
> +
> +       scm->pid[PIDTYPE_TGID] =3D pid;
> +       scm->pid[PIDTYPE_PID] =3D get_pid(thread_pid);
>         scm->creds.pid =3D pid_vnr(pid);
>         return 0;
>  }
> @@ -207,7 +219,8 @@ int __scm_send(struct socket *sock, struct msghdr *ms=
g, struct scm_cookie *p)
>                         if (err)
>                                 goto error;
>
> -                       if (!p->pid || pid_vnr(p->pid) !=3D creds.pid) {
> +                       if (!p->pid[PIDTYPE_TGID] ||
> +                           pid_vnr(p->pid[PIDTYPE_TGID]) !=3D creds.pid)=
 {
>                                 struct pid *pid;
>                                 err =3D -ESRCH;
>                                 pid =3D find_get_pid(creds.pid);
> @@ -504,10 +517,10 @@ static void scm_pidfd_recv(struct msghdr *msg, stru=
ct scm_cookie *scm)
>                 return;
>         }
>
> -       if (!scm->pid)
> +       if (!scm->pid[PIDTYPE_TGID])
>                 return;
>
> -       pidfd =3D pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
> +       pidfd =3D pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pid=
fd_file);
>
>         if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>                 if (pidfd_file) {
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 42cffeafc8c1..c7d423465859 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1973,7 +1973,7 @@ static void unix_destruct_scm(struct sk_buff *skb)
>  {
>         struct scm_cookie scm =3D {};
>
> -       swap(scm.pid, UNIXCB(skb).pid);
> +       swap_pids(scm.pid, UNIXCB(skb).pid);
>
>         if (UNIXCB(skb).fp)
>                 unix_detach_fds(&scm, skb);
> @@ -1991,7 +1991,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, =
struct sk_buff *skb, bool sen
>  {
>         int err =3D 0;
>
> -       UNIXCB(skb).pid =3D get_pid(scm->pid);
> +       get_pids(UNIXCB(skb).pid, scm->pid);
>         UNIXCB(skb).uid =3D scm->creds.uid;
>         UNIXCB(skb).gid =3D scm->creds.gid;
>         UNIXCB(skb).fp =3D NULL;
> @@ -2005,7 +2005,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm,=
 struct sk_buff *skb, bool sen
>
>  static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
>  {
> -       scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).g=
id);
> +       get_pids(scm->pid, UNIXCB(skb).pid);

nit: keep scm_set_cred() here and rather move get_pid()
from scm_set_cred() to scm_send().


> +       scm->creds.pid =3D pid_vnr(scm->pid[PIDTYPE_TGID]);
> +       scm->creds.uid =3D UNIXCB(skb).uid;
> +       scm->creds.gid =3D UNIXCB(skb).gid;
>         unix_set_secdata(scm, skb);
>  }
>
> @@ -2025,20 +2028,20 @@ static void unix_skb_to_scm(struct sk_buff *skb, =
struct scm_cookie *scm)
>  static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *=
sk,
>                                 const struct sock *other)
>  {
> -       if (UNIXCB(skb).pid)
> +       if (UNIXCB(skb).pid[PIDTYPE_TGID])
>                 return 0;
>
>         if (unix_may_passcred(sk) || unix_may_passcred(other) ||
>             !other->sk_socket) {
> -               struct pid *pid;
>                 int err;
>
> -               pid =3D task_tgid(current);
> -               err =3D pidfs_register_pid(pid);
> -               if (unlikely(err))
> +               get_task_pids(UNIXCB(skb).pid, current);
> +               err =3D pidfs_register_pids(UNIXCB(skb).pid);
> +               if (unlikely(err)) {
> +                       put_pids(UNIXCB(skb).pid);
>                         return err;
> +               }
>
> -               UNIXCB(skb).pid =3D get_pid(pid);
>                 current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>         }
>
> @@ -2048,7 +2051,7 @@ static int unix_maybe_add_creds(struct sk_buff *skb=
, const struct sock *sk,
>  static bool unix_skb_scm_eq(struct sk_buff *skb,
>                             struct scm_cookie *scm)
>  {
> -       return UNIXCB(skb).pid =3D=3D scm->pid &&
> +       return UNIXCB(skb).pid[PIDTYPE_TGID] =3D=3D scm->pid[PIDTYPE_TGID=
] &&
>                uid_eq(UNIXCB(skb).uid, scm->creds.uid) &&
>                gid_eq(UNIXCB(skb).gid, scm->creds.gid) &&
>                unix_secdata_eq(scm, skb);
> diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
> index 8119dbeef3a3..402742895acc 100644
> --- a/net/unix/af_unix.h
> +++ b/net/unix/af_unix.h
> @@ -2,6 +2,7 @@
>  #ifndef __AF_UNIX_H
>  #define __AF_UNIX_H
>
> +#include <linux/pid_types.h>
>  #include <linux/uidgid.h>
>
>  #define UNIX_HASH_MOD  (256 - 1)
> @@ -11,7 +12,7 @@
>  struct sock *unix_peer_get(struct sock *sk);
>
>  struct unix_skb_parms {
> -       struct pid              *pid;           /* skb credentials      *=
/
> +       DECLARE_PIDS(pid, PIDTYPE_TGID);        /* skb credentials by pid=
 type */
>         kuid_t                  uid;
>         kgid_t                  gid;
>         struct scm_fp_list      *fp;            /* Passed files         *=
/
>
> --
> 2.55.0
>
