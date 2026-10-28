Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793228185;
	b=gQm3+8tqX+xvzA3AifxeYPPc+8ZGWn0E47jdRToxnWZQqAvgwZwha54JvoTHsoNSmKwd
	 lMV49EPT4sxrMDPopY22nuiKyOo/YvFzKq/5ieU6t6jZMi5msxySnloJnLAGCvbhtB11n
	 nk3HrJ68QLgR+XtqlQlHp7iR/CnnvInTFUi8hnda3yqEYfzDk/E0Fp0gyqLv2iyPVGXCq
	 wgikZr39Zds+d479Gl8szDjNsdx/PfQoLnbXr5UkzsU6OA3h06CFGwJKl2Uv+0Qmwl849
	 WvG6ZKGYAVxKINvRU8H17MW+m/JsRJdYhXlP54NrFtmP0Qi/WhSeKMQX7L1ykUqNvHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
	b=GHiSW0f2laI1Khbq8YEQtrXE8TorZuEgZo/Dp7AiMHbyhxQozCW4fELQhbnhOKJ3rZGY
	 U/MCJ0CgJSTgtPYF5AQYTmg6/jGd/6eNvOCN4OgbgUKq1heWbM5h0DZkkJbNK8sSzI7Qo
	 hhgkH4xqMoKC9Dz/uMEIxdnlJPOI25Tl0kYt8fPmLlvc0E6Hg/VodwAGiMugZtcog4b4n
	 mjEUMCmjo6rrz0aXF5UamLMJQVWBW4+pAHkECATXvwbRaZrtXgoDD4yHRqI4a3L+PiIJ1
	 KvMPtJeDASWWBfq5a32vKQ6Uwb8cB1GspfVB0SuCBT82rvmEkRyNok537Q4kBy2nX4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZOSlVJG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683E606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 22:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0683E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZOSlVJG
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso1507690e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793228183; cv=none;
        d=google.com; s=arc-20260327;
        b=pNpnhSJw5chmkWAqEp2Tde9YuuwD/MvWRTNlpAi+V5+vdoaWj1K9wD/dGn831CGRpz
         Zmiz6DeAE6TnECcSiJZHAIws/8O2x4FqLzTrGslBnL1t458na0GzoAIqEOAQ+L8xAli1
         4h56IQCh7U17MzP/MwefLr5CPE5FGjovvPYSi86g1XwFmkG7oRfED3H79DWFkw+RTivu
         Z7UWirRZS62H2nSlgWaWupkoH7ie9hdkklsUCuCdbXUOxi2bavQjB9MyWNOcToEVGCSW
         p7Cq0YyRzwYKyRoSietFJWRAR4gCVrp9zJvHQd8KtcZ+k3g9AXwgu3tfRP/H+iqWanPx
         QeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        fh=ZfgsUOgoMcmoj26sVKGFo9IV4Ky6KCgLuLM9/lvRui8=;
        b=O9sP3G1TDHTN5SMYbBrw3yAOzTDWnUSgcFLhNLtCNErhq6YwkyRUz0qlrj8O15DLR3
         VxjzfvUFEigsTurqazlZdnglwZP+0dbg2zewOL8mfYjQGDa22Eu+QTkI2NLQb1Cr04cy
         Xp6hBno2KdLRufXO9/fQ+WqsQtq9udEflMkCnmyjJEGTT0/nUTuP0bk2rg0LPuo2xK5/
         4ehIXlzYlaNqnZHDO6PyU6Toto9EBTq0P7oS+HJCBWHqqgO4AcJY477xkRcNhE0Afazo
         T3WT3iCQ7+uSY2MppNvVRjGTq+WvnlFcBESG4g7pA4zHuY326pfvQUWpM0Pa/7zNGV26
         ZNVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793228183; x=1793832983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        b=bZOSlVJGtHEYwYd8P/JXTJGc0heKbmZ4zF6gCQsfAWUdj+V8lveZo37a35kI44zsZG
         8r9p4GP3JXlJVRf/lRQCeD7DpNu+EpwjtNRy8B/mAQWg4VrhYeyQL+tDoFWr1hQ8Js/1
         WmBu61FcofxUa9iC2o9+OqMJhIY2ZxGCvswPzn8Prxv7xx3PhcvCqjngxpEz26C3Zh5+
         QCDR/cnpyszjYnYa+NJ3GR//R0d+Eo5+XTYFDLb2ivFHUdLHCDDXia/PshsMR6SOBMAE
         M4o+rVXHudqK4Y3GjiNjn4cOkyeetgJTVfYAYDZGmr6blu+DiQE+KChOyTySu65qfvrn
         wIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228183; x=1793832983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        b=N1dxEI2RJ6c6jcPLqgtKEkFhgBpOjXbuwMcLe92qFwJGLEx7o3Ie2DmbJnezmqZnCV
         wuEg6JBn1nedcL/2YopTCXfiTDgiSyxEPsfrZBdnuEehXUyfNQW58dvImVuaIQCorhLn
         1oz5fkeuKagmV9H15oYRdA6TA/Lkt1dVtRkLYqCH+b4RejkHmmWLGlyp5GHoCA3jLEXl
         xuEsDug71aNWHlpPLQuh0iEaFCa/4j80EUkaD3vhBhTVi4xglCLlmBELXZNT6dsZFWU0
         LlU6DGGyaVy8nQ+Udn1gXJ+5QhTpXG5wthyidxqlV5VwAV81PPxv8Yhyiwu5KQ+5LUSV
         cX2Q==
