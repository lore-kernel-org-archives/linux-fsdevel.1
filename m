Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404A223DD4;
	Wed,  2 Sep 2026 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308416; cv=none; b=CWj13MtqstLOOUtsJjjVHUJ2oS5nZSHJ1PBoDa++8VVN+Ch4Dnh9ruhbs5rv6XMoHtfmlb0bLIJ2fhsiq+JSUSwXeXwgWV+wZoLjpREmaloLxBgXyURNB/rOQE5IKzgC9cJqnTs6oJ19QaUV52NIvGXGmfd2wIp5cQyO8Odcork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308416; c=relaxed/simple;
	bh=uLI5/rTn5/MQlsT5qhBQcxSDx9uqN+W6apHTvnWimNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXv7AdBgvdxB5UCl1QU3AZx2Lpn6yIbnw/v15nayLHRP67AEtqLTf/RzVrIqt4FlMMNGSzlcUtXlPq9IEK3n/q5iR9w8lnYrc1BQjhR+EbuuIaPfcDc21YGttwlT2o6O+cASoomcl6guVeN6jB/Ks+BRiArERnBI4XvgORfHqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPeknzf+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPeknzf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68201F000E9;
	Wed,  2 Sep 2026 00:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308415;
	bh=YMzG+rkEPr98P3Xw7OJuTOChrTpDIgow8a8OceBsIKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EPeknzf+CKaorA6rYRUJbiKDimxsPyEsiMTjZ4rRpLsTP1p0ordokjYJh+dgcmwul
	 T0xK2TctIZPMvdR4fV4yiSCTNdyDCY0JW5AqGqvb+DubGbHjYhOEE3NUSCNoZ6lUlu
	 qmhwlqdd+mqk6KNqFyv/83jGnRTfFKiRQM/6HGIlSs8ck3Nmn+se4E/ZzQkUragNNs
	 EGaA5OasVwOnMcvFG2Prd0Z7fqEdToemxDcZwR4eb3Vs4rF9uwV4/+35emJs9JwA25
	 5XX1LdTKyw4Ms7cGnjzxMXstQfxRUzT3XCVk1iUJSczyW2uOAc3dirMG20bz5w75Hc
	 0jDtXGnCsvqPA==
Date: Tue, 1 Sep 2026 17:20:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>
Subject: Re: [PATCH 05/10] net: turn sk_peer_pid into an array indexed by
 pid type
Message-ID: <20260901172014.71a2863c@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-5-70cbfda0c7ba@kernel.org>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
	<20260831-work-unix-passpidfd-v1-5-70cbfda0c7ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 13:21:17 +0200 Christian Brauner wrote:
> Currently only the struct pid of the thread-group leader is recorded
> for a socket's peer. To make room for the struct pid of the thread that
> called connect(), listen() or socketpair() turn sk_peer_pid into an
> array indexed by pid type. All users, including bluetooth and the
> coredump socket, keep using the PIDTYPE_TGID slot.
> 
> Nothing fills the PIDTYPE_PID slot yet. No functional changes.

This patch suffers from missing kdoc and general inability to build:

Warning: include/net/sock.h:606 struct member 'PIDTYPE_TGID' not described in 'sock'
Warning: include/net/sock.h:606 Excess struct member 'sk_peer_pid' description in 'sock' (did you mean one of: '#define sk_portpair             __sk_common.skc_portpair', 'sk_peer_cred', 'sk_peer_lock', 'sk_peek_off')


include/trace/events/landlock.h:946:13: error: incompatible pointer types assigning to 'struct pid *' from 'struct pid *const volatile *' [-Wincompatible-pointer-types]


What's the merging path for these? Judging by the To: perhaps you
expect us to take these directly?
-- 
pw-bot: cr
