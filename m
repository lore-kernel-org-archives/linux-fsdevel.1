Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E4391E5F;
	Wed,  9 Sep 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979181; cv=none; b=cJLE8cfYQ1yR1yNgx28/PdPvGWEnx6xpSzfAaVvQZrkOqrNvQozKJZTDyYbpopZvkPFweseg3vK/0c9PYNjpP5cVwC+r+WdO8FYSbNHy858YkCYt/DnM1ngXCKwmCiUJmD4lG+3oE+3e6UL4Ot5vKJj+AOELAGfHdU5V+u40oZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979181; c=relaxed/simple;
	bh=MC5rnj+PmKrh+D+W/3DT+hg8Sal13qGmvv5yGFi3x7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2ZOQIAH4g0GidvR0ofIPnWXK6+TeaE2mMsYEwR2iYlD99Rui4BpmZuEL3CxA43WR0KGyJk0KG+CwBqN585MK4pBikYqVmQfrl37N2yw6y1W38i8AMaWr1TkTuTYw5gGz8//kCWh4ylF3wAOqp6z2nazY2rsUETVtG63O9PnhDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JObXuvSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JObXuvSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B9B1F000FF;
	Wed,  9 Sep 2026 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979180;
	bh=3GvnrlLJE8wQpnfFH02vjFP2deR4PHg0FAoR1W//fdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JObXuvSwPIPJcJCkCuA22ZnS+f7JAjCsNYXAiV+fIJzT+zPsLOe+Ab+PelYdsXpRL
	 ZOwfZW930uD3GbOL+SzF8+NyA2Ieb0R7zO72F4fFYfriyVcixLCgyuw8Cm4IW2rvFt
	 +CstQQRoALjXvBE5CATVDdhEfsproPlYDM+v3D9UfUQaM3JWYMSEew/+JBMR6s0HlK
	 x3jLAEftox8t8RGI3VN5WNSTW/jHhaMxYlJFUyvYiVxBpS5LLH/ZzgCQPiUHSLfP51
	 CFM5VtOd5BJWGG4/377zdfi5DV+0FvE7GEXFZra3x5j0Nyx5xK7v67Cb7Dd//4AQS/
	 VbPEZsCG11+aw==
Date: Wed, 9 Sep 2026 11:39:39 -0700
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
Subject: Re: [PATCH v2 00/10] net: support thread-specific pidfds for send
 and connect
Message-ID: <20260909113939.726dadbf@kernel.org>
In-Reply-To: <20260909-vorkommen-einwickeln-entspannen-fb7fb4e29575@brauner>
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
	<20260909-vorkommen-einwickeln-entspannen-fb7fb4e29575@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 14:40:25 +0200 Christian Brauner wrote:
> @Jakub, shared branch in vfs-7.4.shared.net-next.pidfd. I'm open to rebasing if
> you have need for that on your end during the cycle.

SG, thanks! Once we pull the hashes need to stay stable, we have a lot
of subordinate trees and too much code for feature branches.
Let's give it a couple of days, let AI and Kuniyuki review, and take 
it from there.
