Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D03FB067;
	Wed, 17 Jun 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701100; cv=none; b=ZkwzOpYWV7h/mh5z5wm93VlxBGlqZ4uDrR/8vDzLY65jZ6WSqhrl4GodawikgxclZv+IjXH+KEEzfI6v3xa67o4EmYt7VmvMOcBCF5SEHp9q24QjNPick4XlUHvmx0Cr7bf0NyiPl9G3CcDlTW6JNNXLW2lmHg4ihpASllxblO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701100; c=relaxed/simple;
	bh=g2Cvu2SbLot4Ugox82nxLY269fwBYG4brxVVXKrxo48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ1BfXEEWe1R9s8ODAkfrH2JwizJQKcffbjcOUd1swLlQy4+1SWDCUPMvLzKCCAzbhbLzudd41g77rdfwYpM9XsG67tj+aaDNNLwWNC2b8QVyo3shILQktCtGvDUgMkeUi7xsVhQ5gofqbXgHZNLMWPekFRbBIHjOekuQMuiDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3VQzose; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3VQzose"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4472D1F000E9;
	Wed, 17 Jun 2026 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781701097;
	bh=6kkhjZjL73iL5SGgm49lqvbOfAh7vnr1veqEvER01Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G3VQzoseBcEc4ZqnjUIl5dazPAdmqv7vocvgDItW4EH/fCUZCK1d3yK4zzLroA2gb
	 pUOaT9bhTD3u970CxoWgLfxnyqCF4Y37VhygB0LU1Gfs+JmtJ+DASl6HnJtvongAWB
	 ehFYqG5mGezcnrDiU/QJNNylFoHvhuMhhChrUW9aKp9z0rZLHO8VsQlaKa7OhNMrDD
	 S7CLqoLojp6bvkRavTBq6arKO6F8UhAY+hkxtSBMgAnZpn7niR+gl0TTKQSbL328Yn
	 gKRlBAqhpEojrnPsRtGea5Vs7SuYNGUe1MicyGQaNPKGTsvvj1n50OVDLhotYEhb2P
	 LVJL/M4K0GSvw==
Date: Wed, 17 Jun 2026 14:58:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	sudeep.holla@kernel.org, james.quinlan@broadcom.com, f.fainelli@gmail.com, 
	vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com, 
	michal.simek@amd.com, d-gole@ti.com, jic23@kernel.org, elif.topuz@arm.com, 
	lukasz.luba@arm.com, philip.radford@arm.com, souvik.chakravarty@arm.com, 
	leitao@kernel.org, kas@kernel.org, puranjay@kernel.org, usama.arif@linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
Message-ID: <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612223802.1337232-1-cristian.marussi@arm.com>

