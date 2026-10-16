Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D4312815;
	Fri, 16 Oct 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166254; cv=none; b=qWJn0Wj4lRIvIGWeFNrVSWArreALtCIMRh5YMs0t359/CW6l9VjvDDnxRM87tmw4SV5Zc+A+12n4oMTWFNC9jZ5ZxLpTrJUHP9sRJb8QVQqiCyVDjuNqXpinaWQAkbO8ldXAj5V1A4FMAEuU0gsTLzlanNzZq8JaMwAqQcp3l3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166254; c=relaxed/simple;
	bh=gOEwH8yU/F9Y/HxrcNSw3k1V15gWq0ScRHxiYP6dAnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGDFsuPXSuohVo7gZP/oJVArZV7CAjK0nGBrphOc9Q+Je8w9c7S3mwkzGjwUSxVIWCFR1IC0gD5aIycFWKBleyPkmfEIooDxEKCuXzMsooGbOao6bNcACQETfIYARfbH4w4pqyo3tMKcyukAYFYjmMif/sICAsvyQHmy2F+Q6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep+qV2GK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep+qV2GK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027601F000C4;
	Fri, 16 Oct 2026 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166253;
	bh=LNZ/9AwYIVVQVx7xigaw8FPB4qK/S5erjaS0Vu8xy2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ep+qV2GKps74QhVDgCHJGaYtnCv38QC+IAgb/hHFMUerya4zXfd1a7B4wW3T3xzaN
	 zMBW/brscnPEt6texzmnGsi/doVGEthjirhQXf/TTxF5hBhdSfyeyCJJ1HYVabdpKG
	 wKhkl2iUrtzmxCoItpz6NtY+xy3WbuGpYqwlPdTUWDQfELYvgYG7CAGLEvfiydadm8
	 gPTXSnrZ3mRQwauugD3KRYKuukiV080RINISW5Vm7fSYimejc5ds/XF1eMCpC96LwS
	 RGw02KLsXdXqA4l3owuphYpFBYaLWSX3FIdxsq7yniQOHUV00CGSSdjOAc93gM57Ud
	 dyW7WwSGtF8gg==
Date: Fri, 16 Oct 2026 08:57:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Halaney <andrew@amutable.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH v4 00/10] net: support thread-specific pidfds for send
 and connect
Message-ID: <20261016085732.2f1ffb8a@kernel.org>
In-Reply-To: <20261016-erdball-skisport-erhaben-93d64cfd2890@brauner>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
	<1ab71b00-fbe1-42a0-a99e-27d5cd5e5a6e@redhat.com>
	<20261016-erdball-skisport-erhaben-93d64cfd2890@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 11:14:22 +0200 Christian Brauner wrote:
> > I think that this late in the cycle, the series could go via Christian's
> > tree only and we could get it back after the merge window. WDYT?  
> 
> Sounds good to me. Thanks for being flexible.

Yup, close enough to the merge window so risk is low.

Then again, I don't understand why it's hard to apply
something off of a shared point.

Konstantin, could you consider adding a b4 option which would
make it apply the patches on the most recent Linus release tag
and then merge them into current branch as normal?
Simpler version is to let the user name the application base.
This lets other trees trivially create a branch later if they
want to.
