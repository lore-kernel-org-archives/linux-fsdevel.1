Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB42481FDF;
	Wed, 17 Jun 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716332; cv=none; b=WZutUWdyP8Lht/n7Ic2aHMyfn5LkgdgM6siWlU7PvOPpjwzWwPm7TCLhtnZ2b+tgiNsd2FX5hzvGw0ql+/NvMbS4WkrzXlzbfRLi2HdUXFcAkvX2GpHEu+rF3gal5hcONRnE24ZCh5zDz+cXLxca00OVd+eILKIo/pI3fNwjR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716332; c=relaxed/simple;
	bh=qtq/IBU8PZzD/1Fu/0Y0dF/SchG8mINMtFUyXVucawI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkGnaUZm//ge7kfng1HA7IX7N3isCtTM1tpxgHpkYQzYlVOdjA8Cs4jYajIrI7olR99W7xyGCRPLBrw8s7rLBjcj0E/C5Depn8mLY875Ho2VMsekU4lID3LTfbshBs64khX7KM2BW6CuHl80DeqPVzYirgeLWv4GjJqbD0g2iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FbHUID58; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FbHUID58"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D9992BC6;
	Wed, 17 Jun 2026 10:12:01 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9DC3F763;
	Wed, 17 Jun 2026 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781716325; bh=qtq/IBU8PZzD/1Fu/0Y0dF/SchG8mINMtFUyXVucawI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbHUID58nz4QkOwaVHiCItdlgGxLgeqOlXhpH89C60dg/mkRpgweNcr5iGlpEB/ko
	 owJt/dHdKvmO3+OcIft8ynEj0StDqOwEUXyoo0TqcDMM5a9YOyY/cHSx7lDu5lA1Kx
	 2g44p0ch6IpE02yaRStHd/t2NE3y1OFa3xyftPRw=
Date: Wed, 17 Jun 2026 18:11:55 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com,
	jic23@kernel.org, elif.topuz@arm.com, lukasz.luba@arm.com,
	philip.radford@arm.com, souvik.chakravarty@arm.com,
	leitao@kernel.org, kas@kernel.org, puranjay@kernel.org,
	usama.arif@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
Message-ID: <ajLVW1eHzbGDm4yn@pluto>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>

On Wed, Jun 17, 2026 at 02:58:09PM +0200, Christian Brauner wrote:
> On Fri, Jun 12, 2026 at 11:37:30PM +0100, Cristian Marussi wrote:
> > Hi all,
> > 

Hi Christian,

thanks for having had a look at this, first of all.

A few remarks down below...

