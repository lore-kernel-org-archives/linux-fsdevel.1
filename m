Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6530C17B;
	Mon, 15 Jun 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509513; cv=none; b=McHRb/XDjK+vI4m9gUlTQN8CL6JNsKzwEJbn22eNq9KZpweooZwYkTRbHf0mcKb3WQD9a6cbbs6goTF3x9zP9sEyLYuzZ6HtR2c8konfeVjGvQZLRQak26GAK8XFcQYggtLNrWIX02UzfyQJvVXJX/qG11+XSYZf5xs6bSm3Wz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509513; c=relaxed/simple;
	bh=S3aesdr6kLsMUr3xS9pG14iz/MosAT4l49e0wdffs74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntM0sQ1+C3jrt9GL6IWtBjKnyW0uHdYxjUXTvqVdcMcQ4sFISe1KrSekc2uTOS5G4Xn8mPKryNRUmPk7uAnXHuCA/4WpKehzM34hgk7SA9ezNpZsdpBAktuVjoj88gkRPQJgCqOwdo/Zz8i6VVZchOEb1rspq1VYVpODPvlAVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fzKvQYgj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fzKvQYgj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFA171BB0;
	Mon, 15 Jun 2026 00:44:59 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50F153F915;
	Mon, 15 Jun 2026 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781509504; bh=S3aesdr6kLsMUr3xS9pG14iz/MosAT4l49e0wdffs74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzKvQYgj2iF4lrktbW85bXMa+pjivHU/qBOlR1WbOnnjLYmME7Tp1Afkh4vR5bR3R
	 Xk7sbfqqXI1biKbxPrUDKsMsI3DqmYJ/wy1gFhSbIyf6ezFz7cU3VxpEVE6FxIkLUl
	 kVuEJpT4atyv2vAFewU3n7onhcjNKa/r06KPy/9A=
Date: Mon, 15 Jun 2026 08:44:49 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com,
	dan.carpenter@linaro.org, d-gole@ti.com,
	jonathan.cameron@huawei.com, elif.topuz@arm.com,
	lukasz.luba@arm.com, philip.radford@arm.com, brauner@kernel.org,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 01/24] firmware: arm_scmi: Add new SCMIv4.0 error
 codes definitions
Message-ID: <ai-tXclzfL9CkGkq@pluto>
References: <20260329163337.637393-2-cristian.marussi@arm.com>
 <20260612101100.186627-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612101100.186627-1-usama.arif@linux.dev>

On Fri, Jun 12, 2026 at 03:10:59AM -0700, Usama Arif wrote:
> On Sun, 29 Mar 2026 17:33:12 +0100 Cristian Marussi <cristian.marussi@arm.com> wrote:
> 

Hi Usama,

Thanks for having a look at this first of all !

I was busy posting a V4 before merge window last week so this late
reply....

I am already planning a V5 in -rc1 in two weeks where beside some more
minor ABI additions I will plan to address any incoming reviews and
some residual minor issues I know about (mostly sparse related)

...but you are CCed already in V4...

> > SCMIv4.0 introduces a couple of new possible protocol error codes: add
> > the needed definitions and mappings to Linux error values.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/common.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 7c35c95fddba..44af2018e21d 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -45,6 +45,8 @@ enum scmi_error_codes {
> >  	SCMI_ERR_GENERIC = -8,	/* Generic Error */
> >  	SCMI_ERR_HARDWARE = -9,	/* Hardware Error */
> >  	SCMI_ERR_PROTOCOL = -10,/* Protocol Error */
> > +	SCMI_ERR_IN_USE = -11,  /* In Use Error */
> > +	SCMI_ERR_PARTIAL = -12, /* Partial Error */
> >  };
> >  
> >  static const int scmi_linux_errmap[] = {
> > @@ -60,6 +62,8 @@ static const int scmi_linux_errmap[] = {
> >  	-EIO,			/* SCMI_ERR_GENERIC */
> >  	-EREMOTEIO,		/* SCMI_ERR_HARDWARE */
> >  	-EPROTO,		/* SCMI_ERR_PROTOCOL */
> > +	-EPERM,			/* SCMI_ERR_IN_USE */
> 
> "In use" reads like a resource-state failure, where -EBUSY would normally be expected.
> -EPERM suggests an authorization failure,  which is already represented by SCMI_ERR_ACCESS.
> 

The usage of this in Telemetry is indeed a resource state failure that relates to groups usage
and it means something like "this is busy now, so you cannot do that now with this current config"
...but you are definitely right that -EPERM does NOT fit well here and especially is NOT what IN_USE
should signify in general in SCMI as a return code for future users.

I will fix in V5.

Thanks,
Cristian