On Fri, Jun 12, 2026 at 11:37:30PM +0100, Cristian Marussi wrote:
> Hi all,
> 
> --------------------------------------------------------------------------------
> [TLDR Summary]
> This series introduces a new SCMI driver which uses a new Telemetry FS to expose
> and configure SCMI Telemetry Data Events retrieved from the platform SCMI FW
> at runtime. The patches carrying the new STLMFS Filesystem support are tagged
> with 'stlmfs'.
> --------------------------------------------------------------------------------
> 
> the upcoming SCMI v4.0 specification [0] introduces a new SCMI protocol
> dedicated to System Telemetry.
> 
> In a nutshell, the SCMI Telemetry protocol allows an agent to discover at
> runtime the set of Telemetry Data Events (DEs) available on a specific
> platform and provides the means to configure the set of DEs that a user is
> interested into, while reading them back using the collection method that
> is deeemed more suitable for the usecase at hand. (...amongst the various
> possible collection methods allowed by SCMI specification)
> 
> Without delving into the gory details of the whole SCMI Telemetry protocol
> let's just say that the SCMI platform/server firmware advertises a number
> of Telemetry Data Events, each one identified by a 32bit unique ID, and an
> SCMI agent/client, like Linux, can discover them and read back at will the
> associated data value in a number of ways.
> Data collection is mainly intended to happen on demand via shared memory
> areas exposed by the platform firmware, discovered dynamically via SCMI
> Telemetry and accessed by Linux on-demand, but some DE can also be reported
> via SCMI Notifications asynchronous messages or via direct dedicated
> FastChannels (another kind of SCMI memory based access): all of this
> underlying mechanism is anyway hidden to the user since it is mediated by
> the kernel driver which will return the proper data value when queried.
> 
> Anyway, the set of well-known architected DE IDs defined by the spec is
> limited to a dozen IDs, which means that the vast majority of DE IDs are
> customizable per-platform: as a consequence, though, the same ID, say
> '0x1234', could represent completely different things on different systems.
> 
> Precise definitions and semantic of such custom Data Event IDs are out of
> the scope of the SCMI Telemetry specification and of this implementation:
> they are supposed to be provided using some kind of JSON-like description
> file that will have to be consumed by a userspace tool which would be
> finally in charge of making sense of the set of available DEs.
> 
> IOW, in turn, this means that even though the DEs enumerated via SCMI come
> with some sort of topological and qualitative description provided by the
> protocol (like unit of measurements, name, topology info etc), kernel-wise
> we CANNOT be completely sure of "what is what" without being fed-back some
> sort of information about the DEs by the afore mentioned userspace tool.
> 
> For these reasons, currently this series does NOT attempt to register any
> of these DEs with any of the usual in-kernel subsystems (like HWMON, IIO,
> PERF etc), simply because we cannot be sure which DE is suitable, or even
> desirable, for a given subsystem. This also means there are NO in-kernel
> users of these Telemetry data events as of now.
> 
> So, while we do not exclude, for the future, to feed/register some of the
> discovered DEs to/with some of the above mentioned Kernel subsystems, as
> of now we have ONLY modeled a custom userspace API to make SCMI Telemetry
> available to userspace tools.
> 
> In deciding which kind of interface to expose SCMI Telemetry data to a
> user, this new SCMI Telemetry driver aims at satisfying 2 main reqs:
> 
>  - exposing an FS-based human-readable interface that can be used to
>    discover, configure and access our Telemetry data directly also from
>    the shell without special tools
> 
>  - exposing alternative machine-friendly, more-performant, binary
>    interfaces that can be used to avoid the overhead of multiple accesses
>    to the VFS and that can be more suitable to access with custom tools
> 
> In the initial RFC posted a few months ago [1], the above was achieved
> with a combination of a SysFS interface, for the human-readable side of
> the story, and a classic chardev/ioctl for the plain binary access.
> 
> Since V1, instead, we moved away from this combined approach, especially
> away from SysFS, for the following reason:
> 
>  1. "Abusing SysFS": SysFS is a handy way to expose device related
>       properties in a common way, using a few common helpers built on
>       kernfs; this means, though, that unfortunately in our scenario I had
>       to generate a dummy simple device for EACH SCMI Telemetry DataEvent
>       that I got to discover at runtime and attach to them, all of the
>       properties I need.
>       This by itself seemed to me abusing the SysFS framework, but, even
>       ignoring this, the impact on the system when we have to deal with
>       hundreds or tens of thousands of DEs is sensible.
>       In some test scenario I ended with 50k DE devices and half-a-millon
>       related property files ... O_o
> 
>  2. "SysFS constraints": SysFS usage itself has its well-known constraints
>       and best practices, like the one-file/one-value rule, and due to the
>       fact that any virtual file with a complex structure or handling logic
>       is frowned upon, you can forget about IOCTLs and mmap'ing to provide
>       a more performant interface within SysFs, which is the reason why,
>       in the previous RFC, there was an additional alternative chardev
>       interface.
>       These latter limitations around the implementation of files with a
>       more complex semantic (i.e. with a broader set of file_operations)
>       derive from the underlying KernFS support, so KernFS is equally not
>       suitable as a building block for our implementation.
> 
>  2. "Chardev limitations": Given the nature of the protocol, the hybrid
>       approach employing character devices was itself problematic: first
>       of all because there is an upper limit on the number of chardev we
>       can create, dictated by the range of available minor numbers, and
>       then because the fact itself to have to maintain 2 completely
>       different interfaces (FS + chardev) is painful.
> 
> As a final remark, please NOTE THAT all of this is supposed to be available
> in production systems across a number of heterogeneous platforms: for these
> reasons the easy choice, debugFS, is NOT an option here.
> 
> Due to the above reasoning, since V1 we opted for a new approach with the
> proposed interfaces now based on a full fledged, unified, virtual pseudo
> filesystem implemented from scratch, so that we can:
> 
>  - expose all the DEs property we like as before with SysFS, but without
>    any of the constraint imposed by the usage of SysFs or kernfs.
> 
>  - easily expose additional alternative views of the same set of DEs
>    using symlinking capabilities (e.g. alternative topological view)
> 
>  - additionally expose a few alternative and more performant interfaces
>    by embedding in that same FS, a few special virtual files:
> 
>    + 'control': to issue IOCTLs for quicker discovery and on-demand access
>    		to data
>    + 'pipe' [TBD]: to provide a stream of events using a virtual
>    		   infinite-style file
>    + 'raw_<N>' [TBD]: to provide direct memory mapped access to the raw
>    		      SCMI Telemetry data from userspace

A filsystem driver for telemetry like this is really misguided. I think
shell access is really not an argument for adding a filesystem into the
kernel like this. That's just not appropriate justification to push
thousand and thousands of lines of code into the kernel.

You're building completely new infrastructure. The format is whatever it
is. If you stream it somehow just add a binary that userspace can use to
consume or translate it. If you need a filesystem interface for
convenience build it via FUSE on top of whatever streams that data and
get it ouf of the kernels way.

You also buy into all kinds of really wonky properties. If you split it
over multiple files you can never get a snapshot of data that is
consistent if it's across multiple files.

Telemetry over a filesystem is just not a great idea. If you did it via
sysfs I really wouldn't care because all because the infrastructure
already exists and I couldn't be bothered if this grew yet another wart
but as a separate massive hand-rolled pseudofs, no I'm not seeing it.
