Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465023D9DA8;
	Fri,  4 Sep 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536317; cv=none; b=fC/6vy3PnyCSnJHvWjoZkw0unkl7tQdEgxRqMKEQTW6NmOmjV0Jwgzto9JWHgqHm4jnQ/5XwijBHxkUfHxmH2LlvQagSztd1RvZWi+w7V55apWHCUgBmaVutMlpg+MqzHiuPM8dfpERGetG2oF/CVHE71Wyh9+Q8y6ChWHRnN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536317; c=relaxed/simple;
	bh=MFGNhoPZSSYrfPl7DxsK1rpVv/eJY/GjY/qKmZtxztw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HG1VmI65Nz+kUdJeEtpKeIXBYnqq1ZpCQTmmyaNLIyAhpCArmg+SYLrd/KI+Afd0kDjac3CLf0piBXPtPcMq5/8OuW8aothbOBbpip0x/so9t0H8Jih/ALEBgr0qoXxsLJh7L2Ru4UKIcmxIjrfAHSShpTvhTt2AwTu5/39dgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osHikE9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osHikE9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBF91F00A3D;
	Fri,  4 Sep 2026 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536315;
	bh=E6gCTHbN1a2TvbVEkb78KjRMvftQouYezcH7gqQv2vI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=osHikE9duZi0l2YZ/2IvPD/u47R7h8kU2MsV+q5Q+suYvHi0rJZl2rqeg9okLAIyZ
	 21fXlhcZnkG+vu+TJnZDcdeRcFl34b35fM6E7ZklgtwZCQABaUABLV03g2VwQ/Glq7
	 Dh49natl6oqJk1BzWQTqoDKX8mQuhVo3ZfyLsOzEJcSVKlGkdoTDjR10o/E8tU/6Ap
	 eHADj4ECChbSKjqxyR6A2iB9yQQXro+tgNsB111dA8qUGjY8w8VDrxQkR8lj4mr1QU
	 h2e/34GCUxD1YHIr0G0TreTMBZFivSCLtiFIRwzm8jz+Q1GrW097acTUiTMPRSx2NE
	 jHhMZQCWInoXg==
Date: Fri, 4 Sep 2026 08:38:34 -0700
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
Message-ID: <20260904083834.5c31e8f1@kernel.org>
In-Reply-To: <20260904-eintagsfliege-goldpreis-gebinde-8e5b7c9fa9b7@brauner>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
	<20260831-work-unix-passpidfd-v1-5-70cbfda0c7ba@kernel.org>
	<20260901172014.71a2863c@kernel.org>
	<20260904-eintagsfliege-goldpreis-gebinde-8e5b7c9fa9b7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 11:03:24 +0200 Christian Brauner wrote:
> > Warning: include/net/sock.h:606 struct member 'PIDTYPE_TGID' not described in 'sock'
> > Warning: include/net/sock.h:606 Excess struct member 'sk_peer_pid' description in 'sock' (did you mean one of: '#define sk_portpair             __sk_common.skc_portpair', 'sk_peer_cred', 'sk_peer_lock', 'sk_peek_off')
> > 
> > 
> > include/trace/events/landlock.h:946:13: error: incompatible pointer types assigning to 'struct pid *' from 'struct pid *const volatile *' [-Wincompatible-pointer-types]
> > 
> > 
> > What's the merging path for these? Judging by the To: perhaps you
> > expect us to take these directly?  
> 
> If you have no quarrels with me taking it through the vfs tree it would
> help because I have other work on top of this. Otherwise a shared branch
> also works.

Shared branch, please. It's too much code to be sitting in another tree
for the full development cycle
