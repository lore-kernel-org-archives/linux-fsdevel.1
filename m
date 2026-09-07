Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13843E488
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776958; cv=pass; b=nauUSHT+fU6whCm+vxuzT0cDG3iqi0TTTC9cEs2gKivAeMrXVjT7oL2VWh0CCfGwBQNZigRmpVxqUaTVu5Mfk3Hw4UqpW2CJS8QIlyQ8AyW21n5kdKcT5PENABUY4nkljzhtSC5+fxjj8dIb1NqPfqTBuxGKlptDNF8BsO+s6jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776958; c=relaxed/simple;
	bh=/pPCcmo1c+POG45z52X2BnuE0gA1n9usXKsFAtkEfko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM5QrbbbN0MoDmKjBYS9VR/ki1QLC9JPqM2RG24rMUFJwf8iTmKolMSv0dVD2S7+TwKrGLIghf5A7mdDHdvAiwEIlal45g5XBHJP0NgTXWBtrG/Q7ZfbOPzjeXeSCt7L262F0ybBQuq65e8ZrBKnDup8zE1+17fZHBmA5cN6lt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=PsWOR6uc; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="PsWOR6uc"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c207cb16cf5so512637766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788776955; cv=none;
        d=google.com; s=arc-20260327;
        b=mx8E16S8+reCV7Tn2bqxTs2XPnwWHptgCEHXQjDtIRSFFlH+4TqkLuV1yGFFwSzIKx
         0+K9nEtGvvHAT/M3JoZWyEWRrWriPTWOvYW1gXTjyp2VMo8o6kzJmTz3VkjWBZe09It+
         mCYE+/yzfRWj55Q/QDF8PVDsgive+bHa/uCiK+JH7Z45wogRPuT6RppDH81JLNCG3FKT
         72mP+mLR4LtLqZLyMFQl4esEehNY1tj2BIt9VIGGNr63sGbdVI7pi2tO1swV2ugl4+0M
         VKdDLQQag+EEVUnffnppjsX7humQ9oxSmavIs8TtjURSdbK8lACoafigrGbRe1AJHq3E
         lgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9774GFxLNjPLVY7G1GzEmZBrWX8xiW+2/RWdji5WoSE=;
        fh=XYWNSzpnlSnuxteIgSRKDST4qHEw+c0YzG5GnVtmXgo=;
        b=gV9hcxkbfEST2AOCEbVq9qbY8vkXuX1nfhVKvJYm+dHO3ZbNXmzozpRuP1ld2LbgWM
         wmZiuCrFTOsvpgqMyYtlvi40WfpzMoTLjME2cqjPbvlAcOqFMb2jLublYZeQkxG0nInc
         1MqZOKAqcvHlNStxlEHY8fC8ZDiNIjVLYmTVKk6cgCW8HUN7BQefkzj+VUuYrOshJrOy
         nDtDewf/lrVsiuTWP05EBj+7Xr2ofxAHKiHRiTDxfSE6uA2LjjIIQl+sUNrrbGQCDxs7
         R84G6v0JWqhAhrCRre83GRzjFJ5Jp9/3uvjW/2x4EJW6CbcNjdHkLJbwk5td5bSlfs4o
         I11g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788776955; x=1789381755; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9774GFxLNjPLVY7G1GzEmZBrWX8xiW+2/RWdji5WoSE=;
        b=PsWOR6ucWs5LNiilAtlGMAErC1D8j4USrRdAR5Ndh9HolAQA27ZvKoBb+NIf8hUjL/
         YZhLgdX8YzmlOLFbD0FH3lppfDuU3JSWwrlpWbCLX/qs9LNqQaAdE7qUC7POycAKqNCM
         cuK7x5WfpYTmtmwE0EOlAiBlFDlrCe89Vmbsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788776955; x=1789381755;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9774GFxLNjPLVY7G1GzEmZBrWX8xiW+2/RWdji5WoSE=;
        b=DYEn0zna1baNm3Kii2ylg3xvszHVCippUQMeh/RXQszRZ6XsoBkwIMIBOiEJ89a2NH
         Gd3H2zGeotjlNepjss1f9VUdaG6OPcLBNTpQ4kLTaVoRKuTLxfjqVSTt1/FhOtWL9WCM
         KXxYky2EDz5sfN4vQITnt++TDAEZUOkyP2GadudANJpJY2x22TcmzCkhyvgr33nTYHEw
         Mo9Ug8Kk5RZNj933WaAUAmNwQKutm6lJCoWYi18Zar94arNWbz85TvuOJmy2dfsNkTDV
         uvYJnzHATAANkmOIq/aXuV5NZAz2g++4LN4tBxiIr3gqhDK4grVY640headUV7MapTHx
         cRVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVUZXC62HNTC3JVYePXqETmZxetta/De22aMcDwX0TZdc6YuWzneEc0HzhxiuIOcnH7qh7iW6HsbBeiPsC@vger.kernel.org
