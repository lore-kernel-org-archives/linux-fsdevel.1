Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4681FCF41;
	Fri,  4 Sep 2026 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512611; cv=none; b=VSWfuQENuTwbLCxf+H/q7GwOoihbOli/k9f0qoOge2+L4nkn2NzUO9dypDu9ppEuWeylTJlKmQY2Faxh9MTNFDujtgDdzJb+QowwBvX8fIXYQwAnVlaN9XH2pfWEbV2UFa5/8+LJIPBn4Th9vHElTAZprJIPqdkWVYH/4KnmbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512611; c=relaxed/simple;
	bh=IiKKmhBsmyzDAEa6K3e0++w83wlpdn2A3PruIjmWfE8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=njgQHUCPul3qXilm2lcLn8Cf1ZSPBMG0Juj3QfbAW3zY4mztTtQxe5mq/LxD6UnCf99VPcMWmxXqPISSqYO6I0oaDuMOGY4RNW10wcpcpwsfIYMtHUIg/TUsEsmGmjXv6JTeSuodfKvcflDBUHXuxtYhtSS80Yq7gaD+Znrz19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+VmLj8C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+VmLj8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32761F00A3D;
	Fri,  4 Sep 2026 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512609;
	bh=YL1+dW9aDIt8bKfDzMgM2VdtSQVd4CAMkl5Iku7TWaA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=X+VmLj8CNyOam4GBHAFWeaHQlqKDiFX3uECYRlWmbGMPZn8m/kMU99CpLTvheBDb9
	 DmThyBaS14uog7TXfgB58YYa/TO3GUQM+QGpkiaXSRppFyQKAQmqR/kCKoEJMknPWh
	 QFXIC3Jn5ucGyYKapJwzaGAE3OcpzY3Vw3aU6fcPtAtKqMvqtvIQMUafiXfkWpaSbt
	 mzmai+cUws7+x2qdOwd9hNMObtpsc3tU+SK65SVxT1U9UklOoiEeQxKdoQ3smparqU
	 liSfCi/FXT5geovf6t+UcfoxQhpFzvbdP47x/ZeP/k1W2425AdOkUGxfEW0q0mhZdp
	 7yaWB6ySwhrWA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/10] net: turn sk_peer_pid into an array indexed by
 pid type
From: Christian Brauner <brauner@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
In-Reply-To: <20260901172014.71a2863c@kernel.org>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
 <20260831-work-unix-passpidfd-v1-5-70cbfda0c7ba@kernel.org>
 <20260901172014.71a2863c@kernel.org>
Date: Fri, 04 Sep 2026 11:03:24 +0200
Message-Id: <20260904-eintagsfliege-goldpreis-gebinde-8e5b7c9fa9b7@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IiKKmhBsmyzDAEa6K3e0++w83wlpdn2A3PruIjmWfE8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTN6oxpPslY6n733Lo52z8WmTja3j7wfkPI9U+PNb3O7
 fvCnsaY1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRslhGhr1vMnx7Ze1sb+RV
 8mmwdIhM3B958CuDx57cI6zOK64dFGRkWLby+dZE3wVpLqsSIjWsF06SNk68HNBs73akw2hl1F4
 ldgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-09-01 17:20 -0700, Jakub Kicinski wrote:
> On Mon, 31 Aug 2026 13:21:17 +0200 Christian Brauner wrote:
> > Currently only the struct pid of the thread-group leader is recorded
> > for a socket's peer. To make room for the struct pid of the thread that
> > called connect(), listen() or socketpair() turn sk_peer_pid into an
> > array indexed by pid type. All users, including bluetooth and the
> > coredump socket, keep using the PIDTYPE_TGID slot.
> > 
> > Nothing fills the PIDTYPE_PID slot yet. No functional changes.
> 
> This patch suffers from missing kdoc and general inability to build:

Oh, damn, the automated pipeline should have done a per-patch build.
Fixing, thanks!

> Warning: include/net/sock.h:606 struct member 'PIDTYPE_TGID' not described in 'sock'
> Warning: include/net/sock.h:606 Excess struct member 'sk_peer_pid' description in 'sock' (did you mean one of: '#define sk_portpair             __sk_common.skc_portpair', 'sk_peer_cred', 'sk_peer_lock', 'sk_peek_off')
> 
> 
> include/trace/events/landlock.h:946:13: error: incompatible pointer types assigning to 'struct pid *' from 'struct pid *const volatile *' [-Wincompatible-pointer-types]
> 
> 
> What's the merging path for these? Judging by the To: perhaps you
> expect us to take these directly?

If you have no quarrels with me taking it through the vfs tree it would
help because I have other work on top of this. Otherwise a shared branch
also works.

