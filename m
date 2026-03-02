Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F17395D8F;
	Mon,  2 Mar 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447329; cv=none; b=APllp2lM8XmS6vtaYJskoTk1tHeNoM3jbBNlwasr9+PYtq0/dWvOdL2EVm+tJ4o5ZyERx16tadDDYeT1mehkDFRmEuXfr7H6tBvouLbGdbOPH2dXDaW1oo1rtPYPyv1h9bfr6t5t9CaOGaMd61YMl/3pKJY1MdjEO6YHvAOS1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447329; c=relaxed/simple;
	bh=kV3G8t5McdLcJ4U2MhKjdNHDuixzr86rHyY5b5xYARs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0ymZukgC9azxSDKeGaSVPRNpD77DbellA6KHChRzPh/XzYD8uEYB3q05HMZ1ywuVOI2fvYbxlG/6FIAtezEtzi6gwtBIPRUJG0m0RCEQTpEbU6YSyHNNDYJglXAJlvcV8hWQSsoia9N+rZGru64+YqUAFFZwfwmTRlW4dcgNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDEizYyM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDEizYyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58225C19423;
	Mon,  2 Mar 2026 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772447329;
	bh=kV3G8t5McdLcJ4U2MhKjdNHDuixzr86rHyY5b5xYARs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDEizYyMTWsrqufFZh4OrPBqXGpPF00IUY2jufIKtw+/Lp3xHNRxDw3AZq7eQeFem
	 ZVTXnA1AC5bYqVpDEljGr0acPoxjf36FVumh8GNzytPG0QojtT3VRAa4369N96fZ20
	 0XvXM+3z5pX0gevXhSmr2p6H2HdfQovDI1WVt08q39y3MCsZ39Q0vXcuzFAzze2fR8
	 EMy/qqqXn14pPxiAaoRrDIfoElAUJJ7R1nSso3lrd04ZPlFSwi2jBzn5GMOSviVpbh
	 jpTnJwnvlxslRZohZ7rBXkFMk0LUbj/XidwO1bH/DVEei+f9ag83McSPOb/LELMQe+
	 t3//gYwiyZ48g==
Date: Mon, 2 Mar 2026 11:28:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] pidfd: add CLONE_AUTOREAP, CLONE_NNP, and
 CLONE_PIDFD_AUTOKILL
Message-ID: <20260302-seltsam-gefieder-f1091b0697cb@brauner>
References: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
 <aaLkdAEaS11Pw_G_@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaLkdAEaS11Pw_G_@redhat.com>

On Sat, Feb 28, 2026 at 01:49:56PM +0100, Oleg Nesterov wrote:
> On 02/26, Christian Brauner wrote:
> >
> > Christian Brauner (6):
> >       clone: add CLONE_AUTOREAP
> >       clone: add CLONE_NNP
> >       pidfd: add CLONE_PIDFD_AUTOKILL
> 
> Well, I still think copy_process should deny
> "CLONE_PARENT && current->signal->autoreap", in shis case the
> new child will have .exit_signal == 0 without signal->autoreap.
> But this really minor.

Sorry, my bad. I've added:

if ((clone_flags & CLONE_PARENT) && current->signal->autoreap)
    return ERR_PTR(-EINVAL);
