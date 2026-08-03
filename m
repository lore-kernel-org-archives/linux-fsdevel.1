Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB282D061D;
	Mon,  3 Aug 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737598; cv=none; b=QM+E4iRLPg/2xAfgSrHZ8oJATueLXwFZTNYl1Eo8uuvBNENb/2SUIQuttdvsAWe8ktzHyoxg/FexiABeTJArFcZ5X+lFDMOzndAK+QCFB34N1E9CQg33aO30vknjCMSRDfv9ZCpPR7jd6DO8YCO4GMYNAvjtzLzMBEFVzD14zyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737598; c=relaxed/simple;
	bh=12WF0nbOTufgJfMoGC5WjlPKMp8kTAFitthbPVUOzpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltlgBg7TIgmkvaSxfvuO4FpC7ACakvwSPRXyogCpSo+2Pza+b1NUxAvubcEItsdcGSTMk6u3kRq7j7/HBLnLHMAPNUccbTLWpx/AOFRWGRcwyMX9hMVH8RdbssVRyitByfKbU03LFUvDoETHVCGluZdXWao3lNrctum7ROUQd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tkEfKzj/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tkEfKzj/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76A8C143D;
	Sun,  2 Aug 2026 23:13:10 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 505913F66F;
	Sun,  2 Aug 2026 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785737594; bh=12WF0nbOTufgJfMoGC5WjlPKMp8kTAFitthbPVUOzpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkEfKzj/WhOiUQ3UDUlStFj4XamZsfgzWcxa0UevnWDUUClv1wF3F6fpc524V8LjZ
	 TT9T9wtm5PtoNDTWuvNlfbyjWFfvezQhe0a4QMrK2OO9nj0RvFCZv027s8VjRqdhc7
	 8OW6ai/EBCz4PUps2Rq4qRbVhxmXwE5AnJ9B0xUE=
Date: Mon, 3 Aug 2026 07:13:04 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com,
	jic23@kernel.org, elif.topuz@arm.com, lukasz.luba@arm.com,
	philip.radford@arm.com, brauner@kernel.org,
	souvik.chakravarty@arm.com, david@kernel.org,
	subrahmanya.lingappa@oss.qualcomm.com, leitao@kernel.org,
	kas@kernel.org, puranjay@kernel.org, usama.arif@linux.dev,
	kernel-team@meta.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v6 21/22] [RFC] Documentation: Add SCMI System Telemetry
 documentation
Message-ID: <anAxcCMYOT9Pbw8T@pluto>
References: <20260724144430.1440170-1-cristian.marussi@arm.com>
 <20260724144430.1440170-22-cristian.marussi@arm.com>
 <874iho8m26.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874iho8m26.fsf@trenco.lwn.net>

On Fri, Jul 24, 2026 at 09:05:53AM -0600, Jonathan Corbet wrote:
> Cristian Marussi <cristian.marussi@arm.com> writes:
> 

Hi Jon,

thanks for having a look at this !

> > Document ARM SCMI Telemetry IOCTLs interface.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Cc: linux-doc@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > RFC since it still needs more extensive examples
> >
> > v5 --> v6
> >  - fixed typos
> > ---
> >  Documentation/userspace-api/index.rst |   1 +
> >  Documentation/userspace-api/stlm.rst  | 143 ++++++++++++++++++++++++++
> >  2 files changed, 144 insertions(+)
> >  create mode 100644 Documentation/userspace-api/stlm.rst
> >
> > diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> > index a68b1bea57a8..22daa7ebf78e 100644
> > --- a/Documentation/userspace-api/index.rst
> > +++ b/Documentation/userspace-api/index.rst
> > @@ -54,6 +54,7 @@ Devices and I/O
> >     dcdbas
> >     vduse
> >     isapnp
> > +   stlm
> >  
> >  Everything else
> >  ===============
> > diff --git a/Documentation/userspace-api/stlm.rst b/Documentation/userspace-api/stlm.rst
> > new file mode 100644
> > index 000000000000..e34226b11373
> > --- /dev/null
> > +++ b/Documentation/userspace-api/stlm.rst
> > @@ -0,0 +1,143 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. stlm:
> 
> I'm not sure what that last line is meant to be?  It *looks* like it's
> meant to be the sort of top-of-file label that I've been trying to get
> people to stop adding for years...but it lacks the leading underscore,
> and so won't work even for that.  Remove that line?
> 

Yes...my bad I was trying to badly mimicing from some other place...
I removed this in v7, but the Docs are still RFC (even in V7) since they
still lacks a lot more usage examples....I'll go for that in v8

Thanks,
Cristian
