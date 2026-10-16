Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE2C8CE;
	Fri, 16 Oct 2026 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142070; cv=none; b=jIM2AnxkBXcLuxQ76B2xvdHpHv/qbbjju5YDrRN2IPiXyzGg8te3GVxi1vi/RbcVgPsgZA1eApQ1RA4Bcif3Jw6WeOlF+DhPI9y5SIEMwZpmEDkKI63tYz/glNqUxwKLVJXHi2S41qZjuGCPEnqakwaXFRdhh5oM+GTMYT0UuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142070; c=relaxed/simple;
	bh=sRLWeklQ90xZrRkjcVSjhFNMUD9C8I/dTI/7ojTeITo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa92w2ysM15UCDnzlxcIC2d45YgtgD+X71eDVmIYYTDCFI/3zmp3MJdTYmu+mZBQmEpqr6vlhm8kUqkXeaYx1uLoX0a6QcIfF57jJBg7YuIQFN+3FYf5UiN0NO2KqFhkTJLQYNmFcpMB4WAM49uM5iQvURRnVSVbX/DV3W0xZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQSiszVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQSiszVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04101F000C4;
	Fri, 16 Oct 2026 09:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142069;
	bh=sRLWeklQ90xZrRkjcVSjhFNMUD9C8I/dTI/7ojTeITo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iQSiszVaXLGO3bSwlmruRjBBFIJMA3sWcIW0Xva4NNUfkA7hgkw+slycrtv4iCEBZ
	 brTQPBN/D4BGpn4jafC7aqwSFaPvMOxGE//Daqo3mcppq8IGt5HklBxcUlsmS5LKvW
	 yB1Qp7I2BP3k0Wpc01Enp22IEYjuwZVZG9Rfe9I3M22oUCzUCk6B+Cv0mlmYP3pbIJ
	 7FfB8LQ5rJMUrHd9L2X4Vj5ukr/MIOlSb2qmRd/URsRXYT+rH0VrHLYWSz+Et7yPjj
	 KdGqduX1F/B7G2g4LqhRVfbkDHlp2ykxUbFRki6e+Df/7n2DS+KGOqhDxpldtNgeJE
	 3M+Yb7ehl+Jew==
Date: Fri, 16 Oct 2026 11:14:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Halaney <andrew@amutable.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH v4 00/10] net: support thread-specific pidfds for send
 and connect
Message-ID: <20261016-erdball-skisport-erhaben-93d64cfd2890@brauner>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
 <1ab71b00-fbe1-42a0-a99e-27d5cd5e5a6e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ab71b00-fbe1-42a0-a99e-27d5cd5e5a6e@redhat.com>

> I think that this late in the cycle, the series could go via Christian's
> tree only and we could get it back after the merge window. WDYT?

Sounds good to me. Thanks for being flexible.