> > --------------------------------------------------------------------------------
> > [TLDR Summary]
> > This series introduces a new SCMI driver which uses a new Telemetry FS to expose
> > and configure SCMI Telemetry Data Events retrieved from the platform SCMI FW
> > at runtime. The patches carrying the new STLMFS Filesystem support are tagged
> > with 'stlmfs'.
> > --------------------------------------------------------------------------------
> > 
> > the upcoming SCMI v4.0 specification [0] introduces a new SCMI protocol
> > dedicated to System Telemetry.
> > 
> > In a nutshell, the SCMI Telemetry protocol allows an agent to discover at
> > runtime the set of Telemetry Data Events (DEs) available on a specific
> > platform and provides the means to configure the set of DEs that a user is
> > interested into, while reading them back using the collection method that
> > is deeemed more suitable for the usecase at hand. (...amongst the various
> > possible collection methods allowed by SCMI specification)
> > 
> > Without delving into the gory details of the whole SCMI Telemetry protocol
> > let's just say that the SCMI platform/server firmware advertises a number
> > of Telemetry Data Events, each one identified by a 32bit unique ID, and an
> > SCMI agent/client, like Linux, can discover them and read back at will the
> > associated data value in a number of ways.
> > Data collection is mainly intended to happen on demand via shared memory
> > areas exposed by the platform firmware, discovered dynamically via SCMI
> > Telemetry and accessed by Linux on-demand, but some DE can also be reported
> > via SCMI Notifications asynchronous messages or via direct dedicated
> > FastChannels (another kind of SCMI memory based access): all of this
> > underlying mechanism is anyway hidden to the user since it is mediated by
> > the kernel driver which will return the proper data value when queried.
> > 
> > Anyway, the set of well-known architected DE IDs defined by the spec is
> > limited to a dozen IDs, which means that the vast majority of DE IDs are
> > customizable per-platform: as a consequence, though, the same ID, say
> > '0x1234', could represent completely different things on different systems.
> > 
> > Precise definitions and semantic of such custom Data Event IDs are out of
> > the scope of the SCMI Telemetry specification and of this implementation:
> > they are supposed to be provided using some kind of JSON-like description
> > file that will have to be consumed by a userspace tool which would be
> > finally in charge of making sense of the set of available DEs.
> > 
> > IOW, in turn, this means that even though the DEs enumerated via SCMI come
> > with some sort of topological and qualitative description provided by the
> > protocol (like unit of measurements, name, topology info etc), kernel-wise
> > we CANNOT be completely sure of "what is what" without being fed-back some
> > sort of information about the DEs by the afore mentioned userspace tool.
> > 
> > For these reasons, currently this series does NOT attempt to register any
> > of these DEs with any of the usual in-kernel subsystems (like HWMON, IIO,
> > PERF etc), simply because we cannot be sure which DE is suitable, or even
> > desirable, for a given subsystem. This also means there are NO in-kernel
> > users of these Telemetry data events as of now.
> > 
> > So, while we do not exclude, for the future, to feed/register some of the
> > discovered DEs to/with some of the above mentioned Kernel subsystems, as
> > of now we have ONLY modeled a custom userspace API to make SCMI Telemetry
> > available to userspace tools.
> > 
> > In deciding which kind of interface to expose SCMI Telemetry data to a
> > user, this new SCMI Telemetry driver aims at satisfying 2 main reqs:
> > 
> >  - exposing an FS-based human-readable interface that can be used to
> >    discover, configure and access our Telemetry data directly also from
> >    the shell without special tools
> > 
> >  - exposing alternative machine-friendly, more-performant, binary
> >    interfaces that can be used to avoid the overhead of multiple accesses
> >    to the VFS and that can be more suitable to access with custom tools
> > 
> > In the initial RFC posted a few months ago [1], the above was achieved
> > with a combination of a SysFS interface, for the human-readable side of
> > the story, and a classic chardev/ioctl for the plain binary access.
> > 
> > Since V1, instead, we moved away from this combined approach, especially
> > away from SysFS, for the following reason:
> > 
> >  1. "Abusing SysFS": SysFS is a handy way to expose device related
> >       properties in a common way, using a few common helpers built on
> >       kernfs; this means, though, that unfortunately in our scenario I had
> >       to generate a dummy simple device for EACH SCMI Telemetry DataEvent
> >       that I got to discover at runtime and attach to them, all of the
> >       properties I need.
> >       This by itself seemed to me abusing the SysFS framework, but, even
> >       ignoring this, the impact on the system when we have to deal with
> >       hundreds or tens of thousands of DEs is sensible.
> >       In some test scenario I ended with 50k DE devices and half-a-millon
> >       related property files ... O_o
> > 
> >  2. "SysFS constraints": SysFS usage itself has its well-known constraints
> >       and best practices, like the one-file/one-value rule, and due to the
> >       fact that any virtual file with a complex structure or handling logic
> >       is frowned upon, you can forget about IOCTLs and mmap'ing to provide
> >       a more performant interface within SysFs, which is the reason why,
> >       in the previous RFC, there was an additional alternative chardev
> >       interface.
> >       These latter limitations around the implementation of files with a
> >       more complex semantic (i.e. with a broader set of file_operations)
> >       derive from the underlying KernFS support, so KernFS is equally not
> >       suitable as a building block for our implementation.
> > 
> >  2. "Chardev limitations": Given the nature of the protocol, the hybrid
> >       approach employing character devices was itself problematic: first
> >       of all because there is an upper limit on the number of chardev we
> >       can create, dictated by the range of available minor numbers, and
> >       then because the fact itself to have to maintain 2 completely
> >       different interfaces (FS + chardev) is painful.
> > 
> > As a final remark, please NOTE THAT all of this is supposed to be available
> > in production systems across a number of heterogeneous platforms: for these
> > reasons the easy choice, debugFS, is NOT an option here.
> > 
> > Due to the above reasoning, since V1 we opted for a new approach with the
> > proposed interfaces now based on a full fledged, unified, virtual pseudo
> > filesystem implemented from scratch, so that we can:
> > 
> >  - expose all the DEs property we like as before with SysFS, but without
> >    any of the constraint imposed by the usage of SysFs or kernfs.
> > 
> >  - easily expose additional alternative views of the same set of DEs
> >    using symlinking capabilities (e.g. alternative topological view)
> > 
> >  - additionally expose a few alternative and more performant interfaces
> >    by embedding in that same FS, a few special virtual files:
> > 
> >    + 'control': to issue IOCTLs for quicker discovery and on-demand access
> >    		to data
> >    + 'pipe' [TBD]: to provide a stream of events using a virtual
> >    		   infinite-style file
> >    + 'raw_<N>' [TBD]: to provide direct memory mapped access to the raw
> >    		      SCMI Telemetry data from userspace
> 
> A filsystem driver for telemetry like this is really misguided. I think
> shell access is really not an argument for adding a filesystem into the
> kernel like this. That's just not appropriate justification to push
> thousand and thousands of lines of code into the kernel.
> 
> You're building completely new infrastructure. The format is whatever it
> is. If you stream it somehow just add a binary that userspace can use to
> consume or translate it. If you need a filesystem interface for
> convenience build it via FUSE on top of whatever streams that data and
> get it ouf of the kernels way.
> 

...I would not say that this was the kind of feedback I was hoping for,
but I am NOT gonna argue, given that you shot down already what I thought
were all my best selling points :P

At this point my understanding is that the way forward must be to use
a custom tool to configure/extract/translate the raw Telemetry data and
move up into userspace the whole human readable FS layer via FUSE, if
really needed.

I suppose that the new kernel/user interface has to be some dedicated char
device implementing proper fops. (like I did previously in early versions
of this series and then abandoned...)

Is this you have in mind ? Dedicated character device(s) with enough fops
to be able to configure/extract Telemetry data with a custom tool ?

Should/could such a tool live in the kernel tree (tools/) at least for
ease of development/deployment ?

> You also buy into all kinds of really wonky properties. If you split it
> over multiple files you can never get a snapshot of data that is
> consistent if it's across multiple files.

There were also bulk read-all-together interfaces but it does not matter
at this point...

> 
> Telemetry over a filesystem is just not a great idea. If you did it via
> sysfs I really wouldn't care because all because the infrastructure
> already exists and I couldn't be bothered if this grew yet another wart
> but as a separate massive hand-rolled pseudofs, no I'm not seeing it.

...well, I am sure Greg would have shot down the SysFS approach even
more quickly, given the amount of abuse I had to carry-on to be able
to fit my Telemetry sources on top of a zillion dummy devices created
just to be representable in SysFS; indeed I did try to use SysFS in the
initial RFC and it was also a lot of pain to play that game in my
context from the implementation point of view...

...so I thought that adopting this new unified FS approach would have
been much cleaner and acceptable upstream... :D

Thanks again,
Cristian