X-Forwarded-Encrypted: i=1; AKwUvByFGQ5U3BfO1EFj5iovU065FYRp3qmzX6+nvu4Ne6V1kiSGfYfpA4CTpo4dhfvVkWcqyzuYuKVYg5G/br9N@vger.kernel.org
X-Gm-Message-State: AFq9FYKZtaCOFH5AGZMJEpluA3HvSCeEuYYqg6PfMXplqoTG1rbSR8Ul
	0PHsiFkadD76FTjCCKTsAvyh65BB4TnXMJKMKALWFsILKDGvbm+obJzeLyNUgoW6fkxRrymNcmi
	nkHw/JrOF49BVDN4/ACuN7eCZj0U2KGVqdtb9ChYV
X-Gm-Gg: AYBFou0lXW+qPFKJX3em3k8qmXfA82MxdEr5Y46UEGzikW8HQrc8E/7Kv7f3+qpP9Ba
	KqDx6Wvd/JGH7y6ZGswiTrMdyJF+qthpQVOicPPtBhwJ1vU1l72Eyuyx6UBXaaCnwdrY2icb4Nm
	awsp5u8caaIfMOvph14T/gjldlAqrz0xSmN41DzNvURy5ueuZqEmt4Y36mLSKl+RSF4bFuYUvKP
	DP1pEFNh/RugdWDYbthinQnSOdKjfys6/2TYH1U6t00BUnb/WoT/1v71BbeHH9B3F34h+smoQxA
	pH/kc/xfY7TgnPxShnmebt9Zcu/taPYGWTE4UhwDf9OukviUvojimKH8pi5uxt3Tb1HMP8g5n8R
	7LVjh3XwhUCGpmgTnUZgGSNuczrK8HNzYABXzOA==
X-Received: by 2002:a05:6512:3e19:b0:5bf:c239:71ad with SMTP id
 2adb3069b0e04-5bfcad69127mr1282221e87.38.1793228183136; Wed, 28 Oct 2026
 15:56:23 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com>
In-Reply-To: <20261028221705.3915340-1-halg@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 28 Oct 2026 15:56:11 -0700
X-Gm-Features: AclHuK_P2NrO86m_OPGwNSCuxqmiVp7fbTt4tlVfFApQPbneLnvcqCjpUTpk6N8
Message-ID: <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 3:18=E2=80=AFPM Hallgrimur H. Gunnarsson
<halg@google.com> wrote:
>
> When an unprivileged process creates a new user namespace, it is granted
> a full set of capabilities (CAP_FULL_SET) scoped to that namespace.
> While these capabilities are isolated to the namespace, they allow
> unprivileged local users to reach deep kernel subsystems (most notably
> networking configuration and raw sockets via CAP_NET_ADMIN and
> CAP_NET_RAW) that historically assumed a trusted caller and have
> accounted for a large share of local privilege escalation
> vulnerabilities.
>
> Many workloads and sandboxes use unprivileged user namespaces strictly
> for basic UID/GID, mount, PID, or network isolation and never need
> high-risk capabilities like CAP_NET_ADMIN or CAP_NET_RAW. Likewise,
> system administrators often want a host-wide policy ceiling restricting
> which capabilities unprivileged user namespaces may acquire, without
> disabling unprivileged user namespaces altogether.
>
> Prior work by Jonathan Calmels [1] proposed addressing this via a sixth
> per-thread capability set (cap_userns) alongside a global sysctl mask.
> During that discussion [1, 2], feedback (e.g. from Casey Schaufler)
> suggested that rather than adding another per-thread capability set and
> prctl() interface, capability restrictions could be integrated directly
> into struct user_namespace and configured via clone3(). At the same
> time, as noted in [1], a clone3() flag alone is not sufficient for
> administrators who need to enforce a host-wide ceiling on unprivileged
> user namespaces without modifying every userspace callsite.
>
> This series combines both pieces of feedback: it embeds a capability
> bounding set (cap_bset) directly into struct user_namespace, reusing
> the existing task cap_bset, cap_permitted, and cap_effective sets on
> namespace entry, and provides both a system-wide sysctl ceiling for
> unprivileged user namespaces and a CLONE_NEWUSER_BSET flag for
> voluntary per-namespace restriction via clone3().

Why should the task's cap masks affect this?  *Maybe* cap_bset makes
sense, but I'm struggling a bit to see why cap_permitted and
cap_effective should matter.

Also, I think that Docker in non-userns mode restricts cap_bset, and
the purpose of that restriction is rather at odds with interpreting it
as a restriction on newly created user namespaces for purposes of
vulnerability mitigation.

>
> In addition, because restricting CAP_NET_ADMIN at user namespace
> creation time prevents userspace from bringing up the loopback
> interface in new network namespaces, the series first introduces
> an opt-in flag to automatically enable loopback on network namespace
> creation:
>
> 1. Opt-in loopback activation on netns creation (Patch 1)
>
>   New network namespaces start with the loopback interface (lo) DOWN by
>   default, requiring CAP_NET_ADMIN over the owning user namespace to
>   bring it up. To block external network access while preserving
>   localhost networking, sandboxes commonly create an isolated network
>   namespace with only the loopback interface enabled.
>

The whole unshare/clone flag situation is getting out of hand, IMO.
And this new thing makes logical sense but is really about reducing
exposure.

Perhaps we should instead have a small list associated with a userns
(extensible in the future) of things that the ns's admin (i.e. whoever
has CAP_SYS_ADMIN relative to the ns) may do.  That list could
include:

- Create loopback with sensible defaults for ipv4 and/or ipv6 (i see
no obvious reason to separate them)
- Create tun/tap interfaces in that ns (and attach them, etc)

And add a very simple new API to do these things.  Actually, the
tun/tap could just use the normal mechanism.

Thoughts?

--=20
Andy Lutomirski
AMA Capital Management, LLC