X-Gm-Message-State: AFuF++lPIWSMbBqb1oOYGH1O2QCp6dQ2neoo7YziENdG6uKL0U1q5xvP
	yVCSQ24Bi35+CK7sjRHkKoNk1QrHnFzTA71KbAQKgLNI9Jp6BWAeR8CKxb7WXs6KK7GZQDsRMBL
	M/XxS5gWwcNp5v2RtaTzFokFVw6sjMPE1rHRUWsq/bA==
X-Gm-Gg: AYBFou3r7HMscX5iR3X2Mp7kDyj0hQvcqQCkM6GemA9/zFSO7ZN06U5TW3MWAmgIHBu
	AZMv5xwlaSIR8cXYVEsqCir7hpb2ELXXXvdvjHHjTR1SbRJXKB6JOYJjFXO+389zynC9BYAJoDT
	fAUJIO7X/0jfiqtQ/q3/ipfTjdE+8FxZ0OghP7K6BUSzEiuIh4m1v/3P8B4MgOMIjXAl3eHG9NB
	tTBC3j7LiGRKQuqs0OjArndIaAkm+51pxBkH/9kHTdhIHFt4HJEzIFTY/vl8b6DKTBDWsVZt4aS
	u4FkCJuj5n+mnNXdg+L8FhBACBiQZxmfDgPk69hqtJvKybOI9/43MAqiEbTJdK49RUYh8K4ZTWY
	=
X-Received: by 2002:a17:907:c705:b0:c25:62db:772b with SMTP id
 a640c23a62f3a-c260c8b141amr822489666b.7.1788776954579; Mon, 07 Sep 2026
 03:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-6-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-6-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:29:03 +0200
X-Gm-Features: AcwNN1WlWJvrJ2vB2H7lv9qLS355J43HWilCGyv40E-X7Jm5rVAZmAIMZ0pzCnI
Message-ID: <CAJqdLrqS==7gt+bshJ8DzyaqVek_57fqUnT8EFCAboZF1ufcCA@mail.gmail.com>
Subject: Re: [PATCH 06/10] af_unix: record the pid of the connecting thread
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:21 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Currently only the struct pid of the thread-group leader is recorded.
> The identity of the actual thread that connected to a given socket
> cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the
> connecting thread. Nothing uses the thread-specific struct pid yet. No
> functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  net/unix/af_unix.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 335abd23c9bf..d01ee76c8026 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -743,51 +743,47 @@ struct unix_peercred {
>
>  static inline int prepare_peercred(struct unix_peercred *peercred)
>  {
> -       struct pid *pid;
>         int err;
>
> -       pid = task_tgid(current);
> -       err = pidfs_register_pid(pid);
> -       if (likely(!err)) {
> -               peercred->peer_pid[PIDTYPE_TGID] = get_pid(pid);
> -               peercred->peer_cred = get_current_cred();
> +       get_task_pids(peercred->peer_pid, current);
> +       err = pidfs_register_pids(peercred->peer_pid);
> +       if (unlikely(err)) {
> +               put_pids(peercred->peer_pid);
> +               return err;
>         }
> -       return err;
> +
> +       peercred->peer_cred = get_current_cred();
> +       return 0;
>  }
>
>  static void drop_peercred(struct unix_peercred *peercred)
>  {
>         const struct cred *cred = NULL;
> -       struct pid *pid = NULL;
>
>         might_sleep();
>
> -       swap(peercred->peer_pid[PIDTYPE_TGID], pid);
> +       put_pids(peercred->peer_pid);
>         swap(peercred->peer_cred, cred);
> -
> -       put_pid(pid);
>         put_cred(cred);
>  }
>
>  static inline void init_peercred(struct sock *sk,
>                                  const struct unix_peercred *peercred)
>  {
> -       sk->sk_peer_pid[PIDTYPE_TGID] = peercred->peer_pid[PIDTYPE_TGID];
> +       memcpy(sk->sk_peer_pid, peercred->peer_pid, sizeof(sk->sk_peer_pid));
>         sk->sk_peer_cred = peercred->peer_cred;
>  }
>
>  static void update_peercred(struct sock *sk, struct unix_peercred *peercred)
>  {
>         const struct cred *old_cred;
> -       struct pid *old_pid;
>
>         spin_lock(&sk->sk_peer_lock);
> -       old_pid = sk->sk_peer_pid[PIDTYPE_TGID];
> +       swap_pids(sk->sk_peer_pid, peercred->peer_pid);
>         old_cred = sk->sk_peer_cred;
> -       init_peercred(sk, peercred);
> +       sk->sk_peer_cred = peercred->peer_cred;
>         spin_unlock(&sk->sk_peer_lock);
>
> -       peercred->peer_pid[PIDTYPE_TGID] = old_pid;
>         peercred->peer_cred = old_cred;
>  }
>
> @@ -796,7 +792,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
>         lockdep_assert_held(&unix_sk(peersk)->lock);
>
>         spin_lock(&sk->sk_peer_lock);
> -       sk->sk_peer_pid[PIDTYPE_TGID] = get_pid(peersk->sk_peer_pid[PIDTYPE_TGID]);
> +       get_pids(sk->sk_peer_pid, peersk->sk_peer_pid);
>         sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
>         spin_unlock(&sk->sk_peer_lock);
>  }
>
> --
> 2.53.0
>
